zabbix plugins


- configuration: /etc/zabbix/zabbix_agentd.d/*
- scripts: /var/lib/zabbix/bin/*
- visudo: zabbix ALL=(ALL) NOPASSWD: /var/lib/zabbix/bin/user.*
- visudo: disabled -> #Defaults requiretty
