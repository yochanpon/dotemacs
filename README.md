# dotemacs

## 起動する前に行っておくこと

- ネイティブインストールできるように必要なツールをインストール

sudo apt-get install build-essential texinfo

- ~/.bashrcに以下のスクリプトを実装

perl -wle \
    'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
    PATH > ~/.emacs.d/shellenv.el

上記を記述したら、source .bashrc を実行する。

- migemoをインストール

sudo apt-get install migemo
