FROM openjdk:8-jdk
ARG ANDROID_COMPILE_SDK="28"
ARG ANDROID_BUILD_TOOLS="28.0.3" 
ARG ANDROID_SDK_TOOLS="4333796"


RUN apt-get --quiet update --yes 
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip 
RUN unzip -d android-sdk-linux android-sdk.zip 
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null 
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null 
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null 
RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses 

ENV ANDROID_HOME=$PWD/android-sdk-linux \
    PATH=$PATH:$PWD/android-sdk-linux/platform-tools/