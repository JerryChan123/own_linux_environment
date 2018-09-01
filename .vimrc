"定义快捷键的前缀，即<Leader>
"
let mapleader=";"
" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 定义快捷键在结对符之间跳转
nmap <Leader>M %
" 跳转至右方的窗口
noremap <Leader>lw <C-W>l
"" 跳转至左方的窗口
noremap <Leader>jw <C-W>h
"" 跳转至上方的子窗口
noremap <Leader>iw <C-W>k
"" 跳转至下方的子窗口
noremap <Leader>kw <C-W>j

"MinBufExplorer
map <F3> :MBEToggle<cr>
map <leader>11  :MBEbn<cr> 
map <leader>12  :MEBbp<cr>
set mouse =a

"下面的快捷键只针对Cmake的Project等于main的时候
"gcc保存所有文档以及make编译内容
nmap <Leader>m :!rm -rf main<CR>:wa<CR>:make<CR><CR>:cw<CR>

"gcc保存所有文档以及make编译内容以及运行
nmap <Leader>g :!rm -rf main<CR>:wa<CR>:make<CR>:cw<CR><CR>:!./main<CR>




" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认、整词
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>






"inoremap <leader>; <C-x><C-o>

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 定义快捷键到行首和行尾
nmap <leader>uu 0
nmap <leader>ii $

" 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>sf :CtrlSF<CR>

" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>

"自动打开NerdTree
"autocmd vimenter * NERDTree

" NERDTree config
"autocmd vimenter * NERDTree
nmap <F2> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
"---------------------------------------------------------------------
"
"
"
"
"

" *.cpp 和 *.h 间切换
nmap <silent> <Leader>sw :FSHere<cr>



" 设置插件 indexer 调用 ctags 的参数
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"





"基于标签的标识符列表

"安装tagbar插件
""设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_ctags_bin='/usr/bin/ctags'



"自动打开
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
" 设置 tagbar 子窗口的位置出现在主编辑区的左边
let tagbar_right=1
" 设置显示／隐藏标签列表子窗口的快捷键.
nmap <F8> :TagbarToggle<CR>
" 设置标签子窗口的宽度
let tagbar_width=28
" tagbar 子窗口中不显示冗余帮助信息
let g:tagbar_compact=1
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0',
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

"------------------------------------------------
"解决YCM No .ycm extra_conf.py file detected问题
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0

" 开启 YCM 标签引擎
let g:ycm_collect_identifiers_from_tags_files=1

" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 补全功能在注释中同样有效                                         
let g:ycm_complete_in_comments=1                                   
" 开启tags补全引擎                                                 
let g:ycm_collect_identifiers_from_tags_files=1                    
" 键入第一个字符时就开始列出匹配项                                 
let g:ycm_min_num_of_chars_for_completion=1
"静止缓存匹配项，每次都生成新的匹配项目
let g:ycm_cache_omnifunc=0
"语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1  
" YCM相关快捷键，分别是\gl, \gf, \gg,一般直接使用;gg就可以了                                                    
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>              
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>               
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>


let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }




" 引入 C++ 标准库tags
set tags+=~/.tags/stdcpp.tags


" 设置 pullproto.pl 脚本路径
let g:protodefprotogetter='~/.vim/bundle/protodef/pullproto.pl'
" 成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1

" vundle 环境设置
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch

let g:Powerline_colorscheme='solarized256'

" 设置 gvim 显示字体
set guifont=YaHei\ Consolas\ Hybrid\ 11

" 禁止折行
set nowrap

" 配色方案
"set background=dark
"colorscheme solarized
"colorscheme molokai
"colorscheme phd

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on


" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable


" 随 vim 自启动
"let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
"let g:indent_guides_start_level=2
" 色块宽度
"let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
":nmap <silent> <Leader>i <Plug>IndentGuidesToggle



"配置ctrlsf
"if executable('ag')
let g:ctrlsf_ackprg = 'ack'
"endif
let g:ctrlsf_case_sensitive = 'smart'
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_default_view_mode = 'normal'
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '25%'

" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Raimondi/delimitMate'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/phd'
Plugin 'Lokaltog/vim-powerline'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
Plugin 'dyng/ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/DrawIt'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'derekwyatt/vim-protodef'
Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'yegappan/grep'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'gcmt/wildfire.vim'
Plugin 'sjl/gundo.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'suan/vim-instant-markdown'
Plugin 'lilydjwg/fcitx.vim'
" 插件列表结束
call vundle#end()
filetype plugin indent on
"---------
" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
	call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>
" 启动 vim 时自动全屏
autocmd VimEnter * call ToggleFullscreen()


" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch



" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()"
" 加入注释
func SetComment()
	call setline(1,"/*================================================================")
	call append(line("."),   "*   Copyright (C) ".strftime("%Y")." Sangfor Ltd. All rights reserved.")
	call append(line(".")+1, "*   ")
	call append(line(".")+2, "*   file name：".expand("%:t"))
	call append(line(".")+3, "*   author：linchen")
	call append(line(".")+4, "*   create time：".strftime("%Y年%m月%d日"))
	call append(line(".")+5, "*   des：")
	call append(line(".")+6, "*")
	call append(line(".")+7, "================================================================*/")
	call append(line(".")+8, "")
	call append(line(".")+9, "")
endfunc
" 加入shell,Makefile注释
func SetComment_sh()
	call setline(3, "#================================================================")
	call setline(4, "#   Copyright (C) ".strftime("%Y")." Sangfor Ltd. All rights reserved.")
	call setline(5, "#   ")
	call setline(6, "#   file name：".expand("%:t"))
	call setline(7, "#   author：linchen")
	call setline(8, "#   create time：".strftime("%Y年%m月%d日"))
	call setline(9, "#   des:")
	call setline(10, "#")
	call setline(11, "#================================================================")
	call setline(12, "")
	call setline(13, "")
endfunc
" 定义函数SetTitle，自动插入文件头
func SetTitle()
	if &filetype == 'make'
		call setline(1,"")
		call setline(2,"")
		call SetComment_sh()

	elseif &filetype == 'sh'
		call setline(1,"#!/system/bin/sh")
		call setline(2,"")
		call SetComment_sh()

	else
	     call SetComment()
	     if expand("%:e") == 'hpp'
		  call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H")
		  call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H")
		  call append(line(".")+12, "#ifdef __cplusplus")
		  call append(line(".")+13, "extern \"C\"")
		  call append(line(".")+14, "{")
		  call append(line(".")+15, "#endif")
		  call append(line(".")+16, "")
		  call append(line(".")+17, "#ifdef __cplusplus")
		  call append(line(".")+18, "}")
		  call append(line(".")+19, "#endif")
		  call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H")

	     elseif expand("%:e") == 'h'
	  	call append(line(".")+10, "#pragma once")
	     elseif &filetype == 'c'
	  	call append(line(".")+10,"#include \"".expand("%:t:r").".h\"")
	     elseif &filetype == 'cpp'
	  	call append(line(".")+10, "#include \"".expand("%:t:r").".h\"")
	     endif
	endif
endfunc
autocmd BufNewFile * normal G
