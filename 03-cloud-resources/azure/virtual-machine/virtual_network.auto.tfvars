vnet_address_space = [
  "192.168.1.0/24"
]

subnets = {
  vm = [
    "192.168.1.0/25"
  ]
  db = [
    "192.168.1.128/25"
  ]
}

network_topology = {
  "raffaele" = {
    vnet_address_space = ["192.168.1.0/24"]
    subnets = {
      vm = [
        "192.168.1.0/25"
      ]
      db = [
        "192.168.1.128/25"
      ]
    }
  }
  "raffaele-2" = {
    vnet_address_space = ["192.168.2.0/24"]
    subnets = {
      vm = [
        "192.168.2.0/24"
      ]
    }
  }
}