
# see also: http://blog.interlinked.org/tutorials/rsync_time_machine.html
#      and  http://www.sanitarium.net/golug/rsync_backups.html
# rsync -aP --link-dest=PATHTO/$PREVIOUSBACKUP $SOURCE $CURRENTBACKUP
# mv backup.0 backup.1
# rsync -a  --link-dest=../backup.1 source_directory/  backup.0/

# Source and destination

src_dir="/scratchy/Aperture/Vaults"

bkuphost="aethermi@aethermix.com"
bkuproot="/home/aethermi/bkup"
bkupname="vaults"
bkupvers="current"

bkupdest=$bkuphost:$bkuproot/$bkupname/$bkupvers

# o_faking=" -n"
o_syncing="-aKE --partial -x --force "
o_logging="-v --progress --log-file=/slice/var/log/bkup-remote-`date '+%Y%m%d'`.log"
o_sending="--compress --bwlimit=15"
o_speedup="--max-size=2M --cvs-exclude"
o_exclude="--exclude-from=/slice/etc/bkup/rsync-exclude-${bkupname}.txt"

export RSYNC_RSH="ssh -c arcfour -o Compression=no -x "

echo "First pass, small files, on `date`"
rsync   $o_faking $o_syncing $o_sending $o_logging $o_exclude $o_speedup            \
        $src_dir/            $bkupdest/$src_dir/
echo "... done"

o_killing="--delete-after --cvs-exclude" # --delete-excluded   
echo -n "One more pass to pick up everything, and to kill with '$o_killing'..."
date
rsync   $o_faking $o_syncing $o_sending $o_logging $o_exclude            $o_killing \
        $src_dir/            $bkupdest/$src_dir/
echo "Finished on `date`."
