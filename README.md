capbash-phoenix
==============

Scripts for installing [phoenix](https://github.com/phoenixframework/phoenix), should be used in conjunction with capbash

# How to Install #

Install capbash first, more details at:
https://github.com/capbash/capbash

```
curl -s https://raw.githubusercontent.com/capbash/capbash/master/capbash-installer | bash
capbash new YOUR_REPO_ROOT
cd YOUR_REPO_ROOT
```

Now you can install phoenix into your project

```
capbash install phoenix
```

# Configurations #

The available configurations include:

```
ELIXIR_VEION=${ELIXIR_VERSION-v1.0.0-rc2}
PHOENIX_NAME=${PHOENIX_NAME-samplephoenix}
PHOENIX_LAUNCHER_DIR=${PHOENIX_LAUNCHER_DIR-/var/local/apps/${PHOENIX_NAME}}
PHOENIX_REPO=${PHOENIX_REPO-git@github.com:capbash/samplephoenix.git}
PHOENIX_HTTP_PORT=${PHOENIX_PORT-80}
PHOENIX_SSL_PORT=${PHOENIX_PORT-443}
```


# Deploy to Remote Server #

To push the phoenix script to your server, all you need if the IP or hostname of your server (e.g. 192.167.0.48) and your root password.

```
capbash deploy <IP> phoenix
```

For example,

```
capbash deploy 127.0.0.1 phoenix
```
