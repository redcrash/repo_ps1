#!/bin/sh
#
# NAME
#        __repo_ps1.sh - Get the current GIT/Subversion branch, tag or "trunk"
#
# SYNOPSIS
#        __repo_ps1.sh [FORMAT]
#
# DESCRIPTION
#        For use with the PS1 or other PS variables in Bash.
#
#        The FORMAT string at the end is optional. If present, it *must* contain
#        a valid printf format string including a '%s'. 
#        Default: GIT|SVN:branch:hash|revision
#
#        Based on the awesome __git_ps1 && __svn_ps1.
#
# INSTALLATION
#        Add the following line to ~/.bashrc:
#          PS1="${PS1}\$(__repo_ps1 ' (%s)')"
#        or
#          PS1="\${debian_chroot:+($debian_chroot)}${HIGREEN}\u@\h${HIBLUE} \w${BLUE}\$(__repo_ps1 '(%s)')${HIBLUE} \$\[\033[00m\] "
#
#        To enable for all users who have bash_completion:
#        $ sudo mv __repo_ps1.sh /etc/bash_completion.d/
#
#        If that doesn't work, or you prefer a single user installation, add
#        also the following line to ~/.bashrc:
#        source /path/to/__repo_ps1.sh
#
# COPYRIGHT
#        Copyright © 2010-2011 Victor Engmark. License GPLv3+: GNU GPL
#                    2014      Harald Servat
#        version 3 or later <http://gnu.org/licenses/gpl.html>.
#        This is free software: you are free to change and redistribute it.
#        There is NO WARRANTY, to the extent permitted by law.
#
################################################################################

__repo_ps1()
{
	while test "${PWD}" != "/" ;
	do
		if [[ -d .svn ]] || [[ -d .git ]] ; then
			break
		fi
		cd ..
	done

    if [[ -d .svn ]]; then
		IFS='/' read -ra parts <<< "$(svn info 2>/dev/null | grep ^URL:)"
		for i in "${parts[@]}" ; do
			if [[ "${branch}" != "branches" ]] && [[ "${branch}" != "tags" ]] ; then
				if [[ "${i}" == "trunk" ]] ; then
					branch="${i}"
					break;
				elif [[ "${i}" == "branches" ]] || [[ "${i}" == "tags" ]] ; then
					branch="${i}"
				fi
			else
				branch="${branch}:${i}"
				break
			fi
		done

   		revision=$(svn info 2>/dev/null | grep ^Revision: | cut -d" " -f 2)
		if [[ -n "${revision}" ]] ; then
			echo " SVN:"${branch##:-\*}:${revision}
		fi
	elif [[ -d .git ]]; then
		branch="$(git symbolic-ref HEAD 2> /dev/null)";
		hsh="$(git log -1 --oneline 2> /dev/null | cut -c1-7)";
		if [[ -n "${branch}" ]]; then
			echo " GIT:"${branch##refs/heads/}:${hsh}
		fi
	fi
}
