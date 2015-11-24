module Squill
  class SquillFileSearcher

    def search(search_string)
      grep_results = `egrep -l '^#(Description|Name):.*#{search_string}.*$' #{search_argument} | sort`
      grep_results.split("\n").map { |result|
        squillfile = Squill::SquillFile.new(File.basename(result.strip).gsub(/.squill/,''))
        {
          name_highlight: highlight(squillfile.name, search_string),
          description_highlight: highlight(squillfile.description, search_string)
        }
      }
    end

    def list
      results = `find #{squill_search_dir} -type f -name '*.squill' | sort`
      results.split("\n").map { |result| Squill::SquillFile.new(File.basename(result.strip).gsub(/.squill/,'')) }
    end

    private

    def highlight(string, search_string)
      string.gsub(/(#{search_string})/) { |found| "\e[1m#{found}\e[0m" }
    end

    def search_argument
      File.join(squill_search_dir,'*')
    end

    def squill_search_dir
      File.join(File.expand_path('~'),'.squill')
    end

  end
end
