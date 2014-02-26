## Pearson Travel API

This document describes how to use the Pearson SDK to access the Travel API. For further details of this API and it's usage, please see [Pearson Travel API](http://developer.pearson.com/apis/topten-travel-guides/).

### Accessing the Travel API
Start by connecting to the Travel API class provided by the Pearson SDK (see example below). 
```Ruby
travel = Pearson::Travel.new("api_key");
```

where the _api_key_ is your key to access the Pearson Travel API.

If no key is specified, or the key is a 'sandbox' key, then you will be limitied to searching and retrieving from only a subset of the data available in the Travel API.

### Travel API Endpoints

#### Topten, Streetsmart, Around Town and Places

In order to search or retrieve 'topten' style documents from the Travel API, you need to use one of the following endpoint methods that the API provides:

```Ruby
travel = Pearson::Travel.new(my_api_key);
topten = travel.topten
streetsmart = travel.streetsmart
around_town = travel.aroundtown
places = travel.places;
```
These endpoints provide access to search for, and retrieve, documents from the Travel API.

### Searching 
```
topten.search(search_obj)
```
Searches the Travel API (use appropriate endpoint to search for documents other than 'topten'). The ```search_obj``` should be a Ruby hash containing one or more of the following proprerties used to direct the search results:
* offset / limit (integer)
* search - (string) Generic search across all fields on documtent in Travel API. 
* category - (string) Search for specific categories of document (only available for _places_ endpoint).
* lat - (float) GeoSearch based on latitude.
* lon - (float) GeoSearch based on longitude.
* dist - (int) GeoSearch within the given radius (in meters)

_offset_ and _limit_ are optional zero-based indexes into the results returned, and can be used for paging through results. _limit_ defaults to 10, and has a maximum value of 25. An _offset_ greater than total number of results available will cause the return of zero results.

An example of a search *might* be as follows:
```Ruby
search_obj = { search: "(+castle -hotel)",
                  lat: 40.75783,
                  lon: -73.98453,
                  dist: 500,
                  limit: 25
                }

results = places.search(search_obj);
```

### Retrieving an Entry
Use the _get_by_id_ method on the endpoints to retrieve the full detail of a specific entry.
```Ruby
result = topten.get_by_id(id)
```
where _id_ is the Id of the document you wish to retrieve.

### Limiting Search to Specific Travel Datasets
You can limit the search of the Travel API to spefic _datasets_ prior to searching.
```Ruby
places.set_data_sets("tt_dublin,tt_newyor");
#datasets can be passed as a single comma separated string or multiple strings separated by comma.
places.search(search_obj);
```
This will ensure that only the specified travel datasets are searched. 

### Listing Datasets Available
There are almost 90 different datasets in the Travel API. A list of of available dataset names and a description of the area they cover, can be obtained by using the ```datasets``` endpoint.
```Ruby
travel.dataset.search
```

