#!/bin/bash

GIT=$(which git)
VIM=$(which vim)
CP=$(which cp)
RM=$(which rm)
MKDIR=$(which mkdir)

VIM_PATH="${HOME}/.vim"

VUNDLE_GITHUB="https://github.com/VundleVim/Vundle.vim.git"
VUNDLE_VIM_PATH="${HOME}/.vim/bundle/Vundle.vim"

LUNA_SCHEME_GITHUB="https://github.com/notpratheek/vim-luna.git"
LUNA_TMP_PATH="/tmp/vim-luna/"

if [ -z $GIT ]; then
    echo "Error: Git needs to be installed"
    exit 1
fi

if [ -z $VIM ]; then
    echo "Error: Vim needs to be installed"
    exit 1
fi

# Create vim directory structure
if [ ! -d $VIM_PATH ]; then
    echo "Creating .vim directories..."
    $MKDIR $VIM_PATH
    $MKDIR "${VIM_PATH}/colors"
    $MKDIR "${VIM_PATH}/bundle"
fi

# Get vundle
if [ ! -d "$VUNDLE_VIM_PATH" ]; then
    echo "Downloading vundle..."
    $GIT clone --quiet $VUNDLE_GITHUB $VUNDLE_VIM_PATH
fi

# Get luna color scheme
# echo "Downloading luna color scheme..."
# $GIT clone --quiet $LUNA_SCHEME_GITHUB $LUNA_TMP_PATH
# if [ -d $LUNA_TMP_PATH ] && [ -d "${LUNA_TMP_PATH}colors" ]; then
#     $CP ${LUNA_TMP_PATH}colors/* ${VIM_PATH}/colors/
# else
#     echo "Warning: luna color scheme could not be downloaded"
# fi

# Copy vimrc to home
$CP ./vimrc ${HOME}/.vimrc

# Install Vundle plugins
echo "Installing plugins...."
$VIM +PluginInstall +qall

# Remove temp files
# $RM -rf $LUNA_TMP_PATH

echo "Done!"
echo "Your vim is ready to use"
