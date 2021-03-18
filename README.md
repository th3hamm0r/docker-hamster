# docker-hamster

Run legacy hamster time tracker in newer versions of ubuntu (tested with Ubuntu/Kubuntu 20.04).

Based on https://github.com/holderl5/docker-hamster


## Setup

- Install docker (and add your user to the docker group to avoid `sudo`)
- Clone the repo
- adapt locale-specific stuff in `Dockerfile`
- run `build.sh` (run it every time the `Dockerfile` gets changed)
- run `run.sh` to start hamster

  NOTE: The scripts where tested with an existing DB (`~/.local/share/hamster-applet/hamster.db`) and 
  gconf-configuration (`~/.gconf/apps/hamster-applet/%gconf.xml`) of the legacy hamster-applet.

**Autostart:**

Adapt `hamster-docker.desktop` and place it in `~/.config/autostart`:

* replace `[DISPLAY]` with the output of `echo $DISPLAY` (may be ":0" for example)
* replace `[HOME_DIR]` with the output of `echo $HOME`


## TODO

- try to fix/avoid the duplicate calls in `run_hamster.sh`
- remove unnecessary stuff from `Dockerfile` (avoid some packages?)
