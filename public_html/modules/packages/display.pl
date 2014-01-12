# Integrated Web
#   Packages Module

sub displayModule {
	
	$PAGE{'section'} = 'Packages';
	
	if (@REQUEST > 0) {
		# There is a request after 'services' so we'll figure it out and display the correct page
		my $subreq = shift(@REQUEST);
		$PAGE{'thread'} .= '<a href="'.$CONFIG{'web_addr'}.'packages.html">website packages</a> / ';
		
		if ($subreq =~ /^full-service/i) {
			showPackagesFull();
		} elsif ($subreq =~ /^ecommerce/i) {
			showPackagesStore();
		} elsif ($subreq =~ /^specials/i) {
      showPackagesStore();
    } else {
			$PAGE{'404'} = 1;
		}
	} else {
		# There is no request after 'services' so, show the services page
		showPackagesHome();
	}
	
}

sub showPackagesHome {
	
	$PAGE{'thread'} .= 'website packages';
	$PAGE{'title'} = 'Website Packages';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'description'} = 'Integrated Web Services provide a range of website and web store packages for Australian businesses.  We can provide you with everything you need to get an online presence for your business.';
	
	$PAGE{'content'} .= qq~<p>Here at IntegratedWeb, we have developed a number of complete website packages. These enable our customers to get a <a href="$CONFIG{'web_addr'}packages/full-service.html">full website</a> or an <a href="$CONFIG{'web_addr'}packages/ecommerce.html">eCommerce website</a> online at a fixed price.  You can also request a custom quote based on any of our packages.</p>
	
	<p>For more information, use the left hand menu to view our different package types.</p>
	
	<h2><a href="$CONFIG{'web_addr'}packages/full-service.html">Full service packages</a></h2>
	
	<p>We provide a range of full service web presence packages that will allow you to get your business online as easily as possible.</p>
	<p>All of our full service packages include;
		<ul class="tickList">
			<li>Custom Website Design</li>
			<li>Web & Email Hosting</li>
			<li>Domain Name Registration (<em>e.g. your-business.com.au</em>)</li>
			<li>Search Engine Friendly Links & HTML</li>
			<li>24/7 Email Support</li>
		</ul></p>
	<p><a href="$CONFIG{'web_addr'}packages/full-service.html" class="bigLink">Click here to see our range of Full Service packages</a></p>
	
	<h2><a href="$CONFIG{'web_addr'}packages/ecommerce.html">eCommerce packages</a></h2>
	
	<p>If you want to start selling products online, we've got you covered.  We can provide you with everything you need to launch your business online, and start selling your products generally within just a few weeks.</p>
	<p>All of our eCommerce packages include;
		<ul class="tickList">
			<li>Shopping Cart Software (License, Install & Configure)</li>
			<li>Custom Template Design</li>
			<li>Web & Email Hosting</li>
			<li>$LANG{'GA_TITLE'}</li>
			<li>Domain Name Registration (<em>e.g. your-business.com.au</em>)</li>
			<li>Search Engine Friendly Links & HTML</li>
			<li>24/7 Email Support</li>
		</ul></p>
	<p><a href="$CONFIG{'web_addr'}packages/ecommerce.html" class="bigLink">Click here to see our range of eCommerce packages</a></p>~;
	
}

sub showPackagesFull {
	
	$PAGE{'thread'} .= 'full service';
	$PAGE{'title'} = 'Full Service Packages';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'website, get a website, website design, get online, online business, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services provide a range of website packages for Australian businesses.  We can provide you with everything you need to get an online presence for your business.';
	
	## Page Content
	
	$PAGE{'content'} .= qq~<p class="introText">We provide a range of full service web presence packages that will allow you to get your business online as easily as possible.</p>
	<p class="introText">All of our full service packages include;
		<ul class="tickList">
			<li>Custom Website Design</li>
			<li>Web & Email Hosting</li>
			<li>Domain Name Registration (<em>e.g. your-business.com.au</em>)</li>
			<li>Search Engine Friendly Links & HTML</li>
			<li>Search Engine & Directory Submission</li>
			<li>XML Sitemaps (for search engines)</li>
			<li>24/7 Email Support</li>
			<li>Email & Hosting Control Panel</li>
		</ul></p>
	<p>If you're not sure exactly what you want, you can <a href="$CONFIG{'web_addr'}contact-us/get-a-quote.html">request a quote</a> based around any of our packages.</p>~;
	
	$PAGE{'content'} .= qq~<h2>Package comparison</h2>
	
	<table cellpadding="0" cellspacing="0" border="0" class="pkgTable">
	<thead>
		<tr><th width="180">&nbsp;</th><th width="150">Standard</th><th width="150">Premium</th><th width="150">Enterprise</th></tr>
	</thead>
	<tbody>
		<tr><th>$LANG{'CUST_DESIGN_TITLE'}</th>
			<td>$yesimg</td>
			<td>$yesimg</td>
			<td>$yesimg</td></tr>
		
		<tr><th><a onmouseover="Tip('<strong>$LANG{'SEF_TITLE_LONG'}</strong><br />$LANG{'SEF_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'SEF_TITLE'}</a></th>
			<td>$yesimg</td>
			<td>$yesimg</td>
			<td>$yesimg</td></tr>
		
		<tr><th><a onmouseover="Tip('<strong>$LANG{'GA_TITLE_LONG'}</strong><br />$LANG{'GA_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'GA_TITLE'}</a></th>
			<td>$yesimg</td>
			<td>$yesimg</td>
			<td>$yesimg</td></tr>
		
		<tr><th><a onmouseover="Tip('<strong>$LANG{'SEO_TITLE_LONG'}</strong><br />$LANG{'SEO_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'SEO_TITLE'}</a></th>
			<td>$noimg</td>
			<td>$yesimg</td>
			<td>$yesimg</td></tr>
	
		<tr><th><a onmouseover="Tip('<strong>$LANG{'WP_TITLE_LONG'}</strong><br />$LANG{'WP_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'WP_TITLE'}</a></th>
			<td>5</td>
			<td>10</td>
			<td>15</td></tr>
		
		<tr><th><a onmouseover="Tip('<strong>$LANG{'LP_TITLE_LONG'}</strong><br />$LANG{'LP_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'LP_TITLE'}</a></th>
			<td>0</td>
			<td>2</td>
			<td>3</td></tr>
		
		<tr><th><a onmouseover="Tip('<strong>$LANG{'CF_TITLE_LONG'}</strong><br />$LANG{'CF_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'CF_TITLE'}</a></th>
			<td>1</td>
			<td>2</td>
			<td>3</td></tr>
			
		<tr><th>$LANG{'HOS_DISK_TITLE'}</th>
			<td>500MB</td>
			<td>1,000MB</td>
			<td>2,000MB</td></tr>
		
		<tr><th>$LANG{'HOS_TRAF_TITLE'}</th>
			<td>4GB</td>
			<td>7GB</td>
			<td>10GB</td></tr>
		
		<tr><th>$LANG{'HOS_EMAI_TITLE'}</th>
			<td>5</td>
			<td>10</td>
			<td>20</td></tr>
		
		<tr class="total"><th><a onmouseover="Tip('<strong>$LANG{'SETUP_COST_TITLE_LONG'}</strong><br />$LANG{'SETUP_COST_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'SETUP_COST_TITLE'}</a></th>
			<td>\$399</td>
			<td>\$799</td>
			<td>\$1299</td></tr>
		
		<tr class="total"><th><a onmouseover="Tip('<strong>$LANG{'MAIN_Y_COST_TITLE_LONG'}</strong><br />$LANG{'MAIN_Y_COST_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'MAIN_Y_COST_TITLE'}</a></th>
			<td>\$399</td>
			<td>\$699</td>
			<td>\$999</td></tr>
		
	</tbody>
	<tfoot>
		<tr><td><span class="disclaimer">$LANG{'PRICE_EXCL_GST'}</span></td><td><a href="$CONFIG{'web_addr'}contact-us/get-a-quote/full-service.html"><img src="$CONFIG{'web_addr'}img/$PAGE{'template'}/buttons/enquire-now.png" alt="Enquire Now" border="0"></a></td><td><a href="$CONFIG{'web_addr'}contact-us/get-a-quote/full-service.html"><img src="$CONFIG{'web_addr'}img/$PAGE{'template'}/buttons/enquire-now.png" alt="Enquire Now" border="0"></a></td><td><a href="$CONFIG{'web_addr'}contact-us/get-a-quote/full-service.html"><img src="$CONFIG{'web_addr'}img/$PAGE{'template'}/buttons/enquire-now.png" alt="Enquire Now" border="0"></a></td></tr>
	</tfoot>
	</table>
	<p>You can roll over any blue underlined feature title for an explanation.</p>~;
	
	#<h2>Other recurring charges</h2>
	#
	#<p>Some package components require periodical payments to keep them active and valid.  These are typically things such as domain names, and payment gateways.</p>
	#
	#<table cellpadding="0" cellspacing="0" border="0" class="pkgTable">
	#<thead>
	#	<tr><th width="180">&nbsp;</th><th width="150">Renews Every</th><th width="150">Price</th></tr>
	#</thead>
	#<tbody>
	#	<tr><th>$LANG{'AUDOM_TITLE'}</th>
	#		<td>2 Years</td>
	#		<td>\$49.95</tr>
	#</tbody>
	#</table>
	#
	#<p><em>Note: You won't need to pay for these initially as the costs are worked in to each package's setup fee.</em></p>
	#~;
	
}

sub showPackagesStore {
	
	$PAGE{'thread'} .= 'ecommerce';
	$PAGE{'title'} = 'eCommerce Packages';
	
	$PAGE{'robots'} = 'index,follow';
	$PAGE{'keywords'} = 'ecommerce, e commerce, commerce, store, online store, web store, shop, online shop, web shop, start online store, sell online, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services provide a range of online store packages for Australian businesses.  We can provide you with everything you need to get your business selling online.';
	
	## Page Content
	
	$PAGE{'content'} .= qq~<p class="introText">If you want to start selling products online, we've got you covered.  We can provide you with everything you need to launch your business online, and start selling your products generally within just a few weeks.</p>
	<p class="introText">All of our eCommerce packages include;
		<ul class="tickList">
			<li>Shopping Cart Software (License, Install & Configure)</li>
			<li>Custom Template Design</li>
			<li>Web & Email Hosting</li>
			<li><a onmouseover="Tip('<strong>$LANG{'GA_TITLE_LONG'}</strong><br />$LANG{'GA_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'GA_TITLE'}</a></li>
			<li>Domain Name Registration (<em>e.g. your-business.com.au</em>)</li>
			<li>Search Engine Friendly Links & HTML</li>
			<li>Search Engine & Directory Submission</li>
			<li>XML Sitemaps (for search engines)</li>
			<li>24/7 Email Support</li>
			<li>Email & Hosting Control Panel</li>
		</ul></p>
	<p>If you're not sure exactly what you want, you can <a href="$CONFIG{'web_addr'}contact-us/get-a-quote.html">request a quote</a> based around any of our packages.</p>~;
	
	$PAGE{'content'} .= qq~<h2>Package comparison</h2>
	
	<table cellpadding="0" cellspacing="0" border="0" class="pkgTable">
	<thead>
		<tr><th width="180">&nbsp;</th><th width="150">Standard</th><th width="150">Premium</th><th width="150">Enterprise</th></tr>
	</thead>
	<tbody>
		<tr><th><a onmouseover="Tip('<strong>$LANG{'CART_TITLE_LONG'}</strong><br />$LANG{'CART_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'CART_TITLE'}</a></th>
			<td>$yesimg</td>
			<td>$yesimg</td>
			<td>$yesimg</td></tr>

		<tr><th><a onmouseover="Tip('<strong>$LANG{'CUST_TMPL_TITLE_LONG'}</strong><br />$LANG{'CUST_TMPL_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'CUST_TMPL_TITLE'}</a></th>
			<td>$yesimg</td>
			<td>$yesimg</td>
			<td>$yesimg</td></tr>
		
		<tr><th><a onmouseover="Tip('<strong>$LANG{'SEF_TITLE_LONG'}</strong><br />$LANG{'SEF_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'SEF_TITLE'}</a></th>
			<td>$yesimg</td>
			<td>$yesimg</td>
			<td>$yesimg</td></tr>
		
		<tr><th><a onmouseover="Tip('<strong>$LANG{'SEO_TITLE_LONG'}</strong><br />$LANG{'SEO_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'SEO_TITLE'}</a></th>
			<td>$yesimg</td>
			<td>$yesimg</td>
			<td>$yesimg</td></tr>

		<tr><th><a onmouseover="Tip('<strong>$LANG{'DEDSSL_TITLE_LONG'}</strong><br />$LANG{'DEDSSL_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'DEDSSL_TITLE'}</a></th>
			<td>$noimg</td>
			<td>$yesimg</td>
			<td>$yesimg</td></tr>
		
		<tr><th><a onmouseover="Tip('<strong>$LANG{'PAYGA_TITLE_LONG'}</strong><br />$LANG{'PAYGA_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'PAYGA_TITLE'}</a></th>
			<td>$noimg</td>
			<td>$noimg</td>
			<td>$yesimg</td></tr>
		
		<tr><th>$LANG{'HOS_DISK_TITLE'}</th>
			<td>1,000MB</td>
			<td>2,000MB</td>
			<td>4,000MB</td></tr>
		
		<tr><th>$LANG{'HOS_TRAF_TITLE'}</th>
			<td>5GB</td>
			<td>10GB</td>
			<td>20GB</td></tr>
		
		<tr><th>$LANG{'HOS_EMAI_TITLE'}</th>
			<td>10</td>
			<td>20</td>
			<td>30</td></tr>
		
		<tr class="total"><th><a onmouseover="Tip('<strong>$LANG{'SETUP_COST_TITLE_LONG'}</strong><br />$LANG{'SETUP_COST_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'SETUP_COST_TITLE'}</a></th>
			<td>\$899</td>
			<td>\$1,599</td>
			<td>\$2,999</td></tr>
		
		<tr class="total"><th><a onmouseover="Tip('<strong>$LANG{'MAIN_Y_COST_TITLE_LONG'}</strong><br />$LANG{'MAIN_Y_COST_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'MAIN_Y_COST_TITLE'}</a></th>
			<td>\$499</td>
			<td>\$1,199</td>
			<td>\$2,599</td></tr>~;
		
		#<tr class="total"><th><a onmouseover="Tip('<strong>$LANG{'TRAN_COST_TITLE_LONG'}</strong><br />$LANG{'TRAN_COST_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'TRAN_COST_TITLE'}</a></th>
		#	<td>45 cents</td>
		#	<td>45 cents</td>
		#	<td>45 cents</td></tr>
		
	$PAGE{'content'} .= qq~</tbody>
	<tfoot>
		<tr><td><span class="disclaimer">$LANG{'PRICE_EXCL_GST'}</span></td><td><a href="$CONFIG{'web_addr'}contact-us/get-a-quote/ecommerce.html"><img src="$CONFIG{'web_addr'}img/$PAGE{'template'}/buttons/enquire-now.png" alt="Enquire Now" border="0"></a></td><td><a href="$CONFIG{'web_addr'}contact-us/get-a-quote/ecommerce.html"><img src="$CONFIG{'web_addr'}img/$PAGE{'template'}/buttons/enquire-now.png" alt="Enquire Now" border="0"></a></td><td><a href="$CONFIG{'web_addr'}contact-us/get-a-quote/ecommerce.html"><img src="$CONFIG{'web_addr'}img/$PAGE{'template'}/buttons/enquire-now.png" alt="Enquire Now" border="0"></a></td></tr>
	</tfoot>
	</table>
	<p>You can roll over any blue underlined feature title for an explanation.</p>~;
	
	#<h2>Other recurring charges</h2>
	#
	#<p>Some package components require periodical payments to keep them active and valid.  These are typically things such as domain names, and payment gateways.</p>
	#
	#<table cellpadding="0" cellspacing="0" border="0" class="pkgTable">
	#<thead>
	#	<tr><th width="180">&nbsp;</th><th width="150">Renews Every</th><th width="150">Price</th></tr>
	#</thead>
	#<tbody>
	#	<tr><th><a onmouseover="Tip('<strong>$LANG{'PAYGA_TITLE_LONG'}</strong><br />$LANG{'PAYGA_EXP'}', ABOVE, true)" onmouseout="UnTip()">$LANG{'PAYGA_TITLE'}</a></th>
	#		<td>1 Year</td>
	#		<td>\$349</td></tr>
	#		
	#	<tr><th>$LANG{'AUDOM_TITLE'}</th>
	#		<td>2 Years</td>
	#		<td>\$49.95</tr>
	#</tbody>
	#</table>
	#
	#<p><em>Note: You won't need to pay for these initially as the costs are worked in to each package's setup fee.</em></p>
	#~;
	
}

1;