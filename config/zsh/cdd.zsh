# vim: ft=zsh
# Eanble `add-zsh-hook`
autoload -Uz add-zsh-hook

# Set current directory (`pwd`) information to cdd
__enable_cdd() {
  _cdd_chpwd && ls
}
add-zsh-hook chpwd __enable_cdd
