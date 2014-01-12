# Integrated Web
#   Legal Module

sub displayModule {
	
	$PAGE{'section'} = 'legal';
  
	if (@REQUEST > 0) {
		$PAGE{'robots'} = 'none';
		my $subreq = shift(@REQUEST);
		$PAGE{'thread'} .= '<a href="'.$CONFIG{'web_addr'}.'legal.html">legal</a> / ';
		
		if ($subreq =~ /^terms/i) {
			showTerms();
		} elsif ($subreq =~ /^privacy/i) {
			showPrivacy();
		} else {
			$PAGE{'404'} = 1;
		}
	} else {
		# There is no request after 'services' so, show the services page
		showLegalHome();
	}
	
}

sub showLegalHome {
	
	$PAGE{'thread'} .= 'legal';
	$PAGE{'title'} = 'Legal Information';
	
	$PAGE{'content'} .= qq~The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />
	The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />
	The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />
	The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />~;
	
}

sub showTerms {
	
	$PAGE{'thread'} .= 'terms and conditions';
	$PAGE{'title'} = 'Terms and Conditions';
	
	$PAGE{'content'} .= qq~The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />
	The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />
	The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />
	The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />~;
	
}

sub showPrivacy {
	
	$PAGE{'thread'} .= 'privacy policy';
	$PAGE{'title'} = 'Privacy Policy';
	
	$PAGE{'content'} .= qq~The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />
	The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />
	The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />
	The Status of each Task is either Not Scheduled, Pending, Queued, Running, Cancelling, Completed, Cancelled, Warning, or Error. These are color-coded. To sort the list by Status, click the arrow below the word "Status".
	To view runtime details for a Task, click the color-coded status entry next to that Task. This opens a new window that displays the runtime details.<br /><br />~;
	
}

1;