# Docker RA Image for Tomcat8-JRE8 with few customization
#FROM tomcat:8.5.15-jre8
#FROM 876496569223.dkr.ecr.us-east-1.amazonaws.com/wdpr-ra/tc8jre8:1.2.1-10.0.0.0
FROM 876496569223.dkr.ecr.us-east-1.amazonaws.com/wdpr-ra/tc8jre8:2.0.8-50.0.0.0
MAINTAINER "Naren Nallani <naren.x.nallani.-nd@disney.com>"

LABEL DESCRIPTION="This image is used for Tomcat8 and Java8 runtime with additional customizations for SnApp...."

RUN apt-get update && apt-get install -y vim
RUN apt-get install -y wget

ADD . setenv.sh /usr/local/tomcat/bin/

RUN chmod +x /usr/local/tomcat/bin/setenv.sh

# configure app specific tomcat settings here

# NOTE be careful not to unintentionally overwrite tomcat configurations from the RA base image
ADD . ROOT.xml /usr/local/tomcat/conf/Catalina/localhost/

# Copy the WAR from nexus
ADD . snapp.war /usr/local/tomcat/webapps/
                                                                                                     
#RUN chmod +rwx /usr/local/tomcat/webapps/snapp.war /usr/local/tomcat/conf/Catalina/localhost/ROOT.xml

RUN chmod 700 /usr/local/tomcat/webapps/snapp.war /usr/local/tomcat/conf/Catalina/localhost/ROOT.xml


RUN wget -O splunkforwarder-7.1.0-2e75b3406c5b-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.1.0&product=universalforwarder&filename=splunkforwarder-7.1.0-2e75b3406c5b-linux-2.6-amd64.deb&wget=true'

RUN dpkg -i splunkforwarder-7.1.0-2e75b3406c5b-linux-2.6-amd64.deb   

RUN /opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --no-prompt

ADD . inputs.conf /opt/splunkforwarder/etc/system/local/

ADD . outputs.conf /opt/splunkforwarder/etc/system/local/

RUN /opt/splunkforwarder/bin/splunk restart 

RUN /usr/local/tomcat/bin/catalina.sh jpda start

# create SnApp app specific directories
RUN mkdir -p  /usr/local/tomcat/snappappcache
RUN chmod 750 /usr/local/tomcat/snappappcache    

# expose any additional ports if required
EXPOSE 8080

# Run scripts in base image to startup appD and catalina with the appropriate settings
CMD cd /scripts && ./appd-config.sh && ./run.sh
