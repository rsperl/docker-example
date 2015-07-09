package MyModule;

use DateTime;

sub greet {
    return "hello, " . shift;
}

sub get_timestamp {
    my $dt = DateTime->from_epoch(epoch => scalar time(), time_zone => 'America/New_York');
    return $dt->ymd . ' ' . $dt->hms;
}

1;
