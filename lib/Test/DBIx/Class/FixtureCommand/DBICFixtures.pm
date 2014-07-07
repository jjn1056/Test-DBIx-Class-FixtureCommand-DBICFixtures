package Test::DBIx::Class::FixtureCommand::DBICFixtures;

use Moose;
use DBIx::Class::Fixtures;
use File::Spec;
 
with 'Test::DBIx::Class::Role::FixtureCommand';

has 'fixtures_dir' => (
  is => 'ro',
  required => 1);
  
sub install_fixtures {
  my ($self, $sets, @rest) = @_;
  my @sets = ref($sets) ? @$sets : ($sets, @rest);
  my $schema = $self
    ->schema_manager
    ->schema;
 
  my $fixtures = DBIx::Class::Fixtures->new(
    schema => $schema);

  for my $set(@sets) {
    $fixtures->populate({
      directory => File::Spec->catdir( $self->fixtures_dir, $set ),
    });
  }
}
 
__PACKAGE__->meta->make_immutable;
