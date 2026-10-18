use strict;
use warnings;

use App::Plack::NKC::CNB::Validator;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($App::Plack::NKC::CNB::Validator::VERSION, 0.01, 'Version.');
