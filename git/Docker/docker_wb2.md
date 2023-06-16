
### create an alpine container in interactive mode and instal python
*docker container run -d -p 35000:8090 --name con1 alpine:latest sleep 1d
*docker container ls
*docker container exec -it alpine /bin/sh
#after getting into the container 
*apk update && apk upgrade --available
*apk add --update python3
*python -V


### create an ubuntu container with sleep 1d then login user exec.Install python
*docker container run -d -p 36000:8080 --name UBUNTU ubuntu:latest sleep 1d
*docker container exec -it UBUNTU /bin/bash
#after getting into the container 
apt update
apt install python3
python3 -V
image.png

### create a postgress container with user panoramic and password as trekking. try logging in and show the databases (querry for thr psql)
*docker container exec -it con3 postgres POSTGRES_USER=panoramic POSTGRES_PASSWORD=trekking /bin/bash
*docker container exec -it con3 /bin/bash
connect to postgres:
*psql -U username(panaromic) -W password(trekking)
\l - to show the databases


### Try creating a docker file which runs phpinfo page, user ARG and ENV wherever appropriate
  * on apache server
  * on nginx server

PHP install on ubuntu::
-- intall apache2
--sudo apt install php libapache2-mod-php php-mysql -y
--echo "<?php phpinfo(); ?>" > /var/www/html/info.php
o/p : ipaddress/info.php

*Dockerfile for phpinfo : apache2
FROM ubuntu:22.04
LABEL Author="Su" Organization="QT" Project="Learning"
RUN  apt-get update && apt-get install apache2 -y
RUN apt-get install php libapache2-mod-php php-mysql -y
RUN echo "<?php phpinfo() ?>" > /var/www/html/info.php
EXPOSE 80
CMD [“apache2ctl”, “-D”, “FOREGROUND”]

---------------
Dockerfile for phpinfo : nginx
FROM ubuntu:22.04
LABEL Author="Su" Organization="QT" Project="Learning"
RUN  apt-get update && apt-get install nginx -y
RUN apt-get install php libapache2-mod-php -y
RUN echo "<?php phpinfo() ?>" > /var/www/html/info.php
EXPOSE 80
CMD [“apache2ctl”, “-D”, “FOREGROUND”]



### * create a jenkins image by creating your own Dockerfile

Manual steps:
docker container run -d --name conjenkins ubuntu 
docker container -exec -it conjenkins /bin/bash
after getting into container : 
apt update
apt install openjdk-11-jdk -y 
apt install curl -y (install curl and remove sudo)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key |  tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ |  tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt update
apt install jenkins -y

----
FROM ubuntu:22.04
LABEL Author="Su" Organization="QT" Project="Learning"
RUN apt update
RUN apt install openjdk-11-jdk -y 
RUN apt install curl -y
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key |  tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
RUN echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ |  tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
RUN apt update && apt install jenkins -y
RUN "sudo systemctl enable jenkins"
RUN "sudo systemctl status jenkins
EXPOSE 8080 
CMD["usr/bin/jenkins"]

-------------------------------------------------------------------------------------------------

### Create nop commerce and my-sql server  containers and try to make them work by configuring.
#Dockerfile for nopcommerce : 
FROM mcr.microsoft.com/dotnet/sdk:7.0
LABEL author="Su" organization="qt" project="JOIP"
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.60.2/nopCommerce_4.60.2_NoSource_linux_x64.zip /nop/nopCommerce_4.60.2_NoSource_linux_x64.zip
WORKDIR /nop
RUN apt update && apt install unzip -y && \
    unzip /nop/nopCommerce_4.60.2_NoSource_linux_x64.zip && \
    mkdir /nop/bin && mkdir /nop/logs
EXPOSE 5000
CMD [ "dotnet", "Nop.Web.dll", "--urls", "http://0.0.0.0:5000"]

docker image 
----docker image build -t nop .
---- docker container run -d -P --name connop nop
----docker container ls
o/p : ipaddress: container port


**create network : docker network create -d bridge mybridgenetwork
**create volume : docker volume create myvol
##attach to the mysqldb
--docker container run -d --name mysqldb1 -P -e MYSQL_ROOT_PASSWORD=rootroot -e MYSQL_DATABASE=employees -e MYSQL_USER=qtdevops -e MYSQL_PASSWORD=rootroot mysql -v myvol:/var/lib/mysql --network mybridgenetwork

##attaching network and sqlserver to nop (container)
---docker container run -d -P --name connop4 --network mybridgenetwork -e MYSQL_SERVER=mysqldb nop

create SQL
 docker container run -d --name mysqldb -P -e MYSQL_ROOT_PASSWORD=rootroot -e MYSQL_USER=qtdevops -e MYSQL_PASSWORD=rootroot mysql


steps ::
  docker volume create myvol
  docker network create -d bridge mynetwork
  docker container run -d -P --name mysqldb -e MYSQL_ROOT_PASSWORD=rootroot -e MYSQL_DATABASE=employees -e MYSQL_USER=su -e MYSQL_PASSWORD=rootroot mysql -v myvol:/var/lib/mysql --network mynetwork
  docker container ls
  sudo vi Dockerfile
  docker image build -t nop .
  docker container run -d -P --name connop -e MYSQL_SERVER=mysqldb --network mynetwork nop
------------------



### PUSH IMAGE TO ACR 
Connect to VM : 
  install docker
  install azure cli 
  az login
  docker login login server name (acr details)
  cmd : docker login shruthibandiacr.azurecr.io(login server name)

--docker pull nginx
--docker image ls
--docker tag 6efc10a0510f(nginx image is) shruthibandiacr (acr name)
           or
--docker tag 6efc10a0510f shruthibandiacr/nginx(first tagging to the registry and then tag that registry to the server)
using the above image - here tagging to server
--docker tag shruthibandiacr/nginx shruthibandiacr.azurecr.io/nginx (tagging registry to server)
--docker push shruthibandiacr.azurecr.io/nginx 
  #check the pushed images in acr-repositories


  --------------------------------------------------------------------------------------
  Intergrate acr with aks

  https://learn.microsoft.com/en-us/azure/aks/cluster-container-registry-integration?tabs=azure-cli

  --------------------------------------------------------------------------------------

### Dockerfile for spc(multistage)


FROM alpine/git AS vcs
RUN cd / && git clone https://github.com/spring-projects/spring-petclinic.git && \
    pwd && ls /spring-petclinic

FROM maven:3-amazoncorretto-17 AS builder
COPY --from=vcs /spring-petclinic /spring-petclinic
RUN ls /spring-petclinic
RUN cd /spring-petclinic && mvn package

FROM amazoncorretto:17-alpine-jdk
LABEL author="Prakash Reddy" organization="qt" project="learning"
EXPOSE 8080
ARG HOME_DIR=/spc
WORKDIR ${HOME_DIR}
COPY --from=builder /spring-petclinic/target/spring-*.jar ${HOME_DIR}/spring-petclinic.jar
EXPOSE 8080
CMD ["java", "-jar", "spring-petclinic.jar"]

------------------------------------------------------------------------------------

### Dockerfile for gameoflife

FROM tomcat:9-jdk8
LABEL author="Su" organization="qt"
ARG GOL_URL=https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/gameoflife.war
ADD ${GOL_URL} /usr/local/tomcat/webapps/gameoflife.war
VOLUME "/usr/local/tomcat"
EXPOSE 8080




  





