##############################################################################################################
# setup ssh keys
##############################################################################################################
cd ~
cp id_rsa* ~/.ssh
cp cadre_rsa* ~/.ssh
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
cat ~/cadre_rsa.pub >> ~/.ssh/authorized_keys
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
ln -s ~/local/cloud -t ~
ln -s ~/cloud/code -t ~
ln -s ~/cloud/notebooks -t ~
ln -s ~/local/data -t ~
ln -s ~/local/software -t ~
ln -s ~/local/tmp -t ~


##############################################################################################################
# update linux version 
##############################################################################################################

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install git tmux htop gcc g++ make libboost-all-dev openssh-server openssh-client samba smbclient

# configure openssh server, and open ports using ufw
# configure samba server, set password and open ports using ufw

# install hibernate / awake utils (pm-hibernate)
# install nvidia drivers from nvidia (cuda , cudnn )
# update the sleep / awake routines to reset the nvidia drivers on awake as per 999ZZ_nvidia_awake


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
wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
chmod au+x Anaconda3-2019.10-Linux-x86_64.sh
./Anaconda3-2019.10-Linux-x86_64.sh # install conda on a fast hardrive

### Install conda packages into main enviroment ###
conda deactivate
conda install numpy numba tensorboard arrow joblib pandas matplotlib jupyter memory_profiler pyarrow xarray psycopg2 statsmodels scipy scikit-learn dask tqdm sqlalchemy
# install torch as required
conda install pytorch cudatoolkit=10.1 -c pytorch 
pip install itables p3nvml
conda install -c conda-forge jupyter_contrib_nbextensions
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
