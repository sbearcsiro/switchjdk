#!/bin/sh

NL='
'

bashProfile=$(cat ~/.bash_profile | sed '/switchjdk-module/d')
echo "${bashProfile}${NL}${NL}# Leave this switchjdk-module.bash incantation as a single line, so that homebrew upgrades are smooth${NL}if [ -f $(brew --prefix)/etc/switchjdk-module.bash ]; then source $(brew --prefix)/etc/switchjdk-module.bash; fi${NL}" > ~/.bash_profile

echo "*** Did the above fail with permissions errors? ***"
echo "If yes, you will need to do this after homebrew finishes (once off):"
echo "  /usr/local/Cellar/switchjdk/$1/bin/add_switchjdk_to_bash_profile_safely.sh"
