#!/bin/sh
set -e
set -x
src="script/lj"
dst="lj"
extlib="extlib"

rm -rf $extlib
cpanm -L $extlib JSON::PP JSON::Color@0.06
patch $extlib/lib/perl5/JSON/Color.pm < author/json-color.patch
# https://github.com/shoichikaji/App-FatPacker-Simple
fatpack-simple -e Scalar::Util::LooksLikeNumber $src -o $dst

perl -i -0 -pe 's{\A#!perl}{#!/usr/bin/env perl}ms' $dst
perl -i -0 -pe 's/JSON::XS/JSON::PP/msg' $dst

chmod +x $dst
