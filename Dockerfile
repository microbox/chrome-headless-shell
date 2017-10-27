FROM scratch

MAINTAINER Ling <x@e2.to>

ADD ChromeHeadless.tgz /chrome

EXPOSE 9222

ENTRYPOINT ["/chrome/headless_shell", "--no-sandbox", "--hide-scrollbars", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222"]
