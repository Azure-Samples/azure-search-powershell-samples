---
page_type: sample
languages:
  - rest
  - powershell
name: Quickstart in REST - PowerShell
description: |
  PowerShell cmdlets with REST API calls to Azure Search (api-version=2019-05-06), demonstrating index definition, data ingestion, and query execution. 
products:
  - azure
  - azure-search
urlFragment: powershell-rest-quickstart
---

# Quickstart for Azure Search using REST APIs and PowerShell

Demonstrates PowerShell cmdlets calling REST APIs to send requests to Azure Search: create an index, load it with documents, and execute a few queries. 

This sample is a PowerShell script (.ps1) file used in [Quickstart: Create an Azure Search index using PowerShell and the Azure Search REST API](https://docs.microsoft.com/azure/search/search-get-started-powershell). It uses the [Invoke-WebRequest](https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-6) cmdlet and [Azure Search REST APIs (api-version=2019-05-06)](https://docs.microsoft.com/rest/api/searchservice/).

## Contents

| File/folder | Description |
|-------------|-------------|
| `azure-search-quickstart.ps1` | PowerShell script, which you can run from the command line |
| `.gitignore` | Define what to ignore at commit time. |
| `CONTRIBUTING.md` | Guidelines for contributing to the sample. |
| `README.md` | This README file. |
| `LICENSE`   | The license for the sample. |

## Prerequisites

- [Windows PowerShell app](https://docs.microsoft.com/powershell/scripting/components/ise/introducing-the-windows-powershell-ise?view=powershell-6)
- [Azure Search service](https://docs.microsoft.com/azure/search/search-create-service-portal)

## Setup

1. Clone or download this sample repository.
1. Extract contents if the download is a zip file. Make sure the files are read-write.

## Running the quickstart
1. Open the azure-search-quickstart.ps1 file in an editor
1. Replace <YOUR-SERVICE-NAME> and <YOUR-ADMIN-API-KEY> with the service and api-key details of your Azure Search service
1. Open a PowerShell console, navigate to the file location, and run the script: `.\azure-search-quickstart.ps1`

