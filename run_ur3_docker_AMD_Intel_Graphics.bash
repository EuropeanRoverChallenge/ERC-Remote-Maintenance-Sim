xhost + local:root

docker create --rm --net=host --device=/dev/dri -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY --name ur3_simulation_erc  ur3_erc
