module Squill
  class SquillFileSearcher

    def search(search_string)
      grep_results = `grep -l '^# Description:.*#{search_string}.*$' #{search_argument}`
      grep_results.split('\n').map { |result| Squill::SquillFile.new(File.basename(result).gsub(/.squill/,'')) }
    end

    private

    def search_argument
      File.join(squill_dir,'*')
    end

    def squill_dir
      File.join(File.expand_path('~'),'.squill')
    end

  end
end
