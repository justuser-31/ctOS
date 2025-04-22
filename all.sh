if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi

# Инициализация и обновление модулей
git submodule update --init --recursive --remote

./rtracker_cloner.sh
./init.sh
./build.sh
./run.sh
