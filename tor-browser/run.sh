 docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
	--name tor \
        -v /dev/snd:/dev/snd \
	-v /dev/shm:/dev/shm \
	-v /etc/machine-id:/etc/machine-id:ro \
	-e DISPLAY=unix$DISPLAY \
	jess/tor-browser
