VERSION := 0.1
USER ?= asuswrt-merlin
BASE_VERSION := 16.04
TOOLCHAINS := hnd_arm hnd_ax_arm brcm_arm_sdk

all: $(TOOLCHAINS)

.NOTPARALLEL:
$(TOOLCHAINS):
	docker build --build-arg BUILD_VERSION=$@ --build-arg BASE_VERSION=$(BASE_VERSION) -t $(USER)/$(BASE_VERSION)/$@:$(VERSION) .

# Run target as : make run_hnd_arm etc
.PHONY:
$(foreach t,$(TOOLCHAINS), run_$(t)):
	docker run -v $(abspath ../):/asuswrt-merlin -it --user $(shell id -u) $(USER)/$(BASE_VERSION)/$(subst run_,,$@):$(VERSION) /bin/bash


#.PHONY:
#$(foreach t,$(TOOLCHAINS), tag_$(t)): $(TOOLCHAINS) login
#	REPO := $(USER)/$(BASE_VERSION)/$(subst tag_,,$@)
# 	docker tag $(REPO):$(VERSION) $(REPO):latest
#	docker tag $(REPO):$(VERSION) $(REPO):travis-$$TRAVIS_BUILD_NUMBER
#	docker push $(REPO)

login:
	docker login -e=$$DOCKER_EMAIL -u=$$DOCKER_USERNAME -p=$$DOCKER_PASSWORD

#.PHONY:
#push: $(foreach t,$(TOOLCHAINS), tag_$(t))


#$(foreach g, $(shell groups), --group-add $(g))
