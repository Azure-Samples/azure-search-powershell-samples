---
page_type: sample
languages:
  - rest
  - powershell
name: REST calls in PowerShell - API version 2017-11-11
description: |
  PowerShell cmdlets with REST API calls to Azure Search (api-version=2017-11-11), demonstrating index definition, data ingestion, and query execution. This api-version does not support complex types.
products:
  - azure
  - azure-search
urlFragment: powershell-rest-2017-11-11
---

# Issue REST calls in PowerShell (api-version=2017-11-11)

PowerShell cmdlets with REST API calls to Azure Search (api-version=2017-11-11), demonstrating index definition, data ingestion, and query execution. This api-version does not support complex types. This sample is standalone and is not referenced in any walkthroughs.

## Contents

| File/folder | Description |
|-------------|-------------|
| `RestHowTo-Invoke-RestMethod.ps1` | PowerShell script, which you can run from the command line |
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
1. Open the RestHowTo-Invoke-RestMethod.ps1 file in an editor
1. Replace <YOUR-SERVICE-NAME> and <YOUR-ADMIN-API-KEY> with the service and api-key details of your Azure Search service
1. Open a PowerShell console, navigate to the file location, and run the script: `.\RestHowTo-Invoke-RestMethod.ps1`