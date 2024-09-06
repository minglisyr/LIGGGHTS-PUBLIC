cd $HOME
sudo apt update
sudo apt upgrade
sudo apt-get install -y ffmpeg
sudo apt-get install -y git

git clone https://github.com/minglisyr/LIGGGHTS-PUBLIC.git

sudo apt-get install -y openmpi-bin libopenmpi-dev g++ build-essential cmake libgl1-mesa-dev libglu1-mesa-dev paraview
sudo apt-get install -y libvtk9-dev paraview
cd $HOME/LIGGGHTS-PUBLIC/src
make auto
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


