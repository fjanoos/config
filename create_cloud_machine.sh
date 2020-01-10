


# create git credentials file

echo "https://fjanoos:fuckYOU22%21@github.com" >> .git-credentials

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install git tmux htop gcc g++ make libboost-all-dev


# clone the config
git clone https://github.com/fjanoos/config.git

# create the bash file
mv .bashrc .bashrc_org
echo "# FJ's standard setup for gpc machines
####################################################
. ~/config/.bashrc_gpc
" > .bashrc

# create soft links
ln -s config/.gitconfig -t ~
ln -s config/.gitignore -t ~
ln -s config/.git-prompt.sh -t ~
ln -s config/.ipython -t ~
ln -s config/.jupyter -t ~
ln -s config/.tmux.conf -t ~

#  ### setup the ssh keys #######################################

# copy over gpc.ppk into the id_rsa file
echo "-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: DES-EDE3-CBC,35F446BEC3AFB674

WEYgQKGrGNUvswIaYKos1ebdeZ8cAAJPDDfQAsw91bXAesve75A6wfup7APGo9DJ
f0evKAb9PrBJAtelfG+d9QFNKQu6QYrJd4lL2fVkr4aR3MN13PBjAH3c+MA9HR6W
ttHV06P2pTJrJDp5nAwo/ADiZ1NEV7/jFGc6VmMb6Liy/NyT94PZ2jYKBMRaXyA1
ZOlMfwuo8XEFx5lU2Tp6Z3ZX6Z5rNR/ThjTlbUOehZcNwxLV5RF8oywz04nkAmRq
WsU0be33K7ZHdvVkwS9gYjyjKCdb+S+4mfmaxm76vya/9iilYGrW4QebwPxkIDxR
VwX8+OzDV9/I2w7QaJ5lf73PM1L3jIun6YcBEiWQktElKyT36XRi0HfU1BqPzFKi
19uSGwBM4crPgh5+X4LEGhsEfuL7KB4rtmWZWgns03dm34mgZKCqnqr2MICpw2HW
cLKnDk5QDL3PRHVZuwcOFZxjJzDK3Kq83WNcCpPkKAnhcw0/zfjcSFrJLt+MYGRk
6QXsl3ssgJJ1GFTSLFKquyr8hnwyLVmDaY0PoUcLwrfaPSJuv+zKjXWgMKLzF2dU
q0UqAd1xEAuf2N/9VF7IxEqxhrAXXEdnr5zAgUKNnvdPwznoEgsdlfmO9Mt7JGLB
5Bl7r5UUT5+PYsHtdCkL2kTAQklfS1APH3WSbQldwrRar9yZexNm1xOERkNFEMAd
wefzo8yH+hA77jZatJ3yeY9+JOfcGEF7v6RFbj79KXZ5qQaDr16TCBbnw8ARDDhb
r0Ceq6zeJ47CV5ISv2Bd9soIftM8ZeMpJPZbkl4VxcFi/3GBCdWg4LIV8gtZLr1x
xXCcETpyYSVhdIzAxv2/uh7Etyy4e8EMMWGzDl2prybyUn4Rtq0WUvuHQgite2AR
yx3YCOlbsRYj/r7ShuNgLrzxcyz9VUtNdgBa3piRUDCk0/abOIiHCym4tBgV7+ud
2G0tt16JkvRX5o4WaWLfC+NyCzMNFG6oiMpwvKBLt0Lemrwr+2Sj5MTFHPLum6tp
sAzIbG3vo5EfW+NLe+N2+ly/FjuXWaXgu+3dyCd5BTOhXy2pC0uwc6fj8b0pX539
ZQIpfG3viMVm7S4GDMk6IdlN5yJxJA5CoQI8MzzZCqziFHFyu0pvETGriyYqXuC1
FFBzMf4EK/A/Mu6MfnF+skOTDIIF/Lr9seeZQc8/0aiNJbO1IsImiVIE/UhBmfrz
Odyc2BXNCuxLBjBx+l8P7VJjY/Ga8rZ34pvZH780t46Ic0mQVEsjFAJzH1DewQTt
npnmtvKJJnxB5SAUJb1eNhS+gUdd8qMGvEVpQN5fFx9EN9qgU0x3/bVlgMgUsUzw
zmaq8G47MJqwlxhLD35mODenOigoOQBs6j5wTeeEB2tIniOOSCeolSdtI7JvKa5h
VJMA3VNEW1tj8hSOYBvLzlNM4Stm33aKexzMEZZgb6Z1ggZ28B66SEm0w/d7/awp
cKh0bTXKM+iynW5X/e3S/6YW4eunnWysCZNsaKnx3eo/8hksyRCtNpV+BHMA2aOa
37dd2Z2fsxEmo8mupJJ0RHr45unXhJmH29aGVrOIzt4gypdJ8dOqfw==
-----END RSA PRIVATE KEY-----" > ~/.ssh/id_rsa
chmod 0400 id_rsa
# disable password checking for id_rsa
ssh-agent bash
ssh-add ~/.ssh/id_rsa


# copy over code and data from the old machine
export SOURCE_MACHINE=34.69.120.115
SOURCE_HOME='/home/fjanoos/local'

rsync -axrv fjanoos@$SOURCE_MACHINE:$SOURCE_HOME/cloud ~
rsync -axrv fjanoos@$SOURCE_MACHINE:$SOURCE_HOME/collabs ~
rsync -axrv fjanoos@$SOURCE_MACHINE:$SOURCE_HOME/data ~


#################### install other software #########################
mkdir ~/software;  cd ~/software

#### install conda ###
wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
chmod au+x Anaconda3-2019.10-Linux-x86_64.sh
./Anaconda3-2019.10-Linux-x86_64.sh
# install into ~/software/conda

### Install conda packages into main enviroment ###
conda deactivate
#while read requirement; do conda install --yes $requirement; done < conda_requirements.txt 2>error.log
pip install numpy numba torch 
conda install arrow joblib pandas matplotlib jupyter memory_profiler pyarrow
conda install -c conda-forge jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
jupyter nbextension enable codefolding/main
# add any other dependencies ... optional
# conda env create -f ~/config/environment.yml

# install xarray from github
conda uninstall xarray
cd ~/software 
git clone https://github.com/pydata/xarray.git
cd xarray
git pull origin master
python setup.py develop 
# do updates
conda update --all
