use strict ;
use warnings ;
use Apache::Test () ;
use Apache::TestRequest () ;

# Here we simply run the Client tests after setting up the correct URL.
my $url = Apache::TestRequest::module2url('', {path => '/httunnel'}) ;

$HTTunnel::Client::Test::URL = undef ; # stupid warning
$HTTunnel::Client::Test::URL = $url ;

require "Client/t/HTTunnel-Client.t" ;

