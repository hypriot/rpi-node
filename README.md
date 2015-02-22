# rpi-node
Raspberry Pi compatible Docker base image with Node.js preinstalled.

Run all the commands from within the project root directory.

#### Build the Docker Image
```bash
make build
```

#### Run the Docker Image and get the version of the installed Node.js
```bash
make version
```

#### Push the Docker Image to the Docker Hub
* First use a `docker login` with username, password and email address
* Second push the Docker Image to the official Docker Hub
```bash
make push
```
