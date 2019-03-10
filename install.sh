#!/bin/bash

GIT=$(which git)
VIM=$(which vim)
CURL=$(which curl)
CP=$(which cp)
RM=$(which rm)
MKDIR=$(which mkdir)

VIM_PATH="${HOME}/.vim"

VUNDLE_GITHUB="https://github.com/VundleVim/Vundle.vim.git"
VUNDLE_VIM_PATH="${HOME}/.vim/bundle/Vundle.vim"

LUNA_SCHEME_GITHUB="https://github.com/notpratheek/vim-luna.git"
LUNA_TMP_PATH="/tmp/vim-luna/"

LOCAL_BINARIES="${HOME}/bin"

if [ -z $GIT ]; then
    echo "Error: Git needs to be installed"
    exit 1
fi

if [ -z $VIM ]; then
    echo "Error: Vim needs to be installed"
    exit 1
fi

if [ -z $CURL ]; then
    echo "Error: curl eeds to be installed"
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

read -p "Would you like to install extra features? (root access needed)[Y/y]: " install_extra

if [[ "$install_extra" =~ ^(y|Y)$ ]]; then

    if [[ ! -d "$LOCAL_BINARIES" ]];then
        mkdir -p $LOCAL_BINARIES
    fi

    ## Install universal-ctags
    CTAGS=$(which ctags)
    CTAGS_PATH="$LOCAL_BINARIES/ctags"
    if [[ ! -f "$CTAGS_PATH" ]]; then
        echo "Installing universal-ctags..."
        $GIT clone -q git@github.com:universal-ctags/ctags.git ctags-repo
        cd ctags-repo
        ./autogen.sh > /dev/null
        ./configure > /dev/null
        make > /dev/null
        mv ctags "$CTAGS_PATH"
        cd ..
        rm -rf ctags-repo
    fi

    PHP_CS_FIXER=$(which php-cs-fixer)
    PHP_CS_FIXER_PATH="$LOCAL_BINARIES/php-cs-fixer"
    if [[ ! -f "$PHP_CS_FIXER_PATH" ]]; then
        echo "Installing php-cs-fixer...."
        $CURL -L -s https://cs.symfony.com/download/php-cs-fixer-v2.phar -o php-cs-fixer
        chmod a+x php-cs-fixer
        mv php-cs-fixer "$PHP_CS_FIXER_PATH"
    fi
fi

echo "Done!"
echo "Your vim is ready to use"
