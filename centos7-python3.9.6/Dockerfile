FROM centos:7

SHELL [ "/bin/bash", "-c" ]

RUN yum update -y && \
    yum install -y \
    gcc \
    openssl-devel \
    bzip2 \
    bzip2-devel \
    libffi-devel \
    lzma-devel \
    zlib-devel \
    xz-devel \
    readline-devel \
    sqlite \
    sqlite-devel \
    curl \
    tar \
    make \
    centos-release-scl && \
    yum install -y devtoolset-8 

RUN yum install -y gcc gcc-c++ make cmake unzip zlib-devel libffi-devel openssl-devel pciutils net-tools sqlite-devel lapack-devel gcc-gfortran
RUN yum clean all


ARG PYTHON_VERSION=3.9.6
WORKDIR /build

# As soon as NCSA Blue Waters is EOL and no longer needed, switch over to
# centos:8 immediatley.
RUN curl -sLO "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz" && \
    tar -xzf "Python-${PYTHON_VERSION}.tgz" && \
    cd "Python-${PYTHON_VERSION}" && \
    ./configure && \
    make -j"$(($(nproc) - 1))" && \
    make install && \
    printf "\n# For Python 2.7 use 'python2'\n" >> ~/.bashrc && \
    printf "# For Python 2.7 in shebangs use '#!/usr/libexec/platform-python'\n" >> ~/.bashrc && \
    printf "\nsource scl_source enable devtoolset-8\n" >> ${HOME}/.bash_profile

WORKDIR /

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
# As --enable-shared is used put .so files in LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=/usr/local/lib:"${LD_LIBRARY_PATH}"
# Make /usr/local/include/python3.9/Python.h findable by gcc
# c.f. http://gcc.gnu.org/onlinedocs/gcc-4.8.5/gcc/Environment-Variables.html#Environment-Variables
ENV C_INCLUDE_PATH=/usr/local/include/python3.9
ENV CPLUS_INCLUDE_PATH=/usr/local/include/python3.9
# Match official Python docker image environment variables
ENV PYTHON_VERSION="${PYTHON_VERSION}"
# pip version needs to be determined empirically for each CPython
# release as ENV can't be set from RUN output
ENV PYTHON_PIP_VERSION=21.2.4

ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["/bin/bash"]
