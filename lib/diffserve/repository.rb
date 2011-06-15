module DiffServe
  class Repository

    class << self
      # Searches up the file tree to locate the root directory
      # of the Git repository the given path is in.
      def locate(path=Dir.pwd)
        return nil if path == '/'
        return self.new(path) if self.is_repo?(path)
        Repository.locate File.expand_path('..', path)
      end

      def is_repo?(path)
        File.directory? File.expand_path(File.join(path, '.git'))
      end
    end

    attr_reader :path

    def initialize(path)
      @path = path
    end

    # A standard `git diff` doesn't include untracked files.  We want
    # to show them, so we use a `status` (which _does_ include them) and
    # then perform a manual diff on each file.
    #
    # TODO: This will more than likely break on moved files etc...
    def diff
      diffs = []
      status.result.split(/\n/).each do |line|
        st, file = line.strip.split(/\s+/)
        if st == '??'
          # For untracked files, diff against an empty file location.
          diffs << file_diff(file, '/dev/null').result
        else
          diffs << file_diff(file).result
        end
      end
      diffs.join("\n")
    end

    def file_diff(file, base=nil)
      DiffServe::Command.run(self, 'diff', [base, file].compact)
    end

    def untracked
      DiffServe::Command.run(self, 'ls-files', %w{ --others --exclude=standard })
    end

    def status
      DiffServe::Command.run(self, 'status', %w{ --porcelain })
    end

  end
end
