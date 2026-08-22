#!/bin/bash

echo "🚀 Rozpoczynam kompilację przestrzeni roboczej ROS2 (colcon build)..."

# Uruchamiamy kontener z nadpisanym entrypointem, by wykonał tylko budowanie
sudo docker run -it --rm \
  --entrypoint /bin/bash \
  --volume="$(pwd)/HAL-APPLICATION:/ros2_ws/src/HAL-APPLICATION:rw" \
  --volume="$(pwd)/build:/ros2_ws/build:rw" \
  --volume="$(pwd)/install:/ros2_ws/install:rw" \
  --volume="$(pwd)/log:/ros2_ws/log:rw" \
  --name hal_builder \
  hal_rover_env -c "source /opt/ros/humble/setup.bash && colcon build"

echo "✅ Budowanie zakończone! Możesz teraz uruchomić aplikację przez auto.sh lub manual.sh."
