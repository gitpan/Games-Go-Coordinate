use inc::Module::Install;
name 'Games-Go-Coordinate';
all_from 'lib/Games/Go/Coordinate.pm';
perl_version '5.006';

requires 'Class::Accessor::Complex';

build_requires 'Test::More' => '0.70';

use_standard_tests(without => 'pod_coverage');
auto_include;
WriteAll;
