FROM tomcat:8-jdk8-corretto
LABEL author="Su" organization="ABC"
ARG user=tomcat
ARG group=tomcat
ARG uid=1000
ARG gid=1000
ARG  HOME_DIR=/openMRS
RUN DOWNLOAD https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.5.0/openmrs.war
RUN mkdir /var/lib/OpenMRS
RUN groupadd -g ${gid} ${group} \
    && useradd -d "$HOME_DIR" -u ${uid} -g ${gid} -m -s /bin/bash
RUN chown -R tomcat:tomcat /var/lib/OpenMRS
RUN sudo cp openmrs.war /opt/tomcat/webapps/
RUN sudo chown -R tomcat:tomcat /opt/tomcat/webapps/openmrs.war
EXPOSE 8080
CMD ["https://0.0.0.0:8080/openmrs"]
