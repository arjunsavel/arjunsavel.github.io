#!/bin/sh

setup_git() {
  git config --global user.email "asavel@berkeley.edu"
  git config --global user.name "Arjun Savel"
  git config --global push.default matching

  # chmod 400 deploy_key
  echo "  IdentityFile  deploy_key" >> ~/.ssh/config
  echo "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
  echo "Host *\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
  ssh-add deploy_key
  ssh -T git@github.com
}

commit_website_files() {
  git checkout -b master
  git add . *.html
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  git remote set-url origin git@github.com:arjunsavel/arjunsavel.github.io.git
	if ! git push --set-upstream --force origin master ; then
	  _err "git push error"
	fi 
}

setup_git
commit_website_files
upload_files
