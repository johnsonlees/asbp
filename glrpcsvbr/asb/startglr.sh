#!/bin/bash
case "$1" in
  start)
        /usr/bin/sleep 30

        if [[ $( cat /var/lib/mysql/grastate.dat | grep 'safe_to_bootstrap: 1' ) = 'safe_to_bootstrap: 1' ]]; then 
            /usr/bin/echo "--jsmk-- CFGFILE safe_to_bootstrap: 1 IN /var/lib/mysql/grastate.dat"    
            /usr/bin/echo "--jsmk-- THIS IS CLUSTER MASTER.... "   
            /usr/bin/echo "--jsmk-- START galera_new_cluster IN glr `date` "   
            /usr/bin/galera_new_cluster  
        else
            /usr/bin/echo "--jsmk-- CFGFILE safe_to_bootstrap: 0 IN /var/lib/mysql/grastate.dat"    
            /usr/bin/echo "--jsmk-- WAIT FOR CLUSTER MASTER"    

            tt=$[$RANDOM % 37  + $RANDOM % 57 + 37 + $( cat /var/log/messages | wc -l ) % 77  ] 
            /usr/bin/echo "--jsmk-- START sleep and wakeup [ $tt sec ] IN glr `date` "   
            /usr/bin/sleep $tt 
            /usr/bin/echo "--jsmk-- START mariadb.service IN glr `date` BEGIN... " 

            /usr/bin/systemctl start mariadb  

            if [ $? != 0 ]; then
                /usr/bin/echo "--jsmk-- START mariadb.service IN glr `date` [ -JUDGE- ] END..... " 
            else
                /usr/bin/echo "--jsmk-- START mariadb.service IN glr `date` END..... " 
            fi

        fi

        exit 0
	;;
  stop)
        pkill -9 loopglr.sh ;
        #tt=$[$RANDOM % 37  + $RANDOM % 27 + $RANDOM % 17 + $RANDOM % 7 ] 
        tt=$[$RANDOM % 57  + $RANDOM % 7 + $( cat /var/log/messages | wc -l ) % 37  ] 
        /usr/bin/echo "--jsmk-- STOP sleep and wakeup [ $tt sec ] IN glr `date` "   
        /usr/bin/sleep $tt
        /usr/bin/echo "--jsmk-- STOP mariadb.service IN glr `date` BEGIN... " 
        /usr/bin/systemctl stop mariadb   
        /usr/bin/echo "--jsmk-- STOP mariadb.service IN glr `date` END..... " 
        if [[ $( cat /var/lib/mysql/grastate.dat | grep 'safe_to_bootstrap: 1' ) = 'safe_to_bootstrap: 1' ]]; then  
            /usr/bin/echo "--jsmk-- CFGFILE safe_to_bootstrap: 1 IN /var/lib/mysql/grastate.dat"   
            /usr/bin/echo "--jsmk-- THIS IS CLUSTER MASTER.... "   
        else
            /usr/bin/echo "--jsmk-- CFGFILE safe_to_bootstrap: 0 IN /var/lib/mysql/grastate.dat"   
            /usr/bin/echo "--jsmk-- THIS IS CLUSTER SLAVE..... "   
        fi

        exit 0
	;;
  status)
        /usr/bin/echo "--jsmk-- STATUS mariadb.service IN glr `date` END..... " 
        if [[ $( cat /var/lib/mysql/grastate.dat | grep 'safe_to_bootstrap: 1' ) = 'safe_to_bootstrap: 1' ]]; then  
            /usr/bin/echo "--jsmk-- STATUS.CFGFILE safe_to_bootstrap: 1 IN /var/lib/mysql/grastate.dat"   
            /usr/bin/echo "--jsmk-- STATUS.THIS IS CLUSTER MASTER.... "   
        else
            /usr/bin/echo "--jsmk-- STATUS.CFGFILE safe_to_bootstrap: 0 IN /var/lib/mysql/grastate.dat"   
            /usr/bin/echo "--jsmk-- STATUS.THIS IS CLUSTER SLAVE..... "   
        fi

	/usr/bin/systemctl status mariadb -l && exit 0 || exit $?
	  ;;
  restart|force-reload)
        #tt=$[$RANDOM % 37  + $RANDOM % 27 + $RANDOM % 17 + $RANDOM % 7 ] 
        tt=$[$RANDOM % 57  + $RANDOM % 7 + $( cat /var/log/messages | wc -l ) % 37  ] 
        /usr/bin/echo "--jsmk-- RESTART sleep and wakeup [ $tt sec ] IN glr `date` "   
        /usr/bin/sleep $tt
        /usr/bin/echo "--jsmk-- RESTART mariadb.service IN glr `date` BEGIN... " 
        /usr/bin/systemctl restart mariadb  
        /usr/bin/echo "--jsmk-- RESTART mariadb.service IN glr `date` END..... " 
        exit 0
	;;
  *)
	echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
	exit 3
	;;
esac

