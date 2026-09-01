FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    wget \
    unzip \
    git \
    curl \
    cmake \
    ninja-build \
    libgtk-3-dev \
    pkg-config \
    clang \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Flutter SDK
RUN git clone --depth 1 -b stable https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:$PATH"

RUN flutter config --no-analytics
RUN flutter doctor -v

WORKDIR /app
COPY . /app/

RUN flutter pub get
RUN flutter build apk --release

CMD ["echo", "Build complete"]
