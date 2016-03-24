# rpi-node [![Build Status](https://armbuilder.hypriot.com/api/badges/hypriot/rpi-node/status.svg)](https://armbuilder.hypriot.com/hypriot/rpi-node)

Raspberry Pi compatible Docker base image with [Node.js](http://nodejs.org)

Run all the commands from within the project root directory.

### Supported tags and respective `Dockerfile` links
- `4.4.1`, `4.4`, `4`, `argon` ([4.4/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/4.4/Dockerfile))
- `4.4.1-onbuild`, `4.4-onbuild`, `4-onbuild`, `argon-onbuild` ([4.4/onbuild/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/4.4/onbuild/Dockerfile))
- `4.4.1-slim`, `4.4-slim`, `4-slim`, `argon-slim` ([4.4/slim/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/4.4/slim/Dockerfile))
- `4.4.1-wheezy`, `4.4-wheezy`, `4-wheezy`, `argon-wheezy` ([wheezy/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/4.4/wheezy/Dockerfile))
- `5.9.0`, `5.9`, `5`, `latest` ([5.9/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/5.9/Dockerfile))
- `5.9.0-onbuild`, `5.9-onbuild`, `5-onbuild`, `onbuild` ([5.9/onbuild/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/5.9/onbuild/Dockerfile))
- `5.9.0-slim`, `5.9-slim`, `5-slim`, `slim` ([5.9/slim/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/5.9/slim/Dockerfile))
- `5.9.0-wheezy`, `5.9-wheezy`, `5-wheezy`, `wheezy` ([5.9/wheezy/Dockerfile](https://github.com/hypriot/rpi-node/blob/master/5.9/wheezy/Dockerfile))

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
