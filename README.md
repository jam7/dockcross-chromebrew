# dockcross-chromebrew

Scripts to run chromebrew on emulator

## Prerequisites

Docker image named jam7/chromebrew-armv7, jam7/chromebrew-x64 and jam7/chromebrew-x86.
Those are available at docker-hub or you can compile them from https://github.com/jam7/dockcross.

And also it is required to enable qemu-arm on docker host.

```
host$ sudo apt install qemu-user qemu-user-static
```

Or it is possible to set them from containers by hand.

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

## Usage

To prepare chromebrew for all environment.

```
host$ make scripts
host$ make install
host$ make gcc
```

To prepare chromebrew for a particular environment.

```
host$ make scripts
host$ make install-armv7
host$ make gcc-armv7
```

After that, you can either

```
host$ ./chromeos-armv7 crew install make
host$ ./chromeos-armv7 crew build git
host$ ./chromeos-armv7 bash
container$ crew install openssl keep
```

## Resource

Directories at `./armv7`, `./x64` and `./x86` are used for disk space for docker containers.
Those are mounted as /usr/local in each container.

## Known problems

Qemu-arm is not good to run program using pthread.  For example, git often crash in the middle of git-index-pack.
In order to avoid it, please use single cpu with command like `./chromeos-armv7 -a --cpuset-cpus=0 bash`.
