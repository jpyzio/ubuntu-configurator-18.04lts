#!/usr/bin/env bash

sudo apt update

### BEGIN Git and tools
sudo apt install --yes git gitk meld tig
### END Git and tools


### BEGIN Git configuration
while [[ -z ${USER_NAME} ]] ; do
    USER_NAME=`input "Git Global - Your name:"`
done

while [[ -z ${EMAIL} ]] ; do
    EMAIL=`input "Git Global - Your Email:"`
done

git config --global user.name "${USER_NAME}"
git config --global user.email "${EMAIL}"

GPG_ID=`gpg --list-secret-keys --with-colons 2> /dev/null | grep '^sec:' | cut --delimiter ':' --fields 5`
if [[ ! -z "${GPG_ID}" ]]; then
    git config --global user.signingkey ${GPG_ID}
    git config --global commit.gpgsign true
fi

echo -e "npm-debug.log\n.DS_Store\nThumbs.db\n.idea/\n*~\n*.log\n/vendor/\n*.tmp" | tee --append ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
### END Git configuration


### BEGIN Git hooks
HOOKS_DIR="${ROOT_DIR}/git_hooks"
USER_GIT_TEMPLATES_DIR="${HOME}/.git-templates"
USER_GIT_HOOKS_DIR="${USER_GIT_TEMPLATES_DIR}/hooks"

git config --global init.templatedir ${USER_GIT_TEMPLATES_DIR}

mkdir --parents ${USER_GIT_HOOKS_DIR}

curl https://cdn.rawgit.com/tommarshall/git-good-commit/v0.6.1/hook.sh > ${USER_GIT_HOOKS_DIR}/commit-msg
cp ${HOOKS_DIR}/* ${USER_GIT_HOOKS_DIR}/

chmod +x ${USER_GIT_HOOKS_DIR}/*
### END Git hooks