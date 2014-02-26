A Ruby Client Library for accessing the Pearson API
====================================================

# Setting up API and client details.
After loading pearson\_sdk.rb:  

# APIs
See the individual API documentation (TravelAPI, DictionaryAPI, etc.) to see how to use the Pearson API SDK for specific APIs.

# Searching
Searching is fundamental to making the most of the Pearson APIs. See the SEARCHING documentation for hints on how to search for content and make the best use of the available search options.

# Usage

In your Gemfile:

    gem 'pearson_sdk', :git => 'https://github.com/cantino/Pearson-Api-Sdk-Ruby'

In your code:

    require 'pearson'
    api = Pearson::FTArticles.new("your api key")
    request = api.articles.search(search: "chicken")
    request['results']
