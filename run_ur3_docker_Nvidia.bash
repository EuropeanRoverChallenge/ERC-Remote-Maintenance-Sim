xhost + local:root

docker create -it \
    --name ur3_simulation_erc \
    --gpus all \
	--env="DISPLAY=:0" \
	--env="QT_X11_NO_MITSHM=1" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --env="NVIDIA_VISIBLE_DEVICES=all" \
    --env="NVIDIA_DRIVER_CAPABILITIES=all" \
	--privileged \
    --network=host \
    --volume="/dev:/dev" \
    ur3_erc
