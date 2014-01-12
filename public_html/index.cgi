#!/usr/bin/perl -w
###!/opt/ActivePerl-5.10/bin/perl -w
use lib "lib";
use strict;
use DBD::mysql;
use CGI::Session;
use Math::Round qw(nearest);
use Date::Calc qw(Day_of_Year Days_in_Month Mktime Time_to_Date Localtime Add_Delta_Days System_Clock Delta_Days Today Today_and_Now);
use warnings;
use CGI;
our $cgi = new CGI;
use advText;
our $advText = new advText;
use Mail::Sender;
use Template;
use Switch;
use Number::Format;
use Data::Dumper;
our %CONFIG = ();
our %PAGE = ();
our %TOTALTALLY = ();
our %LANG = ();
our @MONTHS = ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
our $currency = new Number::Format(
  -thousands_sep   => ',',
  -decimal_point   => '.',
  -int_curr_symbol => '$'
  );

require 'config.vars.pl';
require 'lang/en-au/standard.def';

## Set up the default values for the template variables
## -----------------------------------------------------------------

  $PAGE{'headers'} = ();
  $PAGE{'sectionParams'} = ();
  $PAGE{'template'} = $CONFIG{'tmpl_default'};
  $PAGE{'title'} = '';
  $PAGE{'robots'} = $CONFIG{'tmpl_page_robots'};
  $PAGE{'keywords'} = $CONFIG{'tmpl_page_keywords'};
  $PAGE{'description'} = $CONFIG{'tmpl_page_description'};
  $PAGE{'copyright'} = $CONFIG{'tmpl_copyright'};
  $PAGE{'thread'} = $CONFIG{'tmpl_thread'};
  $PAGE{'content'} = '';
  $PAGE{'404'} = 0;

## Open the database connection
## -----------------------------------------------------------------

  our $dbh = DBI->connect('dbi:mysql:'.$CONFIG{'database'}, $CONFIG{'db_user'}, $CONFIG{'db_pass'}) or die $DBI::errstr;

## Initialize the session
## -----------------------------------------------------------------
  
  our $newCookies = undef;
  our $session = CGI::Session->load() or die CGI::Session->errstr();
  if ($session->is_expired || $session->is_empty) {
    $session = $session->new() or die $session->errstr;
  }
  
## Get the content for the requested page
## -----------------------------------------------------------------

  our $subTplVars = {};
  our $subTplPath = $CONFIG{'template_path'}.$PAGE{'template'}.'/modules/';
  our $subTplName = undef;
  
  # A few default template vars to avoid redundancy
  $subTplVars->{'webAddress'} = $CONFIG{'web_addr'};
  
  if ((!$cgi->param("req") || $cgi->param("req") eq 'index.html') && !$cgi->param('custom')) { # Homepage module requested
    my $moduleLocation = "modules/home/display.pl";
    require $moduleLocation;
    displayModule();
    $subTplPath .= 'home/';
  }
  elsif($cgi->param('Custom')) {
    die ("custom".$cgi->param('Custom'));
    our @REQUEST = split(/\//, 'api/'.$cgi->param('Custom'));
    my $request = shift(@REQUEST);
    
    $request =~ s/(.htm|.html)$//;
    require "modules/$request/display.pl";
    displayModule();
  }
  else { # Other module requested
    our @REQUEST = split(/\//, $cgi->param("req"));
    my $request = shift(@REQUEST);

    $request =~ s/(.htm|.html)$//;
    my $module = $request;
    my $moduleLocation = "modules/$request/display.pl";
    
    if (-e $moduleLocation) { # Check if module exists
      $subTplPath .= "$request/";
      require $moduleLocation;
      displayModule();
    }
    else {
      $PAGE{'404'} = 1;
    }
  }
  
  if ($subTplName) { # Template name is min req to render a sub-template
    
    my $subTpl = {
      INCLUDE_PATH  => $subTplPath,
      POST_CHOMP    => 1,
      ANYCASE   => 1
    };

    my $subTemplate = Template->new($subTpl);
    
    my $subTplOut = undef;
    $subTemplate->process($subTplName, $subTplVars, \$subTplOut)
      || die $subTemplate->error();
    $PAGE{'content'} = $subTplOut;
    
  }

  if ($PAGE{'404'}) { # No page was found, grab the 404 code from inc
    require 'inc/error-404.pl';
    pageNotFound();
  }
  
## Log the visit
## -----------------------------------------------------------------
  
  my $contactID = ($session->param('loggedIn')) ? $session->param('contactID') : undef;
  ## Get post vars
  my @postVars = $cgi->param;
  my $post = undef;
  for (my $i = 0; $i < @postVars; $i++) {
    $post .= (($i == 0) ? '' : '&') . $postVars[$i] . '=' . $cgi->param($postVars[$i]);
  }
  ## Insert SQL
  my $sth = $dbh->prepare(qq{
    INSERT
      INTO
        sessionLog
        ( cgiSessionID,contactID,httpAccept,httpCookie,httpHost,httpReferer,httpUserAgent,httpResponse,
          remoteAddr,remotePort,requestMethod,requestURI,serverAddress,serverName,serverPort,
          serverProtocol,dateLogged,dateEntered )
      VALUES
        ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NULL );
  });
  $sth->execute($session->id(),$contactID,$ENV{'HTTP_ACCEPT'}, $ENV{'HTTP_COOKIE'}, $ENV{'HTTP_HOST'},
    $ENV{'HTTP_REFERER'}, $ENV{'HTTP_USER_AGENT'}, $ENV{'HTTP_RESPONSE'}, $ENV{'REMOTE_ADDR'}, 
    $ENV{'REMOTE_PORT'}, $ENV{'REQUEST_METHOD'}, $ENV{'REQUEST_URI'}.';'.$post, $ENV{'SERVER_ADDR'}, 
    $ENV{'SERVER_NAME'}, $ENV{'SERVER_PORT'}, $ENV{'SERVER_PROTOCOL'}) 
    or die $sth->errstr;

## Get the session information and put it in to a hash
## -----------------------------------------------------------------

  our $sessionInfo = $session->dataref();
  
## Display the requested page or run the redirect
## -----------------------------------------------------------------
  
  if ($PAGE{'redirect'}) { # If we are doing a redirect, redirect the page
    print "Location: ".$PAGE{'redirect'}." \n\n";
  }
  
  print $session->header("Cache-Control: no-cache, must-revalidate;");
  
  # Get the template, make some changes and display
  
  $PAGE{'templateType'} = 'general';
  if ($cgi->param('view')) { # If this is a different view (e.g. print view), change the template type
    $PAGE{'templateType'} = $cgi->param('view');
  }

  if ($cgi->param("tpl")) {
    $PAGE{'template'} = $cgi->param("tpl");
  }

  my $tmpl = {
    INCLUDE_PATH  => $CONFIG{'template_path'}.$PAGE{'template'}.'/',
    POST_CHOMP    => 1,
    ANYCASE   => 1
  };

  my $template = Template->new($tmpl);

  my $tmplvars = {
    site_url          => $CONFIG{'web_addr'},
    page_title        => (($PAGE{'title'} ne 'Integrated Web Home' && $PAGE{'title'} ne '') ? $PAGE{'title'}.' - '.$CONFIG{'tmpl_page_title'} : $CONFIG{'tmpl_page_title_long'}),
    page_title_h1     => $PAGE{'title'},
    page_robots       => $PAGE{'robots'},
    page_keywords     => $PAGE{'keywords'},
    page_description  => $PAGE{'description'},
    page_copyright    => $PAGE{'copyright'},
    header_html       => $PAGE{'header_html'},
    copyright         => $PAGE{'copyright'},
    page_content      => $PAGE{'content'},
    page_thread       => $PAGE{'thread'},
    section           => $PAGE{'section'},
    session           => $sessionInfo,
    sectionParams     => $PAGE{'sectionParams'},
    debugInfo         => $PAGE{'debugInfo'}
  };

  my $input = $PAGE{'template'}.'.'.$PAGE{'templateType'}.'.htm';

  $template->process($input, $tmplvars)
    || die $template->error();
  
  $session->close();
