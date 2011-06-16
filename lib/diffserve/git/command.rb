module DiffServe::Git
  class Command

    class << self
      def run(repo, cmd, opts = [])
        command = self.new(repo, cmd, opts)
        command.execute
        command
      end
    end

    attr_reader :result

    def initialize(repo, cmd, opts = [])
      @repo = repo
      @cmd  = cmd
      @opts = [opts].flatten
    end

    def execute
      @result = execute! "git #{@cmd} #{option_string}"
    end

    def escaped_option(o)
      return nil if o.to_s == ''
      %Q{"#{o.to_s.gsub('\'', '\'\\\'\'')}"}
    end

    def option_string
      @opts.map { |o| escaped_option(o) }.join(' ')
    end

    private

    def execute!(cmd)
      Dir.chdir(@repo.path) do
        `#{cmd}`.chomp
      end
    end

  end
end
