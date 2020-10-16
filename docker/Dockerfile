# State: endless loop at conda script
#
#Do you accept the license terms? [yes|no]
#[no] >>> Please answer 'yes' or 'no':'
#>>> Please answer 'yes' or 'no':'
#>>> Please answer 'yes' or 'no':'
#
# https://stackoverflow.com/questions/49865531/bash-script-for-anaconda-installer-and-license-agreement















# Dockerfile for Jupyter notebook + nbgrader + Java kernel
# https://github.com/dice-group/nbgraderutils



# Based on
#  Jupyterhub 1.0.0
# which is based on
#  Ubuntu 18.04 LTS
# https://jupyterhub.readthedocs.io/en/stable/quickstart-docker.html
# https://hub.docker.com/r/jupyterhub/jupyterhub/
# https://hub.docker.com/r/library/ubuntu/
# https://github.com/jupyterhub/jupyterhub/blob/0.9.4/Dockerfile

#FROM jupyterhub/jupyterhub:1.0.0
#LABEL maintainer="Adrian Wilke <adrian.wilke@upb.REMOVEME.de>"



# Based on
#  Jupyterhub 1.2.0
# which is based on
#  Ubuntu 20.04 (focal)
# https://jupyterhub.readthedocs.io/en/stable/quickstart-docker.html
# https://hub.docker.com/r/jupyterhub/jupyterhub/
# https://hub.docker.com/r/library/ubuntu/
# https://github.com/jupyterhub/jupyterhub/commits/master/Dockerfile
#
FROM jupyterhub/jupyterhub:1.2
LABEL maintainer="Adrian Wilke <adrian.wilke@upb.REMOVEME.de>"



# Update the system and install
# - APT utils

RUN apt-get -y update && \
 apt-get -y install apt-utils



# Upgrade the system and install
# - nano editor
# - zip (including unzip)
# - wget

RUN apt-get -y upgrade && \
 apt-get -y install \
 nano \
 zip \
 wget



# Install Java
# - Java 11 JRE (OpenJDK)
# - Java 11 JDK (OpenJDK)
# https://wiki.ubuntuusers.de/Java/Installation/OpenJDK/

RUN apt-get -y install \
 openjdk-11-jre \
 openjdk-11-jdk \
 openjdk-11-demo \
 openjdk-11-doc \
 openjdk-11-jre-headless \
 openjdk-11-source \
 && \
 apt-get purge && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/*



# Install Jupyter notebook
# https://hub.docker.com/r/jupyterhub/jupyterhub/#installation

RUN python3 -m pip install notebook



# Install Java kernel / iJava
# https://github.com/SpencerPark/IJava
RUN wget --quiet https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip && \
 unzip ijava-1.3.0.zip && \
 python3 install.py --sys-prefix



# Create linux users (default admin and user for nbgrader)
# Set default password nbgpsw

RUN useradd --create-home nbgadmin && \
 useradd --create-home nbguser && \
 usermod --password \$1\$xg4dbNmA\$ygNrKGsFBsu8hXoGieRSK0 nbgadmin && \
 usermod --password \$1\$xg4dbNmA\$ygNrKGsFBsu8hXoGieRSK0 nbguser



# Install Anaconda
# https://wiki.ubuntuusers.de/Anaconda/
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh && \
 bash Anaconda3-2020.07-Linux-x86_64.sh




# Install nbgrader
# Create directory for pushing/pulling assignments
# Disable extensions for non-admins
# https://conda-forge.org/docs/
# https://anaconda.org/conda-forge/nbgrader/labels
# https://nbgrader.readthedocs.io/en/stable/user_guide/installation.html

RUN conda update -n base conda && \
 conda install -c conda-forge nbgrader=0.6.1 && \
 jupyter nbextension disable --sys-prefix create_assignment/main && \
 jupyter nbextension disable --sys-prefix formgrader/main --section=tree && \
 runuser -l  nbgadmin -c '/opt/conda/bin/jupyter nbextension enable --user create_assignment/main' && \
 runuser -l  nbgadmin -c '/opt/conda/bin/jupyter nbextension enable --user formgrader/main --section=tree'



# Create certificate for HTTPS

RUN mkdir -p /opt/ssl && \
 cd /opt/ssl && \
 /usr/bin/openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/C=DE/ST=NRW/L=Paderborn/O=UPB/OU=DICE/CN=dice.cs.upb.de"



# Configure JupyterHub
# https://jupyterhub.readthedocs.io/en/stable/getting-started/security-basics.html
# https://jupyterhub.readthedocs.io/en/stable/getting-started/authenticators-users-basics.html
# https://jupyterhub.readthedocs.io/en/stable/reference/config-user-env.html

RUN cd /srv/jupyterhub/ && \
 jupyterhub --generate-config && \
 sed -i 's/^#c.JupyterHub.ssl_cert.*/c.JupyterHub.ssl_cert = "\/opt\/ssl\/cert.pem"/' /srv/jupyterhub/jupyterhub_config.py && \
 sed -i 's/^#c.JupyterHub.ssl_key.*/c.JupyterHub.ssl_key = "\/opt\/ssl\/key.pem"/' /srv/jupyterhub/jupyterhub_config.py && \
 sed -i 's/^#c.Authenticator.admin_users.*/c.Authenticator.admin_users = set(["nbgadmin"])/' /srv/jupyterhub/jupyterhub_config.py && \
 cd /mnt && \
 ln -s /srv/jupyterhub/jupyterhub_config.py



# Configure Jupyter
# https://jupyterhub.readthedocs.io/en/stable/getting-started/config-basics.html
# https://jupyterhub.readthedocs.io/en/stable/reference/config-user-env.html
# https://jupyter-notebook.readthedocs.io/en/stable/config_overview.html
RUN jupyter notebook --generate-config && \
 sed -i 's/^#c.NotebookApp.shutdown_no_activity_timeout.*/c.NotebookApp.shutdown_no_activity_timeout = 60 * 60/' /root/.jupyter/jupyter_notebook_config.py && \
 sed -i 's/^#c.MappingKernelManager.cull_idle_timeout.*/c.MappingKernelManager.cull_idle_timeout = 20 * 60/' /root/.jupyter/jupyter_notebook_config.py && \
 sed -i 's/^#c.MappingKernelManager.cull_interval.*/c.MappingKernelManager.cull_interval = 2 * 60/' /root/.jupyter/jupyter_notebook_config.py \
 && \
 [ -d /etc/jupyter/ ] || mkdir -p /etc/jupyter/ && \
 mv /root/.jupyter/jupyter_notebook_config.py /etc/jupyter/ && \
 ln -s /etc/jupyter/jupyter_notebook_config.py /mnt/



# Configure nbgrader
# https://nbgrader.readthedocs.io/en/stable/configuration/config_options.html
# https://nbgrader.readthedocs.io/en/stable/user_guide/managing_assignment_files.html#id8

RUN mkdir -p /srv/nbgrader/exchange && \
 chmod ugo+rw /srv/nbgrader/exchange \
 && \
 printf "c = get_config()\n\
c.CourseDirectory.course_id = \"default-course\"\n\
c.Exchange.root = '/srv/nbgrader/exchange'\n\
c.ExecutePreprocessor.timeout = 300\n\
c.ClearSolutions.code_stub = {\n\
'python': '# YOUR CODE HERE',\n\
'java': '// YOUR CODE HERE',\n\
}" \
> /opt/conda/etc/jupyter/nbgrader_config.py  \
 && \
 cd /mnt && \
 ln -s /opt/conda/etc/jupyter/nbgrader_config.py



# Create nbgrader accounts for nbgadmin and nbguser
# (Avoids autograding errors, if these accounts submitted solution)

RUN cd /home/nbgadmin/ && \
 nbgrader db student add nbgadmin && \
 nbgrader db student add nbguser



# - Default filesystem permissions
#   New homes not readable by others
# - Homes group is nbgadmin for providing feedback
# - Strict permissions for SSL and /mnt
# - Directory to distribute files

RUN sed -i 's/^DIR_MODE=0755.*/DIR_MODE=0770/' /etc/adduser.conf && \
 chmod go-rwx /home/* && \
 chmod g+rwx /home/* \
 && \
 chgrp nbgadmin /home/* \
 && \
 chmod -R o-rwx /opt/ssl && \
 chmod o-rwx /mnt \
 && \
 mkdir /srv/distribution && \
 chown nbgadmin:nbgadmin /srv/distribution/ && \
 echo "hello world!" > /srv/distribution/hello-world.txt && \
 chmod 775 /srv/distribution/hello-world.txt



# Create backup of admin users home

RUN cp -Rp /home/nbgadmin/ /home/.nbgadmin/ && \
 chown nbgadmin:nbgadmin /home/.nbgadmin/
