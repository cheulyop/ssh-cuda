# ssh-cuda

Run below command to build and start ssh-able server.
```
$ UID_GID="$(id -u):$(id -g)" docker-compose up -d --build
```

Change `SSH_MASTER_USER` and `SSH_MASTER_PASS` in `.env` to set new user name and password.

## References

[Creating a SSH and SFTP server with docker compose](http://www.inanzzz.com/index.php/post/6fa7/creating-a-ssh-and-sftp-server-with-docker-compose)

[cdr / code-server](https://github.com/cdr/code-server)
- https://github.com/cdr/code-server/blob/main/ci/release-image/Dockerfile
- https://github.com/cdr/code-server/blob/main/ci/release-image/entrypoint.sh

[ufoym / deepo](https://github.com/ufoym/deepo)
