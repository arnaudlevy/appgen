require 'appgen/loader'
require 'appgen/generator'

module Appgen
  class CLI
    def self.execute(path=nil)
      puts 'Welcome to Appgen'
      app = Appgen::Loader.load path
      Appgen::Generator.generate app
    end
  end
end
