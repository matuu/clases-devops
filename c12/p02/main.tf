# Configure the OpenStack Provider
# Por defecto busca en las variables de entorno que estan seteadas
# en ${USER}.novarc

provider "openstack" {
  #    user_name  = $OS_USERNAME
  #    tenant_name = $OS_TENANT_NAME
  #    password  = $OS_PASSWORD
  #    auth_url  = $OS_AUTH_URL
}

# Configure the Consul provider
provider "consul" {
  address    = "consul.cloud.um.edu.ar:8500"
  datacenter = "um-01"
}

# Security Group para poder exponer los servicios
resource "openstack_compute_secgroup_v2" "c12p02" {
  name        = "c12p02-${var.USER}"
  description = "Security group para las instancias de Terraform"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 3306
    to_port     = 3306
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}

# instancia de compute  para server web
resource "openstack_compute_instance_v2" "c12p02-web" {
  count = "${var.count}"
  name            = "${format("${var.USER}-%02d-web", count.index+1)}"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${var.USER_KEY}"
  security_groups = ["${openstack_compute_secgroup_v2.c12p02.name}"]

  #  floating_ip = "${openstack_compute_floatingip_v2.terraform.address}"

# Usamos la red ya configurada en OPENSTACK UMCLOUD  
  network {
    name = "net_umstack"
  }

# Configuracion de la conexion que haran los provisioners
  connection {
    user = "ubuntu"
  }


 #  user_data = "${file("conf/web.yaml")}"

    provisioner "file" {
         source = "conf/00-bootstrapweb.sh"
         destination = "/tmp/00-bootstrapweb.sh"
    }

    provisioner "file" {
         source = "conf/01-confweb.sh"
         destination = "/tmp/01-confweb.sh"
    }

    provisioner "file" {
         source = "conf/tmpconsul"
         destination = "/tmp/"
    }

    provisioner "remote-exec" {
        inline = [
          "sudo chmod +x /tmp/0*.sh",
          "sudo /tmp/00-bootstrapweb.sh",
          "sudo /tmp/01-confweb.sh ${var.USER}",
	  "sudo /etc/init.d/consul restart"
        ]
     }



}


# Instancia de DB
resource "openstack_compute_instance_v2" "c12p02-db" {

  name            = "${var.USER}-01-db"
  image_name      = "${var.image}"
  flavor_name     = "${var.flavor}"
  key_pair        = "${var.USER_KEY}"
  security_groups = ["${openstack_compute_secgroup_v2.c12p02.name}"]

  #  floating_ip = "${openstack_compute_floatingip_v2.terraform.address}"

  # Usamos la red ya configurada en OPENSTACK UMCLOUD  
  network {
    name = "net_umstack"
  }
  
  # Configuracion de la conexion que haran los provisioners
  connection {
    user = "ubuntu"
  }

#   user_data = "${file("conf/00-bootstrapdb.sh")}"

    provisioner "file" {
         source = "conf/00-bootstrapdb.sh"
         destination = "/tmp/00-bootstrapdb.sh"
    }
    
    provisioner "file" {
         source = "conf/01-confdb.sh"
         destination = "/tmp/01-confdb.sh"
    }
    
    provisioner "file" {
         source = "conf/tmpconsul"
         destination = "/tmp/"
    }   

    provisioner "remote-exec" {
     	inline = [
	  "sudo chmod +x /tmp/0*.sh",
	  "sudo /tmp/00-bootstrapdb.sh",
	  "sudo /tmp/01-confdb.sh",
	  "sudo /etc/init.d/consul restart"
     	]
     }


}
