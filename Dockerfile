FROM ubuntu:18.04

RUN apt-get update --quiet \
    && apt-get install --assume-yes --no-install-recommends \
        \
        # Base
        build-essential \
        ca-certificates \
        make \
        cmake \
        moreutils \
        zlib1g-dev \
        gnupg \
        \
        # Utilities
        vim \
        bash-completion \
        git \
        httpie \
        jq \
        zip \
        unzip \
        screen \
        sudo \
        curl \
        wget \
        \
        # htslib deps
        libcurl4-openssl-dev \
        libbz2-dev \
        liblzma-dev

# Python
RUN apt-get install --assume-yes --no-install-recommends \
        python3.8-dev \
        python3-pip \
    && python3.8 -m pip install --upgrade pip setuptools wheel \
    && update-alternatives --install /usr/bin/python3 python /usr/bin/python3.8 1

# Address locale problem, see "Python 3 Surrogate Handling":
# http://click.pocoo.org/5/python3/
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

# build bcftools
RUN git clone -b xbrianh-readers-idx https://github.com/xbrianh/htslib.git
RUN git clone -b xbrianh-omit-index https://github.com/xbrianh/bcftools.git
RUN (cd bcftools && make)
RUN (cd bcftools && make install)

# terra-notebook-utils
RUN pip3 install wheel
RUN pip3 install --upgrade --no-cache-dir git+https://github.com/DataBiosphere/terra-notebook-utils.git@xbrianh-vcf-samtools

# Create a user
ARG XVCFMERGE_USER
RUN groupadd -g 999 ${XVCFMERGE_USER} && useradd --home /home/${XVCFMERGE_USER} -m -s /bin/bash -g ${XVCFMERGE_USER} -G sudo ${XVCFMERGE_USER}
RUN bash -c "echo '${XVCFMERGE_USER} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
USER ${XVCFMERGE_USER}
WORKDIR /home/${XVCFMERGE_USER}
ENV PATH /home/${XVCFMERGE_USER}/bin:${PATH}

COPY files/merge_vcfs.py /home/${XVCFMERGE_USER}
