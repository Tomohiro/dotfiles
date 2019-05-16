# Set left prompt
PROMPT="%F{cyan}%n%f at %F{yellow}%m%f in %F{blue}%2d%f %1(v|on %F{green}%1v%f|) %2(v|%F{yellow}(%2v)%f|)
%F{magenta}❯%f "

# Set right prompt
RPROMPT=''

# Enable color
autoload -U colors; colors

# Prepare to show VCS information on prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enbale git cvs svn bzr hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:git:*' stagedstr '!'
zstyle ':vcs_info:git:*' unstagedstr '+'
zstyle ':vcs_info:git:*' formats '%s:%b' '%c%u'
zstyle ':vcs_info:git:*' actionformats '(%s)-[%r/%b|%a]'

# Export 3 type messages
#   $vcs_info_msg_0: Normal
#   $vcs_info_msg_1: Warning
#   $vcs_info_msg_2: Error
zstyle ':vcs_info:*' max-exports 3
__show_vcs_info_precmd() {
   vcs_info
   psvar=()
   [[ -n $vcs_info_msg_0_ ]] && psvar[1]=$vcs_info_msg_0_
   [[ -n $vcs_info_msg_1_ ]] && psvar[2]=$vcs_info_msg_1_
   [[ -n $vcs_info_msg_2_ ]] && psvar[3]=$vcs_info_msg_2_
}
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions __show_vcs_info_precmd)

# If you want to load prompt themes, please enable following line.
#
# Example:
#   prompt adam1 # Load adam1 theme
#
# autoload -U promptinit; promptinit
