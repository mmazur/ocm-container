#FROM ocm-container
FROM fedora:latest
LABEL maintainer="Mariusz Mazur <mmazur@redhat.com>"

ENV I_AM_IN_CONTAINER="I-am-in-container"


# Don't use updates repo (or anything other than base)
RUN sh -c 'sed -e "s,^enabled=.$,enabled=0," -i /etc/yum.repos.d/fedora-*.repo' \
    && dnf install -y \
    bash-completion \
    findutils \
    fzf \
    git \
    jq \
    make \
    procps-ng \
    python3-pip \
    rsync \
    sshuttle \
    unzip \
    vim-enhanced \
    wget \
    && dnf clean all


ARG osv4client=openshift-client-linux-4.3.12.tar.gz
ARG rosaversion=v0.1.3
ARG awsclient=awscli-exe-linux-x86_64.zip
ARG osdctlversion=v0.3.0
ARG veleroversion=v1.5.2
ARG ocmversion=v0.1.45

COPY container-setup /container-setup

WORKDIR /container-setup/install
RUN ./install-rosa.sh
RUN ./install-ocm.sh
RUN ./install-oc.sh
RUN ./install-aws.sh
RUN ./install-kube_ps1.sh
RUN ./install-osdctl.sh
RUN ./install-velero.sh

WORKDIR /container-setup/utils
ENV PATH "$PATH:/root/utils"
RUN ./install-utils.sh && rm -rf /container-setup

WORKDIR /root
ENTRYPOINT ["/bin/bash"]
