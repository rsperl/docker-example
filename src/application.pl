#!/usr/bin/perl
use strict;
use Readonly;

$| = 1;

#
# note that I can reference an env var to specify custom libraries
# (this could also be done by setting PERL5LIB)
#
use lib "$ENV{APP_DIR}/lib";
use MyModule;

Readonly my $max_reps   => $ENV{MAX_REPS};
Readonly my $sleep_time => $ENV{SLEEP_TIME};
Readonly my $greet_name => $ENV{GREET_NAME};

print <<EOF;
===== ESPY Demo ====
Max reps:   $max_reps
Sleep time: $sleep_time
Greet name: $greet_name

EOF

#
# use method from an external module
#
print MyModule::greet($greet_name) . "\n\n";

print "=== start\n";

for( my $i=0; $i<$max_reps; $i++) {
    print MyModule::get_timestamp() . " : rep $i/$max_reps\n";
    sleep $sleep_time;
}
print "=== finished\n";

