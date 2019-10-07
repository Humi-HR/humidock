# Humi Platform Setup

- Clone the humidock repo at the same level as your application repositories

#### These have been pre-added, but may be configured incorrectly for your setup:

- Verify the /nginx/conf files point to the correct folders /var/www/APP_FOLDER/public
  - Add these server_name's to your /etc/hosts for 127.0.0.1
- Verify mysql 8.0 support with `default_authentication_plugin=mysql_native_password` in /mysql/my.cnf
- Verify the mysql init script in /mysql creates the required databases

#### Setup your own environment file

- cp env-example .env

- Update your local .env/.env.testing files with the following host aliases

  - database hosts: mysql
  - redis host: redis
  - service api urls: use /etc/hosts aliases (local.api.humi.ca)
  - vagrant urls: use docker.for.mac.localhost (on mac) docker.for.win.localhost (on win) start your container and find the host ip address from inside the container, typically labeled docker0 (linux)

- change the database credentials to root/root

see https://laradock.io/documentation/ for all the environment options (including running workers, cron scheduling, etc)
see https://nickjanetakis.com/blog/docker-tip-65-get-your-docker-hosts-ip-address-from-in-a-container for instructions on finding your host ip address

#### Now run docker

- Optional, add the dock command to your path export `export PATH=$PATH:/Users/kevinlanglois/www/humi/humidock`

- run `dock up` or `./dock up` or `docker-compose up -d nginx mysql redis workspace`

#### Accessing workspace

You can access the workspace using bash

- run `dock workspace` or `./dock workspace` or `docker-compose exec --user=laradock workspace bash`

If we wish to ssh to the workspace, enable the `INSTALL_WORKSPACE_SSH` flag as per the docs
(https://laradock.io/documentation/#access-workspace-via-ssh)

```bash
ssh -o PasswordAuthentication=no    \
    -o StrictHostKeyChecking=no     \
    -o UserKnownHostsFile=/dev/null \
    -p 2222                         \
    -i workspace/insecure_id_rsa    \
    laradock@localhost
```

see ./dock for other relevant commands/learning

```bash
  ./dock workspace - exec bash into workspace

      (docker-compose exec --user=laradock workspace bash)

  ./dock up - start all containers

      (docker-compose up -d nginx mysql redis workspace )

  ./dock down - stop all containers

      (docker-compose stop, docker stop $(docker ps -aq), docker rm $(docker ps -aq))

  ./dock kill - destroy all containers

      (docker system prune -a)

  ./dock build service - build container by name

      (docker-compose build $2)

```
