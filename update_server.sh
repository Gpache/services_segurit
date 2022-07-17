#!/bin/bash

clear
msg="Actualización del servidor"
printf "$msg"
read -p "Presiona enter para continuar..."

sudo docker-compose -f docker_compose_production.yml down
sudo git pull origin master
cd app
sudo git pull origin master
cd ..

PS3='   Se modificó el archivo package.json?: '
options=("Si" "No")
select opt in "${options[@]}"
do
    case $REPLY in
        "1")
            echo "         Se modificó? ► ${character} ✅"
            break
            ;;
        "2")
            echo "         Se modificó? ► ${character} ✅"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

packagejson=$REPLY

if [[ $packagejson -eq 1 ]]
  then
    sudo docker rm -f node_install
    sudo docker-compose -f docker_node_install.yml up

    sudo docker rm -f node_build
    sudo docker-compose -f docker_nuxt_build.yml up

    sudo docker-compose -f docker_compose_production.yml up -d
    sudo docker-compose -f docker_nuxt_build.yml up
  else
    sudo docker rm -f node_build
    sudo docker-compose -f docker_nuxt_build.yml up

    sudo docker-compose -f docker_compose_production.yml up -d
    sudo docker-compose -f docker_nuxt_build.yml up
fi
