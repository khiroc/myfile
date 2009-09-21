" my vimrc  Last Change: 22-Sep-2009.

:if version < 701
   :finish
:endif

"reset MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END


" ---------------------------------------------------------------------
" standard configure 基本設定

" viとの互換性をとらない(vimの独自拡張機能を使う)
" set nocompatible

" defult encode
" 基本はutf-8
" set fileencoding=utf-8

" backup configure バックアップの設定
" バックアップをとらない
set nobackup
" ファイルの上書きの前にバックアップを作る
" (ただし、backupがオフである場合、バックアップは上書き成功後に削除される)
set writebackup

" buffer adv バッファを保存せずに切り替え
set hidden

" autoread 他で書き換えられたファイルを自動でリロード
set autoread

" excommand history コマンド履歴拡張
set history=100


" auto indent オートインデントの設定
set smartindent
" set cindent
" set cinoptions=:0

" set tabindent タブインデントの設定
set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=2
autocmd MyAutoCmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd MyAutoCmd FileType make setlocal noexpandtab

" break delete バックスペース拡張
set backspace=2 

" command complete コマンド補完
set wildmenu
set wildmode=longest,list,full

" swap file ~/tmp スワップの置き場所
set directory-=.

" always crrent directoy 開いている場所をcrrent
au BufEnter * execute ":lcd " . expand("%:p:h")

" netrw config ディレクトリブラウザの設定
let g:netrw_liststyle = 1
" let g:netrw_list_hide = '.*\.swp$ , .*\.zip$'

" search 検索の設定
set incsearch
set hlsearch
set ignorecase
set smartcase

" search easy slash$question 検索時にスラッシュと？を自動エスケープ
cnoremap <expr> / getcmdtype() ==  '/' ? '\/' : '/'

" unused key Nop 使わないキーをNop
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" keyremap4macbook patch
if has('kaoriya')
  map <Down> <C-n>
  map <Up> <C-p>
  map <backspace> <C-h>
endif


" ---------------------------------------------------------------------
" display configure 表示設定

" colorscheme torte カラーテーマ
" colorscheme desert
colorscheme koehler
" syntax_on 構文ハイライト
syntax on

" 行番号を表示
set number

" statusline ステータスライン
" 入力中のステータスラインを表示
set showcmd
" ステータスラインを常に表示
set laststatus=2
" ステータスラインの表示内容
" set statusline=%<%F%m%r
" set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
set statusline=%<%F\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}
set statusline+=%=
set statusline+=[ci=%c]
set statusline+=[L=%l/%L]
set statusline+=[%p%%]

" 2byte文字の表示
set ambiwidth=double

" search-highlight 検索時にハイライト&esc連打でnoハイライト
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?
nnoremap * :<C-u>set hlsearch<Return>*
nnoremap # :<C-u>set hlsearch<Return>#


" カーソルの下にラインを引く(描画が遅くなる)
" set cursorline

" ウィンドウの横幅を84より大きくとる
" nnoremap <C-w>h <C-w>h:call <SID>good_width()<CR>
" nnoremap <C-w>l <C-w>l:call <SID>good_width()<CR>
" nnoremap <C-w>H <C-w>H:call <SID>good_width()<CR>
" nnoremap <C-w>L <C-w>L:call <SID>good_width()<CR>
" 
" function! s:good_width()
"   if winwidth(0) < 84
"    vertical resize 84
"   endif
" endfunction
 


" ---------------------------------------------------------------------
" key-change ショートカットキーの変更・設定

" <C-h> -> :help
nnoremap <C-h> :<C-u>help<Space>
nnoremap <Space>h :<C-u>help<Space>
" open mytips
nnoremap <Space>t :<C-u>help<Space>mytips.txt<CR>

" open vimrc
nnoremap <Space>, :<C-u>edit $MYVIMRC<CR>
" reload vimrc
if has("gui_running")
  command! ReloadVimrc source $MYVIMRC | source $MYGVIMRC
else
  command! ReloadVimrc source $MYVIMRC
endif

" autoreload vimrc
" autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" graphic move && center
vmap j gjzz
vmap k gkzz
nmap j gjzz
nmap k gkzz

" search etc keep center 真ん中をキープ
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" easy buffer move バッファ移動のショートカット
" nnoremap <silent> <Space>n :<C-u>bnext<CR>
" nnoremap <silent> <Space>p :<C-u>bprevious<CR>

" easy tab move タブ移動のショートカット
nnoremap <silent> <Space>n :<C-u>tabnext<CR>
nnoremap <silent> <Space>p :<C-u>tabprevious<CR>

" commentout コメントアウトのショートカット
" all
vnoremap <Space> <Nop>
vnoremap <Space>" :s/^/"<CR>:nohlsearch<CR>
vnoremap <Space>/ :s/^/\/\/<CR>:nohlsearch<CR>
vnoremap <Space># :s/^/#<CR>:nohlsearch<CR>
vnoremap <Space>% :s/^/%/<CR>:nohlsearch<CR>
vnoremap <Space>! :s/^/!/<CR>:nohlsearch<CR>
vnoremap <Space>- :s/^/--/<CR>:nohlsearch<CR>

" commentout delete コメント削除
vnoremap <Space>d :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

" ファイルタイプで簡単コメントアウト
" commentop.vimに乗り換え
" java mode 
" autocmd FileType java vnoremap <Space>c :s/^/\/\/<CR>:nohlsearch<CR>
" ruby mode
" autocmd FileType ruby vnoremap <Space>c :s/^/#<CR>:nohlsearch<CR>
" commentout end コメントアウトのショートカットおしまい


" quick write & quit & kwbd(keep window buf del)
nnoremap <Space>w :<C-u>up<CR>
nnoremap <Space>q :<C-u>quit<CR>
nnoremap <Space>d :<C-u>Kwbd<CR>
"<Leader><Leader>で変更があれば保存
noremap <Leader><Leader> :<C-u>up<CR>
" quick shell
" nnoremap <Space>s :<C-u>shell<CR>
" date insert
command! Date :r !date
" sudo write
" nnoremap <Space>S :<C-u>w !sudo tee %<CR>


" rename excmd exコマンドでリネーム
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))))

" emacs move
noremap! <C-f> <right>
noremap! <C-b> <left>
noremap! <C-a> <Home>
noremap! <C-e> <End>
noremap! <C-d> <Del>

" cmdline change :;
noremap ; :
noremap : ;

" <a>auto-</a>case  自動で括弧入力
" inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>

" nomal mode : enter->o+esc ノーマルモードでエンター改行
" 前の行のコメントを引き継ぐ
" noremap <CR> o<ESC>
" 改行オンリー
nnoremap <CR> :<C-u>call append(expand('.'), '')<Cr>j

" serach keyword under the cursor カーソル下のキーワードを検索 
" nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'
nnoremap <expr> <Space>* ':%substitute/\<' . expand('<cword>') . '\>/'

" tags-and-searches タグ移動
nnoremap [Tag]   <Nop>
nmap     t [Tag]
nnoremap [Tag]t  <C-]>zz
nnoremap <silent> [Tag]j  :<C-u>tag<CR>zz
nnoremap <silent> [Tag]k  :<C-u>pop<CR>zz
nnoremap <silent> [Tag]s  :<C-u>tags<CR>
" nnoremap t  <Nop>
" nnoremap tt  <C-]>zz
" nnoremap tj  :<C-u>tag<CR>
" nnoremap tk  :<C-u>pop<CR>
" nnoremap tl  :<C-u>tags<CR>
 
" its esay marksi & registers マーク・レジスタショートカット
nnoremap <Space>m  :<C-u>marks<CR>
nnoremap <Space>r  :<C-u>registers<CR>

" file open encoding shortcut 各エンコーディングで開き直すショートカット
command! -bang -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
command! -bang -nargs=? Euc edit<bang> ++enc=euc-jp <args>
" files open shortcut ディレクトリ以下を再帰的にargs
nnoremap <Space>a :<C-u>args **/*.*

" vimdiff abbreviate diff略語
cabbrev dt diffthis
cabbrev ds diffsplit
cabbrev do diffoff

" v mode search 直前に選択した範囲で検索
" vnoremap z/ <ESC>/\%V
" vnoremap z? <ESC>?\%V

"vimの戦闘力を計算する
command! -bar -nargs=? -complete=file CalcFP echo len(filter(readfile(empty(<q-args>) ? $MYVIMRC : expand(<q-args>)),'v:val !~ "^\\s*$\\|^\\s*\""'))



" ---------------------------------------------------------------------
" plugin configure プラグインの設定

" autocomplpop.vim
let g:acp_ignorecaseOption = 1

" buftabs.vim
"バッファタブにパスを省略してファイル名のみ表示する
let g:buftabs_only_basename = 1
"バッファタブをステータスライン内に表示する
" let g:buftabs_in_statusline = 1

" fuf.vim(fuzzyfinder.vim)
" Mru-file and Mru-cmd on
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 300
let g:fuf_mrucmd_maxItem = 400
" shortcut
nnoremap [Fuzzy]  <Nop>
nmap     f [Fuzzy]
nnoremap <silent> [Fuzzy]f :<C-u>FufFile!<CR>
nnoremap <silent> [Fuzzy]d :<C-u>FufDir!<CR>
nnoremap <silent> [Fuzzy]m :<C-u>FufMruFile!<CR>
nnoremap <silent> [Fuzzy]b :<C-u>FufBuffer!<CR>
nnoremap <silent> [Fuzzy]c :<C-u>FufMruCmd!<CR>
nnoremap <silent> [Fuzzy]t :<C-u>FufTag!<CR>
nnoremap <silent> [Fuzzy]a :<C-u>FufAddBookmark<CR>
nnoremap <silent> [Fuzzy]' :<C-u>FufBookmark<CR>
nnoremap <silent> [Fuzzy]r :<C-u>FufRenewCache<CR>
" ctl+Enter vsp
" let g:FufOptionVsplit = '<C-Enter>'
"ctl+Enter tabnew
" let g:FufOptionTabpage = '<C-Enter>'

" Ku.vim
" enter mapping overwrite
autocmd MyAutoCmd User plugin-ku-buffer-initialized call ku#default_key_mappings(1)
" shortcut
nnoremap <Space>kb :<C-u>Ku buffer<Return>
nnoremap <Space>kf :<C-u>Ku file<Return>
nnoremap <Space>kh :<C-u>Ku history<Return>
nnoremap <Space>km :<C-u>Ku file_mru<Return>
nnoremap <Space>kcc :<C-u>Ku cmd_mru/cmd<Return>
nnoremap <Space>kcs :<C-u>Ku cmd_mru/search<Return>

" MRU -Most Recently Used
let MRU_Max_Entries = 400
let MRU_Window_Height = 15
" let MRU_Use_Current_Window  =  1 
" let MRU_Auto_Close = 0
" let MRU_Add_Menu   = 0 

" neocomplcache.vim
" Don't use autocomplpop.
let g:AutoComplPop_NotEnableAtStartup = 1
" Use neocomplcache.
let g:NeoComplCache_EnableAtStartup = 1
" hoge -> hoge,Hoge || Hoge -> Hoge
let g:NeoComplCache_SmartCase = 1
" Use previous keyword completion.(前の単語を考慮して候補の並びを決定する)
let g:NeoComplCache_PreviousKeywordCompletion = 1
" Use tags auto update.
" let g:NeoComplCache_TagsAutoUpdate = 1
" Use preview window.
let g:NeoComplCache_EnableInfo = 1
" Use camel case completion. (AE -> ArgumentsException)
let g:NeoComplCache_EnableCamelCaseCompletion = 1
" Use underbar completion. (p_h -> public_html)
" let g:NeoComplCache_EnableUnderbarCompletion = 1
" Set minimum syntax keyword length.
let g:NeoComplCache_MinSyntaxLength = 3
" Set skip input time.
let g:NeoComplCache_SkipInputTime = '0.2'
" alphabeticalorder (候補の順番をアルファベット順にする)
" let g:NeoComplCache_AlphabeticalOrder = 1
" Set manual completion length.
let g:NeoComplCache_ManualCompletionStartLength = 1
" C-jでneocomplcache補完
inoremap <expr><C-j>  pumvisible() ? "\<C-j>" : "\<C-x>\<C-u>\<C-p>"

" refe.vim
" refer to ftplugin

" sudo.vim
nnoremap <Space>S :<C-u>e sudo:%<CR>

" scrach.vim (kaoriya patch)
" nnoremap <silent> <Space>s :<C-u>Scratch<CR>
nmap <unique> <silent> <Space>s <Plug>ShowScratchBuffer
" imap <unique> <silent> <Space>s <Plug>InsShowScratchBuffer
let g:scratchBackupFile=$HOME . "/tmp/scratch.txt"

" smartchr.vim 
inoremap <buffer><expr> = smartchr#one_of('=', ' = ', ' == ', ' === ', '=')
inoremap <buffer><expr> < smartchr#one_of('<', ' < ', ' <= ', '<')
inoremap <buffer><expr> > smartchr#one_of('>', ' > ', ' >= ', '>')

" smartword.vim
map w  <Plug>(smartword-w)zz
map b  <Plug>(smartword-b)zz
map e  <Plug>(smartword-e)zz
map ge <Plug>(smartword-ge)zz
noremap W  w
noremap B  b
noremap E  e
noremap gE ge

" surround.vim
" nnoremap gt cst
" ftpluginの方に書いたよ
" 今後もそっちに追加
" 追加内容をdocのmytipsに書こう

" taglist.vim
"right window 右側に表示 
let Tlist_Use_Right_Window = 1
" exit only window
let Tlist_Exit_OnlyWindow = 1
" 編集中のファイルのみ表示
let Tlist_Show_One_File = 1  
" vertically split taglist width
let Tlist_WinWidth = 40
" Automatically update the taglist to include newly edit files
let Tlist_Auto_Update = 1
" Maximum number of items in a tags sub-menu.
" Tlist_Max_Submenu_Items = 300
" Tlist shortcut
nnoremap <silent> [Tag]l  :<C-u>TlistToggle<CR><C-w>=
" FileExplorer+ winmanager.vimとの連携
" let winManagerWindowLayout = 'FileExplorer|TagList'
" objective-cに対応
if has('kaoriya')
  let tlist_objc_settings='objc;P:protocols;i:interfaces;I:implementations;M:instance methods;C:implementation methods;Z:protocol methods'
endif
" vimshell.vim
nnoremap <Space>v :<C-u>VimShell<CR>
" 非同期実行
" let g:VimShell_EnableInteractive = 1

" writebackup.vim
nnoremap <Space>b :<C-u>WriteBackup<CR>

" yankring.vim
nnoremap <Space>y :<C-u>YRShow<CR>
let g:yankring_window_height = 10



" ---------------------------------------------------------------------
" encoding 文字コードの自動認識(by ずんwiki コピペなので勉強すること)
if has(! "kaoriya")
  if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
  endif
  if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'eucjp-ms'
      let s:enc_jis = 'iso-2022-jp-3'
      " iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'euc-jisx0213'
      let s:enc_jis = 'iso-2022-jp-3'
    endif
    " fileencodingsを構築
    if &encoding ==# 'utf-8'
      let s:fileencodings_default = &fileencodings
      let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
      let &fileencodings = &fileencodings .','. s:fileencodings_default
      unlet s:fileencodings_default
    else
      let &fileencodings = &fileencodings .','. s:enc_jis
      set fileencodings+=utf-8,ucs-2le,ucs-2
      if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
        set fileencodings+=cp932
        set fileencodings-=euc-jp
        set fileencodings-=euc-jisx0213
        set fileencodings-=eucjp-ms
        let &encoding = s:enc_euc
        let &fileencoding = s:enc_euc
      else
        let &fileencodings = &fileencodings .','. s:enc_euc
      endif
    endif
    " 定数を処分
    unlet s:enc_euc
    unlet s:enc_jis
  endif
  " 日本語を含まない場合は fileencoding に encoding を使うようにする
  if has('autocmd')
    function! AU_ReCheck_FENC()
      if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
        let &fileencoding=&encoding
      endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
  endif
  " 改行コードの自動認識
  set fileformats=unix,dos,mac
  " □とか○の文字があってもカーソル位置がずれないようにする
  if exists('&ambiwidth')
    set ambiwidth=double
  endif
end
