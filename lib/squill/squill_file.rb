module Squill
  class SquillFile

    def initialize
      ensure_squill_dir
    end

    private

    def ensure_squill_dir
      if !File.directory?(squill_dir)
        Dir.mkdir(squill_dir)
      end
    end

    def squill_dir
      File.join(File.expand_path('~'),'.squill')
    end

  end
end
