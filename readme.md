# HAL-APPLICATION - Docker Deployment Stack

To repozytorium zawiera w pełni skonteneryzowane środowisko do uruchamiania interfejsu sterowania łazikiem (HAL-APPLICATION). Działa na dowolnej dystrybucji Linuxa (Ubuntu, Arch, Fedora), rozwiązuje problemy z zależnościami (np. braki w xacro) i obsługuje separację sieciową dla wielu użytkowników (DDS Domain ID).

## 1. Wymagania wstępne
Na swoim komputerze-hoście musisz mieć zainstalowane:
1. **Docker:** `sudo apt install docker.io` (Ubuntu) / `sudo pacman -S docker` (Arch) / `sudo dnf install docker` (Fedora).
   * Pamiętaj o uruchomieniu usługi Dockera: `sudo systemctl enable --now docker`
2. **xhost:** Narzędzie do przepuszczania okien X11. `x11-xserver-utils` (Ubuntu) / `xorg-xhost` (Arch/Fedora).

## 2. Pobieranie (Ważne!)
Ponieważ kod aplikacji jest podpięty jako submodule, **musisz** sklonować repozytorium z odpowiednią flagą:

```bash
git clone --recursive https://<LINK_DO_TWOJEGO_REPO>.git
cd hal-docker-deploy

(Jeśli zapomniałeś flagi --recursive i folder HAL-APPLICATION jest pusty, napraw to komendą: git submodule update --init --recursive).
3. Budowanie obrazu (Tylko za pierwszym razem)

Zbuduj obraz Dockera zawierający ROS2 Humble i wszystkie niezbędne pakiety:
Bash

sudo docker build -t hal_rover_env .

4. Uruchamianie

Za pierwszym uruchomieniem system wyświetli komunikat o braku zbudowanego workspace'u i wrzuci Cię do terminala. Wpisz po prostu colcon build, poczekaj na zakończenie, wpisz exit i uruchom skrypt ponownie.

Wybierz jeden ze skryptów w zależności od sprzętu. Numer na końcu to ROS_DOMAIN_ID – użyj unikalnego numeru (np. 5), jeśli pracujesz w tej samej sieci WiFi co inne osoby, żebyście nie sterowali nawzajem swoimi łazikami. Domyślnie używa kanału 0.

Opcja A: Z padem od Xboxa
(Wymaga fizycznego podłączenia pada po USB ZANIM odpalisz skrypt!)
Bash

./auto.sh 5

Opcja B: Tylko myszka (Tryb Manualny)
Bash

./manual.sh 5

5. Jak aktualizować kod źródłowy łazika?

Jeśli zespół programistów wrzucił nowe zmiany do HAL-APPLICATION, wystarczy, że wejdziesz do folderu submodułu i pobierzesz zmiany:
Bash

cd HAL-APPLICATION
git pull origin main
cd ..
git add HAL-APPLICATION
git commit -m "Zaktualizowano submoduł do najnowszej wersji"

Przy kolejnym uruchomieniu skryptu wejdź do kontenera (bash na końcu komendy run) i wpisz colcon build, aby skompilować nowe zmiany C++/Python.
