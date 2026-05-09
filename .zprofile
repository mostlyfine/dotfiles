eval "$(/opt/homebrew/bin/brew shellenv)"

if (( ${+commands[keychain]} )) && [ -f ~/.keychain/${HOST:-$(hostname)}-sh ]; then
  keychain -q ~/.ssh/id_ed25519 ~/.ssh/id_rsa > /dev/null 2>&1
  source ~/.keychain/${HOST:-$(hostname)}-sh
fi

if [[ -n "$SSH_AUTH_SOCK" && "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ]]; then
  ln -snf $SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
  export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
fi
