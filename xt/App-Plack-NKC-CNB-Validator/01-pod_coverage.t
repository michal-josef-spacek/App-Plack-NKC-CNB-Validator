use strict;
use warnings;

use Test::NoWarnings;
use Test::Pod::Coverage 'tests' => 2;

# Test.
pod_coverage_ok('App::Plack::NKC::CNB::Validator', 'App::Plack::NKC::CNB::Validator is covered.');
