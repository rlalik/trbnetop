#!/bin/bash

cd $PANDA_TRB_BASEDIR/conf



echo "configure system container"

provide_dhcp=yes
#edit conf/dhcpd.conf, enter your trb3 MAC address ###


### no need to touch the rest of the file ###

if [ $provide_dhcp == "yes" ]; then
  echo starting dhcp server
  cp dhcpd.conf /etc/dhcp/dhcpd.conf
  > /tmp/dhcp_leasefile
  dhcpd -lf /tmp/dhcp_leasefile
  echo ... >> conf_log.txt
  echo dhcp server started >> conf_log.txt
  echo using config file $PANDA_TRB_BASEDIR/conf/dhcpd.conf >> conf_log.txt
  echo >> conf_log.txt
fi
