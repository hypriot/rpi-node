# rpi-node

[![dockeri.co](http://dockeri.co/image/hypriot/rpi-node)](https://registry.hub.docker.com/u/hypriot/rpi-node/)

Raspberry Pi compatible Docker base image with [Node.js](http://nodejs.org).

Run all the commands from within the project root directory.

### Supported tags and respective Dockerfile links
0.10.36 ([Dockerfile](https://github.com/hypriot/rpi-node/tree/5b4ce02c35086ef60aae412b3fd9103d5439e1c2))
0.12.0 ([Dockerfile](https://github.com/hypriot/rpi-node/blob/aa767f5d7e9bd5918aa2f2676d0533eef75d43b0/Dockerfile))
4.0.0, latest ([4.0/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/4.0/Dockerfile))
4.0.0-onbuild, onbuild ([4.0/onbuild/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/4.0/onbuild/Dockerfile))
4.0.0-slim, slim ([4.0/slim/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/4.0/slim/Dockerfile))
4.0.0-wheezy, wheezy ([4.0/wheezy/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/4.0/wheezy/Dockerfile))

### Build Details
- [Source Project Page](https://github.com/hypriot)
- [Source Repository](https://github.com/hypriot/rpi-node)
- [DockerHub] (https://registry.hub.docker.com/u/hypriot/rpi-node/)


#### Build the Docker Image
```bash
make dockerbuild
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

## License

The MIT License (MIT)

Copyright (c) 2015 Hypriot

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
