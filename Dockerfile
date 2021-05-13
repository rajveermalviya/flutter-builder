FROM docker.io/library/fedora:34
ENV JAVA_HOME=/usr/lib/jvm/java-11
ENV ANDROID_SDK_ROOT=/sdk/android_sdk
RUN echo -e "[main]\nmax_parallel_downloads=20\n" | sudo tee /etc/dnf/dnf.conf \
    && cat /etc/dnf/dnf.conf \
    && sudo dnf update -y \
    && sudo dnf install -y findutils curl unzip git java-11-openjdk-devel \
    && curl -LO https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip \
    && unzip commandlinetools-linux-7302050_latest.zip -d /tmp \
    && mkdir -p /sdk/android_sdk/cmdline-tools/latest \
    && mv /tmp/cmdline-tools/* /sdk/android_sdk/cmdline-tools/latest/ \
    && rm -rf /tmp \
    && rm commandlinetools-linux-7302050_latest.zip \
    && yes | /sdk/android_sdk/cmdline-tools/latest/bin/sdkmanager --licenses \
    && /sdk/android_sdk/cmdline-tools/latest/bin/sdkmanager --update \
    && git clone https://github.com/flutter/flutter.git -b stable /sdk/flutter \
    && /sdk/flutter/bin/flutter upgrade
ENV PATH="/sdk/flutter/bin:${PATH}"
