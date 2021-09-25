#!/bin/sh

echo "Semantic-Release Drone Versão: $VERSAO"


# Validamos se o usuário foi informado
if [ -z "$PLUGIN_USERNAME" ]; then
    echo "###### ALERTA ######"
    echo "Nenhuma credencial fornecida para o repositório ${DRONE_REPO_LINK}"
    echo
    echo "Se o mesmo for um repositório privado, você precisa informar as credenciais."
    echo
    echo "Em caso de duvidas consulte: https://github.com/goudev/semantic-release"
else
    if [ -z "$PLUGIN_PASSWORD" ]; then
        echo "###### ALERTA ######"
        echo "Nenhuma senha fornecida para o repositório ${DRONE_REPO_LINK}"
        echo "Se o mesmo for um repositório privado, você precisa informar as credenciais."
        echo
        echo "Consulta a documentação em:"
        echo "https://github.com/goudev/semantic-release"
        echo
    fi

    echo '[credential "'${DRONE_REPO_LINK}'"]' > ~/.gitconfig
    echo "username = ${PLUGIN_USERNAME}" >> ~/.gitconfig
    echo "echo '${PLUGIN_PASSWORD}'" > ~/.gitpassword
    chmod +x ~/.gitpassword
    export GIT_ASKPASS=~/.gitpassword

    # Seta as credenciais de acesso para o semantic-releas
    export GIT_CREDENTIALS="${PLUGIN_USERNAME}:${PLUGIN_PASSWORD}"
fi

# Valida as configurações de e-mail
if [ -z "${DRONE_GLOBAL_USER_EMAIL}" ]; then
    if [ -z "${DRONE_COMMIT_AUTHOR_EMAIL}" ]; then
        git config --global user.email "git@localhost"
        export GIT_COMMITTER_EMAIL="git@localhost"
        export GIT_AUTHOR_EMAIL="git@localhost"
    else
        git config --global user.email "${DRONE_COMMIT_AUTHOR_EMAIL}"
        export GIT_COMMITTER_EMAIL="${DRONE_COMMIT_AUTHOR_EMAIL}"
        export GIT_AUTHOR_EMAIL="${DRONE_COMMIT_AUTHOR_EMAIL}"
    fi
else
    git config --global user.email "${DRONE_GLOBAL_USER_EMAIL}"
    export GIT_COMMITTER_EMAIL="${DRONE_GLOBAL_USER_EMAIL}"
    export GIT_AUTHOR_EMAIL="${DRONE_GLOBAL_USER_EMAIL}"
fi

# Valida as configurações do nome
if [ -z "${DRONE_GLOBAL_USER_NAME}" ]; then
    if [ -z "${DRONE_COMMIT_AUTHOR_NAME}" ]; then
        git config --global user.name "git"
        export GIT_COMMITTER_NAME="git"
        export GIT_AUTHOR_NAME="git"
    else
        git config --global user.name "${DRONE_COMMIT_AUTHOR_NAME}"
        export GIT_COMMITTER_NAME="${DRONE_COMMIT_AUTHOR_NAME}"
        export GIT_AUTHOR_NAME="${DRONE_COMMIT_AUTHOR_NAME}"
    fi
else
    git config --global user.name "${DRONE_GLOBAL_USER_NAME}"
    export GIT_COMMITTER_NAME="${DRONE_GLOBAL_USER_NAME}"
    export GIT_AUTHOR_NAME="${DRONE_GLOBAL_USER_NAME}"
fi

# Valida a configuração do branch do semantic-release
if [ -z "${PLUGIN_BRANCH}" ]; then
    export BRANCH_NAME="master"
else
    export BRANCH_NAME="${PLUGIN_BRANCH}"
fi
exec "$@"