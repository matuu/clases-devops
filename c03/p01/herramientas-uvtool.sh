#!/bin/bash
export http_proxy=http://172.16.16.1:8000/

echo "Instalación"
echo "sudo apt-get install uvtool #Desloguearse/Loguear para que tome GID"
echo ""

echo "Obteniendo imágenes"
echo "uvt-simplestreams-libvirt -v sync release=xenial arch=amd64 --source http://cloud-images.ubuntu.com/releases"
echo ""

echo "keys"
echo "ssh-keygen"
echo ""

echo "Lanzando una instancia"
echo "uvt-create primervm"
echo ""

echo "Ver IP"
echo "uvt-kvm ip primervm"
echo ""


echo "Loguearse"
echo "uvt-kvm ssh primervm --insecure"
echo ""

echo "Eliminar"
echo "uvt-kvm destroy primervm"
echo ""

echo "Creando con parámetros"
echo "uvt-kvm create segundavm release=xenial arch=amd64 --bridge virbr0 --memory 512 --disk 10 --memory 2048"
echo ""

