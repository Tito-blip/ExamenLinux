#!/bin/bash

sudo apt update # Actualizar paquetes apt

echo "Paquetes actualizados correctamente."

PACKAGES=("git" "curl" "ufw" "docker-compose" "docker.io") # Lista de paquetes para instalar

for p in ${PACKAGES[@]}; do # Instalar paquetes con apt
	echo "Instalando $p..."
	sudo apt install -y $p
	echo "$p Instalado correctamente"
done

DIR="/opt/webapp/html"

# Crear usuario sysadmin y grupo docker
if getent group "docker" > /dev/null; then
	echo "Grupo 'docker' ya existe"
else
 	sudo groupadd "docker"
	echo "Grupo 'docker' creado"
fi
# Verificar si el usuario existe
if id "sysadmin" > ∕dev∕null 2>&1; then
	echo "Usuario 'sysadmin' ya existe"
else
	sudo useradd -m -g "docker" "sysadmin"
	echo "Usuario 'sysadmin' creado y asignado al grupo 'docker'"
fi

if [ ! -d $DIR ]; then # Crear carpeta para webapp y cambiar permisos para sysadmin
	echo "Creando carpeta en $DIR..."
	sudo mkdir -p $DIR
	sudo chgrp -R docker $DIR
	sudo chmod -R g+w $DIR
	echo "Carpeta creada correctamente en la ruta $DIR"
else
	cd "$DIR" || echo "Error al acceder al directorio $DIR"
	echo "Directorio actual: $PWD"
fi

# Descargar archivo docker-compose.yml
if curl -sS -O https://gist.githubusercontent.com/DarkestAbed/0c1cee748bb9e3b22f89efe1933bf125/raw/5801164c0a6e4df7d8ced00122c76895997127a2/docker-compose.yml; then
        echo "docker-compose.yml descargado"
else
        echo "Error al descargar docker-compose.yml"
fi

# Crear archivo html para nginx
if [ ! -e index.html ]; then
		touch index.html
		sudo tee index.html > /dev/null << 'EOF'
    			<h1>Servidor Seguro Propiedad de Benjamin Gonzalez - Acceso Restringido</h1>
EOF
fi

cd $DIR
sudo mv index.html $DIR/html # Necesario para no modificar compose inicial, manteniendo la integridad original (volumen de nginx).
sudo docker-compose up -d # Iniciar contenedor nginx con archivo compose.yml
sudo chown sysadmin:docker /opt/webapp/html/* # Cambiar permisos para usuario sysadmin y grupo docker
