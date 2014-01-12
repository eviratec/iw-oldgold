package advText;
use strict;
=begin nd
Callan's Super Advanced (with only 1 function) Text Handling Module
	v 0.1
=cut
sub new {
	my $self = {
	};
	bless($self);
	return $self;
}

sub replace {
	my $self = shift;
	my $search = shift;
	my $replace = shift;
	my $subject = shift;
	if (! defined $subject) { return -1; }
	my $count = shift;
	if (! defined $count) { $count = -1; }
	
	# start iterating
	my ($i,$pos) = (0,0);
	while ( (my $idx = index( $subject, $search, $pos )) != -1 ) {
		substr( $subject, $idx, length($search) ) = $replace;
		$pos=$idx+length($replace);
		if ($count>0 && ++$i>=$count) { last; }
	}
	
	return $subject;
}

1;