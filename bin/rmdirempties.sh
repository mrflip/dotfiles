find "${@-.}" -depth -type d -exec rm -f {}/.DS_Store \; -exec rmdir {} \;
