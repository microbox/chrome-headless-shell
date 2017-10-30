FROM yukinying/chrome-headless:62.0.3201.2

# switch to root to build image
# =================================================
USER root

# prepare rootfs
# =================================================
RUN mkdir /rootfs
WORKDIR /rootfs
RUN mkdir bin sbin etc etc/default dev dev/pts lib usr proc sys tmp root home

# Install Chinese/Japanese/Korea fonts
# =================================================
# RUN apt-get update && apt-get install fonts-noto-cjk

# install busybox
# =================================================
ADD https://busybox.net/downloads/binaries/1.27.1-i686/busybox /sbin/busybox
RUN chmod +x /sbin/busybox
RUN cp /sbin/busybox /rootfs/sbin
RUN /sbin/busybox --install -s bin

# create all directories
# =================================================
RUN mkdir -p chrome chrome/locales lib64 usr/bin usr/sbin usr/share lib/x86_64-linux-gnu usr/lib/x86_64-linux-gnu

# =================================================
RUN bash -c "cp -R /chrome/{headless_lib.pak,headless_shell,mus_app_resources_100.pak,mus_app_resources_200.pak,mus_app_resources_strings.pak} chrome"
RUN cp /chrome/locales/en-US.pak chrome/locales

# extract chrome headless shell dependencies
# =================================================
RUN cp /lib64/ld-linux-x86-64.so.2 lib64/
RUN bash -c "cp /lib/x86_64-linux-gnu/lib{pthread,dl,rt,expat,m,gcc_s,c}.so* lib/x86_64-linux-gnu"
RUN bash -c "cp /usr/lib/x86_64-linux-gnu/lib{nss3,nssutil3,smime3,nspr4,plc4,plds4}.so* usr/lib/x86_64-linux-gnu"
RUN cp -r /usr/lib/x86_64-linux-gnu/nss/* usr/lib/
RUN cp /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 usr/lib/x86_64-linux-gnu
RUN cp -r /etc/fonts etc
RUN cp -r /usr/share/fonts usr/share
RUN ls -ahl bin

# build rootfs
RUN tar cf /rootfs.tar .