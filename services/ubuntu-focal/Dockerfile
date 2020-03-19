FROM ubuntu:focal
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y subversion git curl wget netcat \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y g++ make perl ruby \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo vim nano man

#
# create a user (UserID: ${USER} or "developer")
#
ARG USER
ENV user=${USER:-"developer"}
RUN adduser --gecos ",,," --disabled-password $user \
    && passwd -d $user \
    && usermod -G sudo $user \
    && echo $user ALL=NOPASSWD: ALL > /etc/sudoers.d/$user \
    && echo Set disable_coredump false > /etc/sudo.conf

###
### run custom scripts
###
USER root
WORKDIR /tmp
ADD common/scripts/root ./scripts/common
ADD ubuntu-focal/scripts/root ./scripts/custom
RUN chmod -R +x scripts \
    && sync \
    && ./scripts/common/setup_root.sh \
    && ./scripts/custom/setup_root.sh
WORKDIR /home/$user
ADD common/scripts/user ./scripts/common
ADD ubuntu-focal/scripts/user ./scripts/custom
RUN chown -R $user:$user ./scripts
USER $user
RUN chmod -R +x ./scripts \
    && sync \
    && ./scripts/common/setup_user.sh \
    && ./scripts/custom/setup_user.sh
ENTRYPOINT ["sh", "-c", "./scripts/common/entrypoint.sh"]
