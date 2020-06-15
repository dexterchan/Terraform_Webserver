terraform {
  backend "remote" {
    organization = "dextest"

    workspaces {
      name = "simpleWebServerSetup"
    }
  }
}