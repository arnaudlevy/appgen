module Appgen
  class Generator
    def self.generate(app_description)
      Generator.new app_description
    end

    def initialize(app_description)
      @app_description = app_description
      parse
    end

    protected

    def parse
      byebug
    end
  end
end
