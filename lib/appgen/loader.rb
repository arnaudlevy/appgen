require 'open-uri'

module Appgen
  class Loader
    def self.load(path=nil)
      path = find_local_path if path.nil?
      puts '  No description found, you should add an app description in a file, or call appgen with a path or url.' and return if path.nil?
      read_description path
    end

    def self.find_local_path
      Dir['*'].each do |entry|
        next if File.directory? entry
        next if entry.start_with? '.'
        puts "  Found file named #{entry}"
        return entry
      end
    end

    def self.read_description(path)
      puts "  Loading app description from #{path}"
      open(path) { |f| f.read }
    end
  end
end
