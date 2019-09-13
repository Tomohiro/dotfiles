# vim: ft=zsh

# __is_installed checks install status the specified command
function __is_installed() {
  # Add zplug path to search command temporarily
  PATH=$PATH:/usr/local/opt/zplug/bin
  type $1 &> /dev/null
}

# __is_exists_or_create find a path or create it
function __is_exists_or_create() {
  if [ ! -d $1 ]; then
    mkdir -p $1
  fi
}

# Disable loading global profiles for OS X El Capitan.
#   - http://mattprice.me/2015/zsh-path-issues-osx-el-capitan/
setopt no_global_rcs

# Add Homebrew directories to the `$PATH`
PATH=/usr/local/bin:/usr/local/sbin:$PATH
[ -d /opt/X11/bin ] && PATH=/opt/X11/bin:$PATH

# Set XDG Base Directory
#   - https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_LOCAL_HOME=$HOME/.local
export XDG_DATA_HOME=$XDG_LOCAL_HOME/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# Initialize when not exists XDG directories
__is_exists_or_create $XDG_LOCAL_HOME
__is_exists_or_create $XDG_DATA_HOME
__is_exists_or_create $XDG_CONFIG_HOME
__is_exists_or_create $XDG_CACHE_HOME

if __is_installed ruby; then
  export RUBY_DATA_HOME=$XDG_DATA_HOME/ruby
  __is_exists_or_create $RUBY_DATA_HOME
fi

if __is_installed rbenv; then
  export RBENV_ROOT=$XDG_DATA_HOME/rbenv
  eval "$(rbenv init -)"
fi

if __is_installed pyenv; then
  export PYENV_ROOT=$XDG_DATA_HOME/pyenv
  eval "$(pyenv init -)"
fi

if __is_installed nodenv; then
  export NODENV_ROOT=$XDG_DATA_HOME/nodenv
  eval "$(nodenv init -)"
  __is_installed npm && export NODE_PATH=$(npm root -g)
fi

if __is_installed go; then
  export GOPATH=$XDG_LOCAL_HOME
  export GOROOT=$(go env GOROOT)
  export CGO_CFLAGS=$CFLAGS
  export CGO_LDFLAGS=$LDFLAGS
  export PATH=$PATH:$GOPATH/bin
fi

# Set environment variables for Ghq
# https://github.com/motemen/ghq#environment-variables
if __is_installed ghq; then
  export GHQ_ROOT=$GOPATH/src
fi

# Set environment variables for Rust/Cargo
# https://doc.rust-lang.org/cargo/reference/environment-variables.html
if __is_installed rustup-init; then
  export CARGO_HOME=$XDG_DATA_HOME/cargo
  __is_exists_or_create $CARGO_HOME
  PATH=$PATH:$CARGO_HOME/bin
fi

# Set environment variables to MySQL
# https://dev.mysql.com/doc/refman/8.0/en/environment-variables.html
if __is_installed mysql; then
  MYSQL_DATA_HOME=$XDG_DATA_HOME/mysql/
  __is_exists_or_create $MYSQL_DATA_HOME
  export MYSQL_HISTFILE=$MYSQL_DATA_HOME/mysql_history
fi

# Set environment variables to PostgreSQL (PSQL)
# https://www.postgresql.org/docs/11/app-psql.html
if __is_installed psql; then
  export POSTGRES_DATA_HOME=$XDG_DATA_HOME/postgres
  __is_exists_or_create $POSTGRES_DATA_HOME
  export PSQL_HISTORY=$POSTGRES_DATA_HOME/psql_history
fi

# For Docker for Mac
# https://docs.docker.com/engine/reference/commandline/cli/#configuration-files
if __is_installed docker; then
  export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker
  # Enable buildkit to fast docker build (Experimental feature)
  export DOCKER_BUILDKIT=1
fi

# For Xcode
XCODE_PATH=/Applications/Xcode.app
if [ -d $XCODE_PATH ]; then
  PATH=$PATH:$XCODE_PATH/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
fi

# For Google Cloud SDK
if __is_installed gcloud; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi

# Set environment variables for Packer
# https://www.packer.io/docs/other/environment-variables.html
if __is_installed packer; then
  export PACKER_CACHE_DIR=$XDG_CACHE_HOME/packer
  export PACKER_CONFIG=$XDG_CONFIG_HOME/packer
fi

# Set environment variables for Vagrant
# https://www.vagrantup.com/docs/other/environmental-variables.html#vagrant_home
if __is_installed vagrant; then
  export VAGRANT_HOME=$XDG_DATA_HOME/vagrant
fi

if [ -d $XDG_DATA_HOME/bundlizer ]; then
  export BUNDLIZER_ROOT=$XDG_DATA_HOME/bundlizer
  source $BUNDLIZER_ROOT/etc/bashrc
  source $BUNDLIZER_ROOT/completions/bundlizer.zsh
fi

# Load some tools
__is_installed direnv && eval "$(direnv hook zsh)"
__is_installed thefuck && eval $(thefuck --alias)

# Default environment settings
export SHELL=$(which zsh)
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export EDITOR=$(which vim)
export PAGER=lv
export LISTMAX=10000
export TERM_256=xterm-256color
export TERM=$TERM_256
export LS_COLORS='di=01;36'

# Set `-U` option to remove duplicated paths
typeset -U path cdpath fpath manpath

# Export PATH
export PATH=$PATH
