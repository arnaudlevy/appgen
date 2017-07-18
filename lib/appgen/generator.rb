require 'active_support/inflector'

module Appgen
  class Generator
    def self.generate(app_description)
      Generator.new app_description
    end

    def initialize(app_description)
      @app_description = app_description
      @lines = @app_description.lines
      @entities = {}
      find_app_name
      find_entities
      find_items
      generate_app
      generate_entities
    end

    protected

    KEY_APP_NAME = 'The app name is '
    KEY_ENTITY = 'There are '
    KEY_ENTITY_DESCRIPTION = 'A '
    KEY_ENTITY_SEPARATOR = ' has '
    KEY_ITEM_DESCRIPTION = 'a '
    KEY_ITEM_DESCRIPTION_LAST = 'and '

    def find_app_name
      @lines.each do |line| 
        if line.start_with? KEY_APP_NAME
          @app_name = line.gsub(KEY_APP_NAME, '').gsub('.', '').chomp
        end
      end
    end

    def find_entities
      @lines.each do |line| 
        if line.start_with? KEY_ENTITY
          entity = line.gsub(KEY_ENTITY, '').gsub('.', '').chomp.singularize
          @entities[entity] = {}
        end
      end
    end

    def find_items
      @lines.each do |line| 
        if line.start_with? KEY_ENTITY_DESCRIPTION
          split = line.gsub(KEY_ENTITY_DESCRIPTION, '').split(KEY_ENTITY_SEPARATOR)
          entity = split[0]
          description = split[1]
          description.split(', ').each do |item|
            clean_item = item.gsub(KEY_ITEM_DESCRIPTION, '').gsub(KEY_ITEM_DESCRIPTION_LAST, '').gsub('.', '').chomp
            name = clean_item.split(' ')[0]
            type = 'string'
            # TODO other types (text, boolean, float)
            # TODO references
            @entities[entity][name] = type
          end
        end
      end
    end

    def generate_app
      run "rails new #{@app_name} -d postgresql"
    end

    def generate_entities
      @entities.each do |key, value|
        values = value.map { |k, v| "#{k}:#{v}"}.join(' ')
        run "cd #{@app_name}; rails g scaffold #{key} #{values}"
      end
    end

    def run(command)
      puts "$ #{command}"
      system command
    end
  end
end
