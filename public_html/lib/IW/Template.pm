#
# Copyright (c) 2010 Callan Milne
# Integrated Web Services
#
# iwTemplate Module v0.01
#

package iwTemplate;
use 5.10;
use strict;
use warnings;
 
require Exporter;
require Template;
our @ISA = qw(Exporter Template);
our %EXPORT_TAGS = ( 'all' => [ qw() ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw( );

our $VERSION = '0.01';

our $output = undef;

sub new {
  my $self = {};
  bless $self;
  return $self;
}

sub render {
  
  # Render the template
  # $tpl->render(TEMPLATE_FOLDER, TEMPLATE_NAME, TEMPLATE_DATA);
  my ($self,$tplFolder,$tplName,$tplData) = @_;
  
  # Use switch instead of if/else
  
  foreach my $tplAttr (keys $tplData) {
    if (ref($tplData[$tplAttr]) eq 'HASH') {
      
      # Check if this is a regular hash or a switch element
      if ($tplData[$tplAttr]['SWITCH']) {
        # It's a switch, get single template based on
        my $subTplData = '';
      }
      else {
        # Just a regular hash, get additional template for each instance
        my $subTplData = $tplData[$tplAttr];
        my $subTplName = "$tplName-$tplAttr";
        $tplData[$tplAttr] = $self->render($tplFolder,$subTplName,$subTplData);
      }
      
    }
    elsif (ref($tplData[$tplAttr]) eq 'ARRAY') {
      
      # Array of hash elements
      for (my $i = 0; $i < @{$tplData[$tplAttr]}; $i++) {
        my $subTplData = $tplData[$tplAttr][$i];
        my $subTplName = "$tplName-$tplAttr";
        $tplData[$tplAttr][$i] = $self->render($tplFolder,$subTplName,$subTplData);
      }
      
    }
  }
  return $self->populate("$tplName.htm", $tplData);
  
}

sub populate {
  
  # Populate a template file and return it's html
  # $this->populate(TEMPLATE_FILE, TEMPLATE_DATA);
  my ($self, $tplFile, $tplData) = @_;
  
  # 1. Open template handle (read)
  # 2. Open temporary file handle (read/write)
  # 3. For each line of the file, see if there is anything to replace
  #    If something to replace, replace it
  # 4. Add each replaced line to the temp file
  # 5. Output the completeed line to the temp file
  
  # Should I use a temp file, or just output within the script
  # creating and updating a temp file may increase load and mean
  # more work ........ for less benefit ...
  
  my $output = undef;
  
  return $output;
  
}

1;