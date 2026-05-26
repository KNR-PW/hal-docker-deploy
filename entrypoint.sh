#!/bin/bash
set -e

# 1. Załadowanie głównego środowiska ROS2 Humble
source /opt/ros/humble/setup.bash

# 2. Załadowanie zbudowanej aplikacji (jeśli istnieje)
if [ -f "/ros2_ws/install/setup.bash" ]; then
    source /ros2_ws/install/setup.bash
else
    echo "========================================================="
    echo "UWAGA: Workspace nie został jeszcze zbudowany!"
    echo "Zostaniesz przeniesiony do terminala. Wpisz 'colcon build',"
    echo "a następnie uruchom kontener ponownie."
    echo "========================================================="
    exec bash
    exit 0
fi

# 3. Przekazanie sterowania do komendy z CMD (np. launch fullstack)
exec "$@"
