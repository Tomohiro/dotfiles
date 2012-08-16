# vim: ft=zsh

## Auto load settings

    autoload -U colors
    colors

    fpath=($HOME/.zsh/completions $HOME/.zsh/functions /usr/local/share/zsh-completions $fpath)
    autoload -U compinit
    compinit

    autoload -Uz zmv
    #alias zmv='noglob zmv -W'

    zstyle ':completion:*:sudo:*' command-path $PATH
    zstyle ':completion:*:default' menu select=1
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*:processes' command 'ps x'
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:messages' format '%d'
    zstyle ':completion:*:warnings' format 'No matches for: %d'
    zstyle ':completion:*' group-name ''

    if [ -f $HOME/.zsh/auto-fu.zsh ]; then
        source $HOME/.zsh/auto-fu.zsh
        function zle-line-init () {
            auto-fu-init
        }
        zle -N zle-line-init
        zstyle ':completion:*' completer _oldlist _complete
        zstyle ':auto-fu:var' postdisplay ''
    fi

    _cache_hosts=(`perl -ne  'if (/^([a-zA-Z0-9.-]+)/) { print "$1\n";}' ~/.ssh/known_hosts`)

## Set shell options

    setopt auto_menu auto_cd correct auto_name_dirs auto_remove_slash
    setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
    setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
    setopt extended_glob list_types no_beep always_last_prompt
    setopt cdable_vars auto_param_keys share_history
    setopt long_list_jobs magic_equal_subst auto_pushd
    setopt print_eight_bit noflowcontrol
    setopt multibyte combining_chars
    setopt sh_word_split


## History settings

    HISTFILE=$HOME/.zsh-history
    HISTSIZE=100000
    SAVEHIST=100000


## Keybind settings

    bindkey -v
    bindkey '^Q' push-line-or-edit
    bindkey '^R' history-incremental-search-backward


## Set Aliases

    alias cp='nocorrect cp'
    alias mv='nocorrect mv'
    alias rm='nocorrect rm'
    alias mkdir='nocorrect mkdir'
    alias sl='ls'
    alias u='cd ../'
    alias b='cd -'
    alias :q='exit'
    alias tree='tree --charset=C'

    if [ $KERNEL = Darwin ]; then
        alias ls='ls -hF -G'
    else
        alias open='gnome-open'
        alias ls='ls -hF --color=auto'
    fi
    alias la='ls -lAh'
    alias ll='ls -lh'

    alias vi=$EDITOR

    alias plan="vi $HOME/.plan"

    if type colordirff &> /dev/null; then
        alias diff='colordiff'
    fi

    if type weechat-curses &> /dev/null; then
        alias weechat='TERM=screen-256color weechat-curses'
    fi

    # search by ack, ack-grep
    if type ack-grep &> /dev/null; then # Linux
        alias search='ack-grep'
    fi
    if type ack &>/dev/null; then # Darwin
        alias search='ack'
    fi

    if type bundle &> /dev/null; then
        alias be='bundle exec'
    fi

    if ! type svn &> /dev/null; then
        alias svn='sshfs-svn'
    fi

    if ! type mosh &> /dev/null; then
        alias mosh='mosh -p 60000'
    fi

    alias ssh-new=ssh_on_screen


## Global alias

    if type pbcopy &> /dev/null; then # Mac
        alias -g C='| pbcopy'
    elif type xsel &> /dev/null; then # Linux
        alias -g C='| xsel --input --clipboard'
    fi

    alias -g M='| more'
    alias -g L='| less'
    alias -g X='| xargs'
    alias -g H='| w3m -T text/html'


## Set Functions

    # load my functions
    local func_dir=$HOME/.zsh/functions
    for script in `command ls $func_dir`; do
        source $func_dir/$script
    done

    preexec() {
        [[ -n $WINDOW ]] && set_screen_window_title ${(z)2}
    }

## Set other zsh source

    local source_dir=$HOME/.zsh
    for source in `command ls $source_dir/*.zshrc`; do
        source $source
    done


## Startup message

    if type colortest-256 &> /dev/null; then
        colortest-256
    fi

    if type fortune &> /dev/null; then
       fortune
    fi
