FROM --platform=$BUILDPLATFORM rust:1.61.0-buster AS build

ARG TARGETARCH

# 安装必要的依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential git curl musl-tools upx pkg-config libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 克隆项目
RUN git clone https://github.com/zu1k/Good-MITM.git .

# 设置工作目录
WORKDIR Good-MITM

# 安装 Rust nightly 并进行构建
RUN rustup install nightly && rustup default nightly && \
    case "$TARGETARCH" in \
    "amd64") \
        RUST_TARGET="x86_64-unknown-linux-musl" \
        MUSL="x86_64-linux-musl" \
        ;; \
    "arm64") \
        RUST_TARGET="aarch64-unknown-linux-musl" \
        MUSL="aarch64-linux-musl" \
        ;; \
    *) \
        echo "Doesn't support $TARGETARCH architecture" && exit 1 \
        ;; \
    esac && \
    wget -qO- "https://musl.cc/$MUSL-cross.tgz" | tar -xzC /root/ && \
    CC=/root/$MUSL-cross/bin/$MUSL-gcc && \
    rustup target add $RUST_TARGET && \
    PKG_CONFIG_ALLOW_CROSS=1 RUSTFLAGS="-C linker=$CC" CC=$CC cargo build --target "$RUST_TARGET" --release && \
    mv target/$RUST_TARGET/release/good-mitm target/release/ && \
    upx -9 target/release/good-mitm

# 最终镜像
FROM alpine:3.20 AS good-mitm

# 拷贝可执行文件
COPY --from=build /Good-MITM/target/release/good-mitm /usr/bin

# 设置入口点
ENTRYPOINT [ "good-mitm" ]
