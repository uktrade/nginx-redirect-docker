FROM nginx:1.15

ARG ANSIBLE_VERSION=2.7

EXPOSE 443

RUN apt-get update && \
    apt-get install -y gnupg awscli && \
    echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list.d/ansible.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 && \
    apt-get update && \
    apt-get install -y ansible=${ANSIBLE_VERSION}* && \
    apt-get remove --purge --auto-remove -y gnupg && \
    rm -rf /var/lib/apt/lists/*

ENV AWS_DEFAULT_REGION null

COPY scripts /tmp/ansible

WORKDIR /tmp/ansible

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
