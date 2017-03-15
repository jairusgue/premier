#!/bin/bash

# ce code est à mettre dans une repo git de la branche 

pull_request() {
  to_branch=$1
  if [ -z $to_branch ]; then
    to_branch="master"
  fi
  
  # essaie d'atteindre la branche en amont sinon retour sur l'origine
  upstream=$(git config --get remote.upstream.url)
  origin=$(git config --get remote.origin.url)
  if [ -z $upstream ]; then
    upstream=$origin
  fi
  
  to_user=$(echo $upstream | sed -e 's/.*[\/:]\([^/]*\)\/[^/]*$/\1/')
  from_user=$(echo $origin | sed -e 's/.*[\/:]\([^/]*\)\/[^/]*$/\1/')
  repo=$(basename `git rev-parse --show-toplevel`)
  from_branch=$(git rev-parse --abbrev-ref HEAD)

  URL=https://github.com/$to_user/$repo/compare/$to_branch...$from_branch

  #On atteint la page de demande de pull request ensuite une fonction pourrait nous permettre d'écrire
  #dans le "textarea" pour les commentaires le message "Hello Wolrd!"

  echo $URL
  chrome $URL
}
 
# usage
pull_request              # PR to master
pull_request other_branch # PR to other_branch
