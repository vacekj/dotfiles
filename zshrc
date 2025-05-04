# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias p=pnpm
alias px=pnpx
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:/Users/vacekj/.foundry/bin"

alias vim="nvim"

export HOMEBREW_NO_ENV_HINTS=true
alias c="cargo"
alias ytmp3='yt-dlp -x --audio-format mp3 --audio-quality 0 -o '\''%(title)s.%(ext)s'\'
alias gpn="git push --no-verify"
alias gpfn="git push --no-verify --force"

export PATH=$PATH:$HOME/.nargo/bin

eval "$(mcfly init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

unsetopt correct_all
setopt correct

# bun completions
[ -s "/Users/vacekj/.bun/_bun" ] && source "/Users/vacekj/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export DISABLE_ESLINT_PLUGIN=true
export HUSKY=0

alias bubu="brew upgrade"

function call {
  open -a FaceTime "tel://$1"
}

alias pi="pnpm i"
alias cwr="cargo watch -q -c -x 'run -q'"

abook() {
    local DIR="${1}"

    if [[ ! -d $DIR || -z $1 ]]; then
        DIR=$(pwd)
    fi

    # generating random name
    local NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)

    # generating book
    ls -1 "${DIR}/"*.mp3 | awk  '{printf "file |%s|\n", $0}' | \
        sed -e "s/|/\'/g" > "${DIR}/${NAME}.txt" \
        && ffmpeg -f concat -safe 0 -i "${DIR}/${NAME}.txt" -c copy "${DIR}/${NAME}.mp3" \
        && ffmpeg -i "${DIR}/${NAME}.mp3" "${DIR}/${NAME}.m4a" \
        && mv "${DIR}/${NAME}.m4a" "${DIR}/$(basename "${DIR}").m4b"

    # Cleanup
    unlink "${DIR}/${NAME}.txt"
    unlink "${DIR}/${NAME}.mp3"
}

. "$HOME/.cargo/env"

alias hs="ssh atris@atris-hs"
alias bi="bun i"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/vacekj/.cache/lm-studio/bin"
export EDITOR="zed"

# PNPM configuration (prioritized to ensure pnpm's Node.js comes first)
export PNPM_HOME="/Users/vacekj/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Added by Windsurf
export PATH="/Users/vacekj/.codeium/windsurf/bin:$PATH"

alias yt="yt-dlp -f \"bestvideo+bestaudio\" --merge-output-format mkv"

# Moon configuration (moved after PNPM to avoid overriding)
export PATH="$HOME/.moon/bin:$PATH"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias p=pnpm
alias px=pnpx
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:/Users/vacekj/.foundry/bin"

alias vim="nvim"

export HOMEBREW_NO_ENV_HINTS=true
alias c="cargo"
alias ytmp3='yt-dlp -x --audio-format mp3 --audio-quality 0 -o '\''%(title)s.%(ext)s'\'
alias gpn="git push --no-verify"
alias gpfn="git push --no-verify --force"

export PATH=$PATH:$HOME/.nargo/bin

eval "$(mcfly init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

unsetopt correct_all
setopt correct

# bun completions
[ -s "/Users/vacekj/.bun/_bun" ] && source "/Users/vacekj/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export DISABLE_ESLINT_PLUGIN=true
export HUSKY=0

alias bubu="brew upgrade"

function call {
  open -a FaceTime "tel://$1"
}

alias pi="pnpm i"
alias cwr="cargo watch -q -c -x 'run -q'"

abook() {
    local DIR="${1}"

    if [[ ! -d $DIR || -z $1 ]]; then
        DIR=$(pwd)
    fi

    # generating random name
    local NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)

    # generating book
    ls -1 "${DIR}/"*.mp3 | awk  '{printf "file |%s|\n", $0}' | \
        sed -e "s/|/\'/g" > "${DIR}/${NAME}.txt" \
        && ffmpeg -f concat -safe 0 -i "${DIR}/${NAME}.txt" -c copy "${DIR}/${NAME}.mp3" \
        && ffmpeg -i "${DIR}/${NAME}.mp3" "${DIR}/${NAME}.m4a" \
        && mv "${DIR}/${NAME}.m4a" "${DIR}/$(basename "${DIR}").m4b"

    # Cleanup
    unlink "${DIR}/${NAME}.txt"
    unlink "${DIR}/${NAME}.mp3"
}

. "$HOME/.cargo/env"

alias hs="ssh atris@atris-hs"
alias bi="bun i"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/vacekj/.cache/lm-studio/bin"
export EDITOR="zed"

export PATH="$HOME/.moon/bin:$PATH"

# Added by Windsurf
export PATH="/Users/vacekj/.codeium/windsurf/bin:$PATH"

alias yt="yt-dlp -f \"bestvideo+bestaudio\" --merge-output-format mkv"

# pnpm
export PNPM_HOME="/Users/vacekj/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
