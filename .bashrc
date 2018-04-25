#--------------------------------
# FJ common bash configuration
#--------------------------------

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

. ~/config/.bashrc_common
. ~/config/.bashrc_aliases
. ~/config/.git_aliases

#chang the directory color on oakley
export LS_COLORS=$LS_COLORS'di=0;31:'

export GLIBC=$HOME/software/glibc-2.23
export PATH=$HOME/software/cuda-7.5/bin:/nfs/09/osu5388/anaconda3/bin:$HOME/software/bin:$PATH
export CUDA_HOME=$HOME/software/cuda-7.5
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$HOME/software/lib:$HOME/software/lib64:$LD_LIBRARY_PATH
export LD_RUN_PATH=$CUDA_HOME/lib64:$HOME/software/lib:$HOME/software/lib64:$LD_RUN_PATH

alias notebook='jupyter notebook --ip=*'
alias tf='source activate tf0.10.0'

. ~/config/.git_aliases

#------------------------------------------
#  interactive jobs
#-------------------------------------------

function ijob()
{
    echo 'walltime='$1:00:00
    qsub -I -X -l nodes=1:ppn=12:gpus=2 -l walltime=$1:00:00 -l mem=64GB
}

alias sis='qsub -I -l nodes=1:ppn=12:gpus=2:vis'

alias beast='ssh firdaus@69.46.234.57'

# added by Anaconda3 4.2.0 installer
export PATH="/home/fj/anaconda3/bin:$PATH"
