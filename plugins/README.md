zabbix plugins
===

save *.conf

    # cp *.conf /etc/zabbix/zabbix_agentd.d/

save *.pl

    # mkdir -p /var/lib/zabbix/bin/
    # cp *.pl /var/lib/zabbix/bin/
    # chown -R zabbix:zabbix /var/lib/zabbix
    # chmod +x /var/lib/zabbix/bin/user.*.pl

visudo to append line
```
# visudo
zabbix ALL=(ALL) NOPASSWD: /var/lib/zabbix/bin/user.*
```

insert # to disable [requiretty].

    #Defaults requiretty

zabbix-agent must be restarted.

    # service zabbix-agent restart
