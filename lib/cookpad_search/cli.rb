require 'cookpad_search'
require 'thor'

module CookpadSearch
  class CLI < Thor
    map "-f" => :by_food
    map "-i" => :by_id

    desc "-f [foods]","search on http://cookpad.com/ with args food names."
    def by_food(food = '')
      url = DEFAULT_URL + "search/" + food
      Searcher.search(url)
    end

    desc "",""
    def by_id(id = '')
      url = DEFAULT_URL + "recipe/" + id
      Searcher.by_id(url)
    end
  end
end
