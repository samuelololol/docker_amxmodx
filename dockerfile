FROM ubuntu:bionic-20191202
RUN dpkg --add-architecture i386; \
    apt update; \
    apt-get update --fix-missing; \
    apt install -y \
        libstdc++-4.8-dev:amd64 \
        build-essential \
        g++-4.8-multilib gcc-4.8-multilib \
        curl wget file tar bzip2 gzip unzip python util-linux ca-certificates \
        binutils bc jq tmux lib32gcc1 cifs-utils openssh-server;\
    echo 'root:podbotmm' | chpasswd;\
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' \
        /etc/ssh/sshd_config; \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' \
        -i /etc/pam.d/sshd;

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
