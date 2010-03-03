#!/usr/bin/env bash
mkdir -p ~/ics

cd ~/ics/
#git clone git@github.com:mrflip/imw.git imw
cd ~/ics/imw
# git-rbranch git@github-infochimps:infochimps/imw.git mainline

cd ~/ics/
#git clone git@github.com:mrflip/data-infochimps.git pool
cd ~/ics/imw
# git-rbranch git@github-infochimps:data-infochimps/imw.git mainline

cd ~/ics/
# git clone git+ssh://womper.ph.utexas.edu/gitrepos/ics/site.git site

mkdir -p ~/ics/infochimps
cd       ~/ics/infochimps

mkdir -p ~/ics/plugins
cd       ~/ics/plugins
git clone git@github.com:mrflip/restful_authentication_example.git example_restauth
ln -s example_restauth/vendor/plugins/restful_authentication .
cd ~/ics/plugins/example_restauth/vendor/plugins
rmdir restful_authentication
git clone git@github.com:mrflip/restful-authentication.git restful_authentication
cd ~/ics/plugins/example_restauth/vendor/plugins/restful_authentication
git-rbranch git@github.com:mrflip/restful-authentication.git mainline



