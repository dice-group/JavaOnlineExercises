# nbgraderutils

This repository provides scripts and information to offer Web-based Java assignments.
It uses Jupyter Nootbook for web access and the extension nbgrader for assignments.
Additionally, JupyterHub manages multiple users, IJava provides language support, and files are managed by Docker.


## Quick start

Note: The [wiki](https://github.com/dice-group/nbgraderutils/wiki) provides a more detailed description.

1. Optional: Edit `docker/1-build-image.sh` to set the used docker image and tag name.
2. Execute `docker/1-build-image.sh`. This will use `docker/Dockerfile`. The execution output will be appended into a file named build.log.
3. Optional: Edit `docker/2-run-container.sh` to set the used docker container name, the access port, and the mount point for backups.
4. Execute `docker/2-run-container.sh`. This will build and start the docker container.

If you used the default settings, you can access the web frontend at [https://localhost/](https://localhost/).
The default admin user is _nbgadmin_, the default student user is _nbguser_, and the default password for both is _nbgpsw_.

You should change the passwords for the users _nbgadmin_ and _nbguser_. To open a bash in the docker container you can use `scripts/bash.sh`. A command to change a user password is `usermod --password $(openssl passwd -1 <PSW>) <USR>`.


## Directories

- `docker`  
  Files to build docker image and container as a one-time execution
- `docker`  
  Example jupyter notebooks
- `scripts`  
  Scripts to maintain an existing docker container


## Info

- Code  
  https://github.com/dice-group/nbgraderutils
- Documentation  
  https://github.com/dice-group/nbgraderutils/wiki
-  Credits  
  https://dice.cs.uni-paderborn.de/