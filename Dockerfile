FROM ubuntu
RUN apt-get update && apt-get install -y mariadb-server \
   && apt-get clean && rm -rf /var/lib/apt/lists/*
EXPOSE 3306
#give a command to deamonize the image
ENTRYPOINT service mariadb start && tail -f /dev/null