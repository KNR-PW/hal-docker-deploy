#!/bin/bash

echo "Szukanie zawieszonych kontenerów HAL..."

# Znajdź wszystkie (nawet zatrzymane) kontenery, które mają w nazwie "hal_container"
CONTAINERS=$(sudo docker ps -a -q --filter "name=hal_container")

if [ -z "$CONTAINERS" ]; then
    echo "Środowisko jest czyste. Nie znaleziono zablokowanych kontenerów."
else
    echo "Znaleziono zawieszone kontenery. Trwa ich wymuszone zamykanie..."
    # Flaga -f (force) natychmiastowo zabija (SIGKILL) i usuwa kontener
    sudo docker rm -f $CONTAINERS
    echo "Sprzątanie zakończone pomyślnie! Możesz ponownie odpalić łazika."
fi
