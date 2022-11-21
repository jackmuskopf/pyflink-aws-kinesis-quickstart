FROM ubuntu:22.04

SHELL [ "/bin/bash", "-c"]
WORKDIR /app

# install wget, java, and gcc
RUN apt-get update -y
RUN apt-get install wget build-essential openjdk-8-jre -y

# setup some java things
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
RUN update-alternatives --config java # check java install path && \
    update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-8-openjdk-amd64/bin/java 1

# install miniconda
ENV MINICONDA_HOME=/opt/miniconda3
RUN wget -O miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
RUN bash miniconda.sh -b -u -p $MINICONDA_HOME && \
    rm miniconda.sh
RUN $MINICONDA_HOME/bin/conda init

# https://pythonspeed.com/articles/activate-conda-dockerfile/
RUN $MINICONDA_HOME/bin/conda create -n pyflink-1-13 python=3.8
RUN $MINICONDA_HOME/envs/pyflink-1-13/bin/python -m pip install "apache-flink==1.13.6"

ENV PATH "${PATH}:${MINICONDA_HOME}/bin"


RUN echo "conda activate pyflink-1-13" >> ~/.bashrc
RUN conda activate pyflink-1-13

# CMD conda run -n pyflink-1-13 python -c "import pyflink; print(pyflink)"