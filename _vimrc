" Configuration file for gvim
" Written for Debian GNU/Linux by W.Akkerman <wakkerma@debian.org>
" Some modifications by J.H.M. Dassen <jdassen@wi.LeidenUniv.nl>

" Edited by John F. Davis (jfd)

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults (much better!)
set backspace=2		" allow backspacing over everything in insert mode
" Now we set some defaults for the editor 
set autoindent		" always set autoindenting on
set textwidth=0		" Don't wrap words by default
set nobackup		" Don't keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more than
			" 50 lines of registers
set history=50		" keep 50 lines of command line history
"set ruler		" show the cursor position all the time
set sw=4
set ts=4
set paste
"set statusline=%<%f%h%m%r%=%l,%c%V\ %P
set statusline=%<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)%O'%02b'
set laststatus=2
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
set background=light


:map <C-v> "+gP
:map <C-c> "+y
:map <C-x> "+x
:map! <C-v> <C-R>+


" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" taglist stuff
filetype on
let Tlist_Ctags_Cmd="/usr/bin/ctags"
"set tags=./tags,tags,/opt/dbox2/cdkroot/include/tags,/home/davis/progs/c/pciutils-2.1.11-deb,/usr/include/tags
"set tags=./tags,tags,/opt/dbox2/cdkroot/include/tags
set tags=./tags,tags,/usr/src/tags

" Vim5 comes with syntaxhighlighting. If you want to enable syntaxhightlighting
" by default uncomment the next three lines. 
if has("syntax")
  syntax on		" Default to no syntax highlightning 
endif

" Debian uses compressed helpfiles. We must inform vim that the main
" helpfiles is compressed. Other helpfiles are stated in the tags-file.
"set helpfile=$VIMRUNTIME/doc/help.txt.gz

if has("autocmd")

" Set some sensible defaults for editing C-files
augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For *.c and *.h files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd BufRead *       set formatoptions=tcql nocindent comments&
  autocmd BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
"ugroup END

" Also, support editing of gzip-compressed files. DO NOT REMOVE THIS!
" This is also used when loading the compressed helpfiles.
"augroup gzip
  " Remove all gzip autocommands
"  au!

  " Enable editing of gzipped files
  "	  read:	set binary mode before reading the file
  "		uncompress text in buffer after reading
  "	 write:	compress file after writing
  "	append:	uncompress file, append, compress file
"  autocmd BufReadPre,FileReadPre	*.gz set bin
"  autocmd BufReadPre,FileReadPre	*.gz let ch_save = &ch|set ch=2
"  autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
"  autocmd BufReadPost,FileReadPost	*.gz set nobin
"  autocmd BufReadPost,FileReadPost	*.gz let &ch = ch_save|unlet ch_save
"  autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")
""
"  autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
"  autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

"  autocmd FileAppendPre			*.gz !gunzip <afile>
"  autocmd FileAppendPre			*.gz !mv <afile>:r <afile>
"  autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
"  autocmd FileAppendPost		*.gz !gzip <afile>:r
"augroup END

augroup bzip2
  " Remove all bzip2 autocommands
  au!

  " Enable editing of bzipped files
  "       read: set binary mode before reading the file
  "             uncompress text in buffer after reading
  "      write: compress file after writing
  "     append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre        *.bz2 set bin
  autocmd BufReadPre,FileReadPre        *.bz2 let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost      *.bz2 |'[,']!bunzip2
  autocmd BufReadPost,FileReadPost      *.bz2 let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost      *.bz2 execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost    *.bz2 !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost    *.bz2 !bzip2 <afile>:r

  autocmd FileAppendPre                 *.bz2 !bunzip2 <afile>
  autocmd FileAppendPre                 *.bz2 !mv <afile>:r <afile>
  autocmd FileAppendPost                *.bz2 !mv <afile> <afile>:r
  autocmd FileAppendPost                *.bz2 !bzip2 -9 --repetitive-best <afile>:r
augroup END

endif " has ("autocmd")

" Some Debian-specific things
augroup filetype
  au BufRead reportbug.*		set ft=mail
augroup END

" The following are commented out as they cause vim to behave a lot
" different from regular vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make


" moving around in buffers
map <silent> <C-H> :bp<CR>
map <silent> <C-J> <C-W>j
map <silent> <C-K> <C-W>k
map <silent> <C-L> :bn<CR>
map <silent> ,n :sbn<CR>
map <silent> ,p :sbp<CR>
