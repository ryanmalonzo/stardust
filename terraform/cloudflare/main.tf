locals {
  root_domain = "ryanmalonzo.com"
  cname_subdomains = [
    "pangolin",
    "portainer",
    "vaultwarden",
    "jellyfin",
    "radarr",
    "sonarr",
    "prowlarr",
    "sabnzbd",
    "profilarr",
    "sonarr-nonanime",
    "radarr-nonanime",
    "profilarr-nonanime",
    "jellyseerr",
    "qbittorrent"
  ]

  dns_records = concat(
    [
      {
        name    = local.root_domain
        type    = "A"
        content = var.pangolin_ip
      }
    ],
    [
      for sub in local.cname_subdomains : {
        name    = "${sub}.${local.root_domain}"
        type    = "CNAME"
        content = local.root_domain
      }
    ]
  )
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

