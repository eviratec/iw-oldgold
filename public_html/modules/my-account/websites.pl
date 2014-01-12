# Integrated Web
#   Website Module

use Switch;

sub websiteModule {
  
  $subTplPath .= 'websites/';
  
  if (@REQUEST > 0) {
    # There is a sub-request, it will be a website ID
    our $websiteID = shift(@REQUEST);
    $PAGE{'thread'} .= '<a href="'.$CONFIG{'web_addr'}.'my-account/websites">my websites</a> / ';
    
    $PAGE{'section'} = 'websites';
    $PAGE{'sectionParams'}{'websiteID'} = $websiteID;
    
    if (@REQUEST > 0) {
      my $subreq = shift(@REQUEST);
      $PAGE{'thread'} .= '<a href="'.$CONFIG{'web_addr'}.'my-account/websites/'.$subreq.'">WEBSITE_ID</a> / ';
      
      switch ($subreq) {
        case 'emails' {
          if (@REQUEST > 0) {
            our $emailAccountID = shift(@REQUEST);
            if (@REQUEST > 0) {
              my $subreqb = shift(@REQUEST);
              switch ($subreqb) {
                case 'edit' {
                  showEditEmail();
                }
                else {
                    $PAGE{'redirect'} = $CONFIG{'web_addr'}.'/my-account/websites/'.$websiteID.'/emails';
                }
              }
            }
            else {
              showEmail();
            }
          }
          else {
            showEmailList();
          }
        }
        case 'email-groups' {
          if (@REQUEST > 0) {
            our $emailGroupID = shift(@REQUEST);
            if (@REQUEST > 0) {
              my $subreqb = shift(@REQUEST);
              switch ($subreqb) {
                case 'edit' {
                  showEditEmailGroup();
                }
                else {
                  $PAGE{'redirect'} = $CONFIG{'web_addr'}.'/my-account/websites/'.$websiteID.'/email-groups';
                }
              }
            }
            else {
              showEmailGroup();
            }
          }
          else {
            showEmailGroupList();
          }
        }
        case 'domains' {
          if (@REQUEST > 0) {
            my $domainID = shift(@REQUEST);
            if (@REQUEST > 0) {
              my $subreqb = shift(@REQUEST);
              switch ($subreqb) {
                case 'edit' {
                  showEditDomain();
                }
                else {
                  $PAGE{'redirect'} = $CONFIG{'web_addr'}.'/my-account/websites/'.$websiteID.'/domains';
                }
              }
            }
            else {
              showDomain();
            }
          }
          else {
            showDomainList();
          }
        }
        case 'support' {
          
        }
        else {
          $PAGE{'redirect'} = $CONFIG{'web_addr'}.'/my-account/websites/'.$websiteID;
        }
      }
    }
    else {
      showWebsite();
    }
    
  }
  else {
    showWebsiteList();
  }
}

sub showWebsiteList() {

  $subTplName = 'websiteList.htm';
  
  $PAGE{'thread'} .= 'my websites';
  $PAGE{'title'} = 'my websites';
  
  my $websiteSth = $dbh->prepare(qq{
      SELECT 
        w.* 
      FROM 
        contact co
        LEFT JOIN customerContact cu ON co.contactID = cu.contactID
        LEFT JOIN customerWebsite cw ON cu.customerID = cw.customerID
        LEFT JOIN website w ON cw.websiteID = w.websiteID
      WHERE
        co.contactID = ?
        AND (cw.dateThru IS NULL OR cw.dateThru > now())
      ORDER BY
        cu.customerID ASC
    });
  $websiteSth->execute($session->param('contactID'));
  my @websiteList = ();
  for (my $i = 0; $i < $websiteSth->rows; $i++) {
    push (@websiteList, $websiteSth->fetchrow_hashref);
  }
  @{$subTplVars->{'websiteList'}} = @websiteList;

}

sub showWebsite() {

  $subTplName = 'website.htm';
  
  $PAGE{'thread'} .= 'website dashboard';
  $PAGE{'title'} = 'Website Dashboard';
  
  my $websiteSth = $dbh->prepare(qq{
      SELECT 
        w.* 
      FROM 
        contact co
        LEFT JOIN customerContact cu ON co.contactID = cu.contactID
        LEFT JOIN customerWebsite cw ON cu.customerID = cw.customerID
        LEFT JOIN website w ON cw.websiteID = w.websiteID
      WHERE
        co.contactID = ?
        AND w.websiteID = ?
        AND (cw.dateThru IS NULL OR cw.dateThru > now())
      LIMIT 1
    });
  $websiteSth->execute($session->param('contactID'), $websiteID);
  
  if ($websiteSth->rows > 0) {
    my @websiteInfo = $websiteSth->fetchrow_hashref();
    @{$subTplVars->{'websiteInfo'}} = @websiteInfo;
  }
  else {
    $PAGE{'redirect'} = $CONFIG{'web_addr'}.'my-account/websites';
  }
  
}

sub showEmailList() {

  $subTplName = 'emailList.htm';
  
  $PAGE{'thread'} .= 'email account list';
  $PAGE{'title'} = 'Email Account List';

  my $emailListSth = $dbh->prepare(qq{
      SELECT 
        d.*,
        w.*,
        e.*
      FROM 
        contact co
        LEFT JOIN customerContact cu ON co.contactID = cu.contactID
        LEFT JOIN customerWebsite cw ON cu.customerID = cw.customerID
        LEFT JOIN website w ON cw.websiteID = w.websiteID
        LEFT JOIN websiteDomain wd ON w.websiteID = wd.websiteID
        LEFT JOIN domain d ON wd.domainID = d.domainID
        LEFT JOIN domainEmailAccount de ON d.domainID = de.domainID
        LEFT JOIN emailAccount e ON e.emailAccountID = de.emailAccountID
      WHERE
        co.contactID = ?
        AND w.websiteID = ?
        AND (cw.dateThru IS NULL OR cw.dateThru > now())
        AND (wd.dateThru IS NULL OR wd.dateThru > now())
        AND (de.dateThru IS NULL OR de.dateThru > now())
      ORDER BY
        d.domainID ASC,
        e.emailAccountID ASC
    });
  
  $emailListSth->execute($session->param('contactID'), $websiteID);
  my @emailList = ();
  for (my $i = 0; $i < $emailListSth->rows; $i++) {
    push (@emailList, $emailListSth->fetchrow_hashref);
  }
  @{$subTplVars->{'emailList'}} = @emailList;
  
}

sub showEmail() {

  $subTplName = 'email.htm';
  
  $PAGE{'thread'} .= 'view email account';
  $PAGE{'title'} = 'View Email Account';
  
  my $emailSth = $dbh->prepare(qq{
      SELECT 
        w.*,
        e.*,
        d.*
      FROM 
        contact co
        LEFT JOIN customerContact cu ON co.contactID = cu.contactID
        LEFT JOIN customerWebsite cw ON cu.customerID = cw.customerID
        LEFT JOIN website w ON cw.websiteID = w.websiteID
        LEFT JOIN websiteDomain wd ON w.websiteID = wd.websiteID
        LEFT JOIN domain d ON wd.domainID = d.domainID
        LEFT JOIN domainEmailAccount de ON wd.domainID = de.domainID
        LEFT JOIN emailAccount e ON de.emailAccountID = e.emailAccountID
      WHERE
        co.contactID = ?
        AND w.websiteID = ?
        AND e.emailAccountID = ?
        AND (cw.dateThru IS NULL OR cw.dateThru > now())
        AND (de.dateThru IS NULL OR de.dateThru > now())
      LIMIT 1
    });
  $emailSth->execute($session->param('contactID'), $websiteID, $emailAccountID);
  
  if ($emailSth->rows > 0) {
    my @emailInfo = $emailSth->fetchrow_hashref();
    @{$subTplVars->{'emailInfo'}} = @emailInfo;
  }
  else {
    $PAGE{'redirect'} = $CONFIG{'web_addr'}.'my-account/websites/'.$websiteID.'/emails';
  }
  
}

sub showEditEmail() {

  $subTplName = 'editEmail.htm';
  
  $PAGE{'thread'} .= 'edit email account';
  $PAGE{'title'} = 'Edit Email Account';
  
}

sub showEmailGroupList() {

  $subTplName = 'emailGroupList.htm';
  
  $PAGE{'thread'} .= 'email groups';
  $PAGE{'title'} = 'Email Groups';
  
  my $emailAliasListSth = $dbh->prepare(qq{
      SELECT 
        d.*,
        w.*,
        e.*,
        COUNT(ea.emailAccountID) AS `emailAliasAccounts`
      FROM 
        contact co
        LEFT JOIN customerContact cu ON co.contactID = cu.contactID
        LEFT JOIN customerWebsite cw ON cu.customerID = cw.customerID
        LEFT JOIN website w ON cw.websiteID = w.websiteID
        LEFT JOIN websiteDomain wd ON w.websiteID = wd.websiteID
        LEFT JOIN domain d ON wd.domainID = d.domainID
        LEFT JOIN domainEmailAlias de ON d.domainID = de.domainID
        LEFT JOIN emailAlias e ON de.emailAliasID = e.emailAliasID
        LEFT JOIN emailAliasAccount ea ON e.emailAliasID = ea.emailAliasID
      WHERE
        co.contactID = ?
        AND w.websiteID = ?
        AND (cw.dateThru IS NULL OR cw.dateThru > now())
        AND (wd.dateThru IS NULL OR wd.dateThru > now())
        AND (ea.dateThru IS NULL OR ea.dateThru > now())
      GROUP BY
        e.emailAliasID
      ORDER BY
        d.domainID ASC,
        e.emailAliasID ASC
    });
  
  $emailAliasListSth->execute($session->param('contactID'), $websiteID);
  my @emailAliasList = ();
  for (my $i = 0; $i < $emailAliasListSth->rows; $i++) {
    push (@emailAliasList, $emailAliasListSth->fetchrow_hashref);
  }
  @{$subTplVars->{'emailAliasList'}} = @emailAliasList;
  
}

sub showEmailGroup() {

  $subTplName = 'emailGroup.htm';
  
  $PAGE{'thread'} .= 'view email group';
  $PAGE{'title'} = 'View Email Group';
  
}

sub showEditEmailGroup() {

  $subTplName = 'editEmailGroup.htm';
  
  $PAGE{'thread'} .= 'edit email group';
  $PAGE{'title'} = 'Edit Email';
  
}

sub showDomainList() {

  $subTplName = 'domainList.htm';
  
  $PAGE{'thread'} .= 'my domains';
  $PAGE{'title'} = 'My Domains';
  
  my $domainSth = $dbh->prepare(qq{
      SELECT 
        d.*,
        w.*
      FROM 
        contact co
        LEFT JOIN customerContact cu ON co.contactID = cu.contactID
        LEFT JOIN customerWebsite cw ON cu.customerID = cw.customerID
        LEFT JOIN website w ON cw.websiteID = w.websiteID
        LEFT JOIN websiteDomain wd on w.websiteID = wd.websiteID
        LEFT JOIN domain d on wd.domainID = d.domainID
      WHERE
        co.contactID = ?
        AND w.websiteID = ?
        AND (cw.dateThru IS NULL OR cw.dateThru > now())
        AND (wd.dateThru IS NULL OR wd.dateThru > now())
      ORDER BY
        d.domainID ASC
    });
  $domainSth->execute($session->param('contactID'), $websiteID);
  my @domainList = ();
  for (my $i = 0; $i < $domainSth->rows; $i++) {
    push (@domainList, $domainSth->fetchrow_hashref);
  }
  @{$subTplVars->{'domainList'}} = @domainList;
  
}

sub showDomain() {

  $subTplName = 'domain.htm';
  
  $PAGE{'thread'} .= 'view domain';
  $PAGE{'title'} = 'View Domain';
  
}

sub showEditDomain() {

  $subTplName = 'editDomain.htm';
  
  $PAGE{'thread'} .= 'edit domain';
  $PAGE{'title'} = 'Edit Domain';
  
}

1;