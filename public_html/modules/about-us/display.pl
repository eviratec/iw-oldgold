# Integrated Web
#   About Module

use Switch;

sub displayModule {
	
	$PAGE{'section'} = 'about-us';
	
	our $yesimg = qq~<img src="$CONFIG{'web_addr'}img/$PAGE{'template'}/buttons/table-yes.png" alt="Yes" border="0" />~;
	our $optimg = qq~<img src="$CONFIG{'web_addr'}img/$PAGE{'template'}/buttons/table-opt.png" alt="Optional" border="0" />~;
	our $noimg = qq~<img src="$CONFIG{'web_addr'}img/$PAGE{'template'}/buttons/table-no.png" alt="No" border="0" />~;
	
	if (@REQUEST > 0) {
		# There is a request after 'services' so we'll figure it out and display the correct page
		my $subreq = shift(@REQUEST);
		$PAGE{'thread'} .= '<a href="'.$CONFIG{'web_addr'}.'about-us">about us</a> / ';
		
    switch ($subreq) {
      case 'the-team' {
        showTheTeam();
      }
      case 'previous-work' {
        showPreviousWork();
      }
      else {
        $PAGE{'404'} = 1;
      }
    }
    
	} else {
		# There is no request after 'services' so, show the services page
		showBusinessInfo();
	}
	
}

sub showBusinessInfo {
	
  $subTplName = 'businessInfo.htm';
  
	$PAGE{'thread'} .= 'about';
	$PAGE{'title'} = 'About Us';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'web services, services, website design, web application, web development, application development, hosting, webhosting, web hosting, ecommerce, e commerce, commerce, store, online store, web store, shop, online shop, web shop, start online store, sell online, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services provide a range of services including website design, web application development, hosting, and eCommerce to Australian businesses.  We can provide you with everything you need to get your business online.';
	
}

sub showTheTeam {
  
  $subTplName = 'theTeam.htm';
	
	$PAGE{'thread'} .= 'the team';
	$PAGE{'title'} = 'The Team';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'web services, services, website design, joomla, nuke, word press, vbulletin, invision power board, application development, skins, templates, online marketing, website, web development, redesign, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services offer great deals on quality website and template design services to Australian businesses.  We can provide you with everything you need to get your business online, and looking it\'s best.';
	
}

sub showPreviousWork {
  
  $subTplName = 'previousWork.htm';
	
	$PAGE{'thread'} .= 'previous work';
	$PAGE{'title'} = 'Previous Work';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'web development, programming, php, perl, joomla, nuke, word press, vbulletin, invision power board, application development, cms, content management system, crm, customer relationship manager, online ordering, services, website design, online marketing, website, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services offer great deals on web application development services to Australian businesses.  We can build or modify PHP or Perl based web applications for your business, we can also work with Joomla!, vBulletin, WordPress and Invision Board.';
	
}

1;