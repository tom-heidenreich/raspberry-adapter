# check if --no_dkms is passed as argument
if [ "$1" = "--no_dkms" ]; then
    sh ./install/no_dkms.sh
else
    sh ./install/dkms.sh
fi