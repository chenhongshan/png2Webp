# png2Webp

------------
macOs中的shell脚本，该脚本可以批量/单个将png格式图片转换为webp格式图片。

### 工具创建背景
在当前的Android开发工作中,为了包瘦身选择了使用**webp**格式图片全面替换apk中的png图片(ic_launcher.png除外),为了~~偷懒~~工作的方便,便学习shell创建了此脚本。

### 使用方法
在macOs中打开`terminal`指令工具界面中，输入：

```terminal
bash /Users/XXX/Desktop/Png2Webp/png2webp.sh /Users/XXX/Desktop/test
```
其中`/Users/XXX/Desktop/Png2Webp/png2webp.sh`为脚本路径
`/Users/XXX/Desktop/test`为需要转换为webp格式的png文件夹路径，路径也可以是单个png文件的路径如：`/Users/XXX/Desktop/test/test.png`

输入指令后回车，即可运行脚本将**test**文件夹中的png文件转换为webp格式文件。

或者：

先对shell脚本进行授权：

```terminal
chmod +x /Users/XXX/Desktop/Png2Webp/png2webp.sh
```
输入指令后回车，获得授权之后，后面使用时可直接输入：

```terminal
/Users/XXX/Desktop/Png2Webp/png2webp.sh /Users/XXX/Desktop/test

```
授权成后，可直接输入脚本路径+空格+文件夹(或单个png文件)路径，即可运行脚本，进行格式转换。

### 注意事项
如果在执行脚本时，提示cwebp来自不受信任的开发者时可以进行以下操作：

1. 在`terminal`界面通过**brew install webp**指令，从网络仓库安装webp工具到本地，安装成功之后再次运行脚本即可。

2. 打开`系统偏好设置`，在`安全性与隐私`》`通用`面板底部将会出现**cwebp**的相关信息，点击`任打开`按钮，回到`terminal`面板中再次运行脚本即可。

注: 若本地已经安装了`cwebp`指令工具，则脚本将使用安装的指令工具进行文件格式转换操作。安装可能需要较长的等待时间。也可考虑下面的方案。

### 关于/bin/cwebp
`cwebp`指令工具可以自行从[官网](https://developers.google.com/speed/webp/docs/precompiled)下载后放入脚本所在文件夹的`/bin`目录中

