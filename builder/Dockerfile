FROM microbox/chromium-builder

# ref: https://chromium.googlesource.com/chromium/src.git/+refs
ENV CHROMIUM_VERSION 62.0.3202.75

# install dept_tools
WORKDIR /chrome
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

ENV PATH="/opt/gtk/bin:${PATH}:/chrome/depot_tools"

WORKDIR /chrome/Chromium
# fetch chromium source code
# ref: https://www.chromium.org/developers/how-tos/get-the-code/working-with-release-branches
RUN git clone --branch "${CHROMIUM_VERSION}" --depth 1 https://chromium.googlesource.com/chromium/src.git

ADD .gclient /chrome/Chromium/

# Checkout all the submodules at their branch DEPS revisions
RUN gclient sync --with_branch_heads --jobs 16
# tweak to disable use of the tmpfs mounted at /dev/shm
RUN sed -e '/if (use_dev_shm) {/i use_dev_shm = false;\n' -i src/base/files/file_util_posix.cc

WORKDIR /chrome/Chromium/src
# specify build flags
RUN mkdir -p out/Headless && \
    echo 'import("//build/args/headless.gn")' > out/Headless/args.gn && \
    echo 'is_debug = false' >> out/Headless/args.gn && \
    echo 'symbol_level = 0' >> out/Headless/args.gn && \
    echo 'is_component_build = false' >> out/Headless/args.gn && \
    echo 'remove_webcore_debug_symbols = true' >> out/Headless/args.gn && \
    echo 'enable_nacl = false' >> out/Headless/args.gn && \
    gn gen out/Headless

# build chromium headless shell
RUN ninja -C out/Headless headless_shell
RUN tar -zcvf /ChromeHeadlessShell.tgz out/Headless
