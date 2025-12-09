#!/bin/bash

DIR="/opt/webapp/html"
LOCAL_BACKUP_DIR="/var/backups/webapp"
TIMESTAMP=$(date +%Y-%m-%d_%H%M)
BACKUP="backup_web_${TIMESTAMP}.tar.gz"

# Comprobar si existe el directorio para realizar backup
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
sudo tar -czvf $BACKUP $DIR # Comrpimir directorio original
sudo rsync -a $DIR/$BACKUP $LOCAL_BACKUP_DIR # Sincronizar archivo tar con directorio de backup

# Transferencia scp en a traves de puerto 22, con verificacion de llaves ssh
scp -P 22 -o IdentityFile=/root/.ssh/backup_key "${LOCAL_BACKUP_DIR}/${BACKUP}" "test@192.168.100.0:backup/webapp"

SCP_EXIT_CODE=${PIPESTATUS[0]}

# Análisis de códigos de salida de SCP
case $SCP_EXIT_CODE in
    0)
        "Transferencia remota (scp)"
        ;;
    1)
        echo "Error general en SCP"
        ;;
    2)
        echo "Error de conexión SSH"
        ;;
esac
