# $Id$

package Keyword;
use strict;
use base qw/Data::ObjectDriver::BaseObject/;

use Data::ObjectDriver::Driver::DBI;

__PACKAGE__->install_properties({
    columns     => [ 'id', 'select' ],
    datasource  => 'select',
    primary_key => 'id',
    driver      => Data::ObjectDriver::Driver::DBI->new(
        dsn => 'dbi:SQLite:dbname=global.db',
    ),
});
