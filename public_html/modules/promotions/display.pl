# Integrated Web
#   Promotions Module

sub displayModule {
	
  $PAGE{'section'} = 'promotions';
  
	if (@REQUEST > 0) {
		# There is a request after 'promotions' so we'll figure it out and display the correct page
		my $subreq = shift(@REQUEST);
		
		if ($subreq =~ /^oos-042010/i) {
			my $promoExpiry = '2010-04-30';
			showPromoOos();
		} elsif ($subreq =~ /^thankyou/i) {
			submitForm();
		} else {
			$PAGE{'404'} = 1;
		}
	} else {
		# Since there is no 'promotions' page as such, if it's directly requested, return a 404
		$PAGE{'404'} = 1;
	}
	
}

sub submitForm {
	## Check for submitted forms and process (if any)
	my $errorMessage = undef;
	my %formInput = {};
	if ($cgi->param("subForm") eq "true") {
		
		## Prepare values for email message
		my $errorText = undef;
		my $emailSubject = 'IntegratedWeb Special Offer Quote Request';
		my $emailText = qq~You have received a quote request via the special offer page for promotion ~.$cgi->param("promo").qq~!  The details are as follows;<br />~;
		
		%formInput = ('name' => 'Customer Name',
			'companyName' => 'Company Name',
			'email' => 'Email Address',
			'dayPhone' => 'Daytime Phone Number',
			'contactPref' => 'Contact Preference',
			'message' => 'Message',
			'website' => 'Existing Website',
			'websiteAddress' => 'Website Address');
		foreach my $key (keys %formInput) {
			$formInput{$key}[1] = $cgi->param($key);
			$formInput{$key}[1] =~ s/\n/\<br \/\>/gi;
		}
		
		$emailText .= qq~<strong>~.$formInput{'name'}.qq~</strong> ~.$formInput{'name'}[1].qq~<br />~.
			qq~<strong>~.$formInput{'companyName'}.qq~</strong> ~.$formInput{'companyName'}[1].qq~<br />~.
			qq~<strong>~.$formInput{'contactPref'}.qq~</strong> ~.$formInput{'contactPref'}[1].qq~<br />~.
			qq~<strong>~.$formInput{'email'}.qq~</strong> ~.$formInput{'email'}[1].qq~<br />~.
			qq~<strong>~.$formInput{'dayPhone'}.qq~</strong> ~.$formInput{'dayPhone'}[1].qq~<br /><br />~.
			qq~<strong>~.$formInput{'website'}.qq~</strong> ~.$formInput{'website'}[1].qq~<br />~.
			(($formInput{'website'}[1] eq "yes") ? qq~<strong>~.$formInput{'websiteAddress'}.qq~</strong> ~.$formInput{'websiteAddress'}[1].qq~<br />~ : '' ).
			qq~<br /><strong>~.$formInput{'message'}.qq~</strong> ~.$formInput{'message'}[1].qq~<br /><br />~.
			qq~<strong>IP Address</strong> ~.$cgi->remote_host().qq~~;
		
		$emailText .= "<br /><br />Sincerely,<br />Web Team";
		
		## Send email message
		$sender = new Mail::Sender {
			smtp => $CONFIG{'mail_auth_host'},
			from => $cgi->param("name").' <'.$cgi->param("email").'>',
			auth => 'PLAIN',
			authid => $CONFIG{'mail_auth_user'},
			authpwd => $CONFIG{'mail_auth_pass'},
			on_errors => 'die',
			ctype => 'text/html'
		} or die "Can't create the Mail::Sender object: $Mail::Sender::Error\n";
	       
		$sender->Open({
			to => $CONFIG{'mail_quote'},
			subject => $emailSubject
		})
			or die "Can't open the message: $sender->{'error_msg'}\n";
		$sender->SendLineEnc('<html>'.$emailText.'</html>');
		$sender->Close()
			or die "Failed to send the message: $sender->{'error_msg'}\n";
	}
	
	## Output thank-you page
	$PAGE{'thread'} .= 'thank-you';
	$PAGE{'title'} = 'Thank-you';
	
	$PAGE{'robots'} = 'none';
	
	$PAGE{'content'} = qq~<h1>Thank-you for your enquiry</h1>
	<p>A member of our team will get in contact with you within the next one or two working days.</p>
	<p><a href="$CONFIG{'web_addr'}index.html">Click here to return to the home page</a></p>~;
}

sub showPromoOos {
	
	#$PAGE{'thread'} .= 'full service special offer';
	#$PAGE{'title'} = 'Full Service Special Offer';
	#$PAGE{'header_html'} = '<link type="text/css" rel="stylesheet" href="'.$CONFIG{'web_addr'}.'style/shared/promo-oos.css" />';
	
	#$PAGE{'robots'} = 'none';
	
	$PAGE{'404'} = 1;
	
	## Display the page content
	
	#my $promoImages = '/img/promotions/oos';
	#
	#$PAGE{'content'} .= qq~<a href="#enquiryForm"><img src="$promoImages/special-oos-top.gif" style="float: left; border: 0;" /></a>
	#	<img src="$promoImages/special-oos-sep.gif" style="float: left; border: 0;" />
	#	<img src="$promoImages/special-oos-info.gif" style="float: left; border: 0;" />
	#	<div class="promoContactDiv"><h1>Enquire Now</h1>
	#		<form action="/promotions/thankyou.html" method="POST" name="enquiryForm" id="enquiryForm">
	#		<div class="floatingText">To order this or get more information on this offer, please complete the form and we'll get in touch with you.
	#		<br /><br />Integrated Web Services is a 100% Australian owned and operated business.
	#		<br />ABN 62 842 988 455
	#		<br /><br />* denotes required field</div>
	#		<div class="smallInput">
	#			Your Name*
	#			<div><input type="text" name="name" id="name" value="" class="rounded" /></div>
	#		</div>
	#		<div class="bigInput">
	#			Business/Company Name
	#			<div><input type="text" name="companyName" id="companyName" value="" class="rounded" /></div>
	#		</div>
	#		<div class="bigInput">
	#			Email Address*
	#			<div><input type="text" name="email" id="email" value="" class="rounded" /></div>
	#		</div>
	#		<div class="smallInput">
	#			Daytime Phone Number
	#			<div><input type="text" name="dayPhone" id="dayPhone" value="" class="rounded" /></div>
	#		</div>
	#		<div class="bigInput">
	#			What is your preferred contact method? <input type="radio" id="contactPref" name="contactPref" value="phone" ~.(($formInput{'contactPref'}[2] eq 'phone' || $formInput{'contactPref'}[2] eq '') ? 'checked' : '').qq~ />Phone <input type="radio" id="contactPref" name="contactPref" value="email" ~.(($formInput{'contactPref'}[2] eq 'email') ? 'checked' : '').qq~ />Email
	#		</div>
	#		<div class="bigInput">
	#			Do you already have a website? <input type="radio" checked="" onclick="hideDiv('curWebAddr');" value="no" name="website" id="website">No <input type="radio" onclick="showDiv('curWebAddr');" value="yes" name="website" id="website">Yes
	#		</div>
	#		<div class="smallInput"  id="curWebAddr" name="curWebAddr" style="display: none;">
	#			Current website address
	#			<div><input type="text" name="websiteAddress" id="websiteAddress" value="" class="rounded" /></div>
	#		</div>
	#		<div class="bigInput">
	#			Additional Details / Message
	#			<div class="bigText"><textarea name="message" id="message"></textarea></div>
	#		</div>
	#		<input type="hidden" id="req" name="req" value="promotions/thankyou.html" />
	#		<input type="hidden" id="requiredFields" name="requiredFields" value="name::Name,email::Email Address" />
	#		<input type="hidden" id="validateEmail" name="validateEmail" value="email::Email Address" />
	#		<input type="hidden" id="promo" name="promo" value="OOS-042010" />
	#		<input type="hidden" id="subForm" name="subForm" value="true" />
	#		<input type="submit" id="submit" name="submit" value="" onclick="javascript:validateForm('enquiryForm'); return false;" style="width: 115px; height: 36px; background: url(/img/$PAGE{'template'}/buttons/enquire-now-yellow.png); cursor: pointer; border: 0;" />
	#		<inpyut
	#		</form>
	#	</div>
	#	<img src="$promoImages/special-oos-foot.gif"  style="float: left; border: 0;" />
	#	<img src="$promoImages/special-oos-dis.gif"  style="float: left; border: 0;" />
	#	<div style="clear: both;"><img src="$CONFIG{'web_addr'}img/shared/spacer.gif" /></div>~;
	
}

1;