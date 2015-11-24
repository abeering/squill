module Squill
  class SquillFile

    attr_accessor :description, :sql, :name

    def initialize(name)
      ensure_squill_dir
      @name = name
    end

    def exists_as_squill_file?
      File.exist?(squill_file)
    end

    def set_sql_from_file(filename)
      orig_file = File.open(filename, "r")
      @sql = orig_file.read
      orig_file.close
    end

    def set_sql
      prep_tempfile_for_sql
      set_tempfile
      @sql = read_tempfile_for_sql
    end

    def save
      write_file
    end

    def sql_content
      file = File.open(squill_file,'r')
      in_sql = false
      sql = ""
      file.each_line { |line|
        sql << line if in_sql
        in_sql = true if line.match(/^# SQL:/)
      }
      sql
    end

    private

    def prep_tempfile_for_sql
      file = File.open(tempfile, "w")
      file.write <<-SQL_TEMPLATE

# END SQL
# Insert SQL to be added to squill above these lines
      SQL_TEMPLATE
      file.close
    end

    def read_tempfile_for_sql
      file = File.open(tempfile, "r")
      sql = ""
      file.each_line { |line|
        break if line.match(/^# END SQL/)
        sql << line
      }
      file.close
      sql
    end

    def set_tempfile
      system(user_editor, tempfile)
    end

    def write_file
      file = File.open(squill_file, "w")
      file.write(contents_for_squill_file_write)
      file.close
    end

    def contents_for_squill_file_write
      <<-OUTPUT_FILE
# Name: #{@name}
# Description: #{@description}
# SQL:
#{@sql}
      OUTPUT_FILE
    end

    def user_editor
      !ENV['EDITOR'].nil? && !ENV['EDITOR'].empty? ? ENV['EDITOR'] : 'vi'
    end

    def ensure_squill_dir
      if !File.directory?(squill_dir)
        Dir.mkdir(squill_dir)
      end
    end

    def tempfile
      File.join(squill_dir, '.temp')
    end

    def squill_file
      File.join(squill_dir, "#{name}.squill")
    end

    def squill_dir
      File.join(File.expand_path('~'),'.squill')
    end

  end
end
