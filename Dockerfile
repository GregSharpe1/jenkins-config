FROM jenkins/jenkins:lts

ENV CASC_JENKINS_CONFIG "/var/jenkins_home/casc-config/"
ENV PLUGINS_FORCE_UPGRADE=true
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

COPY casc-config/* /var/jenkins_home/casc-config/
COPY jobs/* /var/jenkins_home/casc-config/jobs/
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
