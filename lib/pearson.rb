require 'pearson/version'
require 'rubygems'
require 'json'
require 'httparty'
require 'pp'
require 'active_support/core_ext/object/to_query'

module Pearson
  module Base
    # specify a data set to work in
    def set_data_sets(*args)
      comp = *args.join(",").delete(" ")
      @data_sets = comp * ","
    end

    def get_by_id(id)
      if @api_key.nil?
        response = self.class.get("/#{@api}/#{@endpoint}/#{id}")
      else
        response = self.class.get("/#{@api}/#{@endpoint}/#{id}?api_key=#{@api_key}")
      end
      response.parsed_response
    end

    def expand_url(url)
      prepend = "http://api.pearson.com"
      if @api_key.nil?
        prepend + url
      else
        prepend + url + "?apikey=" + @api_key
      end
    end

    def clean_hash(hash)
      hash.delete_if do |key, val|
        if block_given?
          yield(key, val)
        else
          val.nil? || val == 0 || !val || (val.respond_to?('empty?') && val.empty?) || (val.is_a?(String) && val.strip.empty?)
        end
      end

      hash.each do |key, val|
        if hash[key].is_a?(Hash)
          if block_given?
            hash[key] = clean_hash(hash[key], &Proc.new)
          else
            hash[key] = clean_hash(hash[key])
          end
        end
      end

      hash
    end

    def search(search_obj={})
      key = {api_key: "#{@api_key}", offset: 0, limit: 10}
      queries = clean_hash(key.merge(search_obj)).to_query

      if defined?(@data_sets)
        self.class.get("/#{@api}/#{@data_sets}/#{@endpoint}?#{queries}").parsed_response
      else
        self.class.get("/#{@api}/#{@endpoint}?#{queries}").parsed_response
      end
    end
  end

  class Travel
    include Base
    include HTTParty

    format :json
    base_uri 'http://api.pearson.com/v2'

    def initialize(api_key=nil)
      @api_key = api_key
      @api = "travel"
    end

    def topten
      @endpoint = "topten"
    end

    def streetsmart
      @endpoint = "streetsmart"
    end

    def aroundtown
      @endpoint = "around_town"
    end

    def places
      @endpoint = "places"
    end

    def datasets
      @endpoint = "datasets"
    end

    def categories
      @endpoint = "categories"
    end
  end

  class FoodAndDrink
    include Base
    include HTTParty

    format :json
    base_uri 'http://api.pearson.com/v2'

    def initialize(api_key=nil)
      @api_key = api_key
      @api = "foodanddrink"
    end

    def recipes
      @endpoint = "recipes"
    end
  end

  class FTArticles
    include Base
    include HTTParty

    format :json
    base_uri 'http://api.pearson.com/v2'

    def initialize(api_key=nil)
      @api_key = api_key
      @api = "ft"
    end

    def articles
      @endpoint = "articles"
    end
  end

  class Dictionaries
    include Base
    include HTTParty

    format :json
    base_uri 'http://api.pearson.com/v2'

    def initialize(api_key=nil)
      @api_key = api_key
      @api = "dictionaries"
    end

    def entries
      @endpoint = "entries"
    end
  end
end