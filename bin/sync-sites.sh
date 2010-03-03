
# parse args

usage="run me as $0 from|to sitename  [go] [... extra rsync args ...] (got $# '$@')"
if [[ $# -lt 2 ]] ; then
    echo "No args: $usage" ; exit
fi
dir=`perl -e "print uc $1"`  ; shift 
remote_name="$1"       ; shift
#echo $dir $remote_name

# source
local_name=`( hostname --long || hostname ) 2>/dev/null`
local_name=${local_name/lab[0-9]*.ma.utexas.edu/math}
local_name=${local_name/coolhand.local/home}
local_name=${local_name/Esplanade.local/home}
local_name=${local_name/esplanade.local/home}
local_name=${local_name/coolhand/home}
local_name=${local_name/box162.bluehost.com/mrflip}
local_name=${local_name/box162.bluehost.com/aethermix}

# destination
if   [[ "${remote_name}" = "math"       ]] ; then remote_host=flip@lab9.ma.utexas.edu
elif [[ "${remote_name}" = "home"       ]] ; then remote_host=flip@mrflip.dyndns.org
elif [[ "${remote_name}" = "mrflip"     ]] ; then remote_host=mrflipco@mrflip.com
elif [[ "${remote_name}" = "vizsage"    ]] ; then remote_host=mrflipco@mrflip.com
elif [[ "${remote_name}" = "aethermix"  ]] ; then remote_host=aethermi@aethermix.com
elif [[ "${remote_name}" = "ae"         ]] ; then remote_host=u35500918@alkalineearth.com
else echo "Don't understand what remote site to contact, damn. $usage"; exit ; fi

# directories
task="${local_name}_${remote_name}"
if   [[ "${task}" = math_home       ]] ; then local_root=$HOME/now/                   ; remote_root="${remote_host}:~/now/"
elif [[ "${task}" = home_math       ]] ; then local_root=$HOME/now/                   ; remote_root="${remote_host}:~/now/"
elif [[ "${task}" = home_vizsage    ]] ; then local_root=$HOME/now/vizsage/website/   ; remote_root="${remote_host}:~/vizsage/"
elif [[ "${task}" = home_mrflip     ]] ; then local_root=$HOME/www/mrflip.com/        ; remote_root="${remote_host}:~/"
elif [[ "${task}" = home_aethermix  ]] ; then local_root=$HOME/www/aethermix.com/     ; remote_root="${remote_host}:~/"
elif [[ "${task}" = home_ae         ]] ; then local_root=$HOME/www/alkalineearth.com/ ; remote_root="${remote_host}:~/ --rsync-path=/kunden/homepages/13/d89705294/htdocs/pub/bin/rsync" ;
else echo "Can't figure out my own host, damn."; exit ; fi

# log and ignore
sync_logd=~/slice/var/log
sync_etcd=~/slice/etc/bkup


#
# rsync params
#
o_syncing="-urtplE --keep-dirlinks --partial --force --copy-unsafe-links "
o_logging="--log-file=${sync_logd}/sync-${remote_name}-`date '+%Y%m%d'`.log -v --progress"
o_sending="--compress"
o_speedup="" # --cvs-exclude" # --max-size=25M
o_exclude="--exclude-from=${sync_etcd}/rsync-exclude-${remote_name}"
o_killing=""
export RSYNC_RSH="ssh -c arcfour -o Compression=no -x "
if [[ "${dir}_${local_name}" = "home_TO" ]] ; then $o_sending="$o_sending --bwlimit=32" ; fi

#
# direction?
#
if   [[ "$dir" = "TO" ]] ; then
    sync_from=${local_root}
    sync_dest=${remote_root}
elif [[ "$dir" = "FROM" ]] ; then
    sync_from=${remote_root}
    sync_dest=${local_root}
else
    echo "No from/to ('${dir}'): $usage" ; exit
fi

#
# KLUDGE
if [[ "${task}_${dir}" = home_ae_TO ]] ; then o_exclude="$o_exclude --exclude=/logs --exclude=/logs-saved --exclude=/archive" ; fi


#
# dry run?
#
if [[ "$1" = "go" ]] ; then shift; freals="FOR REALS" ; fi

cmd="rsync $o_syncing $o_sending $o_speedup $o_killing
      $o_exclude
      $o_logging
      $@
      ${sync_from} ${sync_dest}"

#
# OK do it
#
echo "About to run ${freals-DRY RUN} going FROM ${sync_from}/ TO ${sync_dest}/"
separator="#####################################"
if [[ "$freals" = "FOR REALS" ]] ; then
  echo "$cmd" ; echo "Control-C to cancel."; sleep 2;

  echo $separator ; echo  
  $cmd
  echo; echo $separator
else
  cmd="$cmd --dry-run"
  echo "$cmd";

  echo $separator ; echo 
  $cmd
  echo; echo $separator
  echo "re-run with second arg of 'go' ${@+(in front of other args '${@}') }to do it"
fi   
echo "Finished @ `date` ${freals-DRY RUN} of "; echo "$cmd" 

# see also: http://blog.interlinked.org/tutorials/rsync_time_machine.html
#      and  http://www.sanitarium.net/golug/rsync_backups.html
# rsync -aP --link-dest=PATHTO/$PREVIOUSBACKUP $SOURCE $CURRENTBACKUP
# mv backup.0 backup.1
# rsync -a  --link-dest=../backup.1 source_directory/  backup.0/

