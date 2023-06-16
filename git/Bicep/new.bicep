@description('Location for all resources.')
param region string = resourceGroup().location

resource virtualNetwork 'Microsoft.Network/virtualNetworks/virtualNetwork@2021-05-01' = {
  name: 'Vnet'
  location: region
  properties: {
    addressSpace:{
      addressPrefixes:[
        '10.0.0.0/16'
      ]
    }
    subnets:[
      {
        name: subnet1
        properties:{
          addressPrefix:'10.0.0.0/24'
        }
      }
    ]
  }
}

resource networkinterface 'microsoft.Network/networkInterface@2021-05-01'

