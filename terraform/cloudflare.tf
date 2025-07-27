resource "cloudflare_dns_record" "main" {
  zone_id = var.cloudflare_zone_id
  name    = "ryanmalonzo.com"
  ttl     = 1
  type    = "A"
  content = var.pangolin_ip
  proxied = false
}

resource "cloudflare_dns_record" "pangolin" {
  zone_id = var.cloudflare_zone_id
  name    = "pangolin.ryanmalonzo.com"
  ttl     = 1
  type    = "CNAME"
  content = "ryanmalonzo.com"
  proxied = false
}
