require 'rubygems'
require 'json'
require 'httparty'
require 'pp'
require 'active_support/core_ext/object/to_query'

module PearsonApis
  include HTTParty
  
  # specify a dataset to work in
  def setDsets(*args)
    comp = *args.join(",").delete(" ")
    @dsets = comp*","
  end


  def getById(id)
    
    if (@apikey).nil? 
          response = self.class.get("/#{@api}/#{@endpoint}/#{id}")
    else
          response = self.class.get("/#{@api}/#{@endpoint}/#{id}?apikey=#{@apikey}")
    end
    

    # if response.success?
    #   response
    # else
    #   raise response.response
    # end
    resp = response.parsed_response
    return resp
  end

  def expandUrl(url)
    #create full url
    prepend = "http://api.pearson.com"
    if (@apikey).nil?
      itemUrl = prepend + url 
    else
      itemUrl = prepend + url + "?apikey=#{@apikey}"
    end
    itemUrl
  end

  def search(searchobj={})
      
      key = { apikey: "#{@apikey}", offset: 0, limit: 10 }

      toQ = key.merge(searchobj)

      yourVars = toQ.clean!

      queries = yourVars.to_query

    if (defined?(@dsets)).nil?
      response = self.class.get("/#{@api}/#{@endpoint}?#{queries}")
      resp = response.parsed_response
      return resp
    else
      url = "/#{@api}/#{@dsets}/#{@endpoint}?#{queries}"
      response = self.class.get(url)
      resp = response.parsed_response
      return resp
    end
    
  end

end # PearsonApis Module


# Select API via class and leave endpoints as methods.
  class Travel 
    include PearsonApis
    include HTTParty
    
    format :json
    base_uri 'http://api.pearson.com/v2'
    
    def initialize(apikey=nil) # create an api class tied to a key and v2 api
      @apikey = apikey
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

  class Foodanddrink
    include PearsonApis
    include HTTParty
    format :json
    base_uri 'http://api.pearson.com/v2'


    def initialize(apikey=nil) # create an api class tied to a key and v2 api
      @apikey = apikey
      @api = "foodanddrink"
    end
    
    def recipes
      @endpoint = "recipes"
    end

  end

  class Ftarticles 
    include PearsonApis
    include HTTParty
    format :json
    base_uri 'http://api.pearson.com/v2'

    def initialize(apikey=nil) # create an api class tied to a key and v2 api
      @apikey = apikey
      @api = "ft"
    end

    def articles
      @endpoint = "articles"
    end

  end

  class Dictionaries
    include PearsonApis
    include HTTParty
    format :json
    base_uri 'http://api.pearson.com/v2'

    def initialize(apikey=nil) # create an api class tied to a key and v2 api
      @apikey = apikey
      @api = "dictionaries"
    end

    def entries
      @endpoint = "entries"
    end


  end






#### Remove 'empty' values from hash
class Hash
  def clean!
          self.delete_if do |key, val|
              if block_given?
                  yield(key,val)
              else
                  # Prepeare the tests
                  test1 = val.nil?
                  test2 = val === 0
                  test3 = val === false
                  test4 = val.empty? if val.respond_to?('empty?')
                  test5 = val.strip.empty? if val.is_a?(String) && val.respond_to?('empty?')

                  # Were any of the tests true
                  test1 || test2 || test3 || test4 || test5
              end
          end

          self.each do |key, val|
              if self[key].is_a?(Hash) && self[key].respond_to?('clean!')
                  if block_given?
                      self[key] = self[key].clean!(&Proc.new)
                  else
                      self[key] = self[key].clean!
                  end
              end
          end

          return self
      end
end