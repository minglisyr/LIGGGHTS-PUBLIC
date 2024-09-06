#!/bin/bash

cd $HOME
sudo apt update
sudo apt upgrade -y
sudo apt-get install -y git
sudo apt-get install -y ffmpeg openmpi-bin libopenmpi-dev g++ build-essential cmake libgl1-mesa-dev libglu1-mesa-dev python3.12-venv

python3 -m venv liggghts_env
python3 -m venv paraview_env

git clone https://github.com/minglisyr/LIGGGHTS-PUBLIC.git

source liggghts_env/bin/activate
sudo apt-get -y install libvtk9-dev
cd $HOME/LIGGGHTS-PUBLIC/src
make auto -j 12
deactivate

source paraview_env/bin/activate
sudo apt-get install paraview
deactivate

cd /usr/bin
sudo ln -s $HOME/LIGGGHTS-PUBLIC/src/lmp_auto liggghts

echo '
export DISPLAY=$(ip route | awk '"'/default/ { print \$3 }'"'):0.0
export MESA_LOADER_DRIVER_OVERRIDE=i965
export LIBGL_ALWAYS_SOFTWARE=1
export XDG_RUNTIME_DIR="/tmp/runtime-mingli"

#- shortcut to run liggghts in parallel
liggghtspar() { mpirun -np $2 liggghts -in $1; }
export -f liggghtspar
' >> ~/.bashrc && source ~/.bashrc


