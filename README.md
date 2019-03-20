# benchexecrun

This repo has a Dockerfile to run benchexec tool (https://github.com/sosy-lab/benchexec), the docker image is based on Ubuntu 18.04. How to use:

$ docker build --no-cache -t hrocha/benchexecrun -f Dockerfile .
$ docker run -v /sys/fs/cgroup:/sys/fs/cgroup:rw -v $(pwd):/benchexecrun/ --name=benchexecrun -it hrocha/benchexecrun /bin/bash
$ docker run -it --rm -v /sys/fs/cgroup:/sys/fs/cgroup:rw -v $(pwd):/benchexecrun/ hrocha/benchexec /bin/bash -c "runexec --no-container echo
