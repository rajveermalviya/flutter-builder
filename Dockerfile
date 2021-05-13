FROM fedora:34
RUN sudo dnf update -y \
    && sudo dnf install -y curl unzip git java-11-openjdk-devel \
    && git clone https://github.com/flutter/flutter.git /sdk/flutter \
    && curl -LO https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip \
    && unzip commandlinetools-linux-7302050_latest.zip -d /sdk/android_sdk \
    && rm commandlinetools-linux-7302050_latest.zip \
    && ANDROID_SDK_ROOT=/sdk/android_sdk yes | /sdk/android_sdk/cmdline-tools/bin/sdkmanager --licenses \
    && ANDROID_SDK_ROOT=/sdk/android_sdk /sdk/android_sdk/cmdline-tools/bin/sdkmanager --update \
    && ANDROID_SDK_ROOT=/sdk/android_sdk /sdk/flutter/bin/flutter doctor -v
