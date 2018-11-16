# nbgraderutils: Automatically graded Java web exercises

This repository provides scripts and information to offer Web-based Java assignments.  
It uses *Jupyter Notebook* for web access and the extension *nbgrader* for assignments.
Additionally, *JupyterHub* manages multiple users, *IJava* provides language support, and files are managed by *Docker*.


## Quick start

1. **Install Docker**  
   [www.docker.com](https://www.docker.com/)
2. **Download nbgraderutils**  
   `wget https://github.com/dice-group/nbgraderutils/archive/master.zip`
3. **Unpack**  
   `unzip master.zip`
4. **Build Docker image**  
   `sudo ./nbgraderutils-master/docker/1-build-image.sh`  
   (This creates a Docker image *nbgjava* and the tag *latest*. It takes about 9 minutes.)
5. **Run Docker container**  
   `sudo ./nbgraderutils-master/docker/2-run-container.sh`  
   (This uses the mount point */mnt/nbgjava* and the port *8000*. If you want to change this configuration, edit the file first.)
6. **Initialize the system**  
  `sudo ./nbgraderutils-master/scripts/initialize.sh`  
   (This creates example student accounts *nbgtesta*, *nbgtestb*, and *nbgtestc*.
   It also copies assignment templates.)
7. **Go ahead**  
   Open [https://localhost:8000/](https://localhost:8000/)  
   (You can use the teacher account *nbgadmin*, and the student test accounts *nbgtesta*, *nbgtestb*, *nbgtestc*, and *nbguser*. All passwords are *nbgpsw*. You have to change the passwords for public installations.)

The [wiki](https://github.com/dice-group/nbgraderutils/wiki) provides detailed descriptions.


## Info

- Code  
  https://github.com/dice-group/nbgraderutils
- Documentation  
  https://github.com/dice-group/nbgraderutils/wiki
- Credits  
  Data Science Group (DICE) at Paderborn University  
  Adrian Wilke and Michael Röder  
  https://dice.cs.uni-paderborn.de/
