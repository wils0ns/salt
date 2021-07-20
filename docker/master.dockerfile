FROM ubuntu:20.04

ARG SALT_VERSION=3003.1

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y curl tini && \
  curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg \
  https://repo.saltproject.io/py3/ubuntu/20.04/amd64/archive/${SALT_VERSION}/salt-archive-keyring.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] \
  https://repo.saltproject.io/py3/ubuntu/20.04/amd64/archive/${SALT_VERSION} focal main" | \
  tee /etc/apt/sources.list.d/salt.list && \
  apt-get update && apt-get install -y \
  python3-distutils \
  salt-api \
  salt-cloud \
  salt-master \
  salt-minion \
  salt-ssh \
  salt-syndic \
  virt-what && \
  mkdir /var/log/salt/api.d/ -p && \
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
  python3 get-pip.py && \
  python3 -m pip install -U CherryPy pyOpenSSL pyinotify && \
  python3 -m pip uninstall --yes pip && \
  apt-get remove --purge curl python-pip -y && \
  apt-get autoremove -y && apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 4505 4506

COPY ./master.py /entrypoint.py

ENTRYPOINT ["/usr/bin/tini", "--", "python3", "-u", "/entrypoint.py"]
