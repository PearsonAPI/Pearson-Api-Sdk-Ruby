require_relative 'spec_helper.rb'
require_relative '../lib/pearson.rb'

describe Pearson::Travel, "Travel Api" do
  before :each do
    @trav = Pearson::Travel.new
  end

  it "should have the api set to travel" do
    expect(@trav.instance_variable_get(:@api)).to eq("travel")
  end

  it "the aroundtown method should set the endpoint to around_town" do
    @trav.aroundtown
    expect(@trav.instance_variable_get(:@endpoint)).to eq("around_town")
  end

  it "the topten method should set the endpoint to topten" do
    @trav.topten
    expect(@trav.instance_variable_get(:@endpoint)).to eq("topten")
  end

  it "the categories method should set the endpoint to categories" do
    @trav.categories
    expect(@trav.instance_variable_get(:@endpoint)).to eq("categories")
  end

  it "the datasets method should set the endpoint to datasets" do
    @trav.datasets
    expect(@trav.instance_variable_get(:@endpoint)).to eq("datasets")
  end

  it "the places method should set the endpoint to places" do
    @trav.places
    expect(@trav.instance_variable_get(:@endpoint)).to eq("places")
  end

  it "the streetsmart method should set the endpoint to streetsmart" do
    @trav.streetsmart
    expect(@trav.instance_variable_get(:@endpoint)).to eq("streetsmart")
  end

  it "calling the entries method should throw an error" do
    expect { @trav.entries }.to raise_error
  end


end

describe Pearson::FoodAndDrink, "Food and Drink Api" do
  before :each do
    @food = Pearson::FoodAndDrink.new
  end

  it "should have the api set to foodanddrink" do
    expect(@food.instance_variable_get(:@api)).to eq("foodanddrink")
  end

  it "should have an recipes endpoint" do
    @food.recipes
    expect(@food.instance_variable_get(:@endpoint)).to eq("recipes")
  end
end

describe Pearson::FTArticles, "Ft Articles Api" do
  before :each do
    @ft = Pearson::FTArticles.new
  end

  it "should have the api set to ft" do
    expect(@ft.instance_variable_get(:@api)).to eq("ft")
  end

  it "should have an articles endpoint" do
    @ft.articles
    expect(@ft.instance_variable_get(:@endpoint)).to eq("articles")
  end
end

describe Pearson::Dictionaries, "Dictionaries API" do
  before :each do
    @dict = Pearson::Dictionaries.new
  end

  it "should have the api set to dictionaries" do
    expect(@dict.instance_variable_get(:@api)).to eq("dictionaries")
  end

  it "should have an entries endpoint" do
    @dict.entries
    expect(@dict.instance_variable_get(:@endpoint)).to eq("entries")
  end
end

describe Pearson::Travel, "the expand url function" do
  it "should take a url from the api and making a valid asset url" do
    @travelpiece = Pearson::Travel.new
    @travelpiece.topten
    @testurl = "/v2/travel/topten/PkfnyWwS8kwH41"
    expect(@travelpiece.expand_url(@testurl)).to eq("http://api.pearson.com/v2/travel/topten/PkfnyWwS8kwH41")
  end
end

describe Pearson::FoodAndDrink, "the get_by_id function" do
  it "can retrieve an document from the server" do
    @food = Pearson::FoodAndDrink.new
    @food.recipes

    expect(@food.get_by_id("721")["status"]).to eq(200)
    expect(@food.get_by_id("721")["result"]).not_to be_empty
  end
end

describe Pearson::Travel, "refining by dataset" do
  it "returns less results when refined by dataset" do
    @test1 = Pearson::Travel.new
    @test2 = Pearson::Travel.new
    @test1.topten
    @test2.topten
    @test2.set_data_sets("tt_newyor")

    expect(@test1.search["total"]).to be > (@test2.search["total"])
  end
end

describe Pearson::FTArticles, "sandbox access" do
  it "should return a result without an api key" do
    @ft = Pearson::FTArticles.new
    @ft.articles

    expect(@ft.search["status"]).to eq(200)
  end

  it "should return a result using an api_key" do
    @ft = Pearson::FTArticles.new("JZNt3YM1veh1d6HDiCpA86vFJvuRefjw")
    @ft.articles

    expect(@ft.search["status"]).to eq(200)
  end
end