# Integrated Web
#   Home Module

sub displayModule {
	
  $PAGE{'section'} = 'home';
  
	$PAGE{'is_home'} = 1;
	$PAGE{'thread'} .= 'home';
  $PAGE{'title'} = 'Welcome to Integrated Web Services';
	
  $subTplName = 'home.htm';
	
}

1;