# This file publishes the nbgrader container port 8000 to the host port 8000
# It mounts the database directory for backups
# It mounts the home directory for backups
docker run \
-t -d \
-p 8000:8000 \
-v /mnt/database:/srv/jupyterhub \
-v /mnt/home:/home \
--name diceapp \
diceapp

# Version for HTTPS
# This file publishes the nbgrader container port 8000 to the HTTPS host port 443
#-p 443:8000 \
