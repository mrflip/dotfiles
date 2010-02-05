
# see also: http://blog.interlinked.org/tutorials/rsync_time_machine.html
#      and  http://www.sanitarium.net/golug/rsync_backups.html
# rsync -aP --link-dest=PATHTO/$PREVIOUSBACKUP $SOURCE $CURRENTBACKUP
# mv backup.0 backup.1
# rsync -a  --link-dest=../backup.1 source_directory/  backup.0/

# Source and destination

src_dir="/Users/flip"
bkuproot="/Volumes/UsersBkup"
bkupname="esplanade"
bkupvers="current"

bkupdest=$bkuproot/$bkupname/$bkupvers

# o_faking=" -n"
o_syncing="-aKE -x --force "
o_logging="-v  " #--progress
LOGFILE=/slice/var/log/bkup-local-`date '+%Y%m%d'`.log
o_sending=""
o_exclude="--exclude-from=/slice/etc/bkup/rsync-exclude-${bkupname}.txt"
RSYNC=/usr/bin/rsync #use the resource fork-enabled rsync

# o_killing="--delete-after  --delete-excluded"
echo -n "Backing up everything into $bkupdest and killing with '$o_killing'..."
( $RSYNC $o_faking $o_syncing $o_sending $o_logging $o_exclude            $o_killing \
        $src_dir/            $bkupdest/$src_dir/ ) 2>&1 >> $LOGFILE


echo "Finished on `date`."
