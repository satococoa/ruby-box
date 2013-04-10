# RubyBox
Ruby 学習者用の VM です。  
Ruby / Rails 勉強会等での使用を想定しています。

CentOS 6.3 に git, rbenv, ruby-build, ruby 等、すぐに ruby で開発ができるところまで環境を整えます。

環境は VirtualBox の VM 上に作られますので、自分の PC 環境を一切汚すこと無く学習が進められます。

## How to setup
1. [VirtualBox](https://www.virtualbox.org) をインストール
2. [Vagrant](http://www.vagrantup.com) をインストール
3. ターミナル (コマンドプロンプト) から以下のコマンドを実行

```
git clone git://github.com/satococoa/ruby-box.git
cd ruby-box
vagrant up
```

## How to use

VM にログイン: `vagrant ssh`

