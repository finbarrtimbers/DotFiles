ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$reset_color%}%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%} "
ZSH_THEME_SVN_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_SVN_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_SVN_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_SVN_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN

# turns seconds into human readable time
# 165392 => 1d 21h 56m 32s
prompt_pure_human_time() {
    local tmp=$1
    local days=$(( tmp / 60 / 60 / 24 ))
    local hours=$(( tmp / 60 / 60 % 24 ))
    local minutes=$(( tmp / 60 % 60 ))
    local seconds=$(( tmp % 60 ))
    (( $days > 0 )) && echo -n "${days}d "
    (( $hours > 0 )) && echo -n "${hours}h "
    (( $minutes > 0 )) && echo -n "${minutes}m "
    echo "${seconds}s"
}

# displays the exec time of the last command if set threshold was exceeded
prompt_pure_cmd_exec_time() {
    local stop=$EPOCHSECONDS
    local start=${cmd_timestamp:-$stop}
    integer elapsed=$stop-$start
    (($elapsed > ${PURE_CMD_MAX_EXEC_TIME:=1})) && prompt_pure_human_time $elapsed
}

prompt_pure_preexec() {
    cmd_timestamp=$EPOCHSECONDS
}



prompt_pure_precmd() {
    local cmd_exec_time="`prompt_pure_cmd_exec_time`"
    printf "$cmd_exec_time"
}

prompt_setup() {
    zmodload zsh/datetime
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    add-zsh-hook preexec prompt_pure_preexec
    PROMPT='$(git_prompt_info) %{%(?.%F{green}.%F{red})%G❯%f%} '
    precmd_functions+=(vcs_info)  # Add vcs_info to precmd_functions to update it each time the prompt is displayed
}

prompt_setup
