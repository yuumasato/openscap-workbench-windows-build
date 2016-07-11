FROM fedora:23

RUN dnf install -y mingw32-gcc mingw32-binutils mingw32-libxml2 \
	mingw32-libgcrypt mingw32-pthreads mingw32-libxslt \
	mingw32-curl mingw32-pcre mingw32-qt \
	automake autoconf libtool \
	wget make git \
	\
	cmake asciidoctor ;\
	dnf clean all

RUN git clone https://github.com/OpenSCAP/openscap.git -b master

RUN cd openscap ; ./autogen.sh ; \
	mingw32-configure --disable-probes --disable-python --disable-util-oscap-docker; \
	make -j 4 ; make install

RUN wget https://github.com/OpenSCAP/scap-workbench/archive/1.1.2.tar.gz -O workbench.tar.gz

RUN tar -xzf workbench.tar.gz

RUN cd scap-workbench*	;\
	mkdir build/	;\
	cd build/	;\
	mingw32-cmake ../	;\
	make -j 4	;\
	mv ./scap-workbench /scap-workbench-build
