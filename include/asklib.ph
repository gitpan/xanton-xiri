#!/usr/bin/perl
sub basename($);
sub basename($) {
	$_ = shift;
	$_ =~ s%.*/%%;
	return $_;
}
1;
