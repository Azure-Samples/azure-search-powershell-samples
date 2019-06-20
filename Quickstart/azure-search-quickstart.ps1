$apiKey = '<YOUR-ADMIN-API-KEY>'
$searchServiceName = '<YOUR-SEARCH-SERVICE-NAME>'

function Write-Line
{
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]$text
    )
    Write-Host $text -foregroundColor Green
}

function Write-Headers
{
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]$headers
    )

    $text = ($headers.Keys | foreach { "$_`: $($headers[$_])" }) -join "`n"
    Write-Line $text
}

function Send-Request
{
    param($method, $requestUri, $apiKey)
    # Adding 'odata.metadata=none' to the Accept header to make the response payloads more concise and readable.
    $headers = @{"api-key"=$apiKey; "Accept"="application/json; odata.metadata=none"}

    Write-Line "`n$method $requestUri"
    Write-Headers $headers

    $resp = @{}
    $resp = Invoke-WebRequest $requestUri -Method $method -Headers $headers
    $resp.StatusCode
    $resp.Content
}

function Send-RequestWithBody
{
    param($method, $requestUri, $apiKey, $body)
    # Adding 'odata.metadata=none' to the Accept header to make the response payloads more concise and readable.
    $headers = @{"api-key"=$apiKey; "Accept"="application/json; odata.metadata=none"}

    # Adding 'charset=utf-8' to the Content-Type header so that we can index non-ASCII characters like accents from PowerShell.
    $contentType = "application/json; charset=utf-8"

    Write-Line "`n$method $requestUri"
    Write-Line "Content-Type: $contentType"
    Write-Headers $headers
    Write-Line "`n$body"
    
    $resp = @{}
    $resp = Invoke-WebRequest $requestUri -Method $method -Body $body -ContentType $contentType -Headers $headers
    $resp.StatusCode
    $resp.Content
}

Send-Request DELETE "https://$searchServiceName.search.windows.net/indexes/hotels-quickstart?api-version=2019-05-06" $apiKey

$body = @"
{
    "name": "hotels-quickstart",  
    "fields": [
        {"name": "HotelId", "type": "Edm.String", "key": true, "filterable": true},
        {"name": "HotelName", "type": "Edm.String", "searchable": true, "filterable": false, "sortable": true, "facetable": false},
        {"name": "Description", "type": "Edm.String", "searchable": true, "filterable": false, "sortable": false, "facetable": false, "analyzer": "en.lucene"},
        {"name": "Category", "type": "Edm.String", "searchable": true, "filterable": true, "sortable": true, "facetable": true},
        {"name": "Tags", "type": "Collection(Edm.String)", "searchable": true, "filterable": true, "sortable": false, "facetable": true},
        {"name": "ParkingIncluded", "type": "Edm.Boolean", "filterable": true, "sortable": true, "facetable": true},
        {"name": "LastRenovationDate", "type": "Edm.DateTimeOffset", "filterable": true, "sortable": true, "facetable": true},
        {"name": "Rating", "type": "Edm.Double", "filterable": true, "sortable": true, "facetable": true},
        {"name": "Address", "type": "Edm.ComplexType", 
        "fields": [
        {"name": "StreetAddress", "type": "Edm.String", "filterable": false, "sortable": false, "facetable": false, "searchable": true},
        {"name": "City", "type": "Edm.String", "searchable": true, "filterable": true, "sortable": true, "facetable": true},
        {"name": "StateProvince", "type": "Edm.String", "searchable": true, "filterable": true, "sortable": true, "facetable": true},
        {"name": "PostalCode", "type": "Edm.String", "searchable": true, "filterable": true, "sortable": true, "facetable": true},
        {"name": "Country", "type": "Edm.String", "searchable": true, "filterable": true, "sortable": true, "facetable": true}
        ]
     }
  ]
}
"@

Send-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes?api-version=2019-05-06" $apiKey $body

$body = @"
{
    "value": [
    {
    "@search.action": "upload",
    "HotelId": "1",
    "HotelName": "Secret Point Motel",
    "Description": "The hotel is ideally located on the main commercial artery of the city in the heart of New York. A few minutes away is Time's Square and the historic centre of the city, as well as other places of interest that make New York one of America's most attractive and cosmopolitan cities.",
    "Category": "Boutique",
    "Tags": [ "pool", "air conditioning", "concierge" ],
    "ParkingIncluded": false,
    "LastRenovationDate": "1970-01-18T00:00:00Z",
    "Rating": 3.60,
    "Address": 
        {
        "StreetAddress": "677 5th Ave",
        "City": "New York",
        "StateProvince": "NY",
        "PostalCode": "10022",
        "Country": "USA"
        } 
    },
    {
    "@search.action": "upload",
    "HotelId": "2",
    "HotelName": "Twin Dome Motel",
    "Description": "The hotel is situated in a  nineteenth century plaza, which has been expanded and renovated to the highest architectural standards to create a modern, functional and first-class hotel in which art and unique historical elements coexist with the most modern comforts.",
    "Category": "Boutique",
    "Tags": [ "pool", "free wifi", "concierge" ],
    "ParkingIncluded": false,
    "LastRenovationDate": "1979-02-18T00:00:00Z",
    "Rating": 3.60,
    "Address": 
        {
        "StreetAddress": "140 University Town Center Dr",
        "City": "Sarasota",
        "StateProvince": "FL",
        "PostalCode": "34243",
        "Country": "USA"
        } 
    },
    {
    "@search.action": "upload",
    "HotelId": "3",
    "HotelName": "Triple Landscape Hotel",
    "Description": "The Hotel stands out for its gastronomic excellence under the management of William Dough, who advises on and oversees all of the Hotel’s restaurant services.",
    "Category": "Resort and Spa",
    "Tags": [ "air conditioning", "bar", "continental breakfast" ],
    "ParkingIncluded": true,
    "LastRenovationDate": "2015-09-20T00:00:00Z",
    "Rating": 4.80,
    "Address": 
        {
        "StreetAddress": "3393 Peachtree Rd",
        "City": "Atlanta",
        "StateProvince": "GA",
        "PostalCode": "30326",
        "Country": "USA"
        } 
    },
    {
    "@search.action": "upload",
    "HotelId": "4",
    "HotelName": "Sublime Cliff Hotel",
    "Description": "Sublime Cliff Hotel is located in the heart of the historic center of Sublime in an extremely vibrant and lively area within short walking distance to the sites and landmarks of the city and is surrounded by the extraordinary beauty of churches, buildings, shops and monuments. Sublime Cliff is part of a lovingly restored 1800 palace.",
    "Category": "Boutique",
    "Tags": [ "concierge", "view", "24-hour front desk service" ],
    "ParkingIncluded": true,
    "LastRenovationDate": "1960-02-06T00:00:00Z",
    "Rating": 4.60,
    "Address": 
        {
        "StreetAddress": "7400 San Pedro Ave",
        "City": "San Antonio",
        "StateProvince": "TX",
        "PostalCode": "78216",
        "Country": "USA"
        }
    }
]
}
"@

Send-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes/hotels-quickstart/docs/index?api-version=2019-05-06" $apiKey $body

Write-Line "`nWaiting for documents to be indexed..."

Start-Sleep -Seconds 2

Write-Line "`nSearch the index for restaurant and wifi and return only HotelName, Description, and Tags:"

Send-Request GET "https://$searchServiceName.search.windows.net/indexes/hotels-quickstart/docs?search=restaurant wifi&`$select=HotelName, Description, Tags&api-version=2019-05-06" $apiKey

$body = @"
{
    "search": "restaurant wifi",
    "select": "HotelName, Description, Tags"
}
"@

Send-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes/hotels-quickstart/docs/search?api-version=2019-05-06" $apiKey $body

Write-Line "`nFilter on ratings higher than 4 and return only HotelName and Rating:"

Send-Request GET "https://$searchServiceName.search.windows.net/indexes/hotels-quickstart/docs?search=*&`$filter=Rating gt 4&`$select=HotelName,Rating&api-version=2019-05-06" $apiKey

$body = @"
{
    "search": "*",
    "filter": "Rating gt 4",
    "select": "HotelName,Rating"
}
"@

Send-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes/hotels-quickstart/docs/search?api-version=2019-05-06" $apiKey $body

Write-Line "`nSearch on the term 'boutique', taking the top two results, and return only HotelName and Cateogry:"

Send-Request GET "https://$searchServiceName.search.windows.net/indexes/hotels-quickstart/docs?search=*&`$top=2&`$select=HotelName,Category&api-version=2019-05-06" $apiKey

$body = @"
{
    "search": "*",
    "select": "HotelName,Category",
    "top": 2
}
"@

Send-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes/hotels-quickstart/docs/search?api-version=2019-05-06" $apiKey $body

Write-Line "`nSearch the entire index for the term 'pool' and sort by Rating in descending order:"

Send-Request GET "https://$searchServiceName.search.windows.net/indexes/hotels-quickstart/docs?search=pool&$select=HotelName,Description,Tags,Rating&api-version=2019-05-06" $apiKey

$body = @"
{
    "search": "pool",
    "select": "HotelName,Description,Tags,Rating",
    "orderby": "Rating desc"
}
"@

Send-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes/hotels-quickstart/docs/search?api-version=2019-05-06" $apiKey $body


