image: build

akroma:
	@git clone https://github.com/akroma-project/akroma

env: akroma
	$(eval DOC_GIT_REF=$(shell git rev-parse --short HEAD))
	@cd akroma; $(eval AKA_GIT_REF=$(shell git rev-parse --short HEAD))
	$(eval GIT_REF=$(shell echo ${DOC_GIT_REF})$(shell echo ${AKA_GIT_REF}))

build: env
	@echo building akroma:${GIT_REF}
	@cd akroma; docker build -f Dockerfile -t akroma:${GIT_REF} .

daemon: build
	@docker run -p 30303:30303 -p 30303:30303/udp --mount source=akroma,target=/root akroma:${GIT_REF}

node: daemon

interactive: build
	@docker run -i --mount source=akroma,target=/root akroma:${GIT_REF} attach

attach: interactive

console: interactive
