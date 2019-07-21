#--------------------------------
# FJ common bash configuration
#--------------------------------

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

. ~/config/.bashrc_common
. ~/config/.bashrc_aliases
. ~/config/.git_aliases
. ~/config/.git_aliases

#chang the directory color on oakley
export LS_COLORS=$LS_COLORS'di=0;31:'

alias notebook='jupyter notebook --ip=*'

. ~/config/.bashrc_gpc

