#!/usr/bin/env bash

# set up for me
git config --global user.email firdaus@ieee.org
git config --global user.name $(id -nu)
git config --global credential.helper cache

# customize
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global push.default current
# vim
git config --global core.editor nano
# vimdiff
git config --global diff.tool diff
git config --global merge.tool diff
git config --global difftool.prompt false

# git aliases
git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit"
git config --global alias.lola "log --graph --decorate --pretty=oneline --abbrev-commit --all"
git config --global alias.co checkout

# set up bash aliases; presumes ~/.bashrc sources ~/.bash_aliases
#echo "
#alias glog='git lola'
#alias g='git'
#alias gco='git checkout'
#alias gpo='git push origin'
#alias gpm='git pull origin master'
#alias gcmp='gcm && gpo'
#alias gcd='gco develop'
#alias gb='git branch'
#alias gba='gb -a'
#alias ga='git add'
#alias gai='git add -i'
#alias gap='git add -p'
#alias gc='git commit'
#alias gcm='git commit -m "Checkpoint commit."'
#alias gpush='git push'
#alias gpull='git pull'
#alias gs='git status'
#alias gd='git diff'
#alias gdc='git diff --cached'
#alias gg='git grep -n'
#alias gds='git diff --staged'
#alias gre='git checkout -- '
#alias gus='git reset HEAD'
#alias gll='git lol'
#alias gla='git lola'
#alias gpod='gpo develop'
#alias gpom='gpo master'
# Git FuggedaboutIt (let's push it live)
#alias gfi='git add -A && git commit -m \"Checkpoint.\" && git push'

#gk() {
#                   (gitk > /dev/null 2>&1) &
#   }
#
#" > ~/.git_aliases
