# dockcross-chromebrew

Scripts to run chromebrew on emulator

## Prerequisites

Docker images modified specially to emulate chromeos and qemu-arm environment at host are required.

Image names are jam7/chromebrew-armv7, jam7/chromebrew-x64 and jam7/chromebrew-x86.
Those are available at docker-hub or you can compile them from https://github.com/jam7/dockcross.

In order to enable qemu-arm on docker host, run following commands.

```
host$ sudo apt install qemu-user qemu-user-static
```

If you don't want to install it on host, you still can enable them from containers by hand.

```
host$ ./chromeos-armv7 -a --privileged bash
container$ ls /proc/sys/fs/binfmt_misc
container$ sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
container$ ls /proc/sys/fs/binfmt_misc
register  status
container$ sudo update-binfmts --enable qemu-arm
container$ ls /proc/sys/fs/binfmt_misc
qemu-arm  register  status
```

## Preparation

To prepare chromebrew environments for all architectures:

```
host$ make scripts
host$ make install
host$ make gcc
```

To prepare chromebrew for a particular architecture:

```
host$ make scripts
host$ make install-armv7
host$ make gcc-armv7
```

## Usage

You can use emulator like below.  Any of them execute docker container with appropriate qemu support.

```
host$ ./chromeos-armv7 crew install make
host$ ./chromeos-x64 crew build git
host$ ./chromeos-x86 bash
container$ crew install openssl keep
```

For example, you can use arm binary transparently like below.

```
host$ uname -a
Linux seki 4.4.0-79-generic #100-Ubuntu SMP Wed May 17 19:58:14 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
host$ cat hello.c
int main() { puts("hello"); }
host$ ./chromeos-armv7 gcc hello.c
host$ ./chromeos-armv7 file a.out
a.out: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 2.6.16, not stripped
host$ ./chromeos-armv7 ./a.out
hello
```

## Resource

Directories at `./armv7`, `./x64` and `./x86` are used as `/usr/local` in each docker container.

## Known problems

Qemu-arm is not good to run programs using pthread.  For example, git often crash in the middle of git-index-pack.
In order to avoid it, it is required to use single cpus.  Generally, you can force docker to use single cpu
by using command like `./chromeos-armv7 -a --cpuset-cpus=0 bash`.  Or it is also possible to disable threads in
each programs.  I'm going to build git without pthread soon.

Also qemu-arm is really slow.  I'm going to change to use host's cross-compiler instead of arm gcc.
