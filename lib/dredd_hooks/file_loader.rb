module DreddHooks
  module FileLoader

    def self.load(patterns)
      self.unique_paths(patterns).each do |path|
        puts path
        require path
      end
    end

    private

      def self.unique_paths(patterns)
        patterns.inject([]) { |paths, pattern|
          paths += Dir.glob(pattern)
        }.uniq
      end
  end
end

