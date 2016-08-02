

#output "address" {


#    value = "${openstack_networking_port_v2.port_1.address}"


#}

output "Name_web" { value = "${join(",",openstack_compute_instance_v2.c12p02-web.*.name)}" }

output "IP_web" {  value = "${join(",",openstack_compute_instance_v2.c12p02-web.*.access_ip_v4)}" }

output "Name_db" { value = "${openstack_compute_instance_v2.c12p02-db.name}" }

output "IP_db"  { value = "${openstack_compute_instance_v2.c12p02-db.access_ip_v4}" }

