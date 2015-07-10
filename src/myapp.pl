#!/usr/bin/env perl
use Mojolicious::Lite;
use Mojo::Util qw(url_unescape);
use JSON;
use Sys::Hostname;
use feature qw(state);

#
# note that I can reference an env var to specify custom libraries
# (this could also be done by setting PERL5LIB)
#
use lib "$ENV{APP_DIR}/lib";
use MyModule;

$| = 1;

my $app_dir  = $ENV{APP_DIR};
my $hostname = hostname;
my $name     = $ENV{GREET_NAME};

app->config( hypnotoad => { pid_file => "$app_dir/tmp/hypnotoad.pid" });


get '/' => sub {
  my $c = shift;
  my $log = $c->app->log;
  my $debug = $c->param('debug');
  if( ! defined $debug ) {
      $log->info("debug is not defined by the user");
      $debug = $ENV{DEBUG};
  }

  state $count = 0;
  my $data = {
      worker_pid => $$,
      greeting   => MyModule::greet($name),
      hostname   => $hostname,
      time       => scalar time(),
      count      => $count++
  };
  $log->info("pid=$$, hostname=$hostname, count=$count");
  $data->{env} = \%ENV if $debug;
  $c->respond_to( any => { json => $data, status => 200 } );
};

app->start;
