# Integrated Web
#   Services Module

use Switch;

sub displayModule {
	
	$PAGE{'section'} = 'services';
	
	if (@REQUEST > 0) {
		# There is a request after 'services' so we'll figure it out and display the correct page
		my $subreq = shift(@REQUEST);
		$PAGE{'thread'} .= '<a href="'.$CONFIG{'web_addr'}.'services">services</a> / ';
		
    switch ($subreq) {
      case 'application-development' {
        showDevelopment();
      }
      case 'web-design' {
        if (@REQUEST > 0) {
          my $desReq = shift(@REQUEST);
          switch ($desReq) {
            case 'new' {
              showDesignNew();
            }
            else {
              $PAGE{'404'} = 1;
            }
          }
        }
        else {
          showDesign();
        }
      }
      case 'social-media' {
        showSocial();
      }
      case 'ecommerce' {
        if (@REQUEST > 0) {
          my $ecomReq = shift(@REQUEST);
          switch ($ecomReq) {
            case 'premium' {
              showEcommercePremium();
            }
            case 'enterprise' {
              showEcommerceEnterprise();
            }
            else {
              $PAGE{'404'} = 1;
            }
          }
        }
        else {
          showEcommerce();
        }
      }
      case 'online-marketing' {
        showMarketing();
      }
      else {
        $PAGE{'404'} = 1;
      }
    }
    
	} else {
		# There is no request after 'services' so, show the services page
		showOverview();
	}
	
}

sub showOverview {
	
  $subTplName = 'overview.htm';
  
	$PAGE{'thread'} .= 'services';
	$PAGE{'title'} = 'Services';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'web services, services, website design, web application, web development, application development, hosting, webhosting, web hosting, ecommerce, e commerce, commerce, store, online store, web store, shop, online shop, web shop, start online store, sell online, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services provide a range of services including website design, web application development, hosting, and eCommerce to Australian businesses.  We can provide you with everything you need to get your business online.';
	
  
	
}

sub showDesign {
	
  $subTplName = 'design.htm';
  
	$PAGE{'thread'} .= 'web &amp; design services';
	$PAGE{'title'} = 'Web &amp; Design Services';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'web services, services, website design, joomla, nuke, word press, vbulletin, invision power board, application development, skins, templates, online marketing, website, web development, redesign, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services offer great deals on quality website and template design services to Australian businesses.  We can provide you with everything you need to get your business online, and looking it\'s best.';
	
	
	
}

sub showDesignNew {
  
  $subTplName = 'design.new.htm';
  
  $PAGE{'thread'} .= 'business websites';
  $PAGE{'title'} = 'Business Websites';
  
  $PAGE{'robots'} = 'index,follow';
  $PAGE{'keywords'} = 'web services, services, website design, joomla, nuke, word press, vbulletin, invision power board, application development, skins, templates, online marketing, website, web development, redesign, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
  $PAGE{'description'} = 'Integrated Web Services offer great deals on quality website and template design services to Australian businesses.  We can provide you with everything you need to get your business online, and looking it\'s best.';
  
  
  
}

sub showDevelopment {
	
  $subTplName = 'development.htm';
  
	$PAGE{'thread'} .= 'application development';
	$PAGE{'title'} = 'Application Development Services';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'web development, programming, php, perl, joomla, nuke, word press, vbulletin, invision power board, application development, cms, content management system, crm, customer relationship manager, online ordering, services, website design, online marketing, website, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services offer great deals on web application development services to Australian businesses.  We can build or modify PHP or Perl based web applications for your business, we can also work with Joomla!, vBulletin, WordPress and Invision Board.';
	
	
	
}

sub showEcommerce {
  
  $subTplName = 'ecommerce.htm';
  
  $PAGE{'thread'} .= 'ecommerce';
  $PAGE{'title'} = 'Ecommerce Services';
  
  $PAGE{'robots'} = 'index,follow';
  $PAGE{'keywords'} = 'web services, ecommerce, e commerce, commerce, store, online store, web store, shop, online shop, web shop, start online store, sell online, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
  $PAGE{'description'} = 'Integrated Web Services provide a range of ecommerce solutions to Australian businesses.  We can provide you with everything your business needs to start selling your products online.';
	
}

sub showEcommercePremium {
  
  $subTplName = 'ecommerce.premium.htm';
  
  $PAGE{'thread'} .= 'premium ecommerce websites';
  $PAGE{'title'} = 'Premium Ecommerce Websites';
  
  $PAGE{'robots'} = 'index,follow';
  $PAGE{'keywords'} = 'web services, ecommerce, e commerce, commerce, store, online store, web store, shop, online shop, web shop, start online store, sell online, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
  $PAGE{'description'} = 'Integrated Web Services provide a range of ecommerce solutions to Australian businesses.  We can provide you with everything your business needs to start selling your products online.';
  
}

sub showEcommerceEnterprise {
  
  $subTplName = 'ecommerce.enterprise.htm';
  
  $PAGE{'thread'} .= 'enterprise ecommerce websites';
  $PAGE{'title'} = 'Enterprise Ecommerce Websites';
  
  $PAGE{'robots'} = 'index,follow';
  $PAGE{'keywords'} = 'web services, ecommerce, e commerce, commerce, store, online store, web store, shop, online shop, web shop, start online store, sell online, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
  $PAGE{'description'} = 'Integrated Web Services provide a range of ecommerce solutions to Australian businesses.  We can provide you with everything your business needs to start selling your products online.';
  
}

sub showMarketing {
	
  $subTplName = 'marketing.htm';
  
	$PAGE{'thread'} .= 'online marketing services';
	$PAGE{'title'} = 'Online Marketing Services';
	
	
	
}

sub showSocial {
  
  $subTplName = 'social.htm';
  
  $PAGE{'thread'} .= 'social media services';
  $PAGE{'title'} = 'Social Media Services';
  
  
  
}

1;