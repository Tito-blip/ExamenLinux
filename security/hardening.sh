#!/bin/bash

sudo ufw default deny incoming

sudo ufw allow 22/tcp
sudo ufw allow 8080/tcp

SSH_CONFIG="/etc/ssh/sshd_config"

# Buscar y reemplazar la línea PermitRootLogin, o agregarla si no existe
if sudo grep -q "^PermitRootLogin" "$SSH_CONFIG"; then
    sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' "$SSH_CONFIG"
    echo "Se ha actualizado PermitRootLogin a 'no' en $SSH_CONFIG"
else
    # Usar tee para escribir con privilegios de root
    echo "PermitRootLogin no" | sudo tee -a "$SSH_CONFIG" > /dev/null
    echo "Se ha agregado PermitRootLogin 'no' a $SSH_CONFIG"
fi

sudo chmod 600 /opt/webapp/html/docker-compose.yml
echo "Se ha establecido el permiso 600 en /opt/webapp/html/docker-compose.yml"
