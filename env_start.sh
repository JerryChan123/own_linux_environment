#/bin/bash

echo "开始配置opengl环境\n"
#安装opengl
#调试命令=gcc hw_opengl.cpp -o hw_opengl -lGL -lGLU -lglut
sudo apt-get install libglu1-mesa-dev freeglut3-dev mesa-common-dev
#安装ycm的py支持
sudo apt-get install python-dev python3-dev

echo "opengl 环境配置成功\n"


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



./install.py --all

echo "脚本执行结束，下面请运行:PluginInstall操作"
