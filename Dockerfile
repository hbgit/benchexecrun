############################################################
# Dockerfile to run benchexec
# based on Ubuntu
############################################################

FROM ubuntu:16.10

# Metadata indicating an image maintainer.
MAINTAINER <herberthb12@gmail.com>

ENV REPO_DIR=/home/bench/benchexec_files

# Update the repository sources list
RUN apt-get update

# Packages
RUN apt-get install -y sudo \
    python3-pip

# Clean packages installation
RUN apt-get clean

# Install benchexec
pip3 install benchexec

# checking cgroups with benchexec
python3 -m benchexec.check_cgroups

# Copy across source files needed for build
RUN mkdir ${REPO_DIR}
ADD / ${REPO_DIR}

# copying tool modules to the benchexec
RUN cp -r tool_modules/* /usr/local/lib/python3.5/dist-packages/benchexec/tools/

# Testing if the modules are located
python3 -m benchexec.test_tool_info map2checkllvm






    
