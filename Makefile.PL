use lib '.';
use strict;
use warnings;

use inc::Module::Install;

# Definition.
abstract 'Tool to run Plack application with CNB validator.';
author 'Michal Josef Spacek <michal.josef.spacek@gmail.com>';
author_requires 'File::Object' => 0.05;
author_requires 'Test::More' => 0;
author_requires 'Test::NoWarnings' => 0;
author_requires 'Test::Pod' => 0;
author_requires 'Test::Pod::Coverage' => 0;
install_script 'bin/plack-nkc-cnb-validator';
license 'bsd';
name 'App-Plack-NKC-CNB-Validator';
readme_from 'bin/plack-nkc-cnb-validator';
recursive_author_tests('xt');
requires 'Class::Utils' => 0;
requires 'CPAN::Changes' => 0;
requires 'CSS::Struct::Output::Indent' => 0;
requires 'CSS::Struct::Output::Raw' => 0;
requires 'Data::NKC::MARC::Zoom' => 0;
requires 'Error::Pure' => 0;
requires 'Getopt::Std' => 0;
requires 'Plack::App::NKC::CNB::Validator' => 0;
requires 'Plack::Builder' => 0;
requires 'Plack::Runner' => 0;
requires 'Tags::Output::Indent' => 0;
requires 'Tags::Output::Raw' => 0;
requires 'Unicode::UTF8' => 0;
resources 'bugtracker' => 'https://github.com/michal-josef-spacek/App-Plack-NKC-CNB-Validator/issues';
resources 'homepage' => 'https://github.com/michal-josef-spacek/App-Plack-NKC-CNB-Validator';
resources 'repository' => 'git://github.com/michal-josef-spacek/App-Plack-NKC-CNB-Validator';
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();
