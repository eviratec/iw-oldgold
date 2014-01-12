# Integrated Web
#   Order Module

##
##  TO DO:
##  - Fix tax component in invoice from auto-account creation
##

use Switch;

sub displayModule {
	
	$PAGE{'section'} = 'order';
  
	if (@REQUEST > 0) {
    
    # Sub request is order/checkout type
		my $subreq = shift(@REQUEST);
		$PAGE{'thread'} .= '<a href="'.$CONFIG{'web_addr'}.'">order</a> / ';
		
    switch ($subreq) {
      case 'express' {
        if (@REQUEST > 0 && $REQUEST[0] eq 'complete') {
          showExpressComplete();
        }
        elsif (@REQUEST > 0 && $REQUEST[0] eq 'process') {
          processExpressPayment();
        }
        else {
          showExpressCheckout();
        }
      }
      else {
        $PAGE{'redirect'} = $CONFIG{'web_addr'};
      }
    }
    
	} else {
    $PAGE{'redirect'} = $CONFIG{'web_addr'};
	}
	
}

sub showExpressCheckout {
	
  $subTplName = 'express.htm';
  
	$PAGE{'thread'} .= 'express checkout';
	$PAGE{'title'} = 'Express Checkout';
	
	$PAGE{'robots'} = 'none';
	$PAGE{'keywords'} = 'web services, services, website design, web application, web development, application development, hosting, webhosting, web hosting, ecommerce, e commerce, commerce, store, online store, web store, shop, online shop, web shop, start online store, sell online, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services provide a range of services including website design, web application development, hosting, and eCommerce to Australian businesses.  We can provide you with everything you need to get your business online.';
	
  if ($processError == 1) {
    
    ## Set error message for template
    $subTplVars->{'processError'} = 1;
    @{$subTplVars->{'processErrorMessage'}} = @processErrorMessage;
    
    ## Get previously submitted form data
    my @postVars = $cgi->param;
    my %post = ();
    for (my $i = 0; $i < @postVars; $i++) {
      $post{$postVars[$i]} = $cgi->param($postVars[$i]);
    }
    %{$subTplVars->{'formData'}} = %post;
    
  }
  
}

sub showExpressComplete {
  
  $subTplName = 'express.complete.htm';
	
	$PAGE{'thread'} .= 'checkout complete';
	$PAGE{'title'} = 'Checkout Complete';
	
	$PAGE{'robots'} = 'none';
	$PAGE{'keywords'} = 'web services, services, website design, joomla, nuke, word press, vbulletin, invision power board, application development, skins, templates, online marketing, website, web development, redesign, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
	$PAGE{'description'} = 'Integrated Web Services offer great deals on quality website and template design services to Australian businesses.  We can provide you with everything you need to get your business online, and looking it\'s best.';
	
  my $action = shift(@REQUEST);
  my $paymentID = shift(@REQUEST);
  
  my $contactSth = $dbh->prepare(qq{
    SELECT
        co.*,
        l.*,
        p.*
      FROM
        payment p
        LEFT JOIN customer c ON p.customerID = c.customerID
        LEFT JOIN contact co ON p.contactID = co.contactID
        LEFT JOIN contactLogin l ON p.contactID = l.contactID
      WHERE
        p.paymentID = ?
  });
  $contactSth->execute($paymentID);
  my $contact = $contactSth->fetchrow_hashref();
  
  $subTplVars->{'firstName'} = $contact->{'firstName'};
  $subTplVars->{'primaryEmail'} = $contact->{'primaryEmail'};
  $subTplVars->{'username'} = $contact->{'username'};
  $subTplVars->{'password'} = $contact->{'password'};
  $subTplVars->{'paymentSuccessful'} = ($contact->{'paymentStatus'} eq 'COMPLETE') ? 1 : 0;
  
	## Send Email To Customer
	my $subject = qq~Thank-you for your order!~;
	my $email = qq~Thank-you for placing an order at www.integratedweb.com.au for a Premium Ecommerce Website
  <br /><br />We have received your details and will be in contact with you soon to discuss your new website.
	<br /><br /><strong>Your customer ID is $contact->{'customerID'}</strong>
  <br /><br />You may use the following credentials to log in to the customer control panel at integratedweb.com.au to view your invoices and payments.
	<br /><br /><strong>Username</strong> $contact->{'username'}
	<br /><strong>Password</strong> $contact->{'password'}
  <br /><br />Just sit tight and we'll be in contact soon, or you can call to check on the status of your order Mon to Fri 9AM to 6PM AEST on $CONFIG{'phone_orders'}.
	<br /><br />Sincerely,<br />Integrated Web Services<br />Web Team~;
	
	## Send Email Message
  $sender = new Mail::Sender {
    smtp => $CONFIG{'mail_auth_host'},
    from => 'Integrated Web Services <'.$CONFIG{'mail_noreply'}.'>',
    auth => $CONFIG{'mail_smtp_auth_type'},
    authid => $CONFIG{'mail_auth_user'},
    authpwd => $CONFIG{'mail_auth_pass'},
    on_errors => 'die',
    ctype => 'text/html'
  }
  or die "Can't create the Mail::Sender object: $Mail::Sender::Error\n";

  $sender->Open({
    to => $contact->{'primaryEmail'},
    bcc => $CONFIG{'mail_quote'},
    subject => $subject
  }) 
    or die "Can't open the message: $sender->{'error_msg'}\n";
  $sender->SendLineEnc('<html>'.$email.'</html>');
  $sender->Close()
    or die "Failed to send the message: $sender->{'error_msg'}\n";
  
  ## Begin processing via PayPal  
  my $address = {
    Name => $cgi->param('contactFirstName').' '.$cgi->param('contactLastName'),
    Street1 => $cgi->param('addressLine1'),
    Street2 => $cgi->param('addressLine2'),
    CityName => $cgi->param('addressSuburb'),
    PostalCode => $cgi->param('addressPostcode'),
    Phone => $cgi->param('companyPhoneOffice')
  };
  
}

sub processExpressPayment {
  
  ## Check the form was filled in properly, if not, send them back to the order page
  our $processError = 0;
  our @processErrorMessage = ();
  my %requiredFields = (
    'companyName' => 'Company/Trading Name',
    'addressLine1' => 'Address Line 1',
    'addressSuburb' => 'Address Suburb',
    'addressStateID' => 'Address State',
    'addressPostcode' => 'Address Postcode',
    'contactFirstName' => 'Your First Name',
    'contactLastName' => 'Your Last Name',
    'contactEmail' => 'Your Email Address',
    'contactPhoneOffice' => 'Your Primary Phone Number'
    );
  foreach my $key (keys %requiredFields) {
    if (!$cgi->param($key)) {
      $processError = 1;
      push(@processErrorMessage, "You left a required field '$requiredFields{$key}' empty");
    }
  }
  if ($processError == 1) {
    showExpressCheckout();
    return();
  }
  
  ## Create the company
  $companySth = $dbh->prepare(qq{
    INSERT
      INTO
        company
      SET
        name = ?,
        status = ?,
        dateCreated = NOW(),
        dateLastModified = NOW();
  });
  $companySth->execute($cgi->param('companyName'), 'ACTIVE');
  
  ## Get the new company ID
  $companySth = $dbh->prepare(qq{
    SELECT
        companyID
      FROM
        company
      WHERE
        name = ?
      ORDER BY
        dateCreated DESC
      LIMIT 1;
  });
  $companySth->execute($cgi->param('companyName'));
  my $company = $companySth->fetchrow_hashref();
  
  ## Create the company attributes
  $companyAttrSth = $dbh->prepare(qq{
    INSERT
      INTO
        companyAttribute
        (companyID, attrTypeID, attrValue, dateAttrFrom, dateCreated, dateLastModified)
      VALUES
        (?, ?, ?, NOW(), NOW(), NOW()),
        (?, ?, ?, NOW(), NOW(), NOW()),
        (?, ?, ?, NOW(), NOW(), NOW());
  });
  $companyAttrSth->execute(
    $company->{'companyID'}, 'PHONE-OFFICE', $cgi->param('companyPhoneOffice'),
    $company->{'companyID'}, 'ABN', $cgi->param('companyABN'),
    $company->{'companyID'}, 'ACN', $cgi->param('companyACN')
  );
  
  ## Create the customer
  $customerSth = $dbh->prepare(qq{
    INSERT
      INTO
        customer
      SET
        companyID = ?,
        dateCreated = NOW(),
        dateLastModified = NOW();
  });
  $customerSth->execute($company->{'companyID'});
  
  ## Get the new customer ID
  $customerSth = $dbh->prepare(qq{
    SELECT
        customerID
      FROM
        customer
      WHERE
        companyID = ?
      ORDER BY
        dateCreated DESC
      LIMIT 1;
  });
  $customerSth->execute($company->{'companyID'});
  my $customer = $customerSth->fetchrow_hashref();
  
  ## Create the contact
  $contactSth = $dbh->prepare(qq{
    INSERT
      INTO
        contact
      SET
        firstName = ?,
        lastName = ?,
        primaryEmail = ?,
        dateCreated = NOW(),
        dateLastModified = NOW();
  });
  $contactSth->execute($cgi->param('contactFirstName'), $cgi->param('contactLastName'), $cgi->param('contactEmail'));
  
  ## Get the new contact ID
  $contactSth = $dbh->prepare(qq{
    SELECT
        contactID
      FROM
        contact
      WHERE
        primaryEmail = ?
      ORDER BY
        dateCreated DESC
      LIMIT 1;
  });
  $contactSth->execute($cgi->param('contactEmail'));
  my $contact = $contactSth->fetchrow_hashref();
  
  ## Join the customer and customer contact rows
  $customerContactSth = $dbh->prepare(qq{
    INSERT
      INTO
        customerContact
      SET
        customerID = ?,
        contactID = ?,
        contactTypeID = 'PRIMARY',
        dateFrom = NOW(),
        dateCreated = NOW(),
        dateLastModified = NOW();
  });
  $customerContactSth->execute($customer->{'customerID'}, $contact->{'contactID'});
  
  ## Create the contact attributes
  $contactAttrSth = $dbh->prepare(qq{
    INSERT
      INTO
        contactAttribute
        (contactID, attrTypeID, attrValue, dateAttrFrom, dateCreated, dateLastModified)
      VALUES
        (?, ?, ?, NOW(), NOW(), NOW()),
        (?, ?, ?, NOW(), NOW(), NOW()),
        (?, ?, ?, NOW(), NOW(), NOW()),
        (?, ?, ?, NOW(), NOW(), NOW());
  });
  $contactAttrSth->execute(
    $contact->{'contactID'}, 'PHONE-OFFICE', $cgi->param('contactPhoneOffice'),
    $contact->{'contactID'}, 'PHONE-MOBILE', $cgi->param('contactPhoneMobile'),
    $contact->{'contactID'}, 'PHONE-OTHER', $cgi->param('contactPhoneOther'),
    $contact->{'contactID'}, 'EMAIL-PRIMARY', $cgi->param('contactEmail')
  );
  
  ## Insert the company and contact address
  $addressSth = $dbh->prepare(qq{
    INSERT
      INTO
        address
      SET
        firstLine = ?,
        secondLine = ?,
        city = ?,
        stateID = ?,
        postcode = ?,
        dateCreated = NOW(),
        dateLastModified = NOW();
  });
  $addressSth->execute($cgi->param('addressLine1'), $cgi->param('addressLine2'), $cgi->param('addressSuburb'), $cgi->param('addressStateID'), $cgi->param('addressPostcode'));
  
  ## Get the new address ID
  $addressSth = $dbh->prepare(qq{
    SELECT
        addressID
      FROM
        address
      WHERE
        postcode = ?
      ORDER BY
        dateCreated DESC
      LIMIT 1;
  });
  $addressSth->execute($cgi->param('addressPostcode'));
  my $address = $addressSth->fetchrow_hashref();
  
  ## Join the address with the company
  $companyAddressSth = $dbh->prepare(qq{
    INSERT
      INTO
        companyAddress
      SET
        companyID = ?,
        addressID = ?,
        dateFrom = NOW(),
        dateCreated = NOW(),
        dateLastModified = NOW();
  });
  $companyAddressSth->execute($company->{'companyID'}, $address->{'addressID'});
  
  ## Join the address with the contact
  $contactAddressSth = $dbh->prepare(qq{
    INSERT
      INTO
        contactAddress
      SET
        contactID = ?,
        addressID = ?,
        dateFrom = NOW(),
        dateCreated = NOW(),
        dateLastModified = NOW();
  });
  $contactAddressSth->execute($contact->{'contactID'}, $address->{'addressID'});
  
  ## Make the new contact login
  $contactLoginSth = $dbh->prepare(qq{
    INSERT
      INTO
        contactLogin
      SET
        contactID = ?,
        username = ?,
        password = SUBSTRING(MD5(NOW()), 2, 10),
        dateCreated = NOW(),
        dateLastModified = NOW();
  });
  $contactLoginSth->execute($contact->{'contactID'}, substr($cgi->param('contactFirstName'), 0, 3).'-'.substr(time(), 0, 5));
  
  ## Add the invoice
  $invoiceSth = $dbh->prepare(qq{
    INSERT
      INTO
        invoice
      SET
        invoiceStatus = 'NEW',
        dateInvoiceCreated = NOW(),
        dateInvoiceSent = NOW(),
        dateInvoiceDue = NOW();
  });
  $invoiceSth->execute();
  
  ## Get the new invoice ID
  $invoiceSth = $dbh->prepare(qq{
    SELECT
        invoiceID
      FROM
        invoice
      WHERE
        invoiceStatus = 'NEW'
      ORDER BY
        dateInvoiceCreated DESC
      LIMIT 1;
  });
  $invoiceSth->execute();
  my $invoice = $invoiceSth->fetchrow_hashref();  
  
  ## Add the invoice item
  my $paymentAmount = ($cgi->param('paymentOption') eq 'paymentOption1') ? '700.00' : '779.00';
  my $paymentGST = ($cgi->param('paymentOption') eq 'paymentOption1') ? '70.00' : '77.90';
  $invoiceItemSth = $dbh->prepare(qq{
    INSERT
      INTO
        invoiceItem
        (invoiceID, itemSequence, chargeType, itemDescription, itemDetails, itemQuantity, itemPrice, itemTaxable)
      VALUES
        (?, 1, 'PRODUCT', ?, NULL, 1, ?, 1),
        (?, NULL, 'TAX', 'GST 10%', NULL, 1, ?, 0);
  });
  $invoiceItemSth->execute(
    $invoice->{'invoiceID'}, 'Premium Ecommerce Website', $paymentAmount,
    $invoice->{'invoiceID'}, $paymentGST
  );
  
  ## Link the invoice to the customer account
  $invoiceSth = $dbh->prepare(qq{
    INSERT
      INTO
        customerInvoice
      SET
        customerID = ?,
        invoiceID = ?;
  });
  $invoiceSth->execute($customer->{'customerID'}, $invoice->{'invoiceID'});
  
  ## Do the payment stuff
  my $customerID = $customer->{'customerID'};
  my $contactID = $contact->{'contactID'};
  my $total = ($cgi->param('paymentOption') eq 'paymentOption1') ? '770.00' : '100.00';
  
  ## Add the payment row
  my $newPayment = $dbh->prepare(qq{
    INSERT
      INTO
        payment
      SET
        customerID = ?,
        contactID = ?,
        paymentMethodID = 'PAYPAL',
        paymentAmount = ?,
        paymentStatus = 'START',
        dateCreated = NOW(),
        datePaid = NULL;
  });
  $newPayment->execute($customerID, $contactID, $total);
  
  ## Get the payment ID for the new row to identify payment
  my $paymentSth = $dbh->prepare(qq{
    SELECT
        p.paymentID
      FROM
        payment p
      WHERE
        p.customerID = ?
        AND p.contactID = ?
        AND p.paymentStatus = 'START'
        AND p.datePaid IS NULL
      ORDER BY
        dateCreated DESC
      LIMIT
        1;
  });
  $paymentSth->execute($customerID, $contactID);
  my $payment = $paymentSth->fetchrow_hashref();
  
  ## Add the payment attributes
  my $newPaymentAttrs = $dbh->prepare(qq{
    INSERT
      INTO
        paymentAttribute
        (paymentID, attrTypeID, attrValue, dateAttrFrom, dateCreated, dateLastModified)
      VALUES
        (?, 'COMPLETION_REDIRECT', ?, NOW(), NOW(), NOW());
  });
  $newPaymentAttrs->execute($payment->{'paymentID'}, $CONFIG{'web_addr'}.'order/express/complete/'.$payment->{'paymentID'});
  
	## Prepare Email Notification
	my $subject = qq~IntegratedWeb New Order~;
	my $email = qq~An order has been placed at www.integratedweb.com.au for a Premium Ecommerce Website (\$779)
	<br /><br /><strong>Their customer ID is $customer->{'customerID'}</strong>
	<br /><strong>Website Name</strong> ~.$cgi->param('websiteName').qq~
	<br /><strong>Website Domain Name</strong> ~.$cgi->param('websiteDomainName').qq~
	<br /><strong>Is the domain registered</strong> ~.$cgi->param('websiteDomainRegistered').qq~
	<br /><strong>Business Nature</strong> ~.$cgi->param('websiteBusinessNature').qq~
	<br /><strong>Business Sells</strong> ~.$cgi->param('websiteBusinessSells').qq~
	<br /><strong>Business Products</strong> ~.$cgi->param('websiteBusinessProducts').qq~
	<br /><strong>Notes</strong> ~.$cgi->param('notes').qq~
	<br /><br />Sincerely,<br />Web Team~;
	
	## Send Email Message
  $sender = new Mail::Sender {
    smtp => $CONFIG{'mail_auth_host'},
    from => 'Integrated Web Services <'.$CONFIG{'mail_noreply'}.'>',
    auth => $CONFIG{'mail_smtp_auth_type'},
    authid => $CONFIG{'mail_auth_user'},
    authpwd => $CONFIG{'mail_auth_pass'},
    on_errors => 'die',
    ctype => 'text/html'
  }
  or die "Can't create the Mail::Sender object: $Mail::Sender::Error\n";

  $sender->Open({
    to => $CONFIG{'mail_quote'},
    subject => $subject
  }) 
    or die "Can't open the message: $sender->{'error_msg'}\n";
  $sender->SendLineEnc('<html>'.$email.'</html>');
  $sender->Close()
    or die "Failed to send the message: $sender->{'error_msg'}\n";
  
  ## Begin processing via PayPal  
  my $address = {
    Name => $cgi->param('contactFirstName').' '.$cgi->param('contactLastName'),
    Street1 => $cgi->param('addressLine1'),
    Street2 => $cgi->param('addressLine2'),
    CityName => $cgi->param('addressSuburb'),
    PostalCode => $cgi->param('addressPostcode'),
    Phone => $cgi->param('companyPhoneOffice')
  };
  
  use Business::PayPal::API qw( ExpressCheckout GetTransactionDetails TransactionSearch RefundTransaction );
  my $pp = new Business::PayPal::API (
    Username => $CONFIG{'api_paypal_username'},
    Password => $CONFIG{'api_paypal_password'},
    Signature => $CONFIG{'api_paypal_signature'},
    sandbox => 1
  );
  
  my %result = $pp->SetExpressCheckout(
    ReturnURL => $CONFIG{'web_addr'}.'api/paypal',
    CancelURL => $CONFIG{'web_addr'}.'api/paypal',
    OrderTotal => $total,
    Custom => 'paypal-'.$payment->{'paymentID'},
    NoShipping => 1,
    currencyID => 'AUD',
    PaymentAction => 'Sale',
    Address => $address,
    'cpp-header-image' => $CONFIG{'web_addr'}.'img/iw2/iw.logo.png'
  );
  
  $PAGE{'redirect'} = $CONFIG{'api_paypal_expressurl'}.'?cmd=_express-checkout&token='.$result{'Token'};
  
}

1;