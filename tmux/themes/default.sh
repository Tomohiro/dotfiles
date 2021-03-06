# My Theme

if patched_font_in_use; then
  TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="⮂"
  TMUX_POWERLINE_SEPARATOR_LEFT_THIN="⮃"
  TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="⮀"
  TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="⮁"
else
  TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
  TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
  TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
  TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'52'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'255'}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}


# Format: segment_name background_color foreground_color [non_default_separator]

if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
  TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
    'battery 148 127' \
    'hostname 33 0' \
    'ifstat 30 255' \
    "lan_ip 24 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
    'wan_ip 24 255' \
  )
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
  TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
    #"pwd 89 211" \
    'load 234 167' \
    'weather 37 255' \
    'now_playing 236 7' \
  )
fi
