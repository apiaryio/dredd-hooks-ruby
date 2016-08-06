require 'dredd_hooks'

module DreddHooks
  class CLI

    def self.start(error=STDERR, out=STDOUT, files)

      # Load all files given on the command-line
      DreddHooks::FileLoader.load(files)

      # Run the server
      out.puts 'Starting Ruby Dredd Hooks Worker...'
      server = DreddHooks::Server.new(error, out)
      server.run
    end
  end
end

