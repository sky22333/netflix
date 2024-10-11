## sni反代解锁netflix

- [点击获取sni反代IP](https://fofa.info/result?qbase64=Ym9keT0iQmFja2VuZCBub3QgYXZhaWxhYmxlIg%3D%3D)

- [点击下载Acrylic（DNS服务）](https://mayakron.altervista.org/support/acrylic/Home.htm)

#### 1：win系统命令行输入`ipconfig`查看默认默认网关，打开`AcrylicUI.exe`

#### 2：打开`Acrylic`，点击 `File `再点击 `Open Acrylic Configuration` 打开配置文件，将第`12`行的 `8.8.8.8` 改为你的默认网关，将倒数第`6`行复制到最后一行，按 `Ctrl + S` 保存。

#### 3：打开`Acrylic`，点击 `File` 再点击 `Open Acrylic Hosts` 打开 `Hosts` 文件，将本仓库的 `Hosts` 文件复制，粘贴到最下面，然后将获取到的`sni`反代`IP`替换，按 `Ctrl + S` 保存。

#### 4：将本机的`dns`服务器设置为 `127.0.0.1` ，如果是其他局域网设备则填本机的`IP`地址，不在局域网的设备则填本机的公网`IP`。
