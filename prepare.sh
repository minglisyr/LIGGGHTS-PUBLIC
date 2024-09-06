cd $HOME
sudo apt update
sudo apt upgrade
sudo apt-get install -y ffmpeg
sudo apt-get install -y git

git clone https://github.com/minglisyr/LIGGGHTS-PUBLIC.git
git clone https://gitlab.kitware.com/vtk/vtk.git

sudo apt-get install -y openmpi-bin libopenmpi-dev g++ build-essential cmake libgl1-mesa-dev libglu1-mesa-dev libvtk9-dev

cd LIGGGHTS/LIGGGHTS-PUBLIC/src
make auto
echo -e "\nexport LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/LIGGGHTS/LIGGGHTS-PUBLIC/lib/vtk/build/lib" >> ~/.bashrc
source ~/.bashrc
make auto
