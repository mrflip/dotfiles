cd ~/Music/AudioBlogs/FeedReader ; 
wget -r -l1 -H -t1 --cut-dirs=99 -N -np -A.mp3,.rar -erobots=off -nv -X archive -i ~/prefs/mp3blogs2.txt

find ~/Music/AudioBlogs/FeedReader/ -depth -type d -exec rm -f {}/.DS_Store \; -exec rmdir {} \;
find . -type f -size -1000k -exec rm {} \;
