FROM eclipse/stack-base:ubuntu
    
RUN sudo apt-get update && \
    sudo apt-get -y install build-essential libssl-dev libkrb5-dev gcc make ruby-full rubygems debian-keyring && \
    sudo gem install sass compass && \
    sudo apt-get clean && \
    sudo apt-get -y autoremove && \
    sudo apt-get -y clean && \
    sudo rm -rf /var/lib/apt/lists/*
    
EXPOSE 8181
ENV USERNAME ""
ENV PASSWORD ""
ADD run_usercommand.sh /tmp/    
RUN wget -qO- https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN sudo apt update && sudo apt -y install nodejs git ncurses-dev wget curl gcc clang 
RUN mkdir /home/user/workspace

# Cloud 9 

RUN cd /opt && \
       sudo git clone https://github.com/c9/core && \
       cd core && \
       sudo /bin/sh -c ./scripts/install-sdk.sh 
       
       
       
USER user
WORKDIR /home/workspace
CMD ["/tmp/run_usercommand.sh"] 
