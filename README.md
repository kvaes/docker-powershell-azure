AzureRM Powershell Module via Docker
====================================
A small docker container to get your AzureRM commands up & running via Docker ;-)

Getting Started
===============

Launch your container via the following command ;
docker run -ti kvaes/docker-powershell-azure

Next up is to login to your Azure account & subscription

PS /powershell> Login-AzureRMAccount

PS /powershell> Get-AzureRmSubscription

PS /powershell> Select-AzureRmSubscription -SubscriptionId <your-subscription-id>

And take a look at the command that are available (quite limited in the preview)

PS /powershell> get-command *azurerm*
