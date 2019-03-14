#!/bin/bash
case "$1" in
  start)
        /usr/bin/echo " START galera_new_cluster IN glr `date` "  ; 
        /usr/bin/sleep 30
        /usr/bin/galera_new_cluster  
        tt=$[$RANDOM % 77 + 37] 
        /usr/bin/echo " START sleep and wakeup IN glr $tt `date` "  ; 
        /usr/bin/sleep $tt 
        /usr/bin/echo " START mariadb.service IN glr `date` " ;
        /usr/bin/systemctl start mariadb  
        exit 0
	;;
  stop)
        ps -ef | grep loopglr.sh | grep -Ev 'grep' | awk '{print $2}'  | xargs kill -9
        tt=$[$RANDOM % 37 + $RANDOM % 17 ] 
        /usr/bin/echo " STOP sleep and wakeup IN glr $tt `date` "  ; 
        /usr/bin/sleep $tt
        /usr/bin/echo " STOP mariadb.service IN glr `date` " ;
        /usr/bin/systemctl stop mariadb   
        exit 0
	;;
  status)
	/usr/bin/systemctl status mariadb -l && exit 0 || exit $?
	  ;;
  restart|force-reload)
        tt=$[$RANDOM % 77 + 17] 
        /usr/bin/echo " RESTART sleep and wakeup IN glr $tt `date` "  ; 
        /usr/bin/sleep $tt
        /usr/bin/echo " RESTART mariadb.service IN glr `date` " ;
        /usr/bin/systemctl restart mariadb  
        exit 0
	;;
  *)
	echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
	exit 3
	;;
esac

