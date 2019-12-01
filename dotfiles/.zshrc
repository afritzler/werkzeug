export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="af"
plugins=(
  git
  kubectl
)

source $ZSH/oh-my-zsh.sh

### PATH exports
export PATH="$PATH:$HOME/.rvm/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin"
export GO111MODULE=on

### Environment
export LANG=en_US.UTF-8

### Functions
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	alias pbcopy='xclip -selection clipboard'
	alias pbpaste='xclip -selection clipboard -o'
elif [[ "$OSTYPE" == "darwin"* ]]; then

fi

function set-kubeconfig() {
	if [[ "$1" == "" ]]; then
		echo "no kubeconfig specified"
		return 1
	fi
	export KUBECONFIG=$1
}

function unset-kubeconfig() {
	unset KUBECONFIG
}

function paste-clipboard-to-temp() {
	local file="$(mktemp)"
	pbpaste > "$file"
	echo "$file"
}

### Alias
alias ck='set-kubeconfig $(fzf -q ${1:-"kubeconfig"} -e -1 -0)'
alias k='kubectl'
alias sk='set-kubeconfig'
alias uk='unset-kubeconfig'
alias ctk='set-kubeconfig $(paste-clipboard-to-temp)'
alias watch='watch -c -n 1 '
alias watchd='watch -c -d -n 1 '
alias ks='kubectl -n kube-system'
alias kg='kubectl -n garden'
alias ka='kubectl get --all-namespaces'
alias kk='export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"'
unalias ksd

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

homebrew_source="$HOME/.homebrew"
[ -f "$homebrew_source" ] && source "$homebrew_source"
