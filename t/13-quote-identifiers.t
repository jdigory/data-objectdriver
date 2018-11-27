# $Id$

use strict;

use lib 't/lib';
use lib 't/lib/cached';

require './t/lib/db-common.pl';

use Test::More;
use Test::Exception;
BEGIN {
    unless (eval { require DBD::SQLite }) {
        plan skip_all => 'Tests require DBD::SQLite';
    }
    unless (eval { require Cache::Memory }) {
        plan skip_all => 'Tests require Cache::Memory';
    }
}

plan tests => 5;

use Keyword;

setup_dbs({
    global => [qw( keyword)],
});

{
    my $k = Keyword->new;
    ok $k->save;

    my @res = Keyword->search();
    is scalar @res, 1, "keyword populated";

    my $rv = $k->remove;
    is $rv, 1, "keyword deleted";
}

{
    my $k = Keyword->new( select => 'test' );
    ok $k->save;

    my $l = Keyword->lookup({ id => 1 });
    is $l->select, 'test', 'keyword lookup';
}

sub DESTROY { teardown_dbs(qw( global )); }
