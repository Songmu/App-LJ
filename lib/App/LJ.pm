package App::LJ;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use JSON ();
use JSON::Color ();

my $_coder;
sub _coder {
    $_coder ||= JSON->new;
}

sub run {
    print _process_line($_) . "\n" while <STDIN>;
}

sub _process_line {
    my $line = shift;
    chomp $line;

    if ($line =~ /\s*\{.*\}\s*/) {
        my $pre = $`;
        my $maybe_json = $&;
        my $post = $';

        my $json;
        eval {
            $json = _coder->decode($maybe_json);
        };
        if (!$@) {
            my $r = '';
            $r .= "$pre\n" if $pre ne '';
            $r .= JSON::Color::encode_json($json, {pretty => 1});
            $r .= "\n$post" if $post ne '';
            return $r;
        }
    }
    return $line;
}

1;
__END__

=encoding utf-8

=head1 NAME

App::LJ - It's new $module

=head1 SYNOPSIS

    use App::LJ;

=head1 DESCRIPTION

App::LJ is ...

=head1 LICENSE

Copyright (C) Songmu.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Songmu E<lt>y.songmu@gmail.comE<gt>

=cut

