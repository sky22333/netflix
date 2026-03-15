#!/bin/bash
# ==========================================
# DNS 解锁脚本（支持 -ip 参数）
# 用法：
#   bash install.sh -ip 6.6.6.6
# ==========================================
TARGET_IP="203.137.98.127"
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -ip)
            if [[ -n "$2" ]]; then
                TARGET_IP="$2"
                shift 2
            else
                echo "错误: -ip 参数缺少 IP"
                exit 1
            fi
            ;;
        *)
            echo "未知参数: $1"
            echo "用法: $0 -ip <解锁IP>"
            exit 1
            ;;
    esac
done
echo "使用解锁 IP: $TARGET_IP"

if ! command -v dnsmasq &>/dev/null; then
    if command -v apt &>/dev/null; then
        apt update -yq
        apt install dnsmasq -yq
    elif command -v yum &>/dev/null; then
        yum install dnsmasq -y
    else
        echo "错误: 未找到支持的包管理器 (apt/yum)"
        exit 1
    fi
else
    echo "dnsmasq 已安装，跳过安装步骤"
fi

systemctl stop systemd-resolved 2>/dev/null || true
systemctl disable systemd-resolved 2>/dev/null || true
cat > /etc/dnsmasq.conf <<EOF
listen-address=127.0.0.1
no-resolv
server=8.8.8.8
# 直连解锁 IP
address=/.netflix.com/${TARGET_IP}
address=/.netflix.net/${TARGET_IP}
address=/.nflximg.com/${TARGET_IP}
address=/.nflximg.net/${TARGET_IP}
address=/.nflxvideo.net/${TARGET_IP}
address=/.nflxso.net/${TARGET_IP}
address=/.nflxext.com/${TARGET_IP}
address=/.fast.com/${TARGET_IP}
address=/.chatgpt.com/${TARGET_IP}
address=/.openai.com/${TARGET_IP}
EOF
rm -f /etc/resolv.conf
echo "nameserver 127.0.0.1" > /etc/resolv.conf
systemctl enable dnsmasq 2>/dev/null || true
systemctl restart dnsmasq
echo "配置完成"
systemctl status dnsmasq --no-pager -n 0
