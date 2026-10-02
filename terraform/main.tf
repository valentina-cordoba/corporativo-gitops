provider "local" {}

#1. Simular la creación de un servidor (como si fuera EC2 AWS)

resource "local_file" "servidor_produccion" {
	content = "Servidor Ubuntu 24.04 - IP: 192.168.1.100"
	filename = "${path.module}/servidor_simulado.txt"
}

#2. PUENTE DE CONEXION T A, crear el host.ini para Ansible

resource "local_file" "generar_inventario_ansible" {
	content = <<EOF
[produccion]
#Definicion de un grupo de servidores
localhost ansible_conecction=local #Añadiendo a mi pc local el local host no conectarse por ssh

[produccion:vars]
#Variable llamada entorno 
entorno=produccion_critica
EOF

	filename = "../ansible/host.ini"

#Obligar a crear el servidor primero
depends_on = [local_file.servidor_produccion]

}
