# Eco Server Deploy Tool

This tool allows you to deploy an Eco gameserver based on the strangeloopgames/eco-game-server docker image.

Their documentation is nonexistant, so this tool was created to easily create a server without the headaches of reverse engineering how this server works.

## Prerequisites

Make, Docker Engine, and docker-compose.

## Usage

In order to prepare persistant volumes, you will need to prepare your configuration files ahead of time. This tool allows you to copy and stage the Configs and Mods for use.

### Get the container's configurations

You will need to get the Configs and Mods content from the container by running the following command:

```bash
ECO_TAG=latest make copy_configs
```

You will now see the `Configs/` and `Mods/` folders populated. Any files you plan on modifying or mods added need to be added to the `conf.d` and `mod.d` folders respectively. After files are staged in the `conf.d` and `mod.d` directory, a `make copy_configs` needs to be ran to stage the `conf.d` and `mod.d` files for server use.

For example, I need to edit the `network.eco` file for my server information. I copy the `network.eco.template` file to my `conf.d` folder and edit it there. Now that the changes are made, I run `make copy_configs` and the `network.eco` file is ready for use.

### Launch the Server

You are now set to run your server!

```bash
ECO_TAG=latest make deploy
```

### Stop the Server

If you need to shut the server down use:

```bash
make stop
```

### Updating the server

Ensure your server is offline.

Identify the docker tag you intend to migrate to.

You will need to run a `make copy_configs` command prior to updating. This will update any files necessary in the `Configs` and `Mods` folder. You may need to update files in `conf.d` and `mod.d`. Keep an eye on which files changed.

Once you are done updating the configuration files, you should be able to point to the new tag and launch the server:

```bash
ECO_TAG=0.9.0.2-some-tag make deploy
```

### Fork Me!

The best way to deploy this is to fork it as a private repository (some configuration contents are sensitive), and commit the changes eco makes to the server files to push.

## Thanks!

It is ultimately up to you how you want to use this software. I hope it helps ease the deployment.
