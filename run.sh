#!/bin/bash
docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v ~/.local/share/hamster-applet:/home/developer/.local/share/hamster-applet \
       -v ~/.gconf/apps/hamster-applet:/home/developer/.gconf/apps/hamster-applet \
        hamster
