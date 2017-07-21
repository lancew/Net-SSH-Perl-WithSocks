use strict;
use warnings;
use Test::More;
use Test::Fatal;
use Net::SSH::Any::Test;

use_ok('Net::SSH::Perl::WithSocks');

ok my $sshd = Net::SSH::Any::Test->new, 'Able to create a ssh daemon';
$sshd->error and die "Unable to get a working SSH service";

my $host     = $sshd->uri->host;
my $port     = $sshd->uri->port;
my $bad_port = $port + 1;

my $ssh;
ok $ssh = Net::SSH::Perl::WithSocks->new( $host, port => $port, ), "Able to create a Net::SSH::Perl::WithSocks object with valid host/port ($host:$port)";

like(
    exception {
        $ssh
            = Net::SSH::Perl::WithSocks->new( $host, port => $bad_port, );
    },
    qr/Can't connect to $host, port $bad_port/,
    "Correctly dies if unable to connect to a valid port ($host:$bad_port)"
);


done_testing();
