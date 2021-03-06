## Cross-compiling to Windows with Docker

### Intro

The Dockerfile provided in this directory sets up a container image for building all versions of the plugin: 3.0, both 32-bit and 64-bit ones.
Once the image is created, you don't have to re-create it if you change plugin source code, it will pickup any changes in code you make.

### Building

I assume you are running on Linux and you already have Docker installed.

Note that you will need at least 1GiB of free disk space.
You will have to download about 1GiB of data to build the image.

First we need to create the image.
You can build the image yourself by using the Dockerfile

```bash
sudo docker build -t vlc-noop-video-filter-plugin-windows-build .
```

After the image is successfully built, we can run a build script in it to build the plugin binaries.

Note that the build script expects root of this, vlc-noop-video-filter-plugin, git repository to be mounted under `/repo` and the directory into which you want the binaries to be put to be mounted under `/build` inside of the container.
For this, we use the `-v` flag when running a container based on the image.
The syntax is `-v <host-directory-path>:<container-mounting-point>`.

This is how you would run the container based on the image.
Don't forget to specify your own paths in `-v` flags.

```bash
sudo docker run --rm \
    -v /home/nurupo/git/vlc-noop-video-filter-plugin:/repo \
    -v /home/nurupo/git/vlc-noop-video-filter-plugin/build:/build \
    vlc-noop-video-filter-plugin-windows-build \
    all
```

This will start the building process.
You should see the binaries getting created in the directory you specified to be used for `/build` mounting point.

### Building only selected versions of the plugin

If for some reason you don't want to build all of the 4 versions of the plugin binaries, you can specify which exact version you want to build by replacing "all" in the `docker run` command with "3.0 [32|64]".
For example, if you want to build only the VLC 3.0 32-bit version of the plugin, you would run

```bash
sudo docker run -rm \
    -v /home/nurupo/git/vlc-noop-video-filter-plugin:/repo \
    -v /home/nurupo/git/vlc-noop-video-filter-plugin/build:/build \
    vlc-noop-video-filter-plugin-windows-build \
    3.0 32
```

### Freeing disk space

To free the space taken by the image, you can run `sudo docker images` to get the list of images and `sudo docker rmi <image-hash>` to remove an image.
There is also `sudo docker ps -a` to get the list of containers and `sudo docker rm <container-hash>` to remove a container.
