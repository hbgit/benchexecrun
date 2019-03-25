############################################################
# Dockerfile to run benchexec
# based on Ubuntu
#  By gitclone https://github.com/hbgit/benchexecrun:
#   $ docker build --no-cache -t hrocha/benchexecrun -f Dockerfile .
#   $ docker run -v /sys/fs/cgroup:/sys/fs/cgroup:rw --name=benchexecrun -it hrocha/benchexecrun /bin/bash
#   or
#   $ docker run -it --rm -v /sys/fs/cgroup:/sys/fs/cgroup:rw -v $(pwd):/home/benchexec/devel_tool/benchexec_files:Z hrocha/benchexecrun /bin/bash -c "runexec --no-container echo Test"
############################################################

FROM ubuntu:18.04

# Metadata indicating an image maintainer.
MAINTAINER <herberthb12@gmail.com>

# Update the repository sources list
RUN apt-get update

# Packages
RUN apt-get install -y sudo \
    python3-pip \
    git \
    htop \
    wget \
    subversion \
    vim \
    ant \
    default-jre

# Clean packages installation
RUN apt-get clean

# Install benchexec
RUN pip3 install benchexec

RUN useradd -m benchexec && \
    echo benchexec:benchexec | chpasswd && \
    cp /etc/sudoers /etc/sudoers.bak && \
    echo 'benchexec  ALL=(root) NOPASSWD: ALL' >> /etc/sudoers

USER benchexec

RUN mkdir /home/benchexec/devel_tool
WORKDIR /home/benchexec/devel_tool/

#RUN mkdir /home/bench/
#ENV REPO_DIR=/home/bench/benchexec_files \
#    REPO_TOOLS=/home/bench/benchexec_files/tools

RUN mkdir /home/benchexec/devel_tool/benchexec_files
WORKDIR /home/benchexec/devel_tool/benchexec_files
#RUN mkdir ${REPO_TOOLS}
#ADD / ${REPO_DIR}

# copying tool modules to the benchexec
RUN test -e /usr/local/lib/python3.6/dist-packages/benchexec/tools/map2check.py && echo "OKAY" || cp tool_modules/* /usr/local/lib/python3.6/dist-packages/benchexec/tools/

#RUN svn co https://svn.sosy-lab.org/software/cpachecker/trunk CPAchecker; cd CPAchecker; ant; cd ..

RUN sudo chown -R benchexec:benchexec .

VOLUME /home/benchexec/devel_tool/benchexec_files
# Revoke password-less sudo and Set up sudo access for the ``map2check`` user so it
# requires a password
USER root
RUN mv /etc/sudoers.bak /etc/sudoers && \
    echo 'benchexec  ALL=(root) ALL' >> /etc/sudoers
USER benchexec
