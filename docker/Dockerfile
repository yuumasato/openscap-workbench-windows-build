FROM fedora:23

ENV SSG https://github.com/OpenSCAP/scap-security-guide/releases/download/v0.1.30/scap-security-guide-0.1.30.zip
ENV WORKBENCH https://github.com/OpenSCAP/scap-workbench/archive/1.1.2.tar.gz

# Dependencies
RUN dnf install -y mingw32-gcc mingw32-binutils mingw32-libxml2 \
	mingw32-libgcrypt mingw32-pthreads mingw32-libxslt \
	mingw32-curl mingw32-pcre mingw32-qt \
	automake autoconf libtool \
	wget make git \
	\
	cmake asciidoctor \
	\
	unzip	;\
	dnf clean all

# Openscap
RUN git clone https://github.com/OpenSCAP/openscap.git -b master

RUN cd openscap ; ./autogen.sh ; \
	mingw32-configure --disable-probes --disable-python --disable-util-oscap-docker; \
	make -j 4 ; make install

RUN wget ${SSG} -O ssg.zip

# Workbench
RUN git clone --depth 1 https://github.com/mpreisler/mingw-bundledlls.git
RUN wget ${WORKBENCH} -O workbench.tar.gz

RUN tar -xzf workbench.tar.gz	;\
	mv scap-workbench* /scap-workbench

RUN cd scap-workbench*	;\
	mkdir build/	;\
	cd build/	;\
	mingw32-cmake \
		-D SCAP_WORKBENCH_LOCAL_SCAN_ENABLED=false \
		-D SCAP_AS_RPM_EXECUTABLE="" \
		-D SSH_EXECUTABLE=ssh.exe \
		-D NICE_EXECUTABLE="" \
		-D SETSID_EXECUTABLE="" \
		../	;\
		sed 's;/scap-workbench/build/ssh.exe;ssh.exe;' -i Config.h	;\
	make -j 4	;\
	cd ..; mv ./build /scap-workbench-build; mv win32-LICENSE.rtf /scap-workbench-build

RUN \
	sed 's;Value="/scap-workbench\\win32-LICENSE.rtf";Value="win32-LICENSE.rtf";' -i /scap-workbench-build/scap-workbench.wxs

ADD ssh.exe /scap-workbench-build/scap-workbench/
ADD win-ssh-askpass.exe /scap-workbench-build/scap-workbench/

ADD dlls /tmp/dlls
RUN	cd /tmp/dlls	;\
	/mingw-bundledlls/mingw-bundledlls /scap-workbench-build/scap-workbench/scap-workbench.exe  --copy	;\
	/mingw-bundledlls/mingw-bundledlls /scap-workbench-build/scap-workbench/ssh.exe             --copy	;\
	/mingw-bundledlls/mingw-bundledlls /scap-workbench-build/scap-workbench/win-ssh-askpass.exe --copy

# SSG
RUN	\
	unzip ssg.zip	;\
	mv /scap-security-guide* /scap-workbench-build/scap-workbench/ssg

ADD createMsi.cmd /scap-workbench-build/createMsi.cmd

