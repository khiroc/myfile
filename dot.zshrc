# zshcallがあれば読み込む
# [ -f ~/.zshrcall ] && source ~/.zshrcall

export LANG=ja_JP.UTF-8

# プロファイルがあれば読み込む
if [ -f /etc/profile ]; then
	. /etc/profile
fi

# プロンプト、表示
# rootは普段使わないからてきとー
if [ $USER = "root" ]
then
	PROMPT="%B%{[31m%}[${USER}@${HOSTNAME}%/#%{[m%}%b "
	RPROMPT="[%~]"
	HOME=/root
else
	#PROMPT="%B%{[31m%}[$USER]%/#%{[m%}%b "
	PROMPT="[${USER}@${HOSTNAME}][%T]%(!.#.$)"
	RPROMPT='[%~]'
fi

#プロンプトのカラー表示
autoload -U colors
colors


# エスケプシーケンスを使う
setopt prompt_subst

#コマンドの履歴を残す
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

# 履歴ファイルに時刻を記録
setopt extended_history

# 履歴をインクリメンタルに追加
setopt inc_append_history

# ヒストリに追加されるコマンドが前に使った削除
setopt hist_ignore_all_dups

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify


#補完機能
autoload -U compinit
compinit

# 補完キー連打で順に補完候補を自動で補完
setopt auto_menu

# 補完侯補をEmacsのキーバインドで動き回る
zstyle ':completion:*:default' menu select=1

# 補完の時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完の表示を過剰にする
zstyle ':completion:*' verbose yes
# 様々な補完（ミススペル、履歴などなど
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
# いろいろ色つき表示
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'

#LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# 間違ってディレクトリ名だけを入力しても移動
setopt auto_cd

# cdでpushdする。
setopt auto_pushd

# pushdで同じディレクトリを重複してpushしない。
setopt pushd_ignore_dups

# コマンドを間違っても修正してくれる
setopt correct

# 補完機能の候補をつめて表示する
setopt list_packed

# ^Dでログアウトしない
setopt ignore_eof


# cdを打ったら自動的にlsを打ってくれる関数
function cd(){
    builtin cd $@ && ls -GF;
}


# screenのときに自動命名
preexec () {
    if [ $TERM = "screen" ]; then
        1="$1 " # deprecated.
        echo -ne "\ek${${(s: :)1}[0]}\e\\"
    fi
  }

function ssh_screen(){
 eval server=\${$#}
 screen -t $server ssh "$@"
}
if [ x$TERM = xscreen ]; then
  alias ssh=ssh_screen
fi

# screenのセッション保存先
export SCREENDIR=~/tmp/screen/

###alias###
alias l="ls"
alias ls="ls -GF"
alias la="ls -lhAGFTv"
alias ll="ls -lhAGFTv | less"

alias c="cd"

alias cp="cp -ir"
alias cpf="/bin/cp -frv"
alias rm="rm -ir"
alias rmf="/bin/rm -frv"
alias mv="mv -i"

alias lf="less +F"
alias tf="tf"

alias s="sudo"
alias kk="kill -KILL"

alias eclipse="/Applications/eclipse/Eclipse.app/Contents/MacOS/eclipse -clean"
alias cemacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
alias v="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias gv='env LANG=ja_JP.UTF-8 open -a /Applications/MacVim.app "$@"'
alias gvi='env LANG=ja_JP.UTF-8 open -a /Applications/MacVim.app "$@"'
alias gvim='env LANG=ja_JP.UTF-8 open -a /Applications/MacVim.app "$@"'
alias ctags_mv='/Applications/MacVim.app/Contents/MacOS/ctags "$@"'

alias -g H=' --help | less'
alias -g L='| less'
