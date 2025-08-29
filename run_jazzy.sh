#!/bin/bash

# Run Docker container
docker run \
    --name ros-jazzy-dev \
    --privileged \
    --gpus all \
    --network=host \
    --ipc=host \
    --env "ACCEPT_EULA=Y" \
    --env "PRIVACY_CONSENT=Y" \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    -v "$XAUTH:$XAUTH" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v /home/droneproject/tagslam_ros2_ws/:/home/droneproject/tagslam_ros2_ws/ \
    -w /home/droneproject/tagslam_ros2_ws \
    -d ros-jazzy-dev tail -f /dev/null