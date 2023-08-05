DATE=$(shell date -d now "+%Y.%m.%d")
PLATFORM=$(shell uname -m)
ARCHISO=out/archlinux-$(DATE)-$(PLATFORM).iso

.PHONY: all clean test

all: $(ARCHISO)

airootfs/root/.ssh/authorized_keys: ~/.ssh/id_ed25519.pub
	cat $< >> $@

$(ARCHISO): airootfs/root/.ssh/authorized_keys
	sudo mkarchiso -v -w /tmp/archiso-tmp -o ./out .

test: $(ARCHISO)
	run_archiso -u -i $(ARCHISO)

clean:
	sudo rm -rf out/ /tmp/archiso-tmp airootfs/root/.ssh/authorized_keys
