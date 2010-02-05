ssh -f flip@lab2.ma.utexas.edu -L 50070:localhost:50070 -N
ssh -f flip@lab2.ma.utexas.edu -L 50030:localhost:50030 -N
echo "Tunnels to datanode status (50070) and tasknode status (50030) set up.  Cheers!"
open http://localhost:50070/
open http://localhost:50030/
