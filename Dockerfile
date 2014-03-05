FROM ubuntu:12.04
MAINTAINER Shoichi Kaji (skaji@cpan.org)

## NOTE: you should disable SELinux

ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://jp.archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update -y --force-yes
RUN apt-get install monit -y --force-yes

ADD monitrc /etc/monit/monitrc
RUN chown root:root /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc
RUN bash -c 'echo "root:root" | chpasswd'

RUN apt-get install openssh-server -y --force-yes
RUN mkdir /var/run/sshd
RUN chown root:root /var/run/sshd
RUN chmod 700 /var/run/sshd
ADD monit.sshd /etc/monit/conf.d/sshd
RUN chown root:root /etc/monit/conf.d/sshd
RUN chmod 700 /etc/monit/conf.d/sshd

ADD debconf-set-selections /root/debconf-set-selections
RUN cat /root/debconf-set-selections | debconf-set-selections; apt-get install mysql-server -y --force-yes
ADD mysqld_start /usr/local/bin/.mysqld_start
RUN chown root:root /usr/local/bin/.mysqld_start
RUN chmod 755 /usr/local/bin/.mysqld_start
ADD monit.mysqld /etc/monit/conf.d/mysqld
RUN chown root:root /etc/monit/conf.d/mysqld
RUN chmod 700 /etc/monit/conf.d/mysqld

RUN apt-get install redis-server -y --force-yes
RUN mkdir /var/run/redis
RUN chown root:root /var/run/redis
RUN chmod 700 /var/run/redis
ADD monit.redis-server /etc/monit/conf.d/redis-server
RUN chown root:root /etc/monit/conf.d/redis-server
RUN chmod 700 /etc/monit/conf.d/redis-server

EXPOSE 22
EXPOSE 2812

CMD ["/usr/bin/monit", "-I"]
