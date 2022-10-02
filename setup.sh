# check if --bridge arg is passed
if [ "$1" = "--bridge" ]; then
    sh ./setup/bridge.sh
elif [ "$1" = "--dkms" ]; then
    sh ./setup/dkm.sh
elif [ "$1" = "--no-dkms" ]; then
    sh ./setup/no-dkms.sh
else
    echo "Usage: ./setup.sh [--bridge] [--dkms] [--no-dkms]"
    exit 1
fi