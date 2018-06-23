FROM ubuntu:16.04

# Install the basic
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget

ENV HOME /root
WORKDIR /root

# Install VNC and Interface
RUN apt-get install -y lxde-core lxterminal tightvncserver


# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install Webkit for Browsersupport in Knime
RUN \
	apt-get install -y libwebkitgtk-3.0-0

# Install Knime, 3.5.3 canbe replaced with current versions

ADD http://download.knime.org/analytics-platform/linux/knime_3.5.3.linux.gtk.x86_64.tar.gz /root/
RUN tar -xvf /root/knime_3.5.3.linux.gtk.x86_64.tar.gz -C /root/
RUN mkdir /root/Desktop
RUN chmod +x /root/knime_3.5.3/knime
RUN ln -s /root/knime_3.5.3/knime /root/Desktop/knime

RUN rm -rf /var/lib/apt/lists/*
EXPOSE 5901
CMD ["bash"]
#TO BUILD: sudo docker build -t knime .
#TO RUN: docker run --rm --name knime -p 5901:5901 -e USER=root -i knime /bin/bash -c "vncserver :1 -geometry 1366x768 -depth 24 && tail -F /root/.vnc/*.log"

