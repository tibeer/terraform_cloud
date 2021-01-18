# kudos:
#   - https://medium.com/@exustash/three-good-practices-for-better-ci-cd-makefiles-5b93452e4cc3
#   - https://le-gall.bzh/post/makefile-based-ci-chain-for-go/
#   - https://makefiletutorial.com/
#   - https://www.cl.cam.ac.uk/teaching/0910/UnixTools/make.pdf
#
SHELL := /usr/bin/env bash # set default shell
.SHELLFLAGS = -c # Run commands in a -c flag 

.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell

.PHONY: all # All targets are accessible for user
.DEFAULT: help # Running Make will run the help target

BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
ifeq ($(BRANCH), HEAD)
	BRANCH := ${CI_BUILD_REF_NAME}
endif

CONTAINER := $(shell which docker || which podman)

# help: @ List available tasks of the project
help:
	@grep -E '[a-zA-Z\.\-]+:.*?@ .*$$' $(MAKEFILE_LIST)| tr -d '#'  | awk 'BEGIN {FS = ":.*?@ "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# registry-login: @ Login to gitlab registry
registry-login:
	$(CONTAINER) login -u read-registry -p BqLxQGG3rRBtBEC7jQ6x registry.intern.b1-systems.de


# build-test-image: @ Build an image able to run all these tests
build-test-image:
	$(CONTAINER) build -t ci-b1-etraining -f Dockerfile.ci .

# tag-ci-image: @ Tag an image for the CI internal registry
tag-ci-image:
	$(CONTAINER) tag ci-b1-etraining localhost:5000/ci-b1-etraining

# tag-ci-image: @ Push an image to the CI internal registry
push-ci-image:
	$(CONTAINER) push localhost:5000/ci-b1-etraining

# all: @ Run all defined tasks
all: terraform-format terraform-apply
	@echo "testing ..."


# terraform-format: @ Run format check on all terraform files
terraform-format:
	terraform fmt -check=true -diff=true ;\
	exit $$err

# terraform-apply: @ Run terraform apply
terraform-apply:
	terraform apply --auto-approve ;\
	exit $$err
