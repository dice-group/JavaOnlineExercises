echo "Monitor the progress with: tail -f -n 20 build.log"
docker build -t diceapp:latest . >> build.log
echo "Please set the passwords for users nbgadmin and nbguser manually"
echo "usermod --password \$(openssl passwd -1 <PSW>) <USR>"
