#Partir de la imagen base del sistema operativo
FROM ubuntu:latest

#Actualización librerias del sistema
RUN apt-get update && apt-get upgrade -y

#Instalar el software Openssh-server, NGINX y curl
RUN apt-get install -y openssh-server nginx curl

#Cambio de la contraseña de root del contenedor -> "password"
RUN echo 'root:password' | chpasswd

#Creación de un grupo de usuarios: sshmembers
RUN groupadd sshmembers

#Creación de usuario con el nombre de usuario de UOC
ARG cvacag
RUN useradd -m -s /bin/bash -G sshmembers cvacag
RUN echo 'cvacag:password' | chpasswd

#Creación del fichero banner dentro de la carpeta /etc/ que contiene el mensaje de "Pre-Login Banner", con
#el contenido "Connection to UOC OpenSSH Server"
RUN echo 'Connection to UOC OpenSSH Server' > /etc/banner

#Creación dentro del contenedor del directorio: /var/run/sshd
RUN mkdir -p /var/run/sshd

#Modificación del fichero de configuración de OpenSSH Server
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && echo 'Banner /etc/banner' >> /etc/ssh/sshd_config && echo 'Allowgroups sshmembers' >> /etc/ssh/sshd_config 

#Borrar los archivos de configuracion predeterminados de NGINX
RUN rm -v /etc/nginx/nginx.conf /etc/nginx/sites-enabled/default

#Copiar archivo de configuracion del NGINX personalizado
COPY nginx.conf /etc/nginx/nginx.conf

#Copiar nuestra HTML creada a la ubicacion predeterminada de NGINX
COPY /index.html /var/www/html/

#Configuramos la directiva EXPOSE para ssh
EXPOSE 22
EXPOSE 80

#Iniciamos ssh y NGINX al crear un contenedor de la imagen
CMD service ssh start && service nginx start && tail -f /dev/null

