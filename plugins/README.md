zabbix plugins
===

copy *.conf into /etc/zabbix/zabbix_agentd.d/  

(mkdir -p /var/lib/zabbix/bin/)  

(chown -R zabbix:zabbix /var/lib/zabbix)  

copy *.pl into /var/lib/zabbix/bin/



visudo to add line below

`zabbix ALL=(ALL) NOPASSWD: /var/lib/zabbix/bin/user.*`

disable line.

#Defaults requiretty
