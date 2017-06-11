# dockcross-chromebrew

Scripts to run chromebrew on emulator

## Prerequisites

Docker image named jam7/chromebrew-armv7, jam7/chromebrew-x64 and jam7/chromebrew-x86.
Those are available at docker-hub or you can compile them from https://github.com/jam7/dockcross.

And also it is required to enable qemu-arm on docker host.

```
$ sudo apt install qemu-user qemu-user-static
```

Or it is possible to set them from containers by hand.

```
$ ./chromeos-armv7 -a --privileged bash
$ ls /proc/sys/fs/binfmt_misc
$ sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
$ ls /proc/sys/fs/binfmt_misc
register  status
$ sudo update-binfmts --enable qemu-arm
$ ls /proc/sys/fs/binfmt_misc
qemu-arm  register  status
```

## Usage

```
$ make scripts
$ make install
```

or

```
$ make scripts
$ make install-armv7
```

After that, you can either

```
$ ./chromeos-armv7 crew install make
$ ./chromeos-armv7 crew build make
$ ./chromeos-armv7 bash
```

## Resource

./armv7, ./x64 and ./x86 are used as /usr/local by each docker image.
