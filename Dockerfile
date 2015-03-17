FROM phusion/baseimage:0.9.15
MAINTAINER Wyatt Johnson <wyattjoh@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

RUN add-apt-repository ppa:modriscoll/nzbget
ADD sources.list /etc/apt/
RUN apt-get update -qq
RUN apt-get install -qy nzbget

# Path to a directory that only contains the transmission.conf
VOLUME /config
VOLUME /downloads

# Copy default config
RUN cp /usr/share/nzbget/nzbget.conf /config/nzbget.conf

EXPOSE 6789

# Add transmission to runit
RUN mkdir /etc/service/nzbget
ADD nzbget.sh /etc/service/nzbget/run
RUN chmod +x /etc/service/nzbget/run
