require 'dredd_hooks'

module DreddHooks
  class CLI

    def self.start(error=STDERR, out=STDOUT, options, files)

      # Load all files given on the command-line
      DreddHooks::FileLoader.load(files)

      # Run the server
      out.print 'Starting Ruby Dredd Hooks Worker...'
      server = DreddHooks::Server.new(error, out, options)
      server.run
    end
  end
end

