repo_ps1
========

Extending PS1 to show repository information
**

This script adds information regarding the repository where you're working based on your current directory.

NAME
       __repo_ps1.sh - Get the current GIT/Subversion branch, tag or "trunk"

SYNOPSIS
       __repo_ps1.sh [FORMAT]

DESCRIPTION
       For use with the PS1 or other PS variables in Bash.

       The FORMAT string at the end is optional. If present, it *must* contain
       a valid printf format string including a '%s'. 
       Default: GIT|SVN:branch:hash|revision

       Based on the awesome __git_ps1 && __svn_ps1.

INSTALLATION
       Add the following line to ~/.bashrc:
         PS1="${PS1}\$(__repo_ps1 ' (%s)')"
       or
         PS1="\${debian_chroot:+($debian_chroot)}${HIGREEN}\u@\h${HIBLUE} \w${BLUE}\$(__repo_ps1 '(%s)')${HIBLUE} \$\[\033[00m\] "

       To enable for all users who have bash_completion:
       $ sudo mv __repo_ps1.sh /etc/bash_completion.d/

       If that doesn't work, or you prefer a single user installation, add
       also the following line to ~/.bashrc:
       source /path/to/__repo_ps1.sh

COPYRIGHT
       Copyright © 2010-2011 Victor Engmark. License GPLv3+: GNU GPL
                   2014      Harald Servat
       version 3 or later <http://gnu.org/licenses/gpl.html>.
       This is free software: you are free to change and redistribute it.
       There is NO WARRANTY, to the extent permitted by law.
