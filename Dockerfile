FROM ubuntu:14.04

MAINTAINER kterao@slac.stanford.edu

ENV ROOTSYS /usr/local/root
ENV PATH="${ROOTSYS}/bin:${PATH}"
ENV LD_LIBRARY_PATH="${ROOTSYS}/lib:${LD_LIBRARY_PATH}"
ENV PYTHONPATH="${ROOTSYS}/lib:${PYTHONPATH}"

# apt-get
RUN apt-get update && \
    apt-get install -y dpkg-dev \
    	    	       cmake3 \
		       g++ \
		       gcc \
		       binutils \
		       libx11-dev \
		       libxpm-dev \
		       libxft-dev \
		       libxext-dev \
		       libavcodec-dev \
		       libavformat-dev \
		       libgtk2.0-dev \
		       libjasper-dev \
		       libjpeg-dev \
		       libpng-dev \
		       libswscale-dev \
		       libtiff-dev \
		       libtbb2 \
		       pkg-config \
		       python \
		       gfortran \
		       libpcre3-dev \
		       xlibmesa-glu-dev \
		       libglew1.5-dev \
		       libfftw3-dev \
		       graphviz-dev \
		       libldap2-dev \
		       python-dev \
		       python-numpy-dev \
		       libxml2-dev \
		       libgsl0-dev \
		       libqt4-dev \
		       wget \
		       python-pip \
		       git \
		       emacs
# Python
RUN pip install --upgrade setuptools pip
RUN pip install -I --upgrade numpy
RUN pip install -I matplotlib pandas
RUN pip install 'ipython<6.0'
RUN pip install jupyter notebook

# ROOT
RUN mkdir -p /tmp/root && \
    cd /tmp/root && \
    wget https://root.cern.ch/download/root_v6.08.06.source.tar.gz && \
    tar -xzf root_v6.08.06.source.tar.gz && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/root -DGNUINSTALL=ON -Dminuit2:BOOL=ON $PWD/root-6.08.06 && \
    cmake --build . --target install -- -j4 && \
    rm -rf /tmp/root && \
    apt-get autoremove -y && apt-get clean -y

# Directory structure
RUN mkdir /work
RUN mkdir /scratch
RUN mkdir /data
RUN mkdir /app
WORKDIR /work

# Ports
EXPOSE 6006
EXPOSE 8888
