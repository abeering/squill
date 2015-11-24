require 'thor'
require 'squill/squill_file'
require 'squill/squill_file_searcher'

module Squill
  class CLIClient < Thor

    include Thor::Actions

    desc "add <name> (<file>)", "Adds a file to squill library."
    long_desc <<-ADD_DESC
    Adds sql in <file> to squill library with name <name>.
    If no <file> is given, will open your EDITOR or `vi` by default to get SQL.

    Examples:

      Add a squill and prompt for the description and SQL:

      `squill add just-some-sql`

      Add a squill from a file:

      `squill add just-some-sql path/to/file.sql`

      Include a description:

      `squill add does-weird-stuff path/to/file.sql -d 'this sql does something strange'`
    ADD_DESC
    option :desc, :type => :string, :aliases => :d, :desc => "Can take a description on command-line instead of opening EDITOR for description body."
    option :replace, :type => :boolean, :aliases => :r, :desc => "Replaces a squill named <name> which already exists."
    def add(name, file=nil)
      squill_file = Squill::SquillFile.new(name)
      if squill_file.exists_as_squill_file? && !options[:replace]
        puts "a squill by this name already exists. use the the --replace option to replace it."
        return
      end
      squill_file.description = options[:desc].nil? ? ask("Briefly describe #{name}: ") : options[:desc]
      if file.nil?
        squill_file.set_sql
      else
        squill_file.set_sql_from_file(file)
      end
      puts squill_file.yaml
      #squill_file.save
      puts "saved squill."
    end
    map "a" => "add"

    desc "print <name>", "Outputs file from squill library."
    long_desc <<-RUN_DESC
    Adds sql in <file> to Squill library with name <name>.
    If no description option is given, will open the EDITOR set in your environment.

    Example:

      `squill run just-some-sql`
    RUN_DESC
    def print(name)
      squill_file = Squill::SquillFile.new(name)
      if squill_file.exists_as_squill_file?
        puts squill_file.sql
      end
    end
    map "p" => "print"

    desc "search <string>", "Searches for squills whose name or description match <string>."
    long_desc <<-SEARCH_DESC
    Adds sql in <file> to Squill library with name <name>.
    If no description option is given, will open the EDITOR set in your environment.

    Example:

      `squill search some_table`
    SEARCH_DESC
    def search(search_string)
      searcher = Squill::SquillFileSearcher.new
      results = searcher.search(search_string)
      results.each { |result|
        puts "#{result[:name_highlight]} - #{result[:description_highlight]}"
      }
    end
    map "s" => "search"

  end
end
