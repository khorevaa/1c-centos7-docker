FROM centos:centos7

# Perform updates
RUN yum -y update; yum clean all

# Install EPEL
RUN yum -y install epel-release; yum clean all

# Install Microsoft's Core Fonts
RUN yum -y install curl cabextract xorg-x11-font-utils fontconfig; yum clean all
RUN rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Install ImageMagick
RUN yum -y install ImageMagick; yum clean all

ADD rpm/*.rpm /tmp/
RUN rpm -Uvh /tmp/*.rpm

COPY logcfg.xml /opt/1C/v8.3/x86_64/conf/

VOLUME /home/usr1cv8
VOLUME /var/log/1C

EXPOSE 1540-1541 1560-1591

ENTRYPOINT ["/opt/1C/v8.3/x86_64/ragent"]