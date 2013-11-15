require_relative '../spec_helper.rb'
require_relative '../sdk.rb'

describe Travel, "Travel Api" do
	before :each do
		@trav = Travel.new
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

describe Foodanddrink, "Food and Drink Api" do
	before :each do
		@food = Foodanddrink.new
	end

	it "should have the api set to foodanddrink" do
		expect(@food.instance_variable_get(:@api)).to eq("foodanddrink")
	end

	it "should have an recipes endpoint" do
		@food.recipes
		expect(@food.instance_variable_get(:@endpoint)).to eq("recipes")
	end

end

describe Ftarticles, "Ft Articles Api" do
	before :each do
		@ft = Ftarticles.new
	end

	it "should have the api set to ft" do
		expect(@ft.instance_variable_get(:@api)).to eq("ft")
	end

	it "should have an articles endpoint" do
		@ft.articles
		expect(@ft.instance_variable_get(:@endpoint)).to eq("articles")
	end
end

describe Dictionaries, "Dictionaries API" do
	before :each do
		@dict = Dictionaries.new
	end

	it "should have the api set to dictionaries" do
		expect(@dict.instance_variable_get(:@api)).to eq("dictionaries")
	end

	it "should have an entries endpoint" do
		@dict.entries
		expect(@dict.instance_variable_get(:@endpoint)).to eq("entries")
	end
end

describe Travel, "the expand url function" do
	it "should take a url from the api and making a valid asset url" do
		@travelpiece = Travel.new
		@travelpiece.topten
		@testurl = "/v2/travel/topten/PkfnyWwS8kwH41"

		expect(@travelpiece.expandUrl(@testurl)).to eq("http://api.pearson.com/v2/travel/topten/PkfnyWwS8kwH41")

	end
end

describe Foodanddrink, "the getById function" do
	it "can retrieve an document from the server" do
		@food = Foodanddrink.new
		@food.recipes
		
		expect(@food.getById("721")["status"]).to eq(200)
		expect(@food.getById("721")["result"]).not_to be_empty
	end
end

describe Travel, "refining by dataset" do
	it "returns less results when refined by dataset" do
		@test1 = Travel.new
		@test2 = Travel.new
		@test1.topten
		@test2.topten
		@test2.setDsets("tt_newyor")

		expect(@test1.search["total"]).to be > (@test2.search["total"])
	end
end

describe Ftarticles, "sandbox access" do
	it "should return a result without an api key" do
		@ft = Ftarticles.new
		@ft.articles

		expect(@ft.search["status"]).to eq(200)
	end

	it "should return a result using an apikey" do
		@ft = Ftarticles.new("JZNt3YM1veh1d6HDiCpA86vFJvuRefjw")
		@ft.articles

		expect(@ft.search["status"]).to eq(200)
	end
end

