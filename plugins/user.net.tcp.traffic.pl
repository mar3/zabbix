#!/usr/bin/perl
# encoding: utf-8



#
# 通信量を表示します。
#
# iptables でポートを開けていることが前提です。
#
#
#
#
#
#



use strict;
use Getopt::Long;





###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
package out;

# sub new {}

sub println {

	print(@_, "\x0a");
}






###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
package current_direction;

# sub new {}

our $direction = '';









###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
package main;

# sub new {}

sub _analyze_line {

	my ($line, $required_direction, $required_protocol, $required_port) = @_;



	#
	# current chain
	#
	if($line =~ m/\AChain/msi) {
		my ($word1, $word2) = split(' ', $line);
		if(uc($word1) eq 'CHAIN') {
			if(0 < length($word2)) {
				$current_direction::direction = $word2;
				return;
			}
		}
	}

	if(!($required_direction eq $current_direction::direction)) {
		return;
	}

	#
	# detected requested chain
	#

	my ($packets, $length, $target, $protocol) = split(' ', $line);
	if(!($target eq 'ACCEPT')) {
		return;
	}
	if(!($protocol eq $required_protocol)) {
		return;
	}
	$line =~ m/dpt\:([0-9]+)/ms;
	my $port = $1;
	if($required_port != $port) {
		return;
	}

	out::println($length);
}

sub _analyze {

	my ($protocol, $direction, $port) = @_;



	if(!length($protocol)) {
		$protocol = 'tcp';
	}

	if(!length($direction)) {
		$direction = 'INPUT';
	}

	my $stream = undef;
	my $command_text = '/sbin/iptables --list -nvx |';
	if(!open($stream, $command_text)) {
		return;
	}

	while(my $line = <$stream>) {
		_analyze_line($line, $direction, $protocol, $port);
	}
	close($stream);
}

sub _usage {

	out::println('usage:');
	out::println('    --help: show this message.');
	out::println('    --direction: INPUT/OUTPUT');
	out::println('    --protocol: tcp/udp');
	out::println('    --port: port');
	out::println('');
}

sub _main {

	my $action_help = 0;
	my $protocol = '';
	my $direction = '';
	my $port = 0;



	my $result = Getopt::Long::GetOptions(
		'help!' => \$action_help,
		'protocol=s' => \$protocol,
		'direction=s' => \$direction,
		'port=i' => \$port);
	if(!$result) {
		_usage();
	}
	elsif($action_help) {
		_usage();
	}
	else {
		_analyze($protocol, $direction, $port);
	}
}

main::_main(@ARGV);
