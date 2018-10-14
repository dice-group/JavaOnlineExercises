# Dockerfile for Jupyter notebook + nbgrader + Java kernel



# Based on
# Jupyterhub 0.94
# which is based on
# Ubuntu 18.04 LTS
# https://hub.docker.com/r/jupyterhub/jupyterhub/tags/

FROM jupyterhub/jupyterhub:0.9.4
LABEL maintainer="Adrian Wilke <adrian.wilke@upb.REMOVEME.de>"



# Update the system and install packages

RUN apt-get -y update && \
 apt-get -y upgrade && \
 apt-get -y install \
 nano \
 zip \
 && \
 apt-get purge && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/*



# Create certificate for HTTPS

RUN mkdir -p /opt/ssl && \
 cd /opt/ssl && \
 openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/C=DE/ST=NRW/L=Paderborn/O=UPB/OU=DICE/CN=diceapp.cs.upb.de"



# Create an admin and a user

RUN useradd --create-home nbgadmin && \
 useradd --create-home nbguser



# Install Java 11
# https://wiki.ubuntuusers.de/Java/Oracle_Java/

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/11+28/55eed80b163941c8885ad9298e6d786a/jdk-11_linux-x64_bin.tar.gz && \
 tar xzf jdk-11_linux-x64_bin.tar.gz && \
 mkdir /opt/Oracle_Java/ && \
 mv jdk-11 /opt/Oracle_Java/ && \
 update-alternatives --install "/usr/bin/java" "java" "/opt/Oracle_Java/jdk-11/bin/java" 1 && \
 update-alternatives --install "/usr/bin/javac" "javac" "/opt/Oracle_Java/jdk-11/bin/javac" 1 && \
 update-alternatives --install "/usr/bin/jar" "jar" "/opt/Oracle_Java/jdk-11/bin/jar" 1  && \
 update-alternatives --set "java" "/opt/Oracle_Java/jdk-11/bin/java" && \
 update-alternatives --set "javac" "/opt/Oracle_Java/jdk-11/bin/javac" && \
 update-alternatives --set "jar" "/opt/Oracle_Java/jdk-11/bin/jar" && \
 java -version



# Install Jupyter notebook
# Create configuration file
# https://jupyterhub.readthedocs.io/en/stable/getting-started/security-basics.html

RUN python3 -m pip install notebook && \
 cd /srv/jupyterhub/ && \
 jupyterhub --generate-config && \
 sed -i 's/^#c.JupyterHub.ssl_cert.*/c.JupyterHub.ssl_cert = "\/opt\/ssl\/cert.pem"/' /srv/jupyterhub/jupyterhub_config.py && \
 sed -i 's/^#c.JupyterHub.ssl_key.*/c.JupyterHub.ssl_key = "\/opt\/ssl\/key.pem"/' /srv/jupyterhub/jupyterhub_config.py && \
 sed -i 's/^#c.JupyterHub.admin_users.*/c.Authenticator.admin_users = set(["nbgadmin"])/' /srv/jupyterhub/jupyterhub_config.py && \
 cd /mnt && \
 ln -s /srv/jupyterhub/jupyterhub_config.py



# Install Java kernel / iJava

RUN wget --quiet https://github.com/SpencerPark/IJava/releases/download/v1.1.2/ijava-1.1.2.zip && \
 unzip ijava-1.1.2.zip && \
 python3 install.py --sys-prefix



# Install nbgrader
# Create directory for pushing/pulling assignments
# Disable extensions for non-admins

RUN conda install -c conda-forge nbgrader && \
 mkdir -p /srv/nbgrader/exchange && \
 chmod ugo+rw /srv/nbgrader/exchange && \
 jupyter nbextension disable --sys-prefix create_assignment/main && \
 runuser -l  nbgadmin -c '/opt/conda/bin/jupyter nbextension enable --user create_assignment/main' && \
 jupyter nbextension disable --sys-prefix validate_assignment/main && \
 runuser -l  nbgadmin -c '/opt/conda/bin/jupyter nbextension enable --user validate_assignment/main' && \
 jupyter nbextension disable --sys-prefix formgrader/main --section=tree && \
 runuser -l  nbgadmin -c '/opt/conda/bin/jupyter nbextension enable --user formgrader/main --section=tree'



# Configure nbgrader

RUN echo "c = get_config()\n\
c.Exchange.course_id = \"default-course\"\n\
c.Exchange.root = '/srv/nbgrader/exchange'\n\
c.ClearSolutions.code_stub = {\n\
'python': '# YOUR CODE HERE',\n\
'java': '// YOUR CODE HERE',\n\
}" \
> /opt/conda/etc/jupyter/nbgrader_config.py && \
 cd /mnt && \
 ln -s /opt/conda/etc/jupyter/nbgrader_config.py
