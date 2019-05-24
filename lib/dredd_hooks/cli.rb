require 'dredd_hooks'

module DreddHooks
  class CLI

    def self.start(host=DreddHooks::Server::HOST, port=DreddHooks::Server::PORT, error=STDERR, out=STDOUT, files)

      # Load all files given on the command-line
      DreddHooks::FileLoader.load(files)

      # Run the server
      out.puts 'Starting Ruby Dredd Hooks Worker...'
      server = DreddHooks::Server.new(host, port, error, out)
      server.run
    end
  end
end

