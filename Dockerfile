FROM ubuntu:bionic

ENV LANG="C.UTF-8" LANGUAGE="C.UTF-8" LC_ALL="C.UTF-8" TERM="xterm-256color"

# Unminimize Ubuntu image and install core packages
RUN yes | unminimize \
    && apt-get install -y \
        vim git ctags \
        openjdk-8-jdk-headless maven python3-pip build-essential \
        curl wget ssh ftp telnet nmap whois tcpdump net-tools \
        mariadb-client zip unzip tree w3m \
# Install sbt
    && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
    && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add \
    && apt-get update && apt-get install -y sbt \
# Clean up APT cache
    && apt-get autoremove -y && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
# Set default Java version to 8
    && update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java \
# Install Vim plugins
    && git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/preservim/start/nerdtree \
    && vim -u NONE -c "helptags ~/.vim/pack/preservim/start/nerdtree/doc" -c q \
    && git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/pack/airblade/start/vim-gitgutter \
    && vim -u NONE -c "helptags ~/.vim/pack/airblade/start/vim-gitgutter/doc" -c q \
    && git clone https://github.com/majutsushi/tagbar.git ~/.vim/pack/majutsushi/start/tagbar \
    && vim -u NONE -c "helptags ~/.vim/pack/majutsushi/start/tagbar/doc" -c q \
    && git clone https://github.com/itchyny/lightline.vim.git ~/.vim/pack/itchyny/start/lightline \
    && vim -u NONE -c "helptags ~/.vim/pack/itchyny/start/lightline/doc" -c q \
    && for d in ftdetect indent syntax; do mkdir -p ~/.vim/$d; curl -sS -o ~/.vim/$d/scala.vim https://raw.githubusercontent.com/derekwyatt/vim-scala/master/$d/scala.vim; done

COPY etc/skel/ /root/
COPY etc/skel/ /etc/skel/
COPY etc/ssh/ /etc/ssh/

