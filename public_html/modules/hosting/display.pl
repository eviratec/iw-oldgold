# Integrated Web
#   Hosting Module

use Switch;

sub displayModule {
	
	$PAGE{'section'} = 'hosting';
	
	if (@REQUEST > 0) {
		# There is a request after 'services' so we'll figure it out and display the correct page
		my $subreq = shift(@REQUEST);
		$PAGE{'thread'} .= '<a href="'.$CONFIG{'web_addr'}.'hosting">hosting</a> / ';
		
    switch ($subreq) {
      case 'reseller' {
        showReseller();
      }
      case 'virtual-private-servers' {
        showVPS();
      }
      case 'domain-registration' {
        showDomainReg();
      }
      else {
        $PAGE{'404'} = 1;
      }
    }
    
	} else {
		# There is no request after 'services' so, show the services page
		showStandard();
	}
	
}

sub showStandard {
	
  $subTplName = 'standard.htm';
  
	$PAGE{'thread'} .= 'standard hosting';
	$PAGE{'title'} = 'Standard Hosting';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'web services, services, website design, web application, web development, application development, hosting, webhosting, web hosting, ecommerce, e commerce, commerce, store, online store, web store, shop, online shop, web shop, start online store, sell online, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services provide a range of services including website design, web application development, hosting, and eCommerce to Australian businesses.  We can provide you with everything you need to get your business online.';
	
}

sub showReseller {
  
  $subTplName = 'reseller.htm';
	
	$PAGE{'thread'} .= 'reseller hosting';
	$PAGE{'title'} = 'Reseller Hosting';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'web services, services, website design, joomla, nuke, word press, vbulletin, invision power board, application development, skins, templates, online marketing, website, web development, redesign, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services offer great deals on quality website and template design services to Australian businesses.  We can provide you with everything you need to get your business online, and looking it\'s best.';
	
}

sub showVPS {
  
  $subTplName = 'vps.htm';
	
	$PAGE{'thread'} .= 'virtual private servers';
	$PAGE{'title'} = 'Virtual Private Servers';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'web development, programming, php, perl, joomla, nuke, word press, vbulletin, invision power board, application development, cms, content management system, crm, customer relationship manager, online ordering, services, website design, online marketing, website, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services offer great deals on web application development services to Australian businesses.  We can build or modify PHP or Perl based web applications for your business, we can also work with Joomla!, vBulletin, WordPress and Invision Board.';
	
}

sub showDomainReg {
  
  #use SOAP::Lite;
  #my $netregistry = SOAP::Lite->service('https://MIL-241-API:y21ThQF0TGbt9fIF@theconsole.netregistry.com.au/external/services/ResellerAPIService/?wsdl');
  #my $result = $netregistry -> domainLookup('domain', 'netregistry.com.au') -> result();
  #while ( $result )
  #{
  #  $subTplVars->{'output'} .= "$result\n";
  #}
  
#  use SOAP::Lite +autodispatch => 
#    uri => 'http://www.soaplite.com/My/Examples', 
#    proxy => 'http://localhost/', 
#    on_fault => sub { my($soap, $res) = @_; 
#      die ref $res ? $res->faultdetail : $soap->transport->status, "\n";
#    }
#  ;
#  sub SOAP::Transport::HTTP::Client::get_basic_credentials { return ('user' => 'password') };
#  
#  print getStateName(1), "\n\n";
#  
#  my $response = SOAP::Lite 
#    #-> proxy('https://theconsole.netregistry.com.au/external/services/ResellerAPIService/?wsdl')
#    -> proxy('192.168.241.146:3128')
#    -> credentials('MIL-241-API','y21ThQF0TGbt9fIF')
#    -> uri("urn:domain")
#    -> domainLookup("integratedweb.com.au");
#    
#  die "Fault: ".$response->faultcode." ".$response->faultdetail." ".$response->faultstring if $response->faultcode;
#  $subTplVars->{'output'} = $response->result;
#  
  $subTplName = 'domainReg.htm';
	
	$PAGE{'thread'} .= 'domain registration';
	$PAGE{'title'} = 'Domain Registration';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'web hosting, hosting, australian hosting, australian web hosting, aussie web host, host, php, perl, mysql, email, website, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services offer great deals on Australian based web hosting to Australian businesses.  We can host and manage your businesses web services easily and affordably.';
	
}

1;