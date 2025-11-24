([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

[[ "$-" != *i* ]] && return

if [[ -n "$SSH_CONNECTION" ]] && [[ "$PATH" != *:/usr/bin* ]]; then
  source $ISOLATED_DIR/msys2/etc/profile
fi

unset _warning_found
for _warning_prefix in '' ${MINGW_PREFIX}; do
  for _warning_file in ${_warning_prefix}/etc/profile.d/*.warning{.once,}; do
    test -f "${_warning_file}" || continue
    _warning="$(command sed 's/^/\t\t/' "${_warning_file}" 2>/dev/null)"
    if test -n "${_warning}"; then
      if test -z "${_warning_found}"; then
        _warning_found='true'
        echo
      fi
      if test -t 1; then
        printf "\t\e[1;33mwarning:\e[0m\n${_warning}\n\n"
      else
        printf "\twarning:\n${_warning}\n\n"
      fi
    fi
    [[ "${_warning_file}" = *.once ]] && rm -f "${_warning_file}"
  done
done
unset _warning_found
unset _warning_prefix
unset _warning_file
unset _warning

[[ -n "${MSYS2_PS1}" ]] && export PS1="${MSYS2_PS1}"
if [[ -n "$(command -v getent)" ]] && id -G | grep -q "$(getent -w group 'S-1-16-12288' | cut -d: -f2)"; then
  _ps1_symbol='\[\e[1m\]#\[\e[0m\]'
else
  _ps1_symbol='\$'
fi
case "$(declare -p PS1 2>/dev/null)" in
'declare -x '*) ;;
*)
  export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n'"${_ps1_symbol}"' '
  ;;
esac
unset _ps1_symbol