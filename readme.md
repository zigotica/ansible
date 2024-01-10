# Ansible recipes

These recipes are used to manage homelab and servers at home. Feel free to copy and reuse, but run at your own risk.

## Clone in new machine

I actually use [this shell script](https://github.com/zigotica/automated-desktop-setup) to automate my desktop setup. One of the options is actually cloning this repo.

## obscure hostnames, IPs, ...

Please note, I am keeping my internal container IPs and other variables inside an encrypted file at `playbooks/vars/vault.yml`. I keep my hostnames private by using a dynamic inventory file that fetches the hostnames from shell variables `$HOMELAB_HOST_MAIN` and `$HOMELAB_HOST_FALLBACK`.

The file `.vault-password` includes the password that will be used to encrypt/decrypt the vault file. It is git ignored, so it stays local.

A git hook is used to avoid inadvertently pushing secrets to the remote repository. You MUST run `./bin/setup.sh` from project folder, in order to setup the hook and create a password file.

## encrypt/decrypt using ansible-vault

Makefile includes aliases to encrypt/decrypt. Process as follows:

```bash
make encrypt

```

to encrypt the file so it's safe to push to public repo. In order to decrypt,

```bash
make decrypt
``````

## Execute playbooks

### Password file

Finally, to use the playbooks inside the ansible project, run them using `ansible-playbook` and parameters. Most of the playbooks require vault password to get the values of the encrypted vars inside the `playbooks/vars/vault.yml` file. Use:

```bash
ansible-playbook ./playbooks/role/name.yml --vault-password-file .vault-password
```

### sudo escalation for admin tasks

Admin tasks require sudo escalaton. We will need to first modify the sudoers file in the target servers, by running the ssh playbook using the `-K` param:

```
ansible-playbook ./playbooks/admin/00-ssh.yml --vault-password-file .vault-password -K
```

This playbook has a task that removes the need of the password for a specific user. From that moment on, we can run all tasks that require `sudo` without any password nor the `-K` param (we still need the `--vault-password-file` to get the encrypted vault vars):

```bash
ansible-playbook ./playbooks/admin/40-upgrade.yml --vault-password-file .vault-password
```

Feel free to add more recipes into the Makefile.
