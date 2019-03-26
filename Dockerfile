FROM openjdk:8-jdk
ARG ANDROID_COMPILE_SDK="28"
ARG ANDROID_BUILD_TOOLS="28.0.3" 
ARG ANDROID_SDK_TOOLS="4333796"
ENV ANDROID_HOME=/opt/android

RUN apt-get --quiet update --yes \
    && apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
    && wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip \
    && unzip -d $ANDROID_HOME android-sdk.zip \
    && rm -f android-sdk.zip \
    && echo y | $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null \
    && echo y | $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" >/dev/null \
    && echo y | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null \
    && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses 

ENV PATH=$PATH:$ANDROID_HOME/platform-tools/