##!/usr/bin/env sh
#
alias ghbh="git clone git@github.com:Giss-604/tnl.git ~/BASH_HOME_4git" # GitHubBashHpme


alias gs="git status"
alias gcm="git checkout main"
alias gm="git merge"
alias glog="git log --graph --oneline"
alias glog="git log --graph --decorate --oneline"

# Git add / commit / push
# gacp 'example message' 'main'
zgacp () {
  message="${1:-Quick commit}" ; branch="${2:-main}"
  git add . ; git commit -m "$message" ; git push origin "$branch"
}
alias gacp="gacp.pl "
# gacp "My message" -e file(s) # exclude files
# gacp "My message" -f file(s) # add files
# gacp -l

# vim: syntax=sh cc=80 tw=79 ts=2 sw=2 sts=2 et sr
