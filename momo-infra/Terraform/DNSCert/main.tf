
resource "yandex_dns_zone" "zone-btkvtech" {
  name = "zone-btkvtech"

  zone   = "btkv.tech."
  public = true
}

resource "yandex_cm_certificate" "cert-btkvtech" {
  name    = "cert-btkvtech"
  domains = ["btkv.tech", "*.btkv.tech"]

  managed {
    challenge_type  = "DNS_CNAME"
    challenge_count = 1
  }
}

resource "yandex_dns_recordset" "rs-btkvtech" {
  count   = yandex_cm_certificate.cert-btkvtech.managed[0].challenge_count
  zone_id = yandex_dns_zone.zone-btkvtech.id
  name    = yandex_cm_certificate.cert-btkvtech.challenges[count.index].dns_name
  type    = yandex_cm_certificate.cert-btkvtech.challenges[count.index].dns_type
  data    = [yandex_cm_certificate.cert-btkvtech.challenges[count.index].dns_value]
  ttl     = 60
}
