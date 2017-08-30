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
      start
    end

    protected

    KEY_APP_NAME = 'The app name is '
    KEY_ENTITY = 'There are '
    KEY_ENTITY_DESCRIPTION = 'A '
    KEY_ENTITY_DESCRIPTION_ALT = 'An '
    KEY_ENTITY_SEPARATOR = ' has '
    KEY_ITEM_DESCRIPTION = 'a '
    KEY_ITEM_DESCRIPTION_ALT = 'an '
    KEY_ITEM_DESCRIPTION_LAST = 'and '
    KEY_TYPE_START = ' (as '
    KEY_TYPE_END = ')'

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
        line = line
          .gsub(KEY_ENTITY_DESCRIPTION_ALT, KEY_ENTITY_DESCRIPTION)
          .gsub(KEY_ITEM_DESCRIPTION_ALT, KEY_ITEM_DESCRIPTION)
          .gsub(KEY_ITEM_DESCRIPTION_LAST, KEY_ITEM_DESCRIPTION)
        if line.start_with? KEY_ENTITY_DESCRIPTION
          split = line.gsub(KEY_ENTITY_DESCRIPTION, '').split(KEY_ENTITY_SEPARATOR)
          entity = split.first
          description = split.last
          description.split(', ').each do |item|
            clean_item = item
              .gsub(KEY_ITEM_DESCRIPTION, '')
              .gsub('.', '')
              .chomp
            name = clean_item.split(KEY_TYPE_START).first.gsub(' ', '_')
            type = 'string'
            if clean_item.include? KEY_TYPE_START
              type = clean_item.split(KEY_TYPE_START).last.split(KEY_TYPE_END).first
            end
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

    def start
      run "cd #{@app_name}; rails db:create"
      run "cd #{@app_name}; rails db:migrate"
      run "cd #{@app_name}; rails s"
    end

    def run(command)
      puts "$ #{command}"
      system command
    end
  end
end
