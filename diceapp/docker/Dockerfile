# Jupyter notebook
# nbgrader
# Java and C++ kernel
#
# Based on
# Jupyterhub 0.91
# which is based on
# Ubuntu 18.04 LTS

FROM jupyterhub/jupyterhub:0.9.1
LABEL maintainer="Adrian Wilke <adrian.wilke@upb.REMOVEME.de>"



# Update the system and install packages

RUN apt-get -y update && \
 apt-get -y upgrade && \
 apt-get -y install \
 build-essential \
 nano \
 zip \
 && \
 apt-get purge && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/*



# Install Jupyter notebook
# Create configuration file

RUN python3 -m pip install notebook && \
 cd /srv/jupyterhub/ && \
 jupyterhub --generate-config && \
 sed -i 's/^#c.JupyterHub.ssl_cert.*/c.JupyterHub.ssl_cert = "\/opt\/ssl\/cert.pem"/' /srv/jupyterhub/jupyterhub_config.py && \
 sed -i 's/^#c.JupyterHub.ssl_key.*/c.JupyterHub.ssl_key = "\/opt\/ssl\/key.pem"/' /srv/jupyterhub/jupyterhub_config.py && \
 sed -i 's/^#c.JupyterHub.admin_users.*/c.Authenticator.admin_users = set(["nbgadmin"])/' /srv/jupyterhub/jupyterhub_config.py && \
 cp /srv/jupyterhub/jupyterhub_config.py /tmp/jupyterhub_config.py



# Install Java 10

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/10.0.2+13/19aef61b38124481863b1413dce1855f/jdk-10.0.2_linux-x64_bin.tar.gz && \
 tar xzf jdk-10.0.2_linux-x64_bin.tar.gz && \
 mkdir /opt/Oracle_Java/ && \
 mv jdk-10.0.2 /opt/Oracle_Java/ && \
 update-alternatives --install "/usr/bin/java" "java" "/opt/Oracle_Java/jdk-10.0.2/bin/java" 1 && \
 update-alternatives --install "/usr/bin/javac" "javac" "/opt/Oracle_Java/jdk-10.0.2/bin/javac" 1 && \
 update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/Oracle_Java/jdk-10.0.2/bin/javaws" 1 && \
 update-alternatives --install "/usr/bin/jar" "jar" "/opt/Oracle_Java/jdk-10.0.2/bin/jar" 1  && \
 update-alternatives --set "java" "/opt/Oracle_Java/jdk-10.0.2/bin/java" && \
 update-alternatives --set "javac" "/opt/Oracle_Java/jdk-10.0.2/bin/javac" && \
 update-alternatives --set "javaws" "/opt/Oracle_Java/jdk-10.0.2/bin/javaws" && \
 update-alternatives --set "jar" "/opt/Oracle_Java/jdk-10.0.2/bin/jar" && \
 java -version



# Install Java kernel / iJava

RUN wget --quiet https://github.com/SpencerPark/IJava/releases/download/v1.1.1/ijava-1.1.1.zip && \
 unzip ijava-1.1.1.zip && \
 python3 install.py --sys-prefix



# Install GCC and C++ kernel / xeus-cling

RUN conda install xeus-cling notebook -c QuantStack -c conda-forge



# Create an admin and a user

RUN useradd --create-home nbgadmin && \
 useradd --create-home nbguser



# Install nbgrader
# Create directories for pushing/pulling assignments and for the default course
# Disable extensions for non-admins

RUN conda install -c conda-forge nbgrader && \
 mkdir -p /srv/nbgrader/exchange && \
 chmod ugo+rw /srv/nbgrader/exchange && \
 mkdir -p /home/nbgadmin/default-course/ && \
 chown nbgadmin:nbgadmin /home/nbgadmin/default-course/ && \
 jupyter nbextension disable --sys-prefix create_assignment/main && \
 runuser -l  nbgadmin -c '/opt/conda/bin/jupyter nbextension enable --user create_assignment/main' && \
 jupyter nbextension disable --sys-prefix validate_assignment/main && \
 runuser -l  nbgadmin -c '/opt/conda/bin/jupyter nbextension enable --user validate_assignment/main' && \
 jupyter nbextension disable --sys-prefix formgrader/main --section=tree && \
 runuser -l  nbgadmin -c '/opt/conda/bin/jupyter nbextension enable --user formgrader/main --section=tree'



# Create certificate for HTTPS

RUN mkdir -p /opt/ssl && \
 cd /opt/ssl && \
 openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/C=DE/ST=NRW/L=Paderborn/O=UPB/OU=DICE/CN=diceapp.cs.upb.de"



# Configure nbgrader

RUN echo "c = get_config()\n\
c.Exchange.course_id = \"default-course\"\n\
c.Exchange.root = '/srv/nbgrader/exchange'\n\
c.ClearSolutions.code_stub = {\n\
'python': '# YOUR CODE HERE',\n\
'java': '// YOUR CODE HERE',\n\
'C++11': '/* YOUR CODE HERE */',\n\
'C++14': '/* YOUR CODE HERE */',\n\
'C++17': '/* YOUR CODE HERE */'\n\
}" \
> /opt/conda/etc/jupyter/nbgrader_config.py
