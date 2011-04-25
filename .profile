# Starting keychain

      KEYCHAIN=`which keychain`
      if [ $? = 0 ]; then
          HOST=`hostname`
          IDENTITY=~/.ssh/id_rsa
          SSH_AGENT=~/.keychain/$HOST-sh
          $KEYCHAIN $IDENTITY
          . $SSH_AGENT
      fi

# Reading network settings

      if [ -f ~/.network ]; then
          . ~/.network
      fi

# Language Setting

      case $TERM in
          linux) LANG=C ;;
          *) LANG=ja_JP.UTF-8 ;;
      esac

# Replace bash to zsh

      if [ -f /usr/local/bin/zsh ]; then
          ZSH='/usr/local/bin/zsh'
      else
          ZSH=`which zsh`
      fi
      if [ $? = 0 ]; then
          case $TERM in
              xterm) exec $ZSH ;;
              xterm-256color) exec $ZSH ;;
          esac
      fi
