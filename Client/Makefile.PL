use strict ;
use ExtUtils::MakeMaker ;

WriteMakefile(
    NAME              => 'HTTunnel::Client',
    VERSION_FROM      => 'lib/HTTunnel/Client.pm',
	EXE_FILES         => ['httunnel'],
    PREREQ_PM         => {
		LWP => 0
	},
	MAN1PODS          => {
		'httunnel.pod' => '$(INST_MAN1DIR)/httunnel.1'
	},
	MAN3PODS          => {
		'lib/HTTunnel/Client.pod' => '$(INST_MAN3DIR)/HTTunnel::Client.3pm'
	},
	clean             => {
		FILES => "t/server_url lib/HTTunnel/HTTunnel"
	},
) ;


sub MY::postamble {
	my $make = '' ;
	if ($^O eq 'linux') { 
		$make = <<'MAKEFILE';

install::
	mkdir -p /etc/init.d
	mkdir -p /etc/httunnel.d
	/usr/bin/install -m 755 httunnel.sysv /etc/init.d/httunnel
	/usr/bin/install -m 644 httunnel.conf /etc/httunnel.d/sample.conf_

J2SDK = /usr/java/j2sdk1.4.2_06

java:
	$(J2SDK)/bin/javac lib/HTTunnel/Client.java -d lib/HTTunnel

java_test: java
	$(J2SDK)/bin/java -classpath lib/HTTunnel HTTunnel.Client

MAKEFILE
	}

	return $make ;
}


if (! $Apache::HTTunnel::Makefile){
	my $url = prompt("Please enter the URL of your Apache::HTTunnel server (for the test suite):", '') ;
	open(URL, ">t/server_url") or die("Can't open 't/server_url' for writing: $!") ;
	print URL "$url\n" ;
	close(URL) ;
}

