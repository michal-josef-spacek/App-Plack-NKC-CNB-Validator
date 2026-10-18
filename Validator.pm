package App::Plack::NKC::CNB::Validator;

use strict;
use warnings;

use Class::Utils qw(set_params);
use CPAN::Changes;
use Data::NKC::MARC::Zoom;
use Error::Pure qw(err);
use Getopt::Std;
use Plack::App::NKC::CNB::Validator;
use Plack::Builder;
use Plack::Runner;
use Unicode::UTF8 qw(decode_utf8);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Process parameters.
	set_params($self, @params);

	# Object.
	return $self;
}

# Run.
sub run {
	my $self = shift;

	# Process arguments.
	$self->{'_opts'} = {
		'c' => undef,
		'd' => 0,
		'h' => 0,
	};
	if (! getopts('c:dh', $self->{'_opts'})
		|| $self->{'_opts'}->{'h'}) {

		print STDERR "Usage: $0 [-c changes_file] [-d] [-h] [--version]\n";
		print STDERR "\t-c changes_file\tChanges file to present.\n";
		print STDERR "\t-d\t\tDebug mode.\n";
		print STDERR "\t-h\t\tPrint help.\n";
		print STDERR "\t--version\tPrint version.\n";
		return 1;
	}

	my $debug = exists $ENV{'DEBUG'} ? $ENV{'DEBUG'} : 0;
	if (! $debug) {
		$debug = $self->{'_opts'}->{'d'};
	}

	my $zoom = Data::NKC::MARC::Zoom->new(
		'db' => 'NKC01',
		'host' => 'aleph.nkp.cz',
		'port' => 9991,
	);

	my ($css, $tags);
	my %tags = (
		'no_simple' => ['br', 'button', 'div', 'script', 'span', 'textarea'],
		'preserved' => ['pre', 'script', 'style', 'textarea'],
		'xml' => 1,
	);
	if ($debug) {
		require CSS::Struct::Output::Indent;
		$css = CSS::Struct::Output::Indent->new;
		require Tags::Output::Indent;
		$tags = Tags::Output::Indent->new(%tags);
	} else {
		require CSS::Struct::Output::Raw;
		$css = CSS::Struct::Output::Raw->new;
		require Tags::Output::Raw;
		$tags = Tags::Output::Raw->new(%tags);
	}

	# Load Changes file.
	my $changes;
	if (defined $self->{'_opts'}->{'c'}) {
		if (! -r $self->{'_opts'}->{'c'}) {
			err "Changes file '$self->{'_opts'}->{'c'} isn't readable.";
		}
		$changes = CPAN::Changes->load($self->{'_opts'}->{'c'});
	}

	my $app = Plack::App::NKC::CNB::Validator->new(
		'css' => $css,
		'changes' => $changes,
		'generator' => 'CNB validator/'.$VERSION,
		'images' => {
			'logo' => '/img/logo.png',
		},
		'lang' => 'ces',
		'tags' => $tags,
		'title' => decode_utf8('ČNB validátor'),
		'zoom' => $zoom,
	)->to_app;

	my $builder = builder {
		enable 'AccessLog';
		enable 'Session';
		enable 'Static',
			'path' => qr{.*(ico|jpg|png)$},
			'root' => 'static',
		;
		$app;
	};

	Plack::Runner->new->run($builder);

	return 0;
}

1;

__END__
