#!/bin/bash

DIR="/opt/webapp/html"
LOCAL_BACKUP_DIR="/var/backups/webapp"
TIMESTAMP=$(date +%Y-%m-%d_%H%M)
BACKUP="backup_web_${TIMESTAMP}.tar.gz"

if [ ! -d "$DIR" ]; then
    echo "El directorio especificado no existe."
    exit 1
fi

# Crear directorio de backup local si no existe
if [ ! -d "$LOCAL_BACKUP_DIR" ]; then
    echo "Creando directorio de backup local: $LOCAL_BACKUP_DIR"
    sudo mkdir -p "$LOCAL_BACKUP_DIR"
    echo "Directorio $LOCAL_BACKUP_DIR creado con exito."
else
    echo "El directorio ya existe."
fi

cd $DIR
sudo tar -czvf $BACKUP $DIR
sudo rsync -a $DIR/$BACKUP $LOCAL_BACKUP_DIR
