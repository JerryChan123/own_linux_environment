#/bin/bash

echo "开始配置opengl环境\n"
#安装opengl
#调试命令=gcc hw_opengl.cpp -o hw_opengl -lGL -lGLU -lglut
sudo apt-get install libglu1-mesa-dev freeglut3-dev mesa-common-dev

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


