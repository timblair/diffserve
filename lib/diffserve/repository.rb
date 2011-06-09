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

    def diff
      DiffServe::Command.run(self, 'diff')
    end

  end
end
