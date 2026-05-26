#!/bin/bash

# Pobranie numeru domeny z argumentu (jeśli nie podano, używa 0)
DOMAIN_ID=${1:-55}
echo "Uruchamianie aplikacji (Tryb Manualny) w sieci ROS_DOMAIN_ID: $DOMAIN_ID"

# Odblokowanie dostępu do ekranu dla Dockera
xhost +local:root

# Uruchomienie kontenera z przekazaniem domeny
sudo docker run -it --rm \
  --net=host \
  --env="DISPLAY=$DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --env="ROS_DOMAIN_ID=$DOMAIN_ID" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="$(pwd)/HAL-APPLICATION:/ros2_ws/src/HAL-APPLICATION:rw" \
  --volume="$(pwd)/build:/ros2_ws/build:rw" \
  --volume="$(pwd)/install:/ros2_ws/install:rw" \
  --volume="$(pwd)/log:/ros2_ws/log:rw" \
  --name hal_container_manual_$DOMAIN_ID \
  hal_rover_env
