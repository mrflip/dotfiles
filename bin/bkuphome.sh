
# see also: http://blog.interlinked.org/tutorials/rsync_time_machine.html
#      and  http://www.sanitarium.net/golug/rsync_backups.html
# rsync -aP --link-dest=PATHTO/$PREVIOUSBACKUP $SOURCE $CURRENTBACKUP
# mv backup.0 backup.1
# rsync -a  --link-dest=../backup.1 source_directory/  backup.0/

# Source and destination

bkuphost="aethermi@aethermix.com"
bkuproot="/home/aethermi/bkup"
bkupname="esplanade"
bkupvers="current"
# o_faking=" --dry-run"
o_syncing="-aKE --partial -x --force "
o_logging="-v --progress --log-file=/slice/var/log/bkup-remote-`date '+%Y%m%d'`.log"
o_sending="--compress --bwlimit=15"
o_speedup="--max-size=25M --cvs-exclude"
export RSYNC_RSH="ssh -c arcfour -o Compression=no -x "

#
# ics
#
src_dir="/work/ics"
bkupdest=$bkuphost:$bkuproot/$bkupname/$bkupvers
o_exclude="--exclude-from=/slice/etc/bkup/rsync-exclude-ics.txt" # code/  data/  dump@  fiddles/  fixd@  huge/  imw@  infochimps/  load@  log/  oldsite/  pkgd@  pool@  rawd@  ripd@  ruby_gems@  site/  working

o_killing="--delete-after" # --cvs-exclude" # --delete-excluded   
echo "`date`: Backing up ${src_dir} then killing remote with '$o_killing'... "
cmd="rsync   $o_faking $o_syncing $o_sending $o_logging $o_exclude            $o_killing "$@" $src_dir/ $bkupdest/$src_dir/"
echo $cmd ; $cmd
echo "Finished on `date`."
o_killing=''

#
# home
#
src_dir="/Users/flip"
bkupdest=$bkuphost:$bkuproot/$bkupname/$bkupvers
o_exclude="--exclude-from=/slice/etc/bkup/rsync-exclude-${bkupname}.txt"

echo "Backing up main subdirectories on `date`"
for dir in now	bin	 	 	 	 	 \
	 	Papers	Projects Classes research Play	 \
 		Pix	Photos	Movies	                 \
 		www	Sites	Mail			 \
		Library	Public	Prefs # Desktop foo
  do
  echo;  echo "===================================================================="; echo
  echo -n "    `date`: $dir: "
  rsync    $o_faking $o_syncing $o_sending $o_logging $o_exclude $o_speedup            "$@"      \
           $src_dir/"$dir"/     $bkupdest/$src_dir/"$dir"/
done;
echo "... done"

o_killing="--delete-after" # --cvs-exclude" # --delete-excluded   
echo "`date`: One more pass to pick up everything, and to kill with '$o_killing'..."
cmd="rsync $o_faking $o_syncing $o_sending $o_logging $o_exclude            $o_killing "$@" \
           $src_dir/            $bkupdest/$src_dir/"
echo $cmd ; $cmd
echo "Finished on `date`."
o_killing=''
