# Noop video filter plugin for VLC
VLC video filter plugin that does nothing.

## Table of contents

- [Install](#install)
  - [Windows](#windows)
  - [Linux](#linux)
    - [Debian](#debian)
- [Usage](#usage)
- [License](#license)

## Supported versions of VLC
Only VLC 3.0 is supported for now.

## Install

### Windows
Download an appropriate archive:

Version/Bitness | VLC 32 bit | VLC 64 bit
----------- | ------ | -------
VLC 3.0 | [Download](https://github.com/nurupo/vlc-noop-video-filter-plugin/releases/download/v0.1.0/vlc-3.0-32bit-win.zip) | [Download](https://github.com/nurupo/vlc-noop-video-filter-plugin/releases/download/v0.1.0/vlc-3.0-64bit-win.zip)

Extract it at `{VLC}\plugins\video_filter\`, where `{VLC}` is the directory the VLC was installed into, for example `C:\Program Files (x86)\VideoLAN\VLC\`.

Then follow [the usage instructions](#usage) below.

If you want to build the plugin yourself, take a look at [build in a Docker container](/docker) instructions.

Then follow [the usage instructions](#usage) below.
### Linux

#### Debian
Get required libraries and tools:
```bash
sudo apt-get install build-essential pkg-config libvlccore-dev libvlc-dev
```

Build and install:
```bash
make
sudo make install
```

Then follow [the usage instructions](#usage) below.

## Usage
1. Restart VLC to load the newly added plugin.
2. Go into advanced preferences: Tools -> Preferences -> Show settings -> All
3. Enable/Disable the plugin with a checkbox: (in advanced preferences) Video -> Filters -> Noop video filter
4. Restart VLC for settings to take place
5. Play a video
6. Nothing should have changed

## License
LGPLv2.1+
