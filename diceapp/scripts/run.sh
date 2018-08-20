docker run \
-t -d \
-p 8000:8000 \
-v /mnt/database:/srv/jupyterhub \
-v /mnt/adminhome/:/home \
--name diceapp \
diceapp
