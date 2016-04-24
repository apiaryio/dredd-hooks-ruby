module DreddHooks
  module FileLoader
    def self.unique_paths(patterns)
      patterns.inject([]) { |paths, pattern|
        paths += Dir.glob(pattern)
      }.uniq
    end

    def self.load globs
      self.unique_paths(globs).each do |path|
        puts path
        require path
      end
    end
  end
end

