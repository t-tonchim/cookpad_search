require 'cookpad_search'
require 'nokogiri'

module CookpadSearch
  class Parser
    class << self
      def parse_recipes(html)
        parsed_contents = []
        doc = parse(html)
        recipes = doc.css('.recipe-preview')

        recipes.each do |recipe|
          contents = {}
          contents[:title] = recipe.css('.recipe-title').inner_text
          contents[:desc]  = recipe.css('.recipe_description').inner_text
          contents[:id]    = recipe.css('.recipe-title').attribute('href').value.slice(/\d*$/)
          parsed_contents << contents
        end

        parsed_contents
      end

      def parse_a_recipe(html)
        contents = {}
        doc = parse(html)
        contents[:title]               = doc.css('h1.recipe-title').inner_text
        contents[:desc]                = doc.css('description_text').inner_text
        contents[:serving_for]         = doc.css('.servings_for').inner_text
        contents[:ingredient_names]    = doc.css('.ingredient_name').map { |name| name.inner_text }
        contents[:ingredient_quantity] = doc.css('.ingredient_quantity').map {|name| name.inner_text }
        contents[:step_number]         = doc.css('dt > h3').map {|num| num.inner_text }
        contents[:step_text]           = doc.css('dd > p.step_text').map { |text| text.inner_text }
        contents
      end

      private

      def parse(html)
        Nokogiri::HTML.parse(html[:doc], nil, html[:charset])
      end
    end
  end
end
