elif [ "$1" = "--dkms" ]; then
    sh ./remove/dkm.sh
elif [ "$1" = "--no-dkms" ]; then
    sh ./remove/no-dkms.sh
else
    echo "Usage: ./remove.sh [--dkms] [--no-dkms]"
    exit 1
fi