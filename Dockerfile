FROM fedora:34
ENV JAVA_HOME=/usr/lib/jvm/java-11
ENV ANDROID_SDK_ROOT=/sdk/android_sdk
RUN sudo dnf update -y \
    && sudo dnf install -y curl unzip git java-11-openjdk-devel \
    && git clone https://github.com/flutter/flutter.git /sdk/flutter \
    && curl -LO https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip \
    && unzip commandlinetools-linux-7302050_latest.zip -d /sdk/android_sdk \
    && rm commandlinetools-linux-7302050_latest.zip \
    && yes | /sdk/android_sdk/cmdline-tools/bin/sdkmanager --licenses \
    && /sdk/android_sdk/cmdline-tools/bin/sdkmanager --update \
    && /sdk/flutter/bin/flutter doctor -v
