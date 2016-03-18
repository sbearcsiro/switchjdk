#!/bin/sh

NL='
'

bashProfile=$(cat ~/.bash_profile | sed '/switchjdk-module/d')
echo "${bashProfile}${NL}${NL}# Leave this switchjdk-module.bash incantation as a single line, so that homebrew upgrades are smooth${NL}if [ -f $(brew --prefix)/etc/switchjdk-module.bash ]; then source $(brew --prefix)/etc/switchjdk-module.bash; fi${NL}" > ~/.bash_profile
