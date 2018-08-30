#!/bin/bash

#以下路径都需要输入绝对路径，可以通过pwd进行查询，
#不能输入~/linchen类似的路径


#文章参考：https://www.jianshu.com/p/5619e8ef6652  （系统tags的生成）




#/home/linchen/exmaple
echo "输入项目的地址，注意最后一个字符不能为/："
read LOCATION 

#ex：/usr/include/cpp/7.3.0
echo "输入/usr/include中的C++地址："
read CPP 

#如果没初始化indexer.files，则初始化该目录

indexerPath="$HOME/.indexer_files"

if [ ! -e $indexerPath  ]; then
    touch $indexerPath 
fi

#将项目自动添加到.indexer_files中
#[exmaple]
# /home/linchen/file/cpp/exmaple


hello=$LOCATION

cp .ycm_extra_conf.py  $LOCATION
tempTxt=$HOME/temp.txt

if [ -e  $tempTxt    ]; then
    rm $tempTxt
fi   
    
    
grep "$hello" $indexerPath  > $tempTxt
if [ ! -s  $tempTxt  ]; then
    fileName=${hello##*/}
    echo "[$fileName]\n$hello"  >> $indexerPath 
    echo "文件名为：$fileName,写入indexer成功"
fi


#如果没安装ctags，安装ctags

ctagsPath="/usr/bin/ctags"
if [ ! -e $ctagsPath  ]; then
    sudo apt-get install ctags

fi



##生成项目的tag

cd $LOCATION

ctags -R --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+liaS --extra=+q --language-force=c++

echo "项目tags文件配置完成"


#安装ack到电脑上

f="$HOME/bin"
if [ ! -d $f ]; then
  mkdir $f
fi

ackPath=$f/ack

if [ ! -e $ackPath ]; then
    curl https://beyondgrep.com/ack-2.24-single-file > $HOME/bin/ack && chmod 0755 $HOME/bin/ack
fi



#生成系统c++的tag

f="$HOME/.tags"
if [ ! -d $f ]; then
  mkdir $f
fi

if [ ! -d $f/stdcpp.tags ]; then
    cd $CPP
    sudo ctags -R --c++-kinds=+l+x+p --fields=+iaSl --extra=+q --language-force=c++ -f stdcpp.tags
    cp $CPP/stdcpp.tags $f
    echo "复制c++系统tags成功"
fi

echo "finish"

