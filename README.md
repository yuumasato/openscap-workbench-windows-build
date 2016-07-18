Build SCAP Workbench for Windows
================================
Provides scripts to build https://github.com/OpenSCAP/scap-workbench for windows in docker

Usage:
======

1. Clone this repo
------------------

```
$ git clone https://github.com/ybznek/openscap-workbench-windows-build.git
$ cd openscap-workbench-windows-build
```

2. Update Dockerfile
--------------------

- Update `FROM"` section to the latest Fedora. It isn't probably necessarry, but you will have newer/better compiler.
- Update `ENV SSG` & `ENV WORKBENCH` to latest releases

3. Run compilation (takes long time)
------------------------------------
```
$ mkdir build
# ./docker/compile.sh
```
Windows files will be in `./build*`

4. Create MSI using Wix toolset
-------------------------------
- Run Windows and install [Wix toolset](http://wixtoolset.org/releases)
- Copy `build` folder to a Windows folder
- cd to `build/scap-workbench-build`
- Run `createMsi.cmd`

5. Check MSI
------------
- Check msi file output output - you can compare it to previous msi using `msitools` package
