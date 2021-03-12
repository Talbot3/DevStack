FROM nvidia/cuda:10.0-devel-centos7 as builder

ENV NASM_VERSION 2.14
ENV NVCODEC_VERSION 9.1.23.0
ENV FFMPEG_VERSION 4.2

RUN yum install -y autoconf bzip2 git make zlib-devel

RUN curl -fsSLO https://www.nasm.us/pub/nasm/releasebuilds/$NASM_VERSION/nasm-$NASM_VERSION.tar.bz2 \
  && tar -xjf nasm-$NASM_VERSION.tar.bz2 \
  && cd nasm-$NASM_VERSION \
  && ./autogen.sh \
  && ./configure \
  && make -j$(nproc) \
  && make install

RUN git clone -b n$NVCODEC_VERSION --depth 1 https://git.videolan.org/git/ffmpeg/nv-codec-headers \
  && cd nv-codec-headers \
  && make install

ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig
RUN curl -fsSLO https://ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.bz2 \
  && tar -xjf ffmpeg-$FFMPEG_VERSION.tar.bz2 \
  && cd ffmpeg-$FFMPEG_VERSION \
  && ./configure --enable-nvenc --enable-static \
  && make -j$(nproc) \
  && make install


FROM nvidia/cuda:10.0-runtime-centos7

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,video,utility

COPY --from=builder /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=builder /usr/local/bin/ffprobe /usr/local/bin/ffprobe
COPY --from=builder /usr/local/lib/ /usr/local/lib/
COPY --from=builder /usr/local/include /usr/local/include
