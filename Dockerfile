# -----------------------------------------------------------------------------
# ROS 2 Jazzy on Ubuntu 24.04 (Noble) with extra dev tools
# -----------------------------------------------------------------------------
FROM osrf/ros:jazzy-desktop-full 

# Metadata (keep whatever you find useful)
LABEL version="1.0"
LABEL description="ROS 2 Jazzy tagslam development image"

# ----------------------------------------------------------------------------- 
# Arguments / environment
# -----------------------------------------------------------------------------
ARG ROS2_VERSION=jazzy
ENV DEBIAN_FRONTEND=noninteractive

# ----------------------------------------------------------------------------- 
# System update + package installation (single layer, cleans up afterwards)
# -----------------------------------------------------------------------------
RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install --no-install-recommends \
        ros-${ROS2_VERSION}-apriltag-msgs \
        ros-${ROS2_VERSION}-apriltag-detector \
        ros-${ROS2_VERSION}-gtsam \
        git clang-tidy python3-vcstool libopencv-dev sudo && \
    rm -rf /var/lib/apt/lists/*

# ----------------------------------------------------------------------------- 

RUN useradd -m -s /bin/bash droneproject \
    && echo "droneproject ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && chown -R droneproject:droneproject /home/droneproject

# Switch to the new user
USER droneproject
WORKDIR /home/droneproject
SHELL ["/bin/bash", "-l", "-c"]
RUN echo "source /opt/ros/jazzy/setup.bash" >> /home/droneproject/.bashrc
RUN echo "source /home/droneproject/tagslam_ros2_ws/install/setup.bash" >> /home/droneproject/.bashrc
# ---------------------------------