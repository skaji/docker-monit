setup sshd + mysqld + redis-server with monit.

### based on

* http://inokara.hateblo.jp/entry/2014/03/06/005705
* http://knowledge.sakura.ad.jp/tech/1811/

### how

    > git clone git://github.com/shoichikaji/docker-monit
    > cd dockerfile-monit
    > docker build -t TAG .
    > docker run -d -p 10022:22 -p 2812:2812 TAG

Then

    > ssh -p 10022 root@localhost
    # password: root

    > curl http://localhost:2812

### author

Shoichi Kaji

### ps auxwwf

defunct?

```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.1  0.0  40592  2252 ?        Sl   18:23   0:00 /usr/bin/monit -I
root        12  0.0  0.0      0     0 ?        Z    18:23   0:00 [sshd] <defunct>
root        13  0.0  0.0  49900  1248 ?        Ss   18:23   0:00 /usr/sbin/sshd
root        37  0.1  0.1  73304  3664 ?        Ss   18:24   0:00  \_ sshd: root@pts/0
root        49  0.0  0.0  18024  2024 pts/0    Ss   18:24   0:00      \_ -bash
root        60  0.0  0.0  15220  1108 pts/0    R+   18:24   0:00          \_ ps auxwwf
root        15  0.0  0.0      0     0 ?        Z    18:23   0:00 [redis-server] <defunct>
root        16  0.0  0.0  10612  1412 ?        Ss   18:23   0:00 /usr/bin/redis-server /etc/redis/redis.conf
root        18  0.0  0.0      0     0 ?        Z    18:23   0:00 [.mysqld_start] <defunct>
mysql       19  0.1  1.1 447128 42944 ?        Sl   18:23   0:00 /usr/sbin/mysqld
```
