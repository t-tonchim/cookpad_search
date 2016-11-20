require 'cookpad_search'
require 'open-uri'

module CookpadSearch
  class Searcher
    class << self
      def search(url)
        encoded_url = URI.encode(url)
        doc = scrape(encoded_url)
        recipes = Parser.parse_recipes(doc)

        recipes.each do |recipe|
          text = <<-CONTENTS
===================================================================================
ID:#{recipe[:id]}  #{recipe[:title]}
===================================================================================
#{recipe[:desc]}
          CONTENTS

          puts text
        end
      end

      def by_id(url)
        doc = scrape(url)
        recipe = Parser.parse_a_recipe(doc)
        ingredient = recipe[:ingredient_names].zip(recipe[:ingredient_quantity]).to_h

        ingredient_text = ''
        ingredient.each do |name,quantity|
          ingredient_text += "#{name} : #{quantity}\n"
        end

         line = '==============================================================================================='
        _line = '-----------------------------------------------------------------------------------------------'

        steps = recipe[:step_number].zip(recipe[:step_text]).to_h
        step_text = ''
        steps.each do |num,text|
          step_text += "[#{num}]\n#{text}\n#{_line}\n"
        end

        text = <<-CONTENTS
#{line}
#{recipe[:title]}
#{line}
材料 #{recipe[:serving_for]}
#{ingredient_text}
#{_line}
#{step_text}
        CONTENTS

        puts text
      end

      private

      def scrape(url)
        html = {}
        html[:doc] = open(url) do |f|
          html[:charset] = f.charset
          f.read
        end
        html
      end
    end
  end
end
