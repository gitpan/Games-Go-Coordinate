use inc::Module::Install;
include 'Module::AutoInstall';

name 'Games-Go-Coordinate';
all_from 'lib/Games/Go/Coordinate.pm';
perl_version '5.006';

requires 'Moose' => '0.44';

build_requires 'Test::More' => '0.70';

process_templates(
    first_year => 2007,
    rest_from  => "$ENV{HOME}/.mitlib/standard_pod",
    start_tag  => '{%',
    end_tag    => '%}',
);

use_standard_tests(without => 'pod_coverage');
auto_install;
auto_include;
WriteAll;