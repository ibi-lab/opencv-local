from ubuntu:22.04

USER root
RUN apt-get update && apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install tzdata locales && \
    locale-gen ja_JP.UTF-8
RUN apt-get install -y python3 \
    python3-dev \
    python3-pip \
    libffi-dev libssl-dev \
    libsm6 libxext6 libxrender-dev \
    libgtk2.0-dev \
    python3-opencv
RUN apt-get install -y x11-apps
# RUN pip3 install opencv-python
ADD bashrc /root/.bashrc

ENV TZ Asia/Tokyo
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja

WORKDIR /root

CMD ["/bin/bash"]
