locals {
  dns_records = [
    {
      name    = "ryanmalonzo.com"
      type    = "A"
      content = var.pangolin_ip
    },
    {
      name    = "pangolin.ryanmalonzo.com"
      type    = "CNAME"
      content = "ryanmalonzo.com"
    },
    {
      name    = "portainer.ryanmalonzo.com"
      type    = "CNAME"
      content = "ryanmalonzo.com"
    },
    {
      name    = "vaultwarden.ryanmalonzo.com"
      type    = "CNAME"
      content = "ryanmalonzo.com"
    },
    {
      name    = "jellyfin.ryanmalonzo.com"
      type    = "CNAME"
      content = "ryanmalonzo.com"
    }
  ]
}

resource "cloudflare_dns_record" "dns_records" {
  for_each = { for rec in local.dns_records : rec.name => rec }

  zone_id = var.cloudflare_zone_id
  name    = each.value.name
  type    = each.value.type
  content = each.value.content
  ttl     = 1
  proxied = false
}
