#!/bin/bash

sudo apt update

echo "Paquetes actualizados correctamente."

PACKAGES=("git" "curl" "ufw" "docker-compose")
for p in ${PACKAGES[@]}; do
	echo "Instalando $p..."
	sudo apt install -y $p
	echo "$p Instalado correctamente"
done

DIR="/opt/webapp/html"

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

if [ ! -d $DIR ]; then
	echo "Creando carpeta en $DIR..."
	sudo mkdir -p $DIR
	sudo chgrp -R docker $DIR
	sudo chmod -R g+w $DIR
	echo "Carpeta creada correctamente en la ruta $DIR"
else
	cd "$DIR" || echo "Error al acceder al directorio $DIR"
	echo "Directorio actual: $PWD"
	if curl -sS -O https://gist.githubusercontent.com/DarkestAbed/0c1cee748bb9e3b22f89efe1933bf125/raw/5801164c0a6e4df7d8ced00122c76895997127a2/docker-compose.yml; then
        echo "docker-compose.yml descargado"
    else
        echo "Error al descargar docker-compose.yml"
    fi
	if [ ! -e index.html ]; then
		touch index.html
		sudo tee index.html > /dev/null << 'EOF'
		<!DOCTYPE html>
		<html lang="es">
			<head>
    			<meta charset="UTF-8">
    			<meta name="viewport" content="width=device-width, initial-scale=1.0">
    			<title>WebApp</title>
			</head>
			<body>
    			<h1>Servidor Seguro Propiedad de [Benjamin Gonzalez] - Acceso Restringido</h1>
			</body>
		</html>
EOF
	fi
	sudo chown sysadmin:docker /opt/webapp/html/*
fi
