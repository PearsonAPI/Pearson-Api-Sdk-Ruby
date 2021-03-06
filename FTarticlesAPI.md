## Pearson FT Education API

This document describes how to use the Pearson SDK to access the Financial Times Education Api. For further details of this API and it's usage, please see [Pearson FT Education API](http://developer.pearson.com/apis/ft-education-api/).

### Accessing the FT API  
Start by connecting to the FT API class provided by the SDK: 
```Ruby
ft = Pearson::FTArticles.new("api_key");
#where apikey is the key to access the Pearson FT API
```

If no key is specified, or is a 'sandbox' key, searches will return a limited subset of information.  

#### Endpoint: 
The only endpoint for the FT API is 'articles':

```ruby
ft = Pearson::FTArticles.new("api_key");
articles = ft.articles
```

### Searching
```Ruby
articles.search(search_obj);
```

This searches the API for the search terms present in the 'search_obj'. This should be a Ruby hash containing properties to direct the search results:

* offset / limit (intergers) - these are set to 0 and 10 as default.

* search - (string) Searches across all articles for the specified string.  
* headline - (string) Searches for articles with that headline text  

* contributors - (string) Searches for articles by named contributor(s) 

* company - (string) Searches for articles about a named company  

* industry - (string) Limits the search to a given industry  

* country - (string) Limits to articles with a given country  

* sector - (string) Limit to specific sector code  

* region - (string) Limit to specific region code  

* article_date - (string) Limit to articles with the given date (use YYYY-MM-DD) or within a range (use [YYYY-MM-DD TO YYYY-MM-DD])  

_offset_ and _limit_ are optional zero-based indexes into the results returned, and can be used for paging through results. _limit_ defaults to 10, and has a maximum value of 25. An _offset_ greater than total number of results available will cause the return of zero results.  

One search example could be:  
```Ruby
search_obj = {
	search: "technology",
	headline: "Foxconn",
	contributors: "Henry Mance"
}

articles.search(search_obj)
```

You can also retrieve an article by Id using the get_by_id method:
```Ruby
article = articles.get_by_id("cqDa2KAJAf");
```

