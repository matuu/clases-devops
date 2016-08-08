

output "IP_externa" {
    value = "${openstack_networking_port_v2.port_1.address}"
    value = "${openstack_compute_floatingip_v2.c12p01.address}"
}

output "Name_web" { value = "${openstack_compute_instance_v2.c12p01-web.name}" }

output "IP_web" {  value = "${openstack_compute_instance_v2.c12p01-web.access_ip_v4}" }

output "Name_db" { value = "${openstack_compute_instance_v2.c12p01-db.name}" }

output "IP_db"  { value = "${openstack_compute_instance_v2.c12p01-db.access_ip_v4}" }
