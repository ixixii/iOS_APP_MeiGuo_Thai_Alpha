todo list 0: 拿到美国区开发者账号后，
登陆https://appleid.apple.com/
索取验证码
进入后，点击安全 -> 添加受信任的电话号码 √

todo list 1: 
1.1 退出developer.apple.com上中国区的开发者账号 
    重新登陆developer.apple.com/account/ios/profile/limited/create
    会向第0步里的电话号码发送验证码

    退出itunesconnect  
    重新登陆 https://itunesconnect.apple.com/

    退出xcode上的开发者账号（xcode一直不用登陆开发者）

1.2 开发者网站上面 创建证书 √
    1.打开Mac系统的钥匙串访问 -> 证书助理 -> 从证书颁发机构获取证书
      创建csr文件，选择存到磁盘
      常用名称：ThaiAlphabet
      邮箱写appleid的那个就行

    2.创建开发证书dev和生产证书dis
    3.下载证书，双击导入

// 1.3 添加真机设备？算了，直接用模拟器算了 （可以略过） √

1.4 创建应用ID，即注册appid √
    net.vwhm.thaialphabet

// 1.5 创建描述文件？算了，直接用模拟器算了 （可以略过） 

todo list 2: 转到itunesconnect创建应用 √
    转到itunesconnect,创建应用,新建app
    起名：ThaiAlpha （可能会提示名称已被注册）
    主要语言：英文
    隐私政策：privacy.html,放到 Linux服务器
    将本机的privacy.html scp 至 服务器
    ssh root@47.75.103.58
	password:
	cd /usr/local/nginx/html/vwhm_net_wwwroot/app/
	mkdir thaialpha

	切回本地终端：
	cd /Users/beyond/iOS_APP/thaialphabet
	scp /Users/beyond/iOS_APP/thaialphabet/privacy.html root@47.75.103.58:/usr/local/nginx/html/vwhm_net_wwwroot/app/thaialpha
	输入密码

	此时，再将url地址 http://vwhm.net/app/thaialpha/privacy.html，填回itunesconnect


    名称：ThaiAlpha
    副标题：Thai Alpha Learning
    类别：教育/工具
    价格：免费
    年龄分级：4+


todo list 3: 设计appicon 1024*1024  √
    然后一键生成所有图标：http://icon.wuruihong.com/

todo list 4: 新建xcode工程，create a new project
			 选择Tapped App
			 Product name: thaialpha

             然后先关闭xcode

todo list 5: 复制podfile，
             修改target为thaialpha
             然后执行pod install 
             打开thaialpha.xcworkspace，运行到模拟器上iPhone8   

todo list 6: 打开pod工程，开始编码和测试 √
6.1 把appicon图片拖进来，Assets.xcassets
    设置只支持iPhone且竖屏
6.2 工程新建目录：View,Model,Controller,Tools,Resources
6.3 打开main.storyboard，设置底部的tab文字Home,Me
    默认图标，选中图标
    在iconfont上找图标，下载svg，通过Sketch导出为@2x @3x图标
    Tab图标设计规范 https://www.jianshu.com/p/0ce2d11ef195
    75*75 @3x
    50*50 @2x
6.4 打开启动界面，加一个图标log和一个文字 √
LaunchScreen.xib加一个imageView
90*90,距离顶边120，垂直居中
新建一个目录：图片
把appicon@3x.png（180*180px）拖到里面，以供imageView引用     

6.5 设置顶部的状态条Status Bar Style 为 light content
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

6.6 背影图片 高斯模糊 调整配色
http://www.peise.net/tools/web/  三角形配色

6.7 tab的第2个界面



todo list 7: 打包ipa，Xcode不用登陆开发者账号，使用distribution provisoning file就行

			使用Application uploder上传ipa 
			打包上传时，不用XCODE，而是推荐使用Application uploder，但是需要用app专用密码登陆才行
			url: https://appleid.apple.com/
    		

todo list 8: 8种语言本地化 后，提交苹果审核
			关键词，记得要填写
			英文美国
			It is an Thai alphabet learning software. For those who are interested in Thai, this tool is necessary. It can help you quickly and firmly master Thai alphabet, including their pronunciation and writing scientifically and efficiently.



			中文简体
			一款泰语字母学习软件，对于那些对泰语感兴趣的人士来说这款工具是必备品，它能科学高效地帮您快速并且牢固地掌握泰语字母，包括他们的发音和书写

			中文繁体
			一款泰語字母學習軟體，對於那些對泰語感興趣的人士來說這款工具是必備品，它能科學高效地幫您快速並且牢固地掌握泰語字母，包括他們的發音和書寫

			英文英国
			英文加拿大
			英文澳大利亚

			日文
			タイ語のアルファベット学習ソフトは、タイ語に興味がある人にとって必要なツールです。科学的に効率的に迅速かつ確実にタイ語のアルファベットをマスターします。彼らの発音と書き込みが含まれます。

			韩文
			태국어 알파벳 학습 소프트웨어, 태국어에 흥미를 느끼는 사람들에게 이 공구는 필수품입니다. 그것은 과학적 효율적으로 당신에게 빠른 속도와 태국어 알파벳, 그들의 발음과 글씨를 포함하여 쓰기 포함합니다.


			版权：Alva Denise

todo list 9: 尾声，上传项目源代码到git
新建 .gitignore
在里面写上Pods
表示Pods目录不需要git来管理,因为它是pod install自动生成的

git init
git add --all
git commit -m 'iOS 美国区白包2 Thai Alpha 第一次提交'
git remote add origin https://github.com/ixixii/iOS_APP_MeiGuo_Thai_Alpha.git
git push -u origin master
git push origin master

todo list 10: 清理战场
    注销Application uploader, 
    developer.apple.com
    https://appstoreconnect.apple.com/login

    准备登陆下一个账号，写第3个美国区白包			


