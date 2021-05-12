#!/bin/bash
set -e
 
printf "\n\033[0;44m---> Starting the SSH server.\033[0m\n"

# We do this first to ensure sudo works below when renaming the user.
# Otherwise the current container UID may not exist in the passwd database.
eval "$(fixuid -q)"

if [ "${DOCKER_USER-}" ] && [ "$DOCKER_USER" != "$USER" ]; then
  echo "$DOCKER_USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/nopasswd > /dev/null
  # Unfortunately we cannot change $HOME as we cannot move any bind mounts
  # nor can we bind mount $HOME into a new home as that requires a privileged container.
  sudo usermod --login "$DOCKER_USER" ${SSH_MASTER_USER}
  sudo groupmod -n "$DOCKER_USER" ${SSH_MASTER_USER}

  USER="$DOCKER_USER"

  sudo sed -i "/${SSH_MASTER_USER}/d" /etc/sudoers.d/nopasswd
fi
 
sudo service ssh start
sudo service ssh status
 
exec "$@"
