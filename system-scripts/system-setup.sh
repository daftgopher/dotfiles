#!/usr/bin/env zsh

# https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
unameOut=$(uname -a)
case "${unameOut}" in
*Microsoft*) OS="WSL" ;;  #must be first since Windows subsystem for linux will have Linux in the name too
*microsoft*) OS="WSL2" ;; #WARNING: My v2 uses ubuntu 20.4 at the moment slightly different name may not always work
Linux*) OS="Linux" ;;
Darwin*) OS="Mac" ;;
CYGWIN*) OS="Cygwin" ;;
MINGW*) OS="Windows" ;;
*Msys) OS="Windows" ;;
*) OS="UNKNOWN:${unameOut}" ;;
esac

echo ${OS}

cd $HOME

# Install git
if [[ $OS == "Mac" ]]; then
	echo "Mac OS detected"
	# Detect if git installed and prompt if not
	git --version
	# Install homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	INSTALLER="brew"
elif [[ $OS == "Linux" ]]; then
	INSTALLER="apt"
	apt update
fi

PACKAGES=("curl" "git" "fd" "fzf" "neovim" "nmap" "gpg" "gawk" "tmux")
BREW_PACKAGES=("coreutils", "chezmoi")

# Install packages
function installPackages() {
	local packages=("$@")
	for P in "${packages[@]}"; do
		if [[ $OS == "Linux" ]]; then
			apt install -y "$P"
		elif [[ $OS == "Mac" ]]; then
			brew install "$P"
		fi
	done
}

installPackages "${PACKAGES[@]}"

if [[ $OS == "Mac" ]]; then
	installPackages "${BREW_PACKAGES[@]}"
fi

if [[ $OS == "Linux" ]]; then
	sh -c "$(curl -fsLS get.chezmoi.io/lb)"
fi


export PATH="$HOME/.local/bin:$PATH"

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

# Initialize chezmoi
chezmoi init --apply https://github.com/daftgopher/dotfiles.git

# Install language support with asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0
cd $HOME

source ~/.zshrc

LANGUAGES=("nodejs" "golang" "rust" "python")
for lang in ${LANGUAGES[@]}; do
	asdf plugin add $lang
	asdf install $lang latest
done

# Make zsh the default
chsh -s $(which zsh)

source ~/.zshrc

echo "Setup complete. Run: "
echo ""
echo "source ~/.zshrc"
echo ""
echo "to start"

