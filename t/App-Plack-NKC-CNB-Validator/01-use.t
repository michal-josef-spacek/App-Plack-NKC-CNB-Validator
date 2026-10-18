use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;

BEGIN {

	# Test.
	use_ok('App::Plack::NKC::CNB::Validator');
}

# Test.
require_ok('App::Plack::NKC::CNB::Validator');
