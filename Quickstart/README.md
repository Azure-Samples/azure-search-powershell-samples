---
page_type: sample
languages:
  - powershell
name: Quickstart in PowerShell
description: |
  Learn how to create, load, and query an Azure AI Search index using the latest-version REST APIs and PowerShell cmdlets. 
products:
  - azure
  - azure-cognitive-search
urlFragment: powershell-rest-quickstart
---

# Quickstart sample for Azure AI Search using REST APIs and PowerShell

![Flask sample MIT license badge](https://img.shields.io/badge/license-MIT-green.svg)

Demonstrates PowerShell cmdlets calling REST APIs to send requests to Azure AI Search: create an index, load it with documents, and execute a few queries. 

This sample is a PowerShell script (.ps1) file used in [Quickstart: Create an Azure AI Search index using PowerShell and the AI  REST API](https://learn.microsoft.com/azure/search/search-get-started-powershell). It uses the [Invoke-WebRequest](https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-6) cmdlet and [Azure AI Search REST APIs (api-version=2019-05-06)](https://learn.microsoft.com/rest/api/searchservice/).

## Prerequisites

- [Windows PowerShell](https://learn.microsoft.com/powershell/scripting/install/installing-powershell-on-windows)

- [Azure AI Search service](https://learn.microsoft.com/azure/search/search-create-service-portal)

## Set up the sample

1. Clone or download this sample repository.
1
. Extract contents if the download is a zip file. Make sure the files are read-write.

## Run the sample

1. Open the azure-search-quickstart.ps1 file in an editor.

1. Replace <YOUR-SERVICE-NAME> and <YOUR-ADMIN-API-KEY> with the service and api-key details of your Azure AI Search service.

1. Open a PowerShell console, navigate to the file location, and run the script: `.\azure-search-quickstart.ps1`.

## Next steps

You can learn more about Azure AI Search on the [official documentation site](https://learn.microsoft.com/azure/search).