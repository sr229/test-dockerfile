# Copyright (c) 2012-2016 Codenvy, S.A.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# Contributors:
# Codenvy, S.A. - initial API and implementation

FROM eclipse/stack-base:debian

RUN sudo apt-get update && \
    sudo apt-get -y install build-essential libkrb5-dev gcc make ruby-full rubygems debian-keyring python-software-properties software-properties-common apt-utils && \
    sudo gem install sass compass && \
    sudo apt-get clean && \
    sudo add-apt-repository ppa:jonathonf/python-3.6 && \
    sudo apt update && \
    sudo apt -y install python3.6 && \
    sudo rm -rf /usr/bin/python3 && \
    sudo ln -s /usr/bin/python3.6 /usr/bin/python3 && \
    sudo apt -y install python3-pip && \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install pytest && \
    python3 -m pip install flake8 pylint && \
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

RUN wget -qO- https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN sudo apt update && sudo apt -y install nodejs

EXPOSE 1337 3000 4200 5000 9000 8003
RUN sudo npm install --unsafe-perm -g gulp bower grunt grunt-cli yeoman-generator yo generator-angular generator-karma generator-webapp
LABEL che:server:8003:ref=angular che:server:8003:protocol=http che:server:3000:ref=node-3000 che:server:3000:protocol=http che:server:9000:ref=node-9000 che:server:9000:protocol=http
