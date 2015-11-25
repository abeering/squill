# Squill

A very lightweight tool for storing, searching and executing ad-hoc SQL.

## Overview

    $ squill add get-thingamajig-counts -d 'retrieve counts of of thingamajigs grouped by whatchamacallits'
    $ squill search thingamajig
      get-thingamajig-counts - retrieve counts of of thingamajigs grouped by whatchamacallits

      found 1 squills.
    $ squill print get-thingamajig-counts | psql

## Installation

    $ gem install squill

## Configuration

Squill will sometimes want to open an editor for you to insert your SQL (if you're not adding from a file).  If you want to use an editor other than the default `vi` then you should set your editor environment variable.

    $ export EDITOR="/path/to/editor"

Squill was written to save me many many minutes of my life spent re-writing ad-hoc SQL I had already written which eventually added up to my entire existence. (Basically)

You might want to try saving yourself even a bit more time with an alias.

    $ alias sq='squill'

## Usage

### Full help on command-line

    $ squill help

### Adding Squills

To add a squill:

    $ squill add some-sql-i-wrote
    $ squill a some-sql-i-wrote

With no other options you will be prompted for a description and it will open your `$EDITOR` or simply `vi`. (See Configuration)

Names are strings and can have any characters but I'd suggest you keep it simple or strange things might happen.  Who knows.

To add a squill from a file:

    $ squill add some-sql /path/to/ad-hoc.sql

Descriptions can be input on the command-line:

    $ squill add does-weird-stuff path/to/file.sql -d 'this sql does something strange'

### Searching Squills

To search squills by name and description use the search command:

    $ squill search foo
    $ squill s foo

You can give multi-word search strings with quotes:

    $ squill search 'from that_one_table'

### Outputting Squill SQL

Printing the SQL associated with the squill:

    $ squill print some-sql
    $ squill p some-sql
    $ squill p some-sql | psql

### Listing All Squills

If you're having a hard time finding what you want sometimes its best to just list them all and stare blankly at your screen for a while.

    $ squill list

### Deleting Squills

Eventually you wont need that SQL ever again.  Lucky you.

    $ squill delete i-wish-it-was-all-of-them

## Contributing

1. Fork it ( https://github.com/abeering/squill/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
