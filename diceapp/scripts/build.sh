sudo docker build -t diceapp:latest . > build.log
echo "Please set the passwords for users nbgadmin and nbguser manually"
echo "usermod --password \$(openssl passwd -1 <PSW>) <USR>"
