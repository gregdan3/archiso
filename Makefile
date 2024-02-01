DATE:=$(shell date -d now "+%Y.%m.%d")
PLATFORM:=$(shell uname -m)
ARCHISO=out/archlinux-$(DATE)-$(PLATFORM).iso

.PHONY: all clean test test-qemu test-vbox install

all: $(ARCHISO)

airootfs/root/.ssh/authorized_keys: ~/.ssh/authorized_keys
	# assumption: your authorized_keys file is sufficient
	cat $< >> $@

$(ARCHISO): airootfs/root/.ssh/authorized_keys
	sudo mkarchiso -v -w /tmp/archiso-tmp -o ./out .

test: test-qemu

test-qemu: $(ARCHISO)
	run_archiso -u -i $(ARCHISO)

test-vbox: $(ARCHISO)
	echo TODO: execute archiso via vbox
	exit 1

install:
	echo TODO: write to target disk
	exit 1

clean:
	sudo rm -rf out/ /tmp/archiso-tmp airootfs/root/.ssh/authorized_keys
