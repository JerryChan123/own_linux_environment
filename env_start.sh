#/bin/bash

echo "开始安装vim及其插件\n"
#移除本身自带vim,编译新的vim



echo "开始配置opengl环境\n"
#安装opengl
#调试命令=gcc hw_opengl.cpp -o hw_opengl -lGL -lGLU -lglut
sudo apt-get install libglu1-mesa-dev freeglut3-dev mesa-common-dev
#安装ycm的py支持
sudo apt-get install python-dev python3-dev

echo "opengl 环境配置成功\n"
#编译ycm需要
sudo apt-get install mono-xbuild
echo "-------------------------------\n"


echo"开始配置vim文件\n"

if [ !  -d $HOME/.vim/bundle  ]; then
  sudo  rm rf ~/.vim/bundle
fi
echo "正在下载vbundle\n"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "vbundle下载完毕\n"

echo "单独下载YCM插件----------\n"

cd $HOME/.vim/bundle

git clone https://github.com/Valloric/YouCompleteMe.git

cd YouCompleteMe

#下载third_party文件
git submodule update --init --recursive

cd $HOME/.vim/bundle/YouCompleteMe

#建立软连接
ln .ycm_extra_conf.py $HOME 

ln .vimrc $HOME

./install.py --all

echo "脚本执行结束，下面请运行:PluginInstall操作"
