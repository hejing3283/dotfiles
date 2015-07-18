#source ~/.bash_setting_local
source ~/.bash_setting_share
source ~/.bash_setting_alias
umask u=rwx,g=rwx,o=

if [ -e ${HOME}/.bash_setting_local ]; then
	source "${HOME}/.bash_setting_local"
    echo ".bash_setting_local loaded"
fi

if [ -e ${HOME}/.bash_setting_share ]; then
	source "${HOME}/.bash_setting_share"
	echo ".bash_setting_share loaded"
fi
PS1='\e[1;32m[\#] \@ ==> \u@\[\033]0;\h:\W\007\]\h:\W] \e[m\n   ===> '
# Setting PATH for EPD-7.3-2
# The orginal version is saved in .bash_profile.pysave

