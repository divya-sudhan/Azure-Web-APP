resource "azurerm_frontdoor" "frontdoor" {
  name                = "webapp_frontdoor"
  resource_group_name = var.resource_group_name

  routing_rule {
    name               = "route_to_loadbalancer"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["domain_name"] #mention domain_name here
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "loadbalancer" #mention loadbalancer here
    }
  }

backend_pool_load_balancing {
    name = "exampleLoadBalancingSettings1" #mention loadbalancer name
  }

  backend_pool_health_probe {
    name = "exampleHealthProbeSetting1"  #mention loadbalancer name
  }

  backend_pool {
    name = "exampleBackendBing"
    backend {
      host_header = "www.bing.com" #doamin name 
      address     = "www.bing.com" #loadbalancer domain name like "my-alb.us-west-2.elb.amazonaws.com" ,Replace with the actual address of your origin server
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "exampleLoadBalancingSettings1" #mention loadbalancer name 
    health_probe_name   = "exampleHealthProbeSetting1" #mention loadbalancer name
  }

  frontend_endpoint {
    name      = "exampleFrontendEndpoint1"
    host_name = "example-FrontDoor.azurefd.net" #domain name 
  }
}