require 'thor'
require 'squill/squill_file'

module Squill
  class CLIClient < Thor

    desc "add <name> <file>", "Adds a file to Squill library."
    long_desc <<-ADD_DESC
    Adds sql in <file> to Squill library with name <name>.
    If no description option is given, will open the EDITOR set in your environment.

    Examples:

      `squill add just-some-sql path/to/file.sql`

      `squill add does-weird-stuff path/to/file.sql -d 'this sql does something strange'`
    ADD_DESC
    option :desc, :type => :string, :aliases => :d, :desc => "Can take a description on command-line instead of opening EDITOR."
    def add( name, file_path )
      puts "adding #{name} to #{file_path}"
      if options[:desc]
        puts "and give it the description #{options[:desc]}"
      end
      file = Squill::SquillFile.new
    end
    map "a" => "add"

  end
end
