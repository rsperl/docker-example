#!/usr/bin/perl

use strict;
use Data::Dumper;
use Readonly;
use DateTime;

#
# note that I can reference an env var to specify custom libraries
# (this could also be done by setting PERL5LIB)
#
use lib "$ENV{APP_DIR}/lib";
use MyModule;

Readonly my $max_reps   => $ENV{MAX_REPS};
Readonly my $sleep_time => $ENV{SLEEP_TIME};
Readonly my $greet_name => $ENV{GREET_NAME};

print Dumper(\%ENV) . "\n";
print MyModule::greet($greet_name) . "\n\n";

print "=== start\n";
for( my $i=0; $i<$max_reps; $i++) {
    print get_timestamp() . " : rep $i/$max_reps\n";
    sleep $sleep_time;
}
print "=== finished\n";



sub get_timestamp {
    my $dt = DateTime->from_epoch(epoch => scalar time(), time_zone => 'America/New_York');
    return $dt->ymd . ' ' . $dt->hms;
}
