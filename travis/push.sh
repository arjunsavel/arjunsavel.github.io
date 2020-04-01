#!/bin/sh

setup_git() {
  git config --global user.email "asavel@berkeley.edu"
  git config --global user.name "arjunsavel"
  chmod 400 deploy_key
  echo "  IdentityFile  $(pwd)/deploy_key" >> ~/.ssh/config


}

commit_website_files() {
  git checkout -b master
  git add . *.html
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  git remote add origin https://github.com/arjunsavel/arjunsavel.github.io > /dev/null 2>&1
  echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8dGxhgoTwKcheTq7JLyRpPop407V3qln5XfDzVpyr8M2GJrqGdXarSmn7jwbshtLS2DwluVJ9pI6dtg38K4FFRkDPph7n+S4gTkCx9lcPIqX5wwsdJg9Mwmf+7YTNYhf9/JlXIHHh283DR2VW1i+HvMFM5UEBCCkh6Tb37Nhxs4viW1t5SnzdkvLjbZl7VylPMMeZz6nendRRqWUfrZMXgq47Ew31ssPTA2EDWyLkXW1EiueHKAxphamUwtEoS8JqabC/nBah5WiNI7+7iE+LeLrr1PeQUWZyqNpGk+9Xg/FUjHfzX3zu5yAXGpmDYiAOmFrFzuY0T8vpzKlazRZGWZXoMmR/+OZeUALt5yv0gS+7fC40C8QtQ4kf9D2niK6OyNMvVVedL4MDtnug10ndwnaB6UEBf3r6VifCbpYHIm1STxovHIQIpnLvihFFpRLV525KcIwinDoA+v1879Q0j6Xx7AzXaesd4v8QhkpnSWKTiZXzw8oUOqup+DIESoFW9yqnXcyUuegC+AhxzVm0a5kFQY504Ioo4oTycei9hhFT2sbANDZSVapxR3Zc6IpoYwg9P5S/7cXwUNSX2SYw3BCWlbYaVHbZHapFqpLwESRB0AHm9a9+YgwwYYgOhIcPDMbJvCssknmEv6kWz6RiWHaspYwVewV5UtLdPTLKwQ== asavel@berkeley.edu" > ~/.ssh/known_hosts 
	if ! git push -v ; then
	  _err "git push error"
	fi 
}

setup_git
commit_website_files
upload_files