#!/usr/bin/env bash

RED="$(tput setaf 1)"
GRN="$(tput setaf 2)"
YEL="$(tput setaf 3)"
RST="$(tput sgr0)"


echo -ne "\n${GRN}${RST} Installing pre-commit hook ..."
cp bin/pre-commit .git/hooks/pre-commit
chmod ug+x .git/hooks/pre-commit

VAULT=.vault-password
if [ -s "${VAULT}" ];then
  echo -ne "\n${GRN}${RST} File ${VAULT} exists and not empty"
  echo -ne "\n\n${GRN}Finished!${RST}"
else
  touch .vault-password
  echo -ne "\n${RED}${RST} File ${VAULT} created but empty"
  echo -ne "\n${RED}Please make sure you add a password to it as content${RST}"
fi


