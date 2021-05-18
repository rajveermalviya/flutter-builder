FROM docker.io/library/ubuntu:21.04

RUN apt update && apt install -y curl git unzip openjdk-11-jdk

RUN useradd -ms /bin/bash flutterbuilder
USER flutterbuilder
WORKDIR /home/flutterbuilder

RUN mkdir -p sdk/android_sdk/cmdline-tools/latest
ENV ANDROID_SDK_ROOT /home/flutterbuilder/sdk/android_sdk
RUN mkdir -p .android && touch .android/repositories.cfg

RUN curl -LO https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip
RUN unzip commandlinetools-linux-7302050_latest.zip && rm commandlinetools-linux-7302050_latest.zip
RUN mv cmdline-tools/* ${ANDROID_SDK_ROOT}/cmdline-tools/latest/ && rm -r cmdline-tools/
ENV PATH "$PATH:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/:${ANDROID_SDK_ROOT}/platform-tools"
RUN yes | sdkmanager --licenses
RUN sdkmanager "build-tools;30.0.3" "patcher;v4" "platform-tools" "platforms;android-30"

RUN git clone https://github.com/flutter/flutter.git -b stable /home/flutterbuilder/sdk/flutter
ENV PATH "$PATH:/home/flutterbuilder/sdk/flutter/bin"
RUN flutter precache && flutter config --no-analytics
ENTRYPOINT [ "flutter" ]
