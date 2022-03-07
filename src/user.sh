#!/bin/bash
set -e

printf "\n\033[0;44m---> Creating SSH master user.\033[0m\n"

adduser --gecos '' --disabled-password ${SSH_MASTER_USER}
echo "${SSH_MASTER_USER}:${SSH_MASTER_PASS}" | chpasswd
echo 'PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin"' >> /home/${SSH_MASTER_USER}/.profile

echo "${SSH_MASTER_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
# echo "${SSH_MASTER_USER} ALL=NOPASSWD:/bin/mkdir" >> /etc/sudoers
# echo "${SSH_MASTER_USER} ALL=NOPASSWD:/bin/chown" >> /etc/sudoers
# echo "${SSH_MASTER_USER} ALL=NOPASSWD:/usr/sbin/useradd" >> /etc/sudoers
# echo "${SSH_MASTER_USER} ALL=NOPASSWD:/usr/sbin/deluser" >> /etc/sudoers
# echo "${SSH_MASTER_USER} ALL=NOPASSWD:/usr/sbin/chpasswd" >> /etc/sudoers

printf "\n\033[0;44m---> Creating groups \"sftp\" and \"dataman\".\033[0m\n" 
addgroup sftp
addgroup dataman --gid 1005
usermod -aG dataman ${SSH_MASTER_USER}
usermod -g dataman ${SSH_MASTER_USER}

exec "$@"
