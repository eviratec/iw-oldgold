# Integrated Web
#   Contact Module

use Switch;

sub displayModule {
	
	$PAGE{'section'} = 'contact-us';
  
	if (@REQUEST > 0) {
		# There is a request after 'services' so we'll figure it out and display the correct page
		my $subreq = shift(@REQUEST);
		$PAGE{'thread'} .= '<a href="'.$CONFIG{'web_addr'}.'contact-us">contact us</a> / ';
    
    switch ($subreq) {
      case 'get-a-quote' {
        showQuoteForm();
      }
      case 'thankyou' {
        submitForm();
      }
      else {
        $PAGE{'404'} = 1;
      }
    }
	} else {
		# There is no request after 'services' so, show the services page
		showContactInfo();
	}
	
}

sub submitForm {
	my $contactType = $cgi->param("contactType");
	if ($contactType eq 'enquiry') {
		my %selected = ();
		if (@REQUEST > 0) {
			my $subreq = shift(@REQUEST);
			$subreq =~ s/.html//gi;
			$selected{$subreq} = 'selected';
		}
		my %formInput = {};
		if ($cgi->param("subForm") eq "true") {
			my $errorText = undef;
			my $errorCount = 0;
			my $emailSubject = 'IntegratedWeb General Enquiry - '.$cgi->param("subject");
			my $emailText = qq~You have received an enquiry from integratedweb.com.au!  The details are as follows;<br />~;
			%formInput = ('name' => 'Customer Name',
				'companyName' => 'Company Name',
				'email' => 'Email Address',
				'dayPhone' => 'Daytime Phone Number',
				'contactPref' => 'Contact Preference',
				'subject' => 'Subject',
				'message' => 'Message');
			foreach my $key (keys %formInput) {
				$formInput{$key}[1] = $cgi->param($key);
				$formInput{$key}[1] =~ s/\n/\<br \/\>/gi;
				$emailText .= "<br /><strong>".$formInput{$key}.":</strong> ".$formInput{$key}[1];
			}
			$emailText .= "<br /><br />Sincerely,<br />Web Team";
			$sender = new Mail::Sender {
				smtp => $CONFIG{'mail_auth_host'},
				from => $cgi->param("name").' <'.$cgi->param("email").'>',
				auth => 'PLAIN',
				authid => $CONFIG{'mail_auth_user'},
				authpwd => $CONFIG{'mail_auth_pass'},
				on_errors => 'die',
				ctype => 'text/html'
			}
				or die "Can't create the Mail::Sender object: $Mail::Sender::Error\n";
			$sender->Open({
				to => $CONFIG{'mail_enquiry'},
				subject => $emailSubject
			})
				or die "Can't open the message: $sender->{'error_msg'}\n";
			$sender->SendLineEnc('<html>'.$emailText.'</html>');
			$sender->Close()
				or die "Failed to send the message: $sender->{'error_msg'}\n";
		}
	} elsif ($contactType eq 'quote') {
		my %selected = ();
		if (@REQUEST > 0) {
			my $subreq = shift(@REQUEST);
			$subreq =~ s/.html//gi;
			$selected{$subreq} = 'selected';
		}
		my %formInput = {};
		if ($cgi->param("subForm") eq "true") {
			my $errorText = undef;
			my $errorCount = 0;
			my $emailSubject = 'IntegratedWeb Quote Request';
			my $emailText = qq~You have received a quote request from IntegratedWeb!  The details are as follows;<br />~;
			%formInput = ('name' => 'Customer Name',
				'companyName' => 'Company Name',
				'email' => 'Email Address',
				'dayPhone' => 'Daytime Phone Number',
				'contactPref' => 'Contact Preference',
				'quoteType' => 'Quote Type',
				'details' => 'Additional Details',
				'budget' => 'Budget',
				'budgetAmount' => 'Budget Amount',
				'website' => 'Existing Website',
				'websiteAddress' => 'Website Address',
				'deadline' => 'Deadline',
				'deadlineDate' => 'Deadline Date');
			foreach my $key (keys %formInput) {
				$formInput{$key}[1] = $cgi->param($key);
				$formInput{$key}[1] =~ s/\n/\<br \/\>/gi;
				$emailText .= "<br /><strong>".$formInput{$key}.":</strong> ".$formInput{$key}[1];
			}
			$emailText .= "<br /><br />IP Address: ".$cgi->remote_host()."
			<br /><br />Sincerely,<br />Web Team";
			$sender = new Mail::Sender {
				smtp => $CONFIG{'mail_auth_host'},
				from => $cgi->param("name").' <'.$cgi->param("email").'>',
				auth => 'PLAIN',
				authid => $CONFIG{'mail_auth_user'},
				authpwd => $CONFIG{'mail_auth_pass'},
				on_errors => 'die',
				ctype => 'text/html'
			}
				or die "Can't create the Mail::Sender object: $Mail::Sender::Error\n";
			$sender->Open({
				to => $CONFIG{'mail_quote'},
				subject => $emailSubject
			})
				or die "Can't open the message: $sender->{'error_msg'}\n";
			$sender->SendLineEnc('<html>'.$emailText.'</html>');
			$sender->Close()
				or die "Failed to send the message: $sender->{'error_msg'}\n";	
		}
	}
	
	## Output thank-you page
	$PAGE{'thread'} .= 'thank-you';
	$PAGE{'title'} = 'Thank-you for your enquiry';
	
	$PAGE{'robots'} = 'none';
  
  $subTplName = 'thankyou.htm';
  $subTplVars->{'webAddress'} = $CONFIG{'web_addr'};
	
}

sub showContactInfo {
	
	$PAGE{'thread'} .= 'contact us';
	$PAGE{'title'} = 'Contact Us';
	
	$PAGE{'robots'} = 'none';
	
	$subTplName = 'contactInfo.htm';
	
}

sub showQuoteForm {
	
	$PAGE{'thread'} .= 'get a quote';
	$PAGE{'title'} = 'Get a Quote';
	
	$PAGE{'robots'} = 'none';
	
  $subTplName = 'quoteForm.htm';
	
}

1;