# .zshrc

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Powerlevel10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Aliases
alias p="pnpm"
alias px="pnpx"
alias vim="nvim"
alias c="cargo"
alias ytmp3='yt-dlp -x --audio-format mp3 --audio-quality 0 -o "%(title)s.%(ext)s"'
alias gpn="git push --no-verify"
alias gpfn="git push --no-verify --force"
alias bubu="brew upgrade"
alias pi="pnpm i"
alias cwr="cargo watch -q -c -x 'run -q'"
alias bi="bun i"
alias yt="yt-dlp -f \"bestvideo+bestaudio\" --merge-output-format mkv"

# Mcfly
if command -v mcfly >/dev/null 2>&1; then
  eval "$(mcfly init zsh)"
fi

# Fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Rust/Cargo
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Platform-specific settings
if [[ "$(uname)" == "Darwin" ]]; then
  export PATH="$HOME/.foundry/bin:$HOME/.nargo/bin:$HOME/.bun/bin:$HOME/.cache/lm-studio/bin:$HOME/.codeium/windsurf/bin:$HOME/.moon/bin:/opt/homebrew/bin:$HOME/bin:/usr/local/bin:$PATH"
  export PNPM_HOME="$HOME/Library/pnpm"
  export BUN_INSTALL="$HOME/.bun"
  export HOMEBREW_NO_ENV_HINTS=true
  export EDITOR="zed"
  alias hs="ssh atris@atris-hs"
  function call {
    open -a FaceTime "tel://$1"
  }
    export DISABLE_ESLINT_PLUGIN=true
    export HUSKY=0
    unsetopt correct_all
    setopt correct

    # Audiobook function
    abook() {
        local DIR="${1}"
        if [[ ! -d $DIR || -z $1 ]]; then
            DIR=$(pwd)
        fi
        local NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)
        ls -1 "${DIR}/"*.mp3 | awk '{printf "file |%s|\n", $0}' | \
            sed -e "s/|/\'/g" > "${DIR}/${NAME}.txt" \
            && ffmpeg -f concat -safe 0 -i "${DIR}/${NAME}.txt" -c copy "${DIR}/${NAME}.mp3" \
            && ffmpeg -i "${DIR}/${NAME}.mp3" "${DIR}/${NAME}.m4a" \
            && mv "${DIR}/${NAME}.m4a" "${DIR}/$(basename "${DIR}").m4b"
        unlink "${DIR}/${NAME}.txt"
        unlink "${DIR}/${NAME}.mp3"
    }
elif [[ "$(uname)" == "Linux" ]]; then
  export PATH="$HOME/.nix-profile/bin:$PATH"
  export PNPM_HOME="$HOME/.pnpm"
  export BUN_INSTALL="$HOME/.bun"
  export EDITOR="nvim"
fi
