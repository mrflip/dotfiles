#!/usr/bin/env bash
# Absolute paths please
workname=config-`hostname`-`date "+%Y%m%d"`
workdir=/tmp/config/$workname
destdir=$HOME/.config

#
# create dirs
#
echo "Making a working copy in '$workdir'"
mkdir -p $workdir
echo "Ultimate destination will be '$destdir'"
mkdir -p $destdir

#
# create archive
#
echo "Copying files to '$workdir'"
cd ~
cp --parents -rp \
	bin/			\
	.Xdefaults		\
	.ackrc 			\
	.bash_profile		\
	.bashrc 		\
	.caprc			\
	.colorsrc		\
	.cvsignore		\
	.cvsrc			\
	.dir_colors		\
	.emacs			\
	.enscriptrc		\
	.gitconfig		\
	.history-*/		\
	.inputrc		\
	.irbrc			\
	.mrxvtrc		\
	.plan			\
	.profile 		\
	.project 		\
	.quotes/		\
	.sawfishrc		\
	.toprc			\
	.ssh/authorized_keys2	\
	.ssh/config      	\
	.ssh/publickeys/	\
	.subversion/config	\
	.wget/			\
	.wgetrc			\
    	$workdir
#.emacs.d/		

echo "Creating archive '${workdir}.tar.bz2'"
cd /tmp/config
tar cjf ${workname}.tar.bz2 ${workname}

#
#
#
echo "Movine archive '${workdir}.tar.bz2' to its final resting place"
mv -iv ${workname}.tar.bz2 ${destdir}
