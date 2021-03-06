#!/bin/bash
echo "# Optimizacion: proxy local"
echo "export http_proxy=http://172.16.16.1:8000/"
echo ""

export http_proxy=http://172.16.16.1:8000/

echo "# Instalación"
echo "sudo env http_proxy=$http_proxy apt-get install uvtool #Desloguearse/Loguear para que tome GID"
echo ""

echo "# Obteniendo imágenes"
echo "export http_proxy=http://172.16.16.1:8000/"
echo "uvt-simplestreams-libvirt -v sync release=xenial arch=amd64 --source http://cloud-images.ubuntu.com/releases"
echo ""

echo "# SSH keys (locales, podés copiar las tuyas en vez)"
echo "ssh-keygen"
echo ""

echo "# Lanzando una instancia"
echo "uvt-kvm create primervm"
echo ""

echo "# Listamos instancia(s)"
echo "uvt-kvm list"
echo ""

echo "# Ver IP"
echo "uvt-kvm ip primervm"
echo ""


echo "# Loguearse"
echo "uvt-kvm ssh primervm --insecure"
echo ""

echo "# Eliminar"
echo "uvt-kvm destroy primervm"
echo ""

echo "# Creando con parámetros"
echo "uvt-kvm create segundavm release=xenial arch=amd64 --bridge virbr0 --memory 512 --disk 10 --memory 1024"
echo ""

echo "# MSS problems"
echo "iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1400"
echo ""

echo "# Sshutle para acceder a la red en las instancias [http://sshuttle.readthedocs.io/en/stable/]"
echo "sshuttle 192.168.122.0/24 -r ubuntu@IP_INSTANCIA"
