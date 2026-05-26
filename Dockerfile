# Używamy oficjalnego obrazu ROS2 Humble z wersją Desktop
FROM osrf/ros:humble-desktop

# Aktualizacja i instalacja zależności (xacro dodane na stałe)
RUN apt-get update && apt-get install -y \
    python3-pykdl \
    python3-pygame \
    qtbase5-dev \
    qtchooser \
    qt5-qmake \
    qtbase5-dev-tools \
    nano \
    usbutils \
    ros-humble-xacro \
    && rm -rf /var/lib/apt/lists/*

# Ustawienie przestrzeni roboczej
WORKDIR /ros2_ws

# Skopiowanie skryptu startowego do kontenera i nadanie mu praw do wykonywania
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Entrypoint przechwytuje start kontenera i wykonuje konfigurację
ENTRYPOINT ["/entrypoint.sh"]

# Domyślna komenda – odpali się automatycznie po zakończeniu skryptu ENTRYPOINT
CMD ["ros2", "launch", "hal_application", "fullstack.launch.py"]
