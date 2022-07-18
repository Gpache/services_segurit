#!/bin/bash


rand-str()
{
    # Return random alpha-numeric string of given LENGTH
    #
    # Usage: VALUE=$(rand-str $LENGTH)
    #    or: VALUE=$(rand-str)

    local DEFAULT_LENGTH=64
    local LENGTH=${1:-$DEFAULT_LENGTH}

    LC_CTYPE=C  tr -dc A-Za-z0-9 </dev/urandom | head -c $LENGTH
    # -dc: delete complementary set == delete all except given set
}


clear
msg="SEGURIT"


tput setaf 128;
printf "$msg"
tput setaf 7;

printf "\n\n\nNecesitaremos algo de información para instalar este sistema\n\n"
printf "Verás entre paréntesis y en $(tput setaf 128)(este color)$(tput setaf 7) la opción por defecto que se selecciona presionando enter.\n"
printf "De lo contrario podrás ingresar manualmente la opción solicitada.\n"
printf "No te preocupes al final del cuestionario, verás un resumen antes de confirmar.\n\n\n"


read -p "Presiona enter para continuar..."





## ______________________________
## TIME ZONE
printf "\n\n⏳ Necesitamos configurar la zona horaria\n"
while [[ -z "$TZ" ]]
do
  read -p "   System Time Zone $(tput setaf 128)(UTC)$(tput setaf 7): "  TZ
  TZ=${TZ:-UTC}
  echo "      Selected Time Zone ► ${TZ} ✅"
done


## ______________________________
## MONGO

#username
printf "\n\n👤 Necesitamos crear un nombre de usuario para Mongo Db\n"
while [[ -z "$MONGO_USERNAME" ]]
do
  read -p "   Mongo User Name (admin): "  MONGO_USERNAME
  MONGO_USERNAME=${MONGO_USERNAME:-admin}
  echo "      Selected Mongo User Name ► ${MONGO_USERNAME} ✅"
done

#password
random_str=$(rand-str 20)
printf "\n\n🔐 Necesitamos crear una clave segura para Mongo Db\n"
while [[ -z "$MONGO_PASSWORD" ]]
do
  read -p "   Mongo Password $(tput setaf 128)(${random_str})$(tput setaf 7): "  MONGO_PASSWORD
  MONGO_PASSWORD=${MONGO_PASSWORD:-${random_str}}
  echo "      Selected Mongo Password ► ${MONGO_PASSWORD} ✅"
done

#port
printf "\n\n🔌 Selecciona un puerto para Mongo Db\n"
while [[ -z "$MONGO_PORT" ]]
do
  read -p "   Mongo Port $(tput setaf 128)(27017)$(tput setaf 7): "  MONGO_PORT
  MONGO_PORT=${MONGO_PORT:-27017}
  echo "      Selected Mongo Port ► ${MONGO_PORT} ✅"
done

## ______________________________
## EMQX



#Dashboard Password
random_str=$(rand-str 20)
printf "\n\n🔐 Necesitamos crear una clave para el Dashboard de EMQX \n"
while [[ -z "$EMQX_DEFAULT_USER_PASSWORD" ]]
do
  read -p "   EMQX Dashboard Password $(tput setaf 128)(${random_str})$(tput setaf 7): "  EMQX_DEFAULT_USER_PASSWORD
  EMQX_DEFAULT_USER_PASSWORD=${EMQX_DEFAULT_USER_PASSWORD:-${random_str}}
  echo "      Selected EMQX Dashboard Password ► ${EMQX_DEFAULT_USER_PASSWORD} ✅"
done



#EMQX API Password
random_str=$(rand-str 20)
printf "\n\n🔐 Necesitamos crear una clave para la API de EMQX \n"
while [[ -z "$EMQX_DEFAULT_APPLICATION_SECRET" ]]
do
  read -p "   EMQX API Password $(tput setaf 128)(${random_str})$(tput setaf 7): "  EMQX_DEFAULT_APPLICATION_SECRET
  EMQX_DEFAULT_APPLICATION_SECRET=${EMQX_DEFAULT_APPLICATION_SECRET:-${random_str}}
  echo "      Selected EMQX API Password ► ${EMQX_DEFAULT_APPLICATION_SECRET} ✅"
done



random_str=$(rand-str 20)
#MQTT SUPERUSER NAME
printf "\n\n👤 Necesitamos crear un superusuario para MQTT \n"
printf "   Estas credenciales te permitirán conectarte con privilegios totales al broker mqtt. \n"
printf "   Podrás publicar o suscribirte a cualquier tópico \n"
while [[ -z "$EMQX_NODE_SUPERUSER_USER" ]]
do
  read -p "   MQTT Superuser Name $(tput setaf 128)(${random_str})$(tput setaf 7): "  EMQX_NODE_SUPERUSER_USER
  EMQX_NODE_SUPERUSER_USER=${EMQX_NODE_SUPERUSER_USER:-${random_str}}
  echo "      Selected MQTT Superuser Name ► ${EMQX_NODE_SUPERUSER_USER} ✅"
done



#MQTT SUPERUSER PASSWORD
random_str=$(rand-str 20)
printf "\n\n🔐 Necesitamos crear la clave del superusuario MQTT \n"
while [[ -z "$EMQX_NODE_SUPERUSER_PASSWORD" ]]
do
  read -p "   MQTT Superuser Name $(tput setaf 128)(${random_str})$(tput setaf 7): "  EMQX_NODE_SUPERUSER_PASSWORD
  EMQX_NODE_SUPERUSER_PASSWORD=${EMQX_NODE_SUPERUSER_PASSWORD:-${random_str}}
  echo "      Selected MQTT Superuser Password ► ${EMQX_NODE_SUPERUSER_PASSWORD} ✅"
done


#EMQX API WEBHOOK TOKEN
random_str=$(rand-str 20)
printf "\n\n🔐 Necesitamos crear el token que enviará los requests desde EMQX a nuestros Webhooks \n"

while [[ -z "$EMQX_API_TOKEN" ]]
do
  read -p "   EMQX API WEBHOOK TOKEN $(tput setaf 128) (${random_str})$(tput setaf 7): "  EMQX_API_TOKEN
  EMQX_API_TOKEN=${EMQX_API_TOKEN:-${random_str}}
  echo "      Selected EMQX API WEB TOKEN  ► ${EMQX_API_TOKEN} ✅"
done

#PUBLIC KEY
printf "\n\n🔐 Necesitamos crear la public key para las notificaciones push \n"
while [[ -z "$PUBLIC_VAPID_KEY" ]]
do
  read -p "   PUBLIC KEY (BJb6iftIKgiwTplf85gyzxde5QgtWkv2p6H82vwuxJfZ3xXH0uUFU8SiTnIVjx1JZjm-0Bd-cOMHRlYkGrmjGPc): "  PUBLIC_VAPID_KEY
  PUBLIC_VAPID_KEY=${PUBLIC_VAPID_KEY:-BJb6iftIKgiwTplf85gyzxde5QgtWkv2p6H82vwuxJfZ3xXH0uUFU8SiTnIVjx1JZjm-0Bd-cOMHRlYkGrmjGPc}
  echo "      Selected PUBLIC KEY ► ${PUBLIC_VAPID_KEY} ✅"
done

#PRIVATE KEY
printf "\n\n🔐 Necesitamos crear la private key para las notificaciones push \n"
while [[ -z "$PRIVATE_VAPID_KEY" ]]
do
  read -p "   PRIVATE KEY (Ib6zz9e-xyPBiESzB9fQxUGOMnOUOXSj8JZGUvd5210): "  PRIVATE_VAPID_KEY
  PRIVATE_VAPID_KEY=${PRIVATE_VAPID_KEY:-Ib6zz9e-xyPBiESzB9fQxUGOMnOUOXSj8JZGUvd5210}
  echo "      Selected PRIVATE KEY ► ${PRIVATE_VAPID_KEY} ✅"
done

#EMAIL USER
printf "\n\n🔐 Ingrese el email para utilizar el servicio de correo electrónico \n"
while [[ -z "$EMAIL_USER" ]]
do
  read -p "   EMAIL USER (iotabcompany@gmail.com): "  EMAIL_USER
  EMAIL_USER=${EMAIL_USER:-iotabcompany@gmail.com}
  echo "      Selected EMAIL USER ► ${EMAIL_USER} ✅"
done

#EMAIL PASSWORD
printf "\n\n🔐 Ingrese la contraseña proporcionada por google para utilizar el servicio de correo electrónico \n"
while [[ -z "$EMAIL_PASSWORD" ]]
do
  read -p "   EMAIL PASSWORD (qvfefxhflkwipcuk): "  EMAIL_PASSWORD
  EMAIL_PASSWORD=${EMAIL_PASSWORD:-qvfefxhflkwipcuk}
  echo "      Selected EMAIL PASSWORD ► ${EMAIL_PASSWORD} ✅"
done


## ______________________________
## FRONT

#DOMAIN 
printf "\n\n🌐 Ingresa el dominio a donde se alojará este servicio. \n"
printf "   Si todavía no tienes uno podrás ingresar la ip fija del VPS a donde lo estés instalando. \n"
printf "   Luego podrás cambiarlo desde las variables de entorno. \n"

while [[ -z "$DOMAIN" ]]
do
  read -p "   (No http, No www | ex.-> mydomain.com) Dominio: "  DOMAIN
  echo "         Selected Domain ► ${DOMAIN} ✅"
done



#IP 
printf "\n\n🌐 Ingresa la ip pública del VPS. \n"

while [[ -z "$IP" ]]
do
  read -p "   IP: "  IP
  echo "         Selected IP ► ${IP} ✅"
done




#SSL?
printf "\n\n🔐 El sistema está pensado para que un balanceador de cargas gestione los certificados SSL. \n"
printf "   Si la plataforma estará bajo SSL utilizando balanceador de cargas o proporcionando certificados, selecciona 'Con SSL'. \n"
printf "   Esto forzará la redirección SSL, además, el cliente web, se conectará al broker mqtt mediante websocket seguro. \n"
printf "   Si de momento vas a acceder a la plataforma usando una ip, o un dominio sin ssl... selecciona 'Sin SSL'. \n\n"



PS3='   SSL?: '
options=("Con SSL" "Sin SSL")
select opt in "${options[@]}"
do
    case $REPLY in
        "1")
            echo "         SSL? ► ${character} ✅"
            break
            ;;
        "2")
            echo "         SSL? ► ${character} ✅"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


SSL=$REPLY
WSPREFIX=""
SSLREDIRECT=""

if [[ $SSL -eq 1 ]]
  then
        #EMAIL
    printf "\n\n🌐 Ingresa una dirección de email válida para gestionar los certificados. \n"

    while [[ -z "$EMAIL" ]]
    do
      read -p "   EMAIL: "  EMAIL
      echo "         EMAIL INGRESADO ► ${EMAIL} ✅"
    done
    SSL="https://"
    WSPREFIX="wss://"
    MQTT_HOST=$DOMAIN
    MQTT_PORT="8084"
    SSLREDIRECT="false"
  else
    SSL="http://"
    WSPREFIX="ws://"
    MQTT_PORT="8083"
    MQTT_HOST=$IP
    SSLREDIRECT="false"
fi

# Entorno del servidor?
printf "\n\n🔐 Seleccione el entorno en que se instalará el servidor \n"

PS3='   ENTORNO?: '
options=("Producción" "Desarrollo")
select opt in "${options[@]}"
do
    case $REPLY in
        "1")
            echo "         ENTORNO? ► ${character} ✅"
            break
            ;;
        "2")
            echo "         ENTORNO? ► ${character} ✅"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


ENTORNO=$REPLY

msg="
   __                                      
  /__\ ___  ___ _   _ _ __ ___   ___ _ __  
 / \/// _ \/ __| | | | '_ \` _ \ / _ \ '_ \ 
/ _  \  __/\__ \ |_| | | | | | |  __/ | | |
\/ \_/\___||___/\__,_|_| |_| |_|\___|_| |_|                                                                                                                           
"

tput setaf 128;
printf "$msg"
tput setaf 7;

printf "\n\n\n"
printf "   🟢 TIMEZONE: $(tput setaf 128)${TZ}$(tput setaf 7)\n"
printf "   🟢 MONGO USER: $(tput setaf 128)${MONGO_USERNAME}$(tput setaf 7)\n"
printf "   🟢 MONGO PASS: $(tput setaf 128)${MONGO_PASSWORD}$(tput setaf 7)\n"
printf "   🟢 MONGO PORT: $(tput setaf 128)${MONGO_PORT}$(tput setaf 7)\n"
printf "   🟢 EMQX API PASSWORD: $(tput setaf 128)${EMQX_DEFAULT_APPLICATION_SECRET}$(tput setaf 7)\n"
printf "   🟢 MQTT SUPERUSER: $(tput setaf 128)${EMQX_NODE_SUPERUSER_USER}$(tput setaf 7)\n"
printf "   🟢 MQTT SUPER PASS: $(tput setaf 128)${EMQX_NODE_SUPERUSER_PASSWORD}$(tput setaf 7)\n"
printf "   🟢 WEBHOOK WEB TOKEN: $(tput setaf 128)${EMQX_API_TOKEN}$(tput setaf 7)\n"
printf "   🟢 DOMAIN: $(tput setaf 128)${DOMAIN}$(tput setaf 7)\n"
printf "   🟢 IP: $(tput setaf 128)${IP}$(tput setaf 7)\n"
printf "   🟢 SSL?: $(tput setaf 128)${opt}$(tput setaf 7)\n"
printf "   🟢 PUBLIC KEY: $(tput setaf 128)${PUBLIC_VAPID_KEY}$(tput setaf 7)\n"
printf "   🟢 PRIVATE KEY: $(tput setaf 128)${PRIVATE_VAPID_KEY}$(tput setaf 7)\n"
printf "   🟢 EMAIL USER: $(tput setaf 128)${EMAIL_USER}$(tput setaf 7)\n"
printf "   🟢 EMAIL PASSWORD: $(tput setaf 128)${EMAIL_PASSWORD}$(tput setaf 7)\n"

printf "\n\n\n\n";
read -p "Presiona Enter para comenzar la instalación..."
sleep 2

sudo apt-get update
sudo git clone https://github.com/Gpache/services_segurit.git
sudo mv services_segurit services

sudo ufw allow ssh

if [[ $ENTORNO -eq 1 ]]
  then
    cd services

    sudo mkdir data
    cd data
    sudo mkdir certbot
    cd certbot
    sudo mkdir www
    cd www
    sudo mkdir .well-known
    cd ..
    cd ..
    sudo mkdir nginx
    cd nginx
    filename='app.conf'
    sudo sh -c " echo '#upstream miapp {' >> $filename"
    sudo sh -c " echo '#        server node:3000;' >> $filename"
    sudo sh -c " echo '#};' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo 'server {' >> $filename"
    sudo sh -c " echo '    listen 80;' >> $filename"
    sudo sh -c " echo '    server_name ${DOMAIN};' >> $filename"
    sudo sh -c " echo '    location /.well-known/acme-challenge/ {' >> $filename"
    sudo sh -c " echo '    root /var/www/certbot;' >> $filename"
    sudo sh -c " echo '    }' >> $filename"
    sudo sh -c " echo '    location / {' >> $filename"
    sudo sh -c " echo '    return 301 https://\$host\$request_uri;' >> $filename"
    sudo sh -c " echo '    }' >> $filename"
    sudo sh -c " echo '}' >> $filename"
    sudo sh -c " echo 'server {' >> $filename"
    sudo sh -c " echo '    listen 443 ssl;' >> $filename"
    sudo sh -c " echo '    server_name ${DOMAIN};' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '    location / {' >> $filename"
    sudo sh -c " echo '        proxy_pass http://node:3000; #for demo purposes' >> $filename"
    sudo sh -c " echo '    }' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '    ssl_certificate /etc/letsencrypt/live/${DOMAIN}/fullchain.pem;' >> $filename"
    sudo sh -c " echo '    ssl_certificate_key /etc/letsencrypt/live/${DOMAIN}/privkey.pem;' >> $filename"
    sudo sh -c " echo '    include /etc/letsencrypt/options-ssl-nginx.conf;' >> $filename"
    sudo sh -c " echo '    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '}' >> $filename"
    #sudo touch app.conf
    cd ..
    cd ..

    ## ______________________________
    ## INSALL INIT
    filename='.env'


    #SERVICES .ENV
    sudo sh -c " echo 'environment=prod' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '# TIMEZONE (all containers).' >> $filename"
    sudo sh -c " echo 'TZ=${TZ}' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '# M O N G O' >> $filename"
    sudo sh -c " echo 'MONGO_USERNAME=${MONGO_USERNAME}' >> $filename"
    sudo sh -c " echo 'MONGO_PASSWORD=${MONGO_PASSWORD}' >> $filename"
    sudo sh -c " echo 'MONGO_EXT_PORT=${MONGO_PORT}' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '# E M Q X' >> $filename"
    sudo sh -c " echo 'EMQX_DEFAULT_USER_PASSWORD=${EMQX_DEFAULT_USER_PASSWORD}' >> $filename"
    sudo sh -c " echo 'EMQX_DEFAULT_APPLICATION_SECRET=${EMQX_DEFAULT_APPLICATION_SECRET}' >> $filename"

    sudo git clone https://github.com/Gpache/app_segurit.git
    sudo mv app_segurit  app

    cd app

    sudo sh -c "echo 'environment=prod' >> $filename"
    sudo sh -c "echo '' >> $filename"

    #A P I  - N O D E 
    sudo sh -c "echo '#A P I  - N O D E ' >> $filename"
    sudo sh -c "echo 'API_PORT=3001' >> $filename"
    sudo sh -c "echo 'WEBHOOKS_HOST=node' >> $filename"
    sudo sh -c "echo 'MQTT_NOTIFICATION_HOST=${IP}' >> $filename"
    sudo sh -c "echo '' >> $filename"

    # M O N G O 
    sudo sh -c "echo '# M O N G O' >> $filename"
    sudo sh -c "echo 'MONGO_USERNAME=${MONGO_USERNAME}' >> $filename"
    sudo sh -c "echo 'MONGO_PASSWORD=${MONGO_PASSWORD}' >> $filename"
    sudo sh -c "echo 'MONGO_HOST=mongo' >> $filename"
    sudo sh -c "echo 'MONGO_PORT=${MONGO_PORT}' >> $filename"
    sudo sh -c "echo 'MONGO_DATABASE=ioticos_god_level' >> $filename"
    sudo sh -c "echo '' >> $filename"

    # E M Q X
    sudo sh -c " echo 'EMQX_DEFAULT_APPLICATION_SECRET=${EMQX_DEFAULT_APPLICATION_SECRET}' >> $filename"
    sudo sh -c " echo 'EMQX_NODE_SUPERUSER_USER=${EMQX_NODE_SUPERUSER_USER}' >> $filename"
    sudo sh -c " echo 'EMQX_NODE_SUPERUSER_PASSWORD=${EMQX_NODE_SUPERUSER_PASSWORD}' >> $filename"
    sudo sh -c " echo 'EMQX_API_HOST=${IP}' >> $filename"
    sudo sh -c " echo 'EMQX_API_TOKEN=${EMQX_API_TOKEN}' >> $filename"
    sudo sh -c "echo 'EMQX_RESOURCES_DELAY=30000' >> $filename"
    sudo sh -c "echo '' >> $filename"

    # F R O N T
    sudo sh -c "echo '# F R O N T' >> $filename"
    sudo sh -c "echo 'APP_PORT=3000' >> $filename"
    sudo sh -c "echo 'AXIOS_BASE_URL=${SSL}${DOMAIN}:3001/api' >> $filename"

    sudo sh -c "echo 'MQTT_PORT=${MQTT_PORT}' >> $filename"
    sudo sh -c "echo 'MQTT_HOST=${DOMAIN}' >> $filename"
    sudo sh -c "echo 'MQTT_PREFIX=${WSPREFIX}' >> $filename"

    sudo sh -c " echo 'SSLREDIRECT=${SSLREDIRECT}' >> $filename"

    # WEB PUSH
    sudo sh -c "echo 'PUBLIC_VAPID_KEY=${PUBLIC_VAPID_KEY}' >> $filename"
    sudo sh -c "echo 'PRIVATE_VAPID_KEY=${PRIVATE_VAPID_KEY}' >> $filename"

    #EMAIL
    sudo sh -c "echo 'EMAIL_USER=${EMAIL_USER}' >> $filename"
    sudo sh -c "echo 'EMAIL_PASSWORD=${EMAIL_PASSWORD}' >> $filename"

    cd ..

    sudo docker-compose -f docker_node_install.yml up
    sudo docker-compose -f docker_nuxt_build.yml up
    sudo docker-compose -f docker_compose_production.yml up -d

    # INSTALL CERTIFICATES

    if ! [ -x "$(command -v docker-compose)" ]; then
      echo 'Error: docker-compose is not installed.' >&2
      exit 1
    fi

    domains=($DOMAIN www.$DOMAIN)
    rsa_key_size=4096
    data_path="./data/certbot"
    email="$EMAIL" # Adding a valid address is strongly recommended
    staging=0 # Set to 1 if you're testing your setup to avoid hitting request limits

    if [ -d "$data_path" ]; then
      read -p "Existing data found for $domains. Continue and replace existing certificate? (y/N) " decision
      if [ "$decision" != "Y" ] && [ "$decision" != "y" ]; then
        exit
      fi
    fi


    if [ ! -e "$data_path/conf/options-ssl-nginx.conf" ] || [ ! -e "$data_path/conf/ssl-dhparams.pem" ]; then
      echo "### Downloading recommended TLS parameters ..."
      sudo mkdir -p "$data_path/conf"
      curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
      curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"
      echo
    fi

    echo "### Creating dummy certificate for $domains ..."
    path="/etc/letsencrypt/live/$domains"
    sudo mkdir -p "$data_path/conf/live/$domains"
    docker-compose run --rm --entrypoint "\
      openssl req -x509 -nodes -newkey rsa:$rsa_key_size -days 1\
        -keyout '$path/privkey.pem' \
        -out '$path/fullchain.pem' \
        -subj '/CN=localhost'" certbot
    echo


    echo "### Starting nginx ..."
    docker-compose up --force-recreate -d nginx
    echo

    echo "### Deleting dummy certificate for $domains ..."
    docker-compose run --rm --entrypoint "\
      rm -Rf /etc/letsencrypt/live/$domains && \
      rm -Rf /etc/letsencrypt/archive/$domains && \
      rm -Rf /etc/letsencrypt/renewal/$domains.conf" certbot
    echo


    echo "### Requesting Let's Encrypt certificate for $domains ..."
    #Join $domains to -d args
    domain_args=""
    for domain in "${domains[@]}"; do
      domain_args="$domain_args -d $domain"
    done

    # Select appropriate email arg
    case "$email" in
      "") email_arg="--register-unsafely-without-email" ;;
      *) email_arg="--email $email" ;;
    esac

    # Enable staging mode if needed
    if [ $staging != "0" ]; then staging_arg="--staging"; fi

    docker-compose run --rm --entrypoint "\
      certbot certonly --webroot -w /var/www/certbot \
        $staging_arg \
        $email_arg \
        $domain_args \
        --rsa-key-size $rsa_key_size \
        --agree-tos \
        --force-renewal" certbot
    echo

    echo "### Reloading nginx ..."
    docker-compose exec nginx nginx -s reload

    cd data
    cd nginx

    sudo rm -rf app.conf

    filename='app.conf'
    sudo sh -c " echo '#upstream miapp {' >> $filename"
    sudo sh -c " echo '#        server node:3000;' >> $filename"
    sudo sh -c " echo '#};' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo 'server {' >> $filename"
    sudo sh -c " echo '    listen 80;' >> $filename"
    sudo sh -c " echo '    server_name ${DOMAIN};' >> $filename"
    sudo sh -c " echo '    location /.well-known/acme-challenge/ {' >> $filename"
    sudo sh -c " echo '    root /var/www/certbot;' >> $filename"
    sudo sh -c " echo '    }' >> $filename"
    sudo sh -c " echo '    location / {' >> $filename"
    sudo sh -c " echo '    return 301 https://\$host\$request_uri;' >> $filename"
    sudo sh -c " echo '    }' >> $filename"
    sudo sh -c " echo '}' >> $filename"
    sudo sh -c " echo 'server {' >> $filename"
    sudo sh -c " echo '    listen 443 ssl;' >> $filename"
    sudo sh -c " echo '    server_name ${DOMAIN};' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '    location / {' >> $filename"
    sudo sh -c " echo '        proxy_pass http://node:3000; #for demo purposes' >> $filename"
    sudo sh -c " echo '    }' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '    ssl_certificate /etc/letsencrypt/live/${DOMAIN}/fullchain.pem;' >> $filename"
    sudo sh -c " echo '    ssl_certificate_key /etc/letsencrypt/live/${DOMAIN}/privkey.pem;' >> $filename"
    sudo sh -c " echo '    include /etc/letsencrypt/options-ssl-nginx.conf;' >> $filename"
    sudo sh -c " echo '    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '}' >> $filename"
    sudo sh -c " echo '' >> $filename"
    
    sudo sh -c " echo 'server {' >> $filename"
    sudo sh -c " echo '    listen 3001 ssl;' >> $filename"
    sudo sh -c " echo '    server_name ${DOMAIN};' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '    location / {' >> $filename"
    sudo sh -c " echo '        proxy_pass http://node:3001; #for demo purposes' >> $filename"
    sudo sh -c " echo '    }' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '    ssl_certificate /etc/letsencrypt/live/${DOMAIN}/fullchain.pem;' >> $filename"
    sudo sh -c " echo '    ssl_certificate_key /etc/letsencrypt/live/${DOMAIN}/privkey.pem;' >> $filename"
    sudo sh -c " echo '    include /etc/letsencrypt/options-ssl-nginx.conf;' >> $filename"
    sudo sh -c " echo '    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '}' >> $filename"
    sudo sh -c " echo '' >> $filename"

    sudo sh -c " echo 'server {' >> $filename"
    sudo sh -c " echo '    listen 8084 ssl;' >> $filename"
    sudo sh -c " echo '    server_name ${DOMAIN};' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '    location / {' >> $filename"
    sudo sh -c " echo '        proxy_pass http://emqx:8083; #for demo purposes' >> $filename"
    sudo sh -c " echo '        # Aquí comienza el soporte a WebSockets' >> $filename"
    sudo sh -c " echo '        proxy_http_version 1.1;' >> $filename"
    sudo sh -c " echo '        proxy_set_header Upgrade \$http_upgrade;' >> $filename"
    sudo sh -c " echo '        proxy_set_header Connection \"upgrade\";' >> $filename"
    sudo sh -c " echo '        # Aquí termina' >> $filename"
    sudo sh -c " echo '        proxy_set_header Host \$host;' >> $filename"
    sudo sh -c " echo '        proxy_set_header X-Real-IP \$remote_addr;' >> $filename"
    sudo sh -c " echo '        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' >> $filename"
    sudo sh -c " echo '        proxy_set_header X-Forwarded-Proto https;' >> $filename"
    sudo sh -c " echo '        proxy_redirect off;' >> $filename"
    sudo sh -c " echo '    }' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '    ssl_certificate /etc/letsencrypt/live/${DOMAIN}/fullchain.pem;' >> $filename"
    sudo sh -c " echo '    ssl_certificate_key /etc/letsencrypt/live/${DOMAIN}/privkey.pem;' >> $filename"
    sudo sh -c " echo '    include /etc/letsencrypt/options-ssl-nginx.conf;' >> $filename"
    sudo sh -c " echo '    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '}' >> $filename"
    sudo sh -c " echo '' >> $filename"

    sudo sh -c " echo 'server {' >> $filename"
    sudo sh -c " echo '    listen 18084 ssl;' >> $filename"
    sudo sh -c " echo '    server_name ${DOMAIN};' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '    location / {' >> $filename"
    sudo sh -c " echo '        proxy_pass http://emqx:18083; #for demo purposes' >> $filename"
    sudo sh -c " echo '    }' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '    ssl_certificate /etc/letsencrypt/live/${DOMAIN}/fullchain.pem;' >> $filename"
    sudo sh -c " echo '    ssl_certificate_key /etc/letsencrypt/live/${DOMAIN}/privkey.pem;' >> $filename"
    sudo sh -c " echo '    include /etc/letsencrypt/options-ssl-nginx.conf;' >> $filename"
    sudo sh -c " echo '    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '}' >> $filename"
    sudo sh -c " echo '' >> $filename"


    #sudo touch app.conf
    cd ..
    cd ..

    sudo docker stop $(sudo docker ps -a -q)
    sudo docker rm $(sudo docker ps -a -q)
    sudo docker volume rm -f foo-emqx-data
    sudo docker volume rm -f foo-emqx-log

    sudo docker-compose -f docker_node_install.yml up
    sudo docker-compose -f docker_nuxt_build.yml up
    sudo docker-compose -f docker_compose_production.yml up -d

    sudo docker-compose -f docker_nuxt_build.yml up
    sudo docker restart nginx_proxy

  else
    cd services

    ## ______________________________
    ## INSALL INIT
    filename='.env'


    #SERVICES .ENV
    sudo sh -c " echo 'environment=dev' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '# TIMEZONE (all containers).' >> $filename"
    sudo sh -c " echo 'TZ=${TZ}' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '# M O N G O' >> $filename"
    sudo sh -c " echo 'MONGO_USERNAME=${MONGO_USERNAME}' >> $filename"
    sudo sh -c " echo 'MONGO_PASSWORD=${MONGO_PASSWORD}' >> $filename"
    sudo sh -c " echo 'MONGO_EXT_PORT=${MONGO_PORT}' >> $filename"
    sudo sh -c " echo '' >> $filename"
    sudo sh -c " echo '# E M Q X' >> $filename"
    sudo sh -c " echo 'EMQX_DEFAULT_USER_PASSWORD=${EMQX_DEFAULT_USER_PASSWORD}' >> $filename"
    sudo sh -c " echo 'EMQX_DEFAULT_APPLICATION_SECRET=${EMQX_DEFAULT_APPLICATION_SECRET}' >> $filename"

    cd ..

    sudo git clone https://github.com/Gpache/app_segurit.git
    sudo mv app_segurit  app

    cd app

    sudo sh -c "echo 'environment=prod' >> $filename"
    sudo sh -c "echo '' >> $filename"

    #A P I  - N O D E 
    sudo sh -c "echo '#A P I  - N O D E ' >> $filename"
    sudo sh -c "echo 'API_PORT=3001' >> $filename"
    sudo sh -c "echo 'WEBHOOKS_HOST=node' >> $filename"
    sudo sh -c "echo 'MQTT_NOTIFICATION_HOST=${IP}' >> $filename"
    sudo sh -c "echo '' >> $filename"

    # M O N G O 
    sudo sh -c "echo '# M O N G O' >> $filename"
    sudo sh -c "echo 'MONGO_USERNAME=${MONGO_USERNAME}' >> $filename"
    sudo sh -c "echo 'MONGO_PASSWORD=${MONGO_PASSWORD}' >> $filename"
    sudo sh -c "echo 'MONGO_HOST=mongo' >> $filename"
    sudo sh -c "echo 'MONGO_PORT=${MONGO_PORT}' >> $filename"
    sudo sh -c "echo 'MONGO_DATABASE=ioticos_god_level' >> $filename"
    sudo sh -c "echo '' >> $filename"

    # E M Q X
    sudo sh -c " echo 'EMQX_DEFAULT_APPLICATION_SECRET=${EMQX_DEFAULT_APPLICATION_SECRET}' >> $filename"
    sudo sh -c " echo 'EMQX_NODE_SUPERUSER_USER=${EMQX_NODE_SUPERUSER_USER}' >> $filename"
    sudo sh -c " echo 'EMQX_NODE_SUPERUSER_PASSWORD=${EMQX_NODE_SUPERUSER_PASSWORD}' >> $filename"
    sudo sh -c " echo 'EMQX_API_HOST=${IP}' >> $filename"
    sudo sh -c " echo 'EMQX_API_TOKEN=${EMQX_API_TOKEN}' >> $filename"
    sudo sh -c "echo 'EMQX_RESOURCES_DELAY=30000' >> $filename"
    sudo sh -c "echo '' >> $filename"

    # F R O N T
    sudo sh -c "echo '# F R O N T' >> $filename"
    sudo sh -c "echo 'APP_PORT=3000' >> $filename"
    sudo sh -c "echo 'AXIOS_BASE_URL=${SSL}${DOMAIN}:3001/api' >> $filename"

    sudo sh -c "echo 'MQTT_PORT=${MQTT_PORT}' >> $filename"
    sudo sh -c "echo 'MQTT_HOST=${DOMAIN}' >> $filename"
    sudo sh -c "echo 'MQTT_PREFIX=${WSPREFIX}' >> $filename"

    sudo sh -c " echo 'SSLREDIRECT=${SSLREDIRECT}' >> $filename"

    # WEB PUSH
    sudo sh -c "echo 'PUBLIC_VAPID_KEY=${PUBLIC_VAPID_KEY}' >> $filename"
    sudo sh -c "echo 'PRIVATE_VAPID_KEY=${PRIVATE_VAPID_KEY}' >> $filename"

    # EMAIL
    sudo sh -c "echo 'EMAIL_USER=${EMAIL_USER}' >> $filename"
    sudo sh -c "echo 'EMAIL_PASSWORD=${EMAIL_PASSWORD}' >> $filename"

    cd ..

    sudo docker-compose up -d
    
fi
