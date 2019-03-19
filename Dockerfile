############################################################
# Dockerfile to run benchexec
# based on Ubuntu
#  By gitclone https://github.com/hbgit/benchexecrun:
#   $ docker build --no-cache -t hrocha/benchexec -f Dockerfile .
#   $ docker run -v /sys/fs/cgroup:/sys/fs/cgroup:rw --name=benchexecrun -it hrocha/benchexecrun /bin/bash 
############################################################

FROM ubuntu:18.04

# Metadata indicating an image maintainer.
MAINTAINER <herberthb12@gmail.com>

ENV REPO_DIR=/home/bench/benchexec_files \
    REPO_TOOLS=/home/bench/benchexec_files/tools

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

# Copy across source files needed for build
RUN mkdir /home/bench/
RUN mkdir ${REPO_DIR}
WORKDIR ${REPO_DIR}
RUN mkdir ${REPO_TOOLS}
ADD / ${REPO_DIR}

RUN ls

# copying tool modules to the benchexec
RUN test -e /usr/local/lib/python3.6/dist-packages/benchexec/tools/map2check.py && echo "OKAY" || cp tool_modules/* /usr/local/lib/python3.6/dist-packages/benchexec/tools/

#RUN svn co https://svn.sosy-lab.org/software/cpachecker/trunk CPAchecker; cd CPAchecker; ant; cd ..
    
