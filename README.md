# rpi-node
Raspberry Pi comptible Docker baseimage with Nodejs preinstalled.

Run all the commands from within the project root directory.

#### Build the Docker Image
```bash
make build
```

#### Run the Docker Image and get the version of the installed Nodejs
```bash
make version
```

#### Push the Docker Image to the Docker Hub
* First use a `docker login` with username, password and email address
* Second push the Docker Image to the official Docker Hub
```bash
make push
```
