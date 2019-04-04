# Admin api-key and service name can be found in the portal
# Given https://mydemo.search.windows.net, service name is "mydemo"
$apiKey = '[Put your admin api-key here]'
$searchServiceName = '[Put your search service name here]'

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

function Execute-Request
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

function Execute-RequestWithBody
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
    $resp = Invoke-RestMethod $requestUri -Method $method -Body $body -ContentType $contentType -Headers $headers

    $resp.StatusCode
    $resp.Content
}

$body = @"
{
    "name": "hotels",  
    "fields": [
        {"name": "hotelId", "type": "Edm.String", "key": true, "searchable": false, "sortable": false, "facetable": false},
        {"name": "baseRate", "type": "Edm.Double"},
        {"name": "description", "type": "Edm.String", "filterable": false, "sortable": false, "facetable": false},
        {"name": "description_fr", "type": "Edm.String", "filterable": false, "sortable": false, "facetable": false, "analyzer": "fr.lucene"},
        {"name": "hotelName", "type": "Edm.String", "facetable": false},
        {"name": "category", "type": "Edm.String"},
        {"name": "tags", "type": "Collection(Edm.String)"},
        {"name": "parkingIncluded", "type": "Edm.Boolean", "sortable": false},
        {"name": "smokingAllowed", "type": "Edm.Boolean", "sortable": false},
        {"name": "lastRenovationDate", "type": "Edm.DateTimeOffset"},
        {"name": "rating", "type": "Edm.Int32"},
        {"name": "location", "type": "Edm.GeographyPoint"}
    ]
}
"@

Execute-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes?api-version=2017-11-11" $apiKey $body

$body = @"
{
    "value": [
        {
            "@search.action": "upload",
            "hotelId": "1",
            "baseRate": 199.0,
            "description": "Best hotel in town",
            "description_fr": "Meilleur hôtel en ville",
            "hotelName": "Fancy Stay",
            "category": "Luxury",
            "tags": ["pool", "view", "wifi", "concierge"],
            "parkingIncluded": false,
            "smokingAllowed": false,
            "lastRenovationDate": "2010-06-27T00:00:00Z",
            "rating": 5,
            "location": { "type": "Point", "coordinates": [-122.131577, 47.678581] }
        },
        {
            "@search.action": "upload",
            "hotelId": "2",
            "baseRate": 79.99,
            "description": "Cheapest hotel in town",
            "description_fr": "Hôtel le moins cher en ville",
            "hotelName": "Roach Motel",
            "category": "Budget",
            "tags": ["motel", "budget"],
            "parkingIncluded": true,
            "smokingAllowed": true,
            "lastRenovationDate": "1982-04-28T00:00:00Z",
            "rating": 1,
            "location": { "type": "Point", "coordinates": [-122.131577, 49.678581] }
        },
        {
            "@search.action": "mergeOrUpload",
            "hotelId": "3",
            "baseRate": 129.99,
            "description": "Close to town hall and the river"
        },
        {
            "@search.action": "delete",
            "hotelId": "6"
        }
    ]
}
"@

Execute-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes/hotels/docs/index?api-version=2017-11-11" $apiKey $body

Write-Line "`nWaiting for documents to be indexed..."

Start-Sleep -Seconds 2

Write-Line "`nSearch the entire index for the term 'budget' and return only the hotelName field:"

Execute-Request GET "https://$searchServiceName.search.windows.net/indexes/hotels/docs?search=budget&`$select=hotelName&api-version=2017-11-11" $apiKey

$body = @"
{
    "search": "budget",
    "select": "hotelName"
}
"@

Execute-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes/hotels/docs/search?api-version=2017-11-11" $apiKey $body

Write-Line "`nSearch the entire index for hotels cheaper than `$150 per night and return the hotelId and description:"

Execute-Request GET "https://$searchServiceName.search.windows.net/indexes/hotels/docs?search=*&`$filter=baseRate lt 150&`$select=hotelId,description&api-version=2017-11-11" $apiKey

$body = @"
{
    "search": "*",
    "filter": "baseRate lt 150",
    "select": "hotelId,description"
}
"@

Execute-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes/hotels/docs/search?api-version=2017-11-11" $apiKey $body

Write-Line "`nSearch the entire index, order by a specific field (lastRenovationDate) in descending order, take the top two results, and show only hotelName and lastRenovationDate:"

Execute-Request GET "https://$searchServiceName.search.windows.net/indexes/hotels/docs?search=*&`$top=2&`$orderby=lastRenovationDate desc&`$select=hotelName,lastRenovationDate&api-version=2017-11-11" $apiKey

$body = @"
{
    "search": "*",
    "orderby": "lastRenovationDate desc",
    "select": "hotelName,lastRenovationDate",
    "top": 2
}
"@

Execute-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes/hotels/docs/search?api-version=2017-11-11" $apiKey $body

Write-Line "`nSearch the entire index for the term 'motel':"

Execute-Request GET "https://$searchServiceName.search.windows.net/indexes/hotels/docs?search=motel&api-version=2017-11-11" $apiKey

$body = @"
{
    "search": "motel"
}
"@

Execute-RequestWithBody POST "https://$searchServiceName.search.windows.net/indexes/hotels/docs/search?api-version=2017-11-11" $apiKey $body

Execute-Request DELETE "https://$searchServiceName.search.windows.net/indexes/hotels?api-version=2017-11-11" $apiKey