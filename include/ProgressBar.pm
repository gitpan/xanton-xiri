#!/usr/bin/perl -U
# -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# ProgressBar: simple progressbar
# (c) 2001 Ask Solem Hoel <ask@unixmonks.net>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License version 2,
#   *NOT* "earlier versions", as published by the Free Software Foundation.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
# -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#####

use strict;
package ProgressBar;
$|++;
sub new { return bless {}, 'ProgressBar' }
sub jmp {
        my $self = shift;
        my @sym = qw(| / - \\);
        my $dlay = rand 400;
	print $sym[$dlay%4];
        print("\x08");
        return 1;
};
sub end { print " \x08\n" };

1;

