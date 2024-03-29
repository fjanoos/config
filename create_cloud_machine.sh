##############################################################################################################
# setup ssh keys
##############################################################################################################
cd ~
cp id_rsa* ~/.ssh
cp cadre_rsa* ~/.ssh
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/cadre_rsa.pub >> ~/.ssh/authorized_keys
# also copy over these file osc_ssh_keys* ~/.ssh if you want

# See https://stackoverflow.com/questions/2419566/best-way-to-use-multiple-ssh-private-keys-on-one-client
echo "IdentityFile ~/.ssh/id_rsa
IdentityFile ~/.ssh/cadre_rsa
IdentityFile ~/.ssh/osc_ssh_keys" > ~/.ssh/config
chmod 0600 ~/.ssh/*
# setup ssh-agent in bash to use keys without password. Needed for cadre git ssh
ssh-agent bash
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/cadre_rsa
ssh-add ~/.ssh/osc_ssh_keys

##############################################################################################################
# Setup bash configuration and softlinks
##############################################################################################################
cd ~
git clone https://github.com/fjanoos/config.git

# create the bash file
mv .bashrc .bashrc_org
cp ~/config/.bashrc_cloud ~/.bashrc
source ~/.bashrc

# create soft links
ln -s ~/config/.gitconfig -t ~
ln -s ~/config/.gitignore -t ~
ln -s ~/config/.git-prompt.sh -t ~
ln -s ~/config/.ipython -t ~
ln -s ~/config/.jupyter -t ~
ln -s ~/config/.tmux.conf -t ~
ln -s ~/local/experiments -t ~
ln -s ~/local/data -t ~
ln -s ~/local/software -t ~
ln -s ~/local/tmp -t ~
ln -s ~/local/cloud -t ~
ln -s ~/cloud/code -t ~
ln -s ~/cloud/notebooks -t ~
ln -s ~/code/research -t ~

##############################################################################################################
# update linux version 
##############################################################################################################

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git tmux htop html2text tree python3-pip
sudo apt-get install gcc g++ make libboost-all-dev openssh-server openssh-client samba smbclient 

# configure openssh server, and open ports using ufw
# configure samba server, set password and open ports using ufw
# install hibernate / awake utils (pm-hibernate)
# (optionally) setup rdp (https://linuxize.com/post/how-to-install-xrdp-on-ubuntu-18-04/)

# install nvidia drivers from nvidia (cuda , cudnn )
sudo apt-get install nvidia-cuda-toolkit
# alternatively pull teh latest version from https://developer.nvidia.com/cuda-downloads


##############################################################################################################
# copy over code and data from the old machine
##############################################################################################################
export SOURCE_MACHINE=<set your Ip here>
export SOURCE_HOME='/home/fjanoos/'
rsync -axrv fjanoos@$SOURCE_MACHINE:$SOURCE_HOME/cloud ~
rsync -axrv fjanoos@$SOURCE_MACHINE:$SOURCE_HOME/data ~


##############################################################################################################
# install python
##############################################################################################################
mkdir ~/local/tmp;  cd ~/local/tmp
#### install conda ###
wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
chmod au+x Anaconda3-2020.02-Linux-x86_64.sh
./Anaconda3-2020.02-Linux-x86_64.sh # install conda on a fast hardrive

### Install conda packages into main enviroment ###
conda deactivate
conda install numpy numba tensorboard arrow joblib pandas matplotlib jupyter memory_profiler line_profiler pyarrow xarray statsmodels scipy scikit-learn dask tqdm sqlalchemy bottleneck gitpython cloudpickle
pip install numbagg cvxpy cvxpylayers
# install torch as required
conda install pytorch torchvision cudatoolkit=10.2 -c pytorch
# gpu only machines
pip install p3nvml cupy
# command line csv viewier ( /> vd ... )
conda install -c conda-forge jupyter_contrib_nbextensions visidata 
jupyter contrib nbextension install --user
jupyter nbextension enable codefolding/main
jupyter nbextension enable toggle_all_line_numbers/main
# to recreate the full conda environment any other dependencies 
# export the environment like this conda env export | grep -v "^prefix: " > environment.yml
# conda env create -f ~/config/environment.yml
# or 
# while read requirement; do conda install --yes $requirement; done < conda_requirements.txt 2>error.log

# this soft link may get overridden re link it
ln -s ~/config/.jupyter -t ~

# --- install xarray from github if you like ---
#conda uninstall xarray
#cd ~/software 
#git clone https://github.com/pydata/xarray.git
#cd xarray
#git pull origin master
#python setup.py develop 

# do updates
conda update --all
