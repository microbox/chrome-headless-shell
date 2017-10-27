FROM scratch

MAINTAINER Ling <x@e2.to>

ADD rootfs.tar /

EXPOSE 9222

ENTRYPOINT ["/chrome/headless_shell", "--no-sandbox", "--disable-setuid-sandbox", "--disable-gpu", "--hide-scrollbars", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222"]
