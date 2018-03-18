BRANCH = $(error must specify BRANCH)
REPO   = bugzilla/harmony

all: bundle/centos6/cpanfile bundle/ubuntu14/cpanfile

centos6.tar.gz: Makefile
	docker run --rm -i \
		--env BRANCH=$(BRANCH) \
		--env REPOSITORY="https://github.com/$(REPO).git" \
		--name centos6 mozillabteam/centos6 > $@

bundle/%/cpanfile bundle/%/cpanfile.snapshot: %.tar.gz
	tar -zxf $< -C bundle/$* cpanfile cpanfile.snapshot
	touch bundle/$*/{cpanfile,cpanfile.snapshot}


