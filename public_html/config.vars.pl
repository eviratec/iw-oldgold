## General Configuration
$CONFIG{'reqpath'} = 'inc/';
$CONFIG{'web_addr'} = 'http://imagine.eviratec.com/';

## Default Template Values
$CONFIG{'template_path'} = '/home/eviratec/public_html/imagine/cgi-bin/style/';
$CONFIG{'tmpl_default'} = 'iw2';
$CONFIG{'tmpl_page_title'} = 'Integrated Web Services';
$CONFIG{'tmpl_page_title_long'} = 'Integrated Web Services - Ecommerce, design, development, hosting, domains';
$CONFIG{'tmpl_page_robots'} = 'index,follow';
$CONFIG{'tmpl_page_keywords'} = 'IntegratedWeb, IntegrtedWebServices, Integrated Web, Integrated Web Services, Ecommerce Websites, Ecommerce, Ecommerce Services, Online Services, Web Services, Web Design, Web Development, Web Application, Online Store, Web Store';
$CONFIG{'tmpl_page_description'} = 'At Integrated Web, we take pride in providing some of the most reliable, cost effective, world class web services.';
$CONFIG{'tmpl_copyright'} = '&copy; Copyright 2010 Integrated Web Services';
$CONFIG{'tmpl_thread'} = '<a href="http://www.integratedweb.com.au/">integratedweb.com.au</a> / ';

## Business Values
$CONFIG{'phone_orders'} = '1800 823 365';

## Email Configuration
$CONFIG{'mail_auth_host'} = '';
$CONFIG{'mail_auth_type'} = 'PLAIN';
$CONFIG{'mail_auth_user'} = '';
$CONFIG{'mail_auth_pass'} = '';

$CONFIG{'mail_noreply'} = 'no-reply@integratedweb.com.au';
$CONFIG{'mail_web'} = 'callan.milne@integratedweb.com.au';
$CONFIG{'mail_quote'} = 'callan.milne@integratedweb.com.au';
$CONFIG{'mail_enquiry'} = 'callan.milne@integratedweb.com.au';

## MySQL Schemata
$CONFIG{'database'} = '';
$CONFIG{'db_host'} = '';
$CONFIG{'db_user'} = '';
$CONFIG{'db_pass'} = '';

## Payment API Credentials
$CONFIG{'api_paypal_username'} = '';
$CONFIG{'api_paypal_password'} = '';
$CONFIG{'api_paypal_signature'} = '';
$CONFIG{'api_paypal_expressurl'} = 'https://www.paypal.com/cgi-bin/webscr';
#$CONFIG{'api_paypal_username'} = '';
#$CONFIG{'api_paypal_password'} = '';
#$CONFIG{'api_paypal_signature'} = '';
#$CONFIG{'api_paypal_expressurl'} = 'https://www.sandbox.paypal.com/cgi-bin/webscr';

1;
