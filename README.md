[![Typing SVG](https://readme-typing-svg.demolab.com?font=Roboto&weight=900&size=30&duration=3000&pause=1000&color=ec7c26&background=FFFFFF00&center=true&vCenter=true&width=1245&lines=Scripts+Ubuntu+Server)](https://git.io/typing-svg)

## Inicio

> [!IMPORTANT]  
> **Utilizar** ```sudo chmod +x script.sh``` **para hacer ejecutable el script.**
<br>
Primero es necesario clonar el repositorio

```bash
git clone https://github.com/Tito-blip/ExamenLinux.git
```

Luego ingresar a la carpeta

```bash
cd ExamenLinux
```
<br>

## Script 1: Setup

Entrar a directorio deploy
```bash
cd deploy
```

Convertir a ejecutable

```bash
sudo chmod +x setup.sh
```

Ejecutar script

```bash
./setup.sh
```

Volver a directorio principal
```bash
cd ..
```

Despues de ejecutar este script, se habra instalado los siguientes paquetes:
- Docker
- Docker-compose
- Git
- Curl
- Ufw

Adicionalmente, se creara el directorio /opt/webapp/html, y el archivo index.html junto con la descarga del archivo docker-compose.yml (nginx).
Tambien, creando un usuario sysadmin y grupo docker, asi como, un contenedor de nginx en docker.

<br>

## Script 2: Hardening

Entrar a directorio security
```bash
cd security
```

Convertir a ejecutable

```bash
sudo chmod +x hardening.sh
```

Ejecutar script

```bash
./hardening.sh
```

Volver a directorio principal
```bash
cd ..
```

Al terminar de ejecutar este script, el firewall ufw estara configurado para denegar conexiones entrantes, solo admitiendo conexiones al puerto 22 y 8080.
Ademas, se deshabilita la opcion para login root a traves de ssh, y se cambian los permisos del archivo docker-compose.yml a 600.

## Script 3: Backup

Entrar a directorio maitenance
```bash
cd maitenance
```

Convertir a ejecutable

```bash
sudo chmod +x backup.sh
```

Ejecutar script

```bash
./backup.sh
```

Volver a directorio principal
```bash
cd ..
```

Con este script se ejecutara la comprension del directorio /opt/webapp/html, copiandolo localmente con rsync al directorio /var/backups/webapp. 
Junto con esto, se entrega una funcionalidad teorica para copiar el archivo remotamente con scp.

## Screenshots

### SSH Config
![ssh](evidence/ssh_config.png)

### UFW Status
![UFW](evidence/ufw_status.png)

### Web Access
![WEB](evidence/web_access.png)

