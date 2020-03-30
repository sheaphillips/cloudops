provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "shea.phillips@brightcoast.ca"
}

resource "acme_certificate" "certificate" {
  account_key_pem           =acme_registration.reg.account_key_pem
  common_name               = "cloud.brightcoast.ca"
  dns_challenge {
    provider = "route53"
  }
}
