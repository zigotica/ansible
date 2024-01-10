decrypt:
	ansible-vault decrypt --vault-password-file .vault-password playbooks/vars/vault.yml

encrypt:
	ansible-vault encrypt --vault-password-file .vault-password playbooks/vars/vault.yml

