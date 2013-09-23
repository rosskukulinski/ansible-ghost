Ghost Ansible
=============

This repo is a collection of ansible playbooks which can be used to deploy the ghost blogging platform to your own ubuntu-based server. The configuration in this playbook is geared toward a production installation.

It is worth noting that this is currently very much a work in progress. The nginx rules are not great, and the varnish rules are not being used at all yet.

## Getting Started

#### Recommended Specs:

* Operating System: Ubuntu 13.04
* 1gb RAM
* 10GB of disk or more

There are a few things you have to do to get started. The first thing is to copy `vars.yml.example` to `vars.yml`, and fill it in with your own variables.

```bash
cp vars.yml.example vars.yml
vi vars.yml
```

The next step is to do something similar for your inventory file. You'll have to copy `hosts.ini.example` to `hosts.ini` and replace it with a hostname or ip address that you are planning on deploying to.

```bash
cp hosts.ini.example hosts.ini
vi hosts.ini
```

## Deploying!

To kick off a deployment you can run the following:

```bash
ansible-playbook -v -i hosts.ini ghost.yml
```
