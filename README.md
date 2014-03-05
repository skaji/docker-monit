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
