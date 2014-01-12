# Integrated Web
#   External API Module

use Switch;

sub displayModule {
  
  if (@REQUEST > 0) {
    our $subreq = shift(@REQUEST);
    switch ($subreq) {
      case /^paypal/ {
        startPayPalAPI();
      }
    }
  }
  else {
    $PAGE{'redirect'} = $CONFIG{'web_addr'};
    return;
  }
  
}

sub startPayPalAPI {
  
  ## PayPal Express Checkout Module
  use Business::PayPal::API qw( ExpressCheckout );
  my $pp = new Business::PayPal::API (
    Username => $CONFIG{'api_paypal_username'},
    Password => $CONFIG{'api_paypal_password'},
    Signature => $CONFIG{'api_paypal_signature'},
    sandbox => 1
  );
  $Business::PayPal::API::Debug = 1;
  
  ## Get the token out of the query string
  my $qString = $ENV{'REQUEST_URI'};
  my $token = $qString;
  $token =~ s/^\/api\/paypal\?token\=([0-9A-Z-]+)\&.+/$1/i;
  
  ## Get the express checkout details
  my %details = $pp->GetExpressCheckoutDetails($token);
  
  if ($details{'Ack'} eq 'Success') { ## If the checkout was a success
    
    ## Get payment ID
    my $paymentID = $details{'Custom'};
    $paymentID =~ s/paypal\-//gi;
    
    ## Get the payment details
    my $paymentSth = $dbh->prepare(qq{
      SELECT
          p.paymentAmount,
          a.attrValue AS `redirectURL`
        FROM
          payment p
          LEFT JOIN paymentAttribute a ON a.paymentID = p.paymentID AND a.attrTypeID = 'COMPLETION_REDIRECT'
        WHERE
          p.paymentID = ?
        LIMIT
          1;
    });
    $paymentSth->execute($paymentID);
    my $payment = $paymentSth->fetchrow_hashref();
    
    ## Request the payment from PayPal
    my %payInfo = $pp->DoExpressCheckoutPayment( Token => $details{'Token'},
      PaymentAction => 'Sale',
      PayerID => $details{'PayerID'},
      OrderTotal => "$payment->{'paymentAmount'}",
      currencyID => 'AUD'
    );
    
    if ($payInfo{'Ack'} eq 'Success') { ## Request for payment was successful
      
      my $paymentSth = $dbh->prepare(qq{
        UPDATE
            payment
          SET
            paymentStatus = 'COMPLETE',
            datePaid = NOW()
          WHERE
            paymentID = ?
      });
      $paymentSth->execute($paymentID);
      
      $PAGE{'redirect'} = $payment->{'redirectURL'};
      
    }
    else {
      
      my $paymentSth = $dbh->prepare(qq{
        UPDATE
            payment
          SET
            paymentStatus = 'FAILED'
          WHERE
            paymentID = ?
      });
      $paymentSth->execute($paymentID);
      
      $PAGE{'redirect'} = $payment->{'redirectURL'};
      
    }
    
  }
  
}

1;