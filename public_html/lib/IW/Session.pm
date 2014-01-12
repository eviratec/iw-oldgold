package Session;
use strict;
=begin nd
  some info about this package...
=cut
sub new {
  my $self = {
  };
  bless($self);
  return $self;
}

sub logVisit {
  
}

sub startSession {
  # 1. Check if any cookies are set
  #   i. if set, skip to step 3
  # 2. Set session identifier
  # 3. Log session to database
}

sub endSession {

}

sub verifySession {

}

sub getSessionAttr {
  
}

sub setSessionAttr {
  
  my $input = shift(@_);
  if (%{$input}) {
    # Input is hash
    
  }
  else {
    my $attrName = $input;
    my $attrValue = shift(@_);
  }
  
}