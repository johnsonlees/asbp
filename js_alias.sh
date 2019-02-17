#!/bin/bash

alias rdt='rdesktop -g1860x980 -0 -a24 '
alias rto='rdt -rclipboard:PRIMARYCLIPBOARD -rsound:local '
alias rtoadm='rto -uadministrator '
alias rtodsk='rto -rdisk:HomeDsk=/home -rdisk:AllDsk=/media '

alias r72='rtoadm      -pxxxxxxxx 192.168.55.72  & '
alias r97='rtoadm      -pxxxxxxxx 192.168.17.97  & '
alias rh97='rtoadm     -pxxxxxxxx 11x.3.57.xx:59789  & '
alias r101=' rtoadm    -pxxxxxxxx 192.168.30.101 & '
alias r36='  rtoadm    -pxxxxxxxx 192.168.30.36 & '
alias r37='  rtoadm    -pxxxxxxxx 192.168.30.37 & '
alias r50='  rtoadm    -pxxxxxxxx 192.168.30.50 & '
alias r124=' rtodsk    -uadministrator -pxxxxxxxx 192.168.21.124  & '
alias r230=' rto -uhd  -pxxxxxxxx 192.168.30.230 & '
alias rh230='rto -uhd  -pxxxxxxxx 11x.3.57.xx:xxxxx & '

alias ansir=' sudo ansible '
alias updt=' sudo ansible-pull -U https://github.com/johnsonlees/asbp updt.yml '

alias cdf=' cd /home/lee/self/frequently '

alias grepip=' grep -e "[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}" '
alias ms156=' mysql -ursyslog -pxxxxxxxx -h192.168.55.156 -DSyslog '
alias r=' reset '
alias x=' startx & '
