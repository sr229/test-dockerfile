# Copyright (c) 2012-2016 Codenvy, S.A.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# Contributors:
# Codenvy, S.A. - initial API and implementation

FROM eclipse/stack-base:ubuntu
ENV NODE_VERSION=7.7.3 \
    NODE_PATH=/usr/local/lib/node_modules
    
RUN sudo apt-get update && \
    sudo apt-get -y install build-essential libssl-dev libkrb5-dev gcc make ruby-full rubygems debian-keyring && \
    sudo gem install sass compass && \
    sudo apt-get clean && \
    sudo apt-get -y autoremove && \
    sudo apt-get -y clean && \
    sudo rm -rf /var/lib/apt/lists/* 

RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    56730D5401028683275BD23C23EFEFE93C4CFFFE \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

RUN wget -qO- https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN sudo apt update && sudo apt -y install nodejs git ncurses-dev wget curl gcc clang 
RUN mkdir /home/user/workspace

# Cloud 9 

RUN cd /opt && \
       sudo git clone https://github.com/c9/core && \
       cd core && \
       sudo /bin/sh -c ./scripts/install-sdk.sh \
       
CMD ["/usr/sbin/sshd", "-p 22", "-D", "&&", "/usr/bin/nodejs", "/opt/core/server.js", "--auth" "user:cloud9"]

EXPOSE 8181 22
