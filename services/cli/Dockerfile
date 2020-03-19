FROM ubuntu:xenial
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y subversion git curl wget netcat \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y g++ make perl ruby python libpython2.7 \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo vim nano man libncurses5

#
# create a user (UserID: ${USER} or "developer")
#
ARG USER
ENV user=${USER:-"developer"}
RUN adduser --gecos ",,," --disabled-password $user \
    && passwd -d $user \
    && usermod -G sudo $user \
    && echo $user ALL=NOPASSWD: ALL > /etc/sudoers.d/$user

###
### run custom scripts
###
USER root
WORKDIR /tmp
ADD common/scripts/root ./scripts/common
ADD cli/scripts/root ./scripts/custom
RUN chmod -R +x scripts \
    && sync \
    && ./scripts/common/setup_root.sh \
    && ./scripts/custom/setup_root.sh
WORKDIR /home/$user
ADD common/scripts/user ./scripts/common
ADD cli/scripts/user ./scripts/custom
RUN chown -R $user:$user ./scripts
USER $user
RUN chmod -R +x ./scripts \
    && sync \
    && ./scripts/common/setup_user.sh \
    && ./scripts/custom/setup_user.sh
ENTRYPOINT ["sh", "-c", "./scripts/common/entrypoint.sh"]
