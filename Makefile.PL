require 5.008;
use strict;
use warnings;

my $github    = 'https://github.com/briandfoy/';
my $main_file = 'lib/Net/SSH/Perl/WithSocks.pm';

my %WriteMakefile = (
	'NAME'	        => 'Net::SSH::Perl::WithSocks',
	'ABSTRACT_FROM' => $main_file,
	'VERSION_FROM'  => $main_file,
	'LICENSE'       => 'perl',
	'AUTHOR'        => 'Jennie Rose Evers-Corvina <seven@nanabox.net>',
	
	'META_MERGE'     => {
		license => 'perl',
		resources => {
			repository  => 'https://github.com/briandfoy/Net-SSH-Perl-WithSocks',
		  },
		},

	'PREREQ_PM'    => { 
		'IPC::PerlSSH'      => '0',
		'Net::SSH::Perl'    => '0',
		'IO::Socket::Socks' => '0',
		},

	clean  => { FILES    => q|Net-SSH-Perl-*| },
	);

sub arguments { \%WriteMakefile }

do_it() unless caller;
sub do_it {
	require File::Spec;
	my $MM ='ExtUtils::MakeMaker';
	my $MM_version =
		eval{ "$MM " . $WriteMakefile{'CONFIGURE_REQUIRES'}{'ExtUtils::MakeMaker'} }
			//
		"$MM 6.64";
	eval "use $MM_version";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
