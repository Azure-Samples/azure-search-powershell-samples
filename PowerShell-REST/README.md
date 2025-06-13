---
page_type: sample
languages:
  - powershell
name: Issue Azure AI Search REST calls in PowerShell  
description: |
  Learn how to call the Azure AI Search REST APIs from PowerShell. This example demonstrates index creation, data ingestion, and query execution.
products:
  - azure
  - azure-cognitive-search
urlFragment: azure-search-powershell-rest
---

# Issue Azure AI Search REST calls in PowerShell 

PowerShell cmdlets with REST API calls to Azure AI Search, demonstrating index creation, data ingestion, and query execution. This sample is standalone and is not referenced in any walkthroughs.

## Prerequisites

- [Windows PowerShell](https://learn.microsoft.com/powershell/scripting/install/installing-powershell-on-windows)

- [Azure AI Search service](https://learn.microsoft.com/azure/search/search-create-service-portal)

## Setup

1. Clone or download this sample repository.

1. Extract contents if the download is a zip file. Make sure the files are read-write.

## Run the script.

1. Open the RestHowTo-Invoke-RestMethod.ps1 file in an editor.

1. Replace <YOUR-SERVICE-NAME> and <YOUR-ADMIN-API-KEY> with the service and api-key details of your Azure AI Search service.

1. Open a PowerShell console, navigate to the file location, and run the script: `.\RestHowTo-Invoke-RestMethod.ps1`.