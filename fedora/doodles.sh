# Additional profile settings for the Fedora image


# ~/.bash_history configuration
export HISTTIMEFORMAT="%y-%m-%d %H:%M:%S "
export HISTCONTROL=ignoreboth   # Don't save commands leading with a whitespace, or duplicated commands
export HISTFILESIZE=9999999999  # Enable huge history
export HISTSIZE=9999999999      #
export HISTIGNORE="cd:ls"       # Commands to ignore
shopt -s histappend             # Dump the history file after every command


__prompt_command() {
  # Append directly to history file
  history -a
}

export PROMPT_COMMAND="__prompt_command"
