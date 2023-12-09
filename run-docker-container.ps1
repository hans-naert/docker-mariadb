docker stop mariadb-container
docker container rm mariadb-container
docker run -dp 127.0.0.1:3306:3306 --name mariadb-container mariadb-image