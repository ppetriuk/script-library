#!/bin/bash
# Script that cleans up OpenStack resources from the tenant that had KaaS deployed


# *NOTE*: This scripts expects that you sorced your .rc file

if [ -z "$OS_PROJECT_NAME" ];
then
    echo "You have no sourced your .rc file!"
    echo "I refuse to run!"
    exit 35
fi

for lb in `openstack loadbalancer list -c id -f value --project $OS_PROJECT_NAME`; do openstack loadbalancer pool list -c id -f value --loadbalancer $lb >> pools.txt; done
while read p; do echo "Deleting $p"; openstack loadbalancer pool delete $p; done < pools.txt

for lbl in `openstack loadbalancer listener list -c id -f value --project $OS_PROJECT_NAME`; do echo "Deleting LBL $lbl"; openstack loadbalancer listener delete $lbl; done

for lb in `openstack loadbalancer list -c id -f value --project $OS_PROJECT_NAME`; do echo “Deleting $lb”; openstack loadbalancer delete $lb; done

for sg in `openstack security group list --project $OS_PROJECT_NAME -c Name -f value | grep kaas-sg`; do openstack security group delete $sg; done

for s in `openstack server list |grep kaas-node-|awk '{ print $2 }'`; do openstack server delete $s; done

for r_name in `openstack router list --project $OS_PROJECT_NAME -c Name -f value | grep kaas-router-`; do echo processing router $r_name; openstack router set --disable --no-ha  $r_name; openstack router unset --external-gateway $r_name; sleep 5; for interface in `openstack router show -c interfaces_info -f value $r_name | cut -d'"' -f12`; do openstack router remove port $r_name $interface; done; openstack router delete $r_name; done

for net in `openstack network list -c Name -f value --project $OS_PROJECT_NAME | grep kaas-net-`; do echo "Deleting network $net"; openstack network delete $net; done

for ip in `openstack floating ip list --project $OS_PROJECT_NAME -c ID -c "Fixed IP Address" | grep None | cut -d'|' -f 2`; do echo "Releasing FIP $ip"; openstack floating ip delete $ip; done
