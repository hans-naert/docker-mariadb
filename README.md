# Instructions

In the following steps is mariadb-server installed in an existing container.
We are not using the MariaDB Docker image for educational reasons.

More info on https://mariadb.com/kb/en/installing-and-using-mariadb-via-docker/

## Build a deamonized image with Mariadb starting from Ubuntu
```
./build-docker-image.ps1
```

The command above executes docker for building an image with tag "mariadb-image". The Dockerfile contains the following build instructions.
```Docker
FROM ubuntu
RUN apt-get update && apt-get install -y mariadb-server \
   && apt-get clean && rm -rf /var/lib/apt/lists/*
EXPOSE 3306
RUN service mariadb start
#give a command to deamonize the image
ENTRYPOINT service mariadb start && tail -f /dev/null 
```

## Run the deamonized image
```
./run-docker-container.ps1
```
content of the script:
```bash
docker image rm --force mariadb-image
docker build . --tag mariadb-image
```
## Connect to the container
```
./connect-to-docker-container.ps1
```
content of script:
```bash
docker exec -it mariadb-container bash
```
## Open Mariadb client
When connected, we got a bash prompt.\
With the following command we open the Mariadb client:
```bash
mariadb -u root
```
## Configure a password-authenticated Administrative user

Create the user for connecting to the database
```SQL
CREATE USER 'admin_user'@'%' IDENTIFIED BY 'secret_password';
GRANT ALL PRIVILEGES ON *.* TO 'admin_user'@'%' WITH GRANT OPTION; 
FLUSH PRIVILEGES;
```
More info on https://www.cherryservers.com/blog/how-to-install-and-start-using-mariadb-on-ubuntu-20-04#step-4-configure-a-password-authenticated-administrative-user

## Make TCP connection available
Edit the /etc/mysql/my.cnf with nano and uncomment the line with "port = 3306".
Edit the /etc/mysql/mariadb.conf.d/50-server.cnf and change the bind-address to * (was 127.0.0.1)
Restart the server

## Connect with MySQL Workbench

Open MySQL Workbench and make a connection to 127.0.0.1:3306 with the admin_user and the 'secret_password'