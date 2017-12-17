FROM phusion/baseimage
MAINTAINER Abdi Darmawan <abdid46@gmail.com>

### ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

### setup
ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

### Upgrade Ubuntu Images Package
#RUN DEBIAN_FRONTEND="noninteractive" apt-get update
#RUN DEBIAN_FRONTEND="noninteractive" apt-get -y upgrade
#RUN DEBIAN_FRONTEND="noninteractive" apt-get update --fix-missing


### Set the timezone Asia/Jakarta
RUN timedatectl set-timezone Asia/Jakarta



##### Config ######

### Add crontab file in the cron directory
ADD crontab /etc/cron.d/jedi-cron

### Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/jedi-cron

### Create the log file to be able to run tail
RUN touch /var/log/cron.log

### Run the command on container startup
CMD cron && tail -f /var/log/cron.log
