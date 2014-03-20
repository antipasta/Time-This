package Time::This;
use Time::HiRes;
use Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(time_this);
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";

my $counter = 0;

sub time_this {
    my $name;
    my $sub;
    my ( $pkg, $filename, $line ) = caller;
    if ( ref( $_[0] ) eq 'CODE' ) {
        $sub  = shift;
        $name = "Statement " . ++$counter;
    }
    else {
        ( $name, $sub ) = ( shift, shift );
    }
    my $start = Time::HiRes::time;
    my @res_arr;
    my $res;
    if (wantarray) {
        @res_arr = $sub->(@_);
    }
    elsif ( !defined wantarray ) {
        $sub->(@_);
    }
    else {
        $res = $sub->(@_);
    }

    my $took = Time::HiRes::time - $start;

    warn "$name took [$took] at $filename line $line\n";
    return (wantarray) ? @res_arr : $res;
}



1;
__END__

=encoding utf-8

=head1 NAME

Time::This - It's new $module

=head1 SYNOPSIS

    use Time::This;

=head1 DESCRIPTION

Time::This is ...

=head1 LICENSE

Copyright (C) Joe Papperello.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Joe Papperello E<lt>joe@socialflow.comE<gt>

=cut

