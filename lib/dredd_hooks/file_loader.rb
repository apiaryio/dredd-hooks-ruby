module DreddHooks
  module FileLoader

    def self.load(patterns)
      unique_paths(patterns).each do |path|
        puts path
        require path
      end
    end


    def self.unique_paths(patterns)
      paths = patterns.inject([]) { |paths, pattern|
        paths + Dir.glob(pattern)
      }.uniq

      puts "No hook files found in #{patterns}" if paths.empty?
      paths
    end
    private_class_method :unique_paths
  end
end

