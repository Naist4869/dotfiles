# WARNING: PLEASE DO NOT USE THIS SCRIPT, JUST MANUALLY FOLLOW THE STEPS

# this script setup my personal ubuntu 18.04 dev-env for digital ocean host
cd ~

## install basic tools
apt update
apt -y upgrade
## aliyun extra
vi /etc/sysctl.conf 

#net.ipv6.conf.all.disable_ipv6 = 1 
net.ipv6.conf.eth0.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

sysctl -p 

apt install -y build-essential vim zsh git tree clang cmake libboost-dev libssl-dev tmux vim httpie youtube-dl pandoc redis docker.io nodejs htop hugo

# install golang
mkdir -p /usr/local/goes
cd /usr/local/goes
wget https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz
tar xvf go1.14.1.linux-amd64.tar.gz && rm go1.14.1.linux-amd64.tar.gz
mv /usr/local/goes/go /usr/local/goes/go1.14
ln -s /usr/local/goes/go1.14 /usr/local/goes/go
ln -s /usr/local/goes/go/bin/go /usr/local/bin/go
go env -w GOPROXY="https://goproxy.io,https://mirrors.aliyun.com/goproxy/,direct,https://proxy.golang.org"
go env -w GO111MODULE=on
go env -w GOPRIVATE="github.com/Naist4869"

## install python
apt install -y python3-pip
pip3 install virtualenv scipy numpy pandas jupyter tensorflow scikit-learn matplotlib seaborn pillow pyyaml requests

## install `oh-my-zsh`
cd ~/dotfiles
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
cp zsh/zshrc.conf ~/.zshrc
cat zsh/linux-zshrc.conf >> ~/.zshrc
cp zsh/changkun.zsh-theme ~/.oh-my-zsh/themes/
source ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
source ~/.zshrc

# install vim config
cp vim/vimrc.config ~/.vimrc
mkdir -p ~/.vim/colors/ && cp vim/colors/jellybeans.vim ~/.vim/colors/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall # slow
vim -c GoInstallBinaries
~/.vim/bundle/YouCompleteMe/install.py # --clang-completer --tern-completer # the last two are too slow, maybe later

# install tmux config
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
cp ~/.tmux/.tmux.conf.local ~/.
cp tmux/tmux.local.conf ~/.tmux.conf.local

# fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
