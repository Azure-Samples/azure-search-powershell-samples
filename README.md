# PowerShell samples for Azure AI Search

This repository contains PowerShell samples used in Azure AI Search documentation. Unless noted otherwise, all samples run on the shared (free) pricing tier of an [Azure AI Search service](https://learn.microsoft.com/azure/search/search-create-service-portal).

| Sample | Description |
|--------|-------------|
| PowerShell-AzSearchModule | Provides cmdlet syntax demonstrating how to use the AzSearchModule for administrative, control plane tasks. The cmdlets in this module are used to create or delete a service, adjust capacity, and manage keys. |
| PowerShell-REST | Data plane sample, using the Invoke-WebRequest and Invoke-Request cmdlets to create an index, load it with documents, and execute a few queries.  |
| Quickstart | "Day One" introduction to the fundamental tasks of working with a search index: create, load, and query. This sample demonstrates the Invoke-WebRequest cmdlet calling Azure AI Search REST APIs to send requests to Azure AI Search. The index is modeled on a subset of the Hotels dataset, reduced for readability and comprehension. |
