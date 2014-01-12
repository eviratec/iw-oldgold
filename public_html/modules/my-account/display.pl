# Integrated Web
#   Account Module

##
##  TO DO:
##  - Fix dates thoughout accounts module
##

use Switch;

sub displayModule {
  
  $PAGE{'section'} = 'my-account';

  if (@REQUEST > 0) {
    # There is a request after 'services' so we'll figure it out and display the correct page
    my $subreq = shift(@REQUEST);
    $PAGE{'thread'} .= '<a href="'.$CONFIG{'web_addr'}.'my-account">my account</a> / ';
    #print "Content-type: text/html \n\n".$subreq; exit;
    if (!$session->param('loggedIn') && $subreq ne 'login' && $subreq ne 'lost-password') {
      $PAGE{'redirect'} = $CONFIG{'web_addr'}.'my-account/login';
      return;
    }
    
    switch ($subreq) {
      case 'login' {
        showLogin();
      }
      case 'logout' {
        showLogout();
      }
      case 'lost-password' {
        showLostPassword();
      }
      case 'support' {
        showTicketDashboard();
      }
      case 'customer' {
        if (@REQUEST > 0) {
          
        }
        else {
          showCustomerList();
        }
      }
      case 'invoices' {
        if (@REQUEST > 0) {
          our $invoiceID = shift(@REQUEST);
          showInvoice();
        }
        else {
          showInvoiceList();
        }
      }
      case 'payments' {
        if (@REQUEST > 0) {
          our $paymentID = shift(@REQUEST);
          if ($paymentID !~ /^[0-9].+$/) {
            my $subreqb = $paymentID;
            $paymentID = undef;
            switch ($subreqb) {
              case 'new' {
                showNewPayment();
              }
              case 'process' {
                processPayment();
              }
              else {
                $PAGE{'redirect'} = $CONFIG{'web_addr'}.'/my-account/payments';
              }
            }
          }
          else {
            showPayment();
          }
        }
        else {
          showPaymentList();
        }
      }
      case 'details' {
        if (@REQUEST > 0) {
          my $subreqb = shift(@REQUEST);
          switch ($subreqb) {
            case 'edit' {
              showEditDetails();
            }
            else {
              $PAGE{'404'} = 1;
            }
          }
        }
        else {
          showDetails();
        }
      }
      case 'websites' {
        require $CONFIG{'full_path'}.'modules/my-account/websites.pl';
        websiteModule();
        return;
      }
      else {
        $PAGE{'404'} = 1;
      }
    }

  } else {
    # if the contact has only one account, show customer dashboard
    #if (CONTACT_FOR_ONE_CUSTOMER) {
    # showCustomerDashboard();
    #}
    #else {
    # or else show the multi-customer dashboard
      if (!$session->param('loggedIn')) {
        $PAGE{'redirect'} = $CONFIG{'web_addr'}.'my-account/login';
        return;
      }
      showDashboard();
    #}
  }
  
}

sub showDashboard {

  $subTplName = 'dashboard.htm';
  
  $PAGE{'thread'} .= 'dashboard';
  $PAGE{'title'} = 'Dashboard';
  
  ## Get the customer ID
  if (!$customerID) {
    my $customerSth = $dbh->prepare(qq{
      SELECT
          c.customerID
        FROM
          customerContact co
          LEFT JOIN customer c ON co.customerID = c.customerID
        WHERE
          co.contactID = ?
          AND (co.dateThru IS NULL OR co.dateThru > NOW())
        LIMIT 1
    });
    $customerSth->execute($session->param('contactID'));
    my @customer = $customerSth->fetchrow_hashref;
    our $customerID = $customer[0]{'customerID'};
  }
  
  $subTplVars->{'customerID'} = $customerID;
  
  ## Get customer balance
  my $balanceSth = $dbh->prepare(qq{
    SELECT
        SUM(p.paymentAmount) AS `Credits`,
        ( SELECT
              SUM(item.itemQuantity*item.itemPrice) AS 'invTotal'
            FROM
              customerInvoice ci
              LEFT JOIN invoice i ON ci.invoiceID = i.invoiceID
              LEFT JOIN invoiceItem item ON i.invoiceID = item.invoiceID
            WHERE
              ci.customerID = p.customerID
            GROUP BY
              ci.customerID
        ) AS `Debits`
      FROM
        payment p
      WHERE
        p.customerID = ?
        AND p.paymentStatus = 'COMPLETE'
      GROUP BY
        p.customerID
    });
  $balanceSth->execute($customerID);
  my @bal = $balanceSth->fetchrow_hashref;
  my $balance = ($bal[0]{'Credits'} >= $bal[0]{'Debits'}) ? $bal[0]{'Credits'}-$bal[0]{'Debits'} : $bal[0]{'Debits'}-$bal[0]{'Credits'} ;
  $subTplVars->{'customerBalance'} = $currency->format_number($balance, 2, 1);
  $subTplVars->{'customerBalanceIn'} = ($bal[0]{'Credits'} >= $bal[0]{'Debits'}) ? 'credit' : 'debit';
  my ($tyear,$tmonth,$tday,$thour,$tmin,$tsec) = Today_and_Now();
  $subTplVars->{'dateNow'} = "$tday/$tmonth/$tyear $thour:$tmin";
  
}

sub showLogin {
  
  if ($session->param('loggedIn')) {
    $PAGE{'redirect'} = $CONFIG{'web_addr'}.'my-account';
    return;
  }
  
  if ($cgi->param("username")) {
    # Set up the template variables
    my $username = $cgi->param("username");
    my $password = $cgi->param("password");
    my $sth = $dbh->prepare(qq{ SELECT * FROM contactLogin WHERE username = ? AND password = ? });
    $sth->execute($username, $password);
    if ($sth->rows > 0) {
      my $user = $sth->fetchrow_hashref;
      my $contactSth = $dbh->prepare(qq{ SELECT * FROM contact WHERE contactID = ? });
      $contactSth->execute($user->{'contactID'});
      my $contact = $contactSth->fetchrow_hashref;
      $session->param('contactID', $user->{'contactID'});
      $session->param('fullName', $contact->{'firstName'}.' '.$contact->{'lastName'});
      $session->param('loggedIn', 1);
      $session->expire('+8h');
      $session->save_param();
      $PAGE{'redirect'} = $CONFIG{'web_addr'}.'my-account';
      return;
    }
    else {
      $subTplVars->{'errorDivDisplay'} = 'block';
    }
  }
  else {
    # Set up the template variables
    $subTplVars->{'errorDivDisplay'} = 'none';
  }
  
  # Set the template for this page
  $subTplName = 'login.htm';
  
  # Set the information required by the main template
  $PAGE{'thread'} .= 'login';
  $PAGE{'title'} = 'My Account Login';
  
  $PAGE{'robots'} = 'index,follow';
  $PAGE{'keywords'} = 'web services, services, website design, web application, web development, application development, hosting, webhosting, web hosting, ecommerce, e commerce, commerce, store, online store, web store, shop, online shop, web shop, start online store, sell online, business, web presence, '.$CONFIG{'tmpl_page_keywords'};
  $PAGE{'description'} = 'Integrated Web Services provide a range of services including website design, web application development, hosting, and eCommerce to Australian businesses.  We can provide you with everything you need to get your business online.';
  
  
}

sub showLogout {
  
  if ($session->param('loggedIn')) {
    $subTplName = 'logout.htm';
    
    $PAGE{'thread'} .= 'logout';
    $PAGE{'title'} = 'Logout';
  
    $session->delete();
    $session->close();
    $session->new();
  }
  else {
    $PAGE{'redirect'} = $CONFIG{'web_addr'};
  }

}

sub showLostPassword {

  $subTplName = 'lostPassword.htm';
  
  $PAGE{'thread'} .= 'lost password';
  $PAGE{'title'} = 'Lost Password';
  
  if ($cgi->param('email') || $cgi->param('username')) {
    if ($cgi->param('email')) {
      my $userByEmail = 0;
    }
    elsif ($cgi->param('username')) {
      
    }
    if ($error == 1) {
      $subTplVars->{'errorDivDisplay'} = 'block';
    }
  }
  else {
    $subTplVars->{'errorDivDisplay'} = 'none';
  }
  
}

sub showCustomerList {

  $subTplName = 'customerList.htm';
  
  $PAGE{'thread'} .= 'customer list';
  $PAGE{'title'} = 'Customer List';

}

sub showCustomerDashboard {

  $subTplName = 'customerDashboard.htm';
  
  $PAGE{'thread'} .= 'lost password';
  $PAGE{'title'} = 'Lost Password';
  
}

sub showInvoiceList {

  $subTplName = 'invoiceList.htm';
  
  $PAGE{'thread'} .= 'my invoices';
  $PAGE{'title'} = 'My Invoices';
  
  ## Get the customer ID for this invoices display screen
  if (!$customerID) {
    my $customerSth = $dbh->prepare(qq{
      SELECT
          c.customerID
        FROM
          customerContact co
          LEFT JOIN customer c ON co.customerID = c.customerID
        WHERE
          co.contactID = ?
          AND (co.dateThru IS NULL OR co.dateThru > NOW())
        LIMIT 1
    });
    $customerSth->execute($session->param('contactID'));
    my @customer = $customerSth->fetchrow_hashref;
    our $customerID = $customer[0]{'customerID'};
  }
  
  ## Get customer balance
  my $balanceSth = $dbh->prepare(qq{
    SELECT
        SUM(p.paymentAmount) AS `Credits`,
        ( SELECT
              SUM(item.itemQuantity*item.itemPrice) AS 'invTotal'
            FROM
              customerInvoice ci
              LEFT JOIN invoice i ON ci.invoiceID = i.invoiceID
              LEFT JOIN invoiceItem item ON i.invoiceID = item.invoiceID
            WHERE
              ci.customerID = p.customerID
            GROUP BY
              ci.customerID
        ) AS `Debits`
      FROM
        payment p
      WHERE
        p.customerID = ?
        AND p.paymentStatus = 'COMPLETE'
      GROUP BY
        p.customerID
    });
  $balanceSth->execute($customerID);
  my @bal = $balanceSth->fetchrow_hashref;
  my $balance = ($bal[0]{'Credits'} >= $bal[0]{'Debits'}) ? $bal[0]{'Credits'}-$bal[0]{'Debits'} : $bal[0]{'Debits'}-$bal[0]{'Credits'} ;
  $subTplVars->{'customerBalance'} = $currency->format_number($balance, 2, 1);
  $subTplVars->{'customerBalanceIn'} = ($bal[0]{'Credits'} >= $bal[0]{'Debits'}) ? 'credit' : 'debit';

  my ($tyear,$tmonth,$tday,$thour,$tmin,$tsec) = Today_and_Now();
  $subTplVars->{'dateNow'} = "$tday/$tmonth/$tyear $thour:$tmin";

  ## Get the invoices list
  my $invoiceSth = $dbh->prepare(qq{
    SELECT
        i.*,
        SUM(item.itemQuantity*item.itemPrice) AS 'invTotal'
      FROM
        customer c
        LEFT JOIN customerInvoice ci ON c.customerID = ci.customerID
        LEFT JOIN invoice i ON ci.invoiceID = i.invoiceID
        LEFT JOIN invoiceItem item ON i.invoiceID = item.invoiceID
      WHERE
        c.customerID = ?
      GROUP BY
        i.invoiceID
    });
  $invoiceSth->execute($customerID);
  my @invoiceList = ();
  for (my $i = 0; $i < $invoiceSth->rows; $i++) {
    push (@invoiceList, $invoiceSth->fetchrow_hashref);
    $invoiceList[$i]{'invTotal'} = $currency->format_number($invoiceList[$i]{'invTotal'}, 2, 1);
  }
  @{$subTplVars->{'invoiceList'}} = @invoiceList;
  
}

sub showInvoice {

  $subTplName = 'invoice.htm';
  
  $PAGE{'thread'} .= 'tax invoice';
  $PAGE{'title'} = 'Tax Invoice';
  
  ## Get the customer ID for this invoices display screen
  if (!$customerID) {
    my $customerSth = $dbh->prepare(qq{
      SELECT
          c.customerID
        FROM
          customerContact co
          LEFT JOIN customer c ON co.customerID = c.customerID
        WHERE
          co.contactID = ?
          AND (co.dateThru IS NULL OR co.dateThru > NOW())
        LIMIT 1
    });
    $customerSth->execute($session->param('contactID'));
    my @customer = $customerSth->fetchrow_hashref;
    our $customerID = $customer[0]{'customerID'};
  }
  
  my $addressSth = $dbh->prepare(qq{
    SELECT 
        cust.customerID,
        company.name,
        contact.firstName,
        contact.lastName,
        address.firstLine,
        address.secondLine,
        address.city,
        address.postcode,
        state.stateName,
        country.countryName
      FROM 
        customer cust
        JOIN customerContact cont
        LEFT JOIN contact ON cont.contactID = contact.contactID
        JOIN company
        JOIN contactAddress addr
        NATURAL JOIN address
        NATURAL JOIN dataCountryState state
        NATURAL JOIN dataCountry country
      WHERE
        cust.customerID = ?
        AND cont.dateFrom < NOW()
        AND (cont.dateThru IS NULL OR cont.dateThru > NOW())
        AND (cont.contactTypeID = 'BILLING' OR cont.contactTypeID = 'PRIMARY')
        AND addr.dateFrom < NOW()
        AND (addr.dateThru IS NULL OR addr.dateThru > NOW())
  });
  $addressSth->execute($customerID);
  my @addressInfo = $addressSth->fetchrow_hashref();
  @{$subTplVars->{'addressInfo'}} = @addressInfo;
  
  my $invoiceSth = $dbh->prepare(qq{
    SELECT
        i.*,
        item.*,
        itemTax.itemPrice AS 'itemTax',
        ROUND((item.itemPrice*item.itemQuantity), 2) AS `lineTotal`
      FROM
        customer c
        LEFT JOIN customerInvoice ci ON c.customerID = ci.customerID
        LEFT JOIN invoice i ON ci.invoiceID = i.invoiceID
        LEFT JOIN invoiceItem item ON i.invoiceID = item.invoiceID
        LEFT JOIN invoiceItem itemTax ON itemTax.parentInvoiceItemID = item.invoiceItemID
      WHERE
        c.customerID = ?
        AND i.invoiceID = ?
        AND item.chargeType IN ('SERVICE','PRODUCT','SUBSCRIPTION')
      ORDER BY
        item.itemSequence ASC
  });
  $invoiceSth->execute($customerID, $invoiceID);
  
  if ($invoiceSth->rows > 0) {
    
    my @invoiceItemList = ();
    my ($subTotal,$tax,$total) = (0,0,0);
    for (my $i = 0; $i < $invoiceSth->rows; $i++) {
      push (@invoiceItemList, $invoiceSth->fetchrow_hashref);
      $invoiceItemList[$i]{'itemQuantity'} = sprintf("%.2f", $invoiceItemList[$i]{'itemQuantity'});
      $subTotal += $invoiceItemList[$i]{'lineTotal'};
      $tax += $invoiceItemList[$i]{'itemTax'}*$invoiceItemList[$i]{'itemQuantity'};
      $total += $invoiceItemList[$i]{'lineTotal'}+($invoiceItemList[$i]{'itemTax'}*$invoiceItemList[$i]{'itemQuantity'});
      
      $invoiceItemList[$i]{'lineTotal'} = $currency->format_number($invoiceItemList[$i]{'lineTotal'}, 2, 1);
      $invoiceItemList[$i]{'itemQuantity'} = $currency->format_number($invoiceItemList[$i]{'itemQuantity'}, 2, 1);
      $invoiceItemList[$i]{'itemPrice'} = $currency->format_number($invoiceItemList[$i]{'itemPrice'}, 2, 1);
      
      $invoiceItemList[$i]{'dispDetails'} = ($invoiceItemList[$i]{'itemDetails'}) ? 1 : 0;
    }
    
    my ($date,$time) = split(/ /,$invoiceItemList[0]{'dateInvoiceDue'});
    my ($year, $month, $day) = split(/\-/,$date);
    $invoiceItemList[0]{'dateInvoiceDue'} = "$day/$month/$year";
    $invoiceItemList[0]{'invoiceSubTotal'} = $currency->format_number($subTotal, 2, 1);
    $invoiceItemList[0]{'invoiceTax'} = $currency->format_number($tax, 2, 1);
    $invoiceItemList[0]{'invoiceTotal'} = $currency->format_number($total, 2, 1);
    @{$subTplVars->{'invoiceItemList'}} = @invoiceItemList;
    
  }
  else {
    $PAGE{'redirect'} = $CONFIG{'web_addr'}.'my-account/invoices';
  }

}

sub showPayment {

  $subTplName = 'payment.htm';
  
  $PAGE{'thread'} .= 'view payment';
  $PAGE{'title'} = 'view payment';

}

sub showPaymentList {

  $subTplName = 'paymentList.htm';
  
  $PAGE{'thread'} .= 'my payments';
  $PAGE{'title'} = 'My Payments';
  
  ## Get the customer ID for this payments display screen
  if (!$customerID) {
    my $customerSth = $dbh->prepare(qq{
      SELECT
          c.customerID
        FROM
          customerContact co
          LEFT JOIN customer c ON co.customerID = c.customerID
        WHERE
          co.contactID = ?
          AND (co.dateThru IS NULL OR co.dateThru > NOW())
        LIMIT 1
    });
    $customerSth->execute($session->param('contactID'));
    my @customer = $customerSth->fetchrow_hashref;
    our $customerID = $customer[0]{'customerID'};
  }
  
  ## Get customer balance
  my $balanceSth = $dbh->prepare(qq{
    SELECT
        SUM(p.paymentAmount) AS `Credits`,
        ( SELECT
              SUM(item.itemQuantity*item.itemPrice) AS 'invTotal'
            FROM
              customerInvoice ci
              LEFT JOIN invoice i ON ci.invoiceID = i.invoiceID
              LEFT JOIN invoiceItem item ON i.invoiceID = item.invoiceID
            WHERE
              ci.customerID = p.customerID
            GROUP BY
              ci.customerID
        ) AS `Debits`
      FROM
        payment p
      WHERE
        p.customerID = ?
        AND p.paymentStatus = 'COMPLETE'
      GROUP BY
        p.customerID
    });
  $balanceSth->execute($customerID);
  my @bal = $balanceSth->fetchrow_hashref;
  my $balance = ($bal[0]{'Credits'} >= $bal[0]{'Debits'}) ? $bal[0]{'Credits'}-$bal[0]{'Debits'} : $bal[0]{'Debits'}-$bal[0]{'Credits'} ;
  $subTplVars->{'customerBalance'} = $currency->format_number($balance, 2, 1);
  $subTplVars->{'customerBalanceIn'} = ($bal[0]{'Credits'} >= $bal[0]{'Debits'}) ? 'credit' : 'debit';
  my ($tyear,$tmonth,$tday,$thour,$tmin,$tsec) = Today_and_Now();
  $subTplVars->{'dateNow'} = "$tday/$tmonth/$tyear $thour:$tmin";
  
  ## Get the payments list
  my $paymentSth = $dbh->prepare(qq{
    SELECT
        p.paymentID,
        p.paymentAmount,
        p.paymentStatus,
        p.datePaid,
        m.paymentMethodName
      FROM
        customer c
        LEFT JOIN payment p ON c.customerID = p.customerID
        LEFT JOIN paymentMethod m ON p.paymentMethodID = m.paymentMethodID
      WHERE
        c.customerID = ?
    });
  $paymentSth->execute($customerID);
  my @paymentList = ();
  for (my $i = 0; $i < $paymentSth->rows; $i++) {
    push (@paymentList, $paymentSth->fetchrow_hashref);
    #$paymentList[$i]{'paymentDate'} = $currency->format_number($paymentList[$i]{'invTotal'}, 2, 1);
  }
  @{$subTplVars->{'paymentList'}} = @paymentList;

}

sub showNewPayment {

  $subTplName = 'newPayment.htm';
  
  $PAGE{'thread'} .= 'new payment';
  $PAGE{'title'} = 'New Payment';
  
  ## Get the customer ID & other contact info
  my $customerSth = $dbh->prepare(qq{
    SELECT
        c.customerID,
        CONCAT(contact.firstName, ' ', contact.lastName) AS contactName,
        company.name AS companyName
      FROM
        customerContact co
        LEFT JOIN customer c ON co.customerID = c.customerID
        LEFT JOIN contact ON contact.contactID = co.contactID
        LEFT JOIN company ON company.companyID = c.companyID
      WHERE
        co.contactID = ?
        AND (co.dateThru IS NULL OR co.dateThru > NOW())
      LIMIT 1
  });
  $customerSth->execute($session->param('contactID'));
  my @customer = $customerSth->fetchrow_hashref;
  our $customerID = $customer[0]{'customerID'};
  $subTplVars->{'customerID'} = $customer[0]{'customerID'};
  $subTplVars->{'contactName'} = $customer[0]{'contactName'};
  $subTplVars->{'companyName'} = $customer[0]{'companyName'};
  
  ## Get customer balance
  my $balanceSth = $dbh->prepare(qq{
    SELECT
        SUM(p.paymentAmount) AS `Credits`,
        ( SELECT
              SUM(item.itemQuantity*item.itemPrice) AS 'invTotal'
            FROM
              customerInvoice ci
              LEFT JOIN invoice i ON ci.invoiceID = i.invoiceID
              LEFT JOIN invoiceItem item ON i.invoiceID = item.invoiceID
            WHERE
              ci.customerID = p.customerID
            GROUP BY
              ci.customerID
        ) AS `Debits`
      FROM
        payment p
      WHERE
        p.customerID = ?
        AND p.paymentStatus = 'COMPLETE'
      GROUP BY
        p.customerID
    });
  $balanceSth->execute($customerID);
  my @bal = $balanceSth->fetchrow_hashref;
  my $balance = ($bal[0]{'Credits'} >= $bal[0]{'Debits'}) ? $bal[0]{'Credits'}-$bal[0]{'Debits'} : $bal[0]{'Debits'}-$bal[0]{'Credits'} ;
  $subTplVars->{'customerBalance'} = $currency->format_number($balance, 2, 1);
  $subTplVars->{'customerBalanceIn'} = ($bal[0]{'Credits'} >= $bal[0]{'Debits'}) ? 'credit' : 'debit';
  my ($tyear,$tmonth,$tday,$thour,$tmin,$tsec) = Today_and_Now();
  $subTplVars->{'dateNow'} = "$tday/$tmonth/$tyear $thour:$tmin";
  $subTplVars->{'prePopPayment'} = ($bal[0]{'Credits'} >= $bal[0]{'Debits'}) ? '0.00' : $currency->format_number($balance, 2, 1);
  
}

sub processPayment {
  
  ## Get address info
  
  $contactSth = $dbh->prepare(qq{
    SELECT 
        c.*,
        phMob.attrValue AS `phoneMobile`,
        phOff.attrValue AS `phoneOffice`,
        phOth.attrValue AS `phoneOther`,
        emPri.attrValue AS `emailPrimary`,
        emSec.attrValue AS `emailSecondary`,
        a.*,
        astate.stateName,
        acountry.countryName
      FROM 
        contact c
        LEFT JOIN contactAddress ca ON ca.contactID = c.contactID AND ca.dateFrom < NOW() AND (ca.dateThru IS NULL OR ca.dateThru > NOW())
        LEFT JOIN address a ON ca.addressID = a.addressID
        LEFT JOIN dataCountryState astate ON a.stateID = astate.stateID
        LEFT JOIN dataCountry acountry ON astate.countryID = acountry.countryID
        LEFT JOIN contactAttribute phMob ON phMob.contactID = c.contactID AND phMob.attrTypeID = 'PHONE-MOBILE' AND phMob.dateAttrFrom < NOW() AND (phMob.dateAttrThru IS NULL OR phMob.dateAttrThru > NOW())
        LEFT JOIN contactAttribute phOff ON phOff.contactID = c.contactID AND phOff.attrTypeID = 'PHONE-OFFICE' AND phOff.dateAttrFrom < NOW() AND (phOff.dateAttrThru IS NULL OR phOff.dateAttrThru > NOW())
        LEFT JOIN contactAttribute phOth ON phOth.contactID = c.contactID AND phOth.attrTypeID = 'PHONE-OTHER' AND phOth.dateAttrFrom < NOW() AND (phOth.dateAttrThru IS NULL OR phOth.dateAttrThru > NOW())
        LEFT JOIN contactAttribute emPri ON emPri.contactID = c.contactID AND emPri.attrTypeID = 'EMAIL-PRIMARY' AND emPri.dateAttrFrom < NOW() AND (emPri.dateAttrThru IS NULL OR emPri.dateAttrThru > NOW())
        LEFT JOIN contactAttribute emSec ON emSec.contactID = c.contactID AND emSec.attrTypeID = 'EMAIL-SECONDARY' AND emSec.dateAttrFrom < NOW() AND (emSec.dateAttrThru IS NULL OR emSec.dateAttrThru > NOW())
      WHERE 
        c.contactID = ?
  });
  $contactSth->execute($session->param('contactID'));
  my $contact = $contactSth->fetchrow_hashref;
  
  ## Get the customer ID
  if (!$customerID) {
    my $customerSth = $dbh->prepare(qq{
      SELECT
          c.customerID
        FROM
          customerContact co
          LEFT JOIN customer c ON co.customerID = c.customerID
        WHERE
          co.contactID = ?
          AND (co.dateThru IS NULL OR co.dateThru > NOW())
        LIMIT 1
    });
    $customerSth->execute($session->param('contactID'));
    my @customer = $customerSth->fetchrow_hashref;
    our $customerID = $customer[0]{'customerID'};
  }
  
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
  $newPayment->execute($customerID, $session->param('contactID'), $cgi->param('total'));
  
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
  $paymentSth->execute($customerID, $session->param('contactID'));
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
  $newPaymentAttrs->execute($payment->{'paymentID'}, $CONFIG{'web_addr'}.'my-account/payments');
  
  ## Begin processing via PayPal  
  my $address = {
    Name => $contact->{'firstName'}.' '.$contact->{'lastName'},
    Street1 => $contact->{'firstLine'},
    Street2 => $contact->{'secondLine'},
    CityName => $contact->{'suburb'},
    StateOrProvince => $contact->{'stateName'},
    PostalCode => $contact->{'postcode'},
    Country => $contact->{'countryName'},
    Phone => $contact->{'phoneOffice'}
  };
  
  use Business::PayPal::API qw( ExpressCheckout GetTransactionDetails TransactionSearch RefundTransaction );
  my $pp = new Business::PayPal::API (
    Username => $CONFIG{'api_paypal_username'},
    Password => $CONFIG{'api_paypal_password'},
    Signature => $CONFIG{'api_paypal_signature'},
    sandbox => 1
  );
  
  $Business::PayPal::API::Debug = 1;
  
  my %result = $pp->SetExpressCheckout(
    ReturnURL => $CONFIG{'web_addr'}.'api/paypal',
    CancelURL => $CONFIG{'web_addr'}.'api/paypal',
    OrderTotal => $cgi->param('total'),
    Custom => 'paypal-'.$payment->{'paymentID'},
    NoShipping => 1,
    currencyID => 'AUD',
    PaymentAction => 'Sale',
    Address => $address,
    'cpp-header-image' => $CONFIG{'web_addr'}.'img/iw2/iw.logo.png'
  );
  
  $PAGE{'redirect'} = $CONFIG{'api_paypal_expressurl'}.'?cmd=_express-checkout&token='.$result{'Token'};
  
}

sub showDetails {

  $subTplName = 'details.htm';
  
  $PAGE{'thread'} .= 'customer details';
  $PAGE{'title'} = 'Customer Details';
  
  $contactSth = $dbh->prepare(qq{
    SELECT 
        c.*,
        phMob.attrValue AS `phoneMobile`,
        phOff.attrValue AS `phoneOffice`,
        phOth.attrValue AS `phoneOther`,
        emPri.attrValue AS `emailPrimary`,
        emSec.attrValue AS `emailSecondary`,
        a.*,
        astate.stateName,
        acountry.countryName
      FROM 
        contact c
        LEFT JOIN contactAddress ca ON ca.contactID = c.contactID AND ca.dateFrom < NOW() AND (ca.dateThru IS NULL OR ca.dateThru > NOW())
        LEFT JOIN address a ON ca.addressID = a.addressID
        LEFT JOIN dataCountryState astate ON a.stateID = astate.stateID
        LEFT JOIN dataCountry acountry ON astate.countryID = acountry.countryID
        LEFT JOIN contactAttribute phMob ON phMob.contactID = c.contactID AND phMob.attrTypeID = 'PHONE-MOBILE' AND phMob.dateAttrFrom < NOW() AND (phMob.dateAttrThru IS NULL OR phMob.dateAttrThru > NOW())
        LEFT JOIN contactAttribute phOff ON phOff.contactID = c.contactID AND phOff.attrTypeID = 'PHONE-OFFICE' AND phOff.dateAttrFrom < NOW() AND (phOff.dateAttrThru IS NULL OR phOff.dateAttrThru > NOW())
        LEFT JOIN contactAttribute phOth ON phOth.contactID = c.contactID AND phOth.attrTypeID = 'PHONE-OTHER' AND phOth.dateAttrFrom < NOW() AND (phOth.dateAttrThru IS NULL OR phOth.dateAttrThru > NOW())
        LEFT JOIN contactAttribute emPri ON emPri.contactID = c.contactID AND emPri.attrTypeID = 'EMAIL-PRIMARY' AND emPri.dateAttrFrom < NOW() AND (emPri.dateAttrThru IS NULL OR emPri.dateAttrThru > NOW())
        LEFT JOIN contactAttribute emSec ON emSec.contactID = c.contactID AND emSec.attrTypeID = 'EMAIL-SECONDARY' AND emSec.dateAttrFrom < NOW() AND (emSec.dateAttrThru IS NULL OR emSec.dateAttrThru > NOW())
      WHERE 
        c.contactID = ?
  });
  $contactSth->execute($session->param('contactID'));
  my $contact = $contactSth->fetchrow_hashref;
  $subTplVars->{'fullName'} = $contact->{'firstName'}.' '.$contact->{'lastName'};
  $subTplVars->{'info'} = $contact;
  
  $companySth = $dbh->prepare(qq{
    SELECT
        com.*,
        a.*,
        astate.stateName,
        acountry.countryName,
        acn.attrValue AS `acn`,
        abn.attrValue AS `abn`,
        phOff.attrValue AS `phoneOffice`
      FROM
        customerContact co
        LEFT JOIN customer c ON co.customerID = c.customerID
        LEFT JOIN company com ON c.companyID = com.companyID
        LEFT JOIN companyAddress ca ON ca.companyID = c.companyID AND ca.dateFrom < NOW() AND (ca.dateThru IS NULL OR ca.dateThru > NOW())
        LEFT JOIN address a ON ca.addressID = a.addressID
        LEFT JOIN dataCountryState astate ON a.stateID = astate.stateID
        LEFT JOIN dataCountry acountry ON astate.countryID = acountry.countryID
        LEFT JOIN companyAttribute acn ON acn.companyID = c.companyID AND acn.attrTypeID = 'ACN' AND acn.dateAttrFrom < NOW() AND (acn.dateAttrThru IS NULL OR acn.dateAttrThru > NOW())
        LEFT JOIN companyAttribute abn ON abn.companyID = c.companyID AND abn.attrTypeID = 'ABN' AND abn.dateAttrFrom < NOW() AND (abn.dateAttrThru IS NULL OR abn.dateAttrThru > NOW())
        LEFT JOIN companyAttribute phOff ON phOff.companyID = c.companyID AND phOff.attrTypeID = 'PHONE-OFFICE' AND phOff.dateAttrFrom < NOW() AND (phOff.dateAttrThru IS NULL OR phOff.dateAttrThru > NOW())
      WHERE
        co.contactID = ?
        AND (co.dateThru IS NULL OR co.dateThru > NOW())
  });
  $companySth->execute($session->param('contactID'));
  my $company = $companySth->fetchrow_hashref;
  $subTplVars->{'company'} = $company;

}

sub showEditDetails {

  $subTplName = 'editDetails.htm';
  
  $PAGE{'thread'} .= 'edit details';
  $PAGE{'title'} = 'Edit Details';

}

sub showTicketDashboard {

  $subTplName = 'ticketDashboard.htm';
  
  $PAGE{'thread'} .= 'customer support';
  $PAGE{'title'} = 'Customer Support';

}

sub showTicket {

  $subTplName = 'ticket.htm';
  
  $PAGE{'thread'} .= 'view ticket';
  $PAGE{'title'} = 'View Ticket';

}

sub submitTicket {
  
  ## Output thank-you page
  $PAGE{'thread'} .= 'thank-you';
  $PAGE{'title'} = 'Thank-you for your enquiry';
  
  $PAGE{'robots'} = 'none';
  
  $subTplName = 'submitTicket.htm';
  
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
    
  }
  
}

1;
