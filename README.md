## sni反代解锁netflix

- [点击获取sni反代IP](https://fofa.info/result?qbase64=Ym9keT0iQmFja2VuZCBub3QgYXZhaWxhYmxlIg%3D%3D)

- [点击下载Acrylic（DNS服务）](https://mayakron.altervista.org/support/acrylic/Home.htm)

1：win系统命令行输入`ipconfig`查看默认默认网关，打开`AcrylicUI.exe`

2：打开`Acrylic`，点击 `File `再点击 `Open Acrylic Configuration` 打开配置文件，将第`12`行的 `8.8.8.8` 改为你的默认网关，将倒数第`6`行复制到最后一行，按 `Ctrl + S` 保存。

3：打开`Acrylic`，点击 `File` 再点击 `Open Acrylic Hosts` 打开 `Hosts` 文件，将本仓库的 `Hosts` 文件复制，粘贴到最下面，然后将获取到的`sni`反代`IP`替换，按 `Ctrl + S` 保存。

4：将本机的`dns`服务器设置为 `127.0.0.1` ，如果是其他局域网设备则填本机的`IP`地址，不在局域网的设备则填本机的公网`IP`。

5：如果更换了反代IP，则需清除dns缓存，命令：`ipconfig /flushdns`，反代IP尽量选择地理位置离你近的，并且只能解锁没有被墙的网站。

---

## 3xui配置

- 增加 DNS 配置

```
hosts: 定义了一些特定域名的 IP 地址映射。

geosite:netflix 和 geosite:disney 的 DNS 请求将被解析为 6.6.6.6。
```
```
servers: 配置了用于 DNS 解析的服务器。

8.8.8.8（Google DNS）和 1.1.1.1（Cloudflare DNS）。
```

--- 

## 劫持cookie实现免费观看netflix

- [下载中间人劫持工具](https://github.com/zu1k/Good-MITM/releases)

Linux一般下载`good-mitm-0.4.2-x86_64-unknown-linux-gnu.tar.xz`这个版本，win系统下载`good-mitm-0.4.2-x86_64-pc-windows-gnu.zip`这个版本

- 解压
```
xz -d good-mitm-0.4.2-x86 64-unknown-linux-gnu.tar.xz
tar -xvf good-mitm-0.4.2-x86 64-unknown-linux-gnu.tar
```

- 创建配置文件
```
touch netflix.yaml
```
将配置文件复制进去，并替换相应的`cookie`


- 生成证书
```
./good-mitm genca
```

- 后台运行
```
nohup ./good-mitm run -r netflix.yaml > goodmitm.log 2>&1 &
```

此时`good-mitm`程序会开放`34567`端口，将出站的`netflix`流量路由到这个端口的地址即可，地址`127.0.0.1:34567`
