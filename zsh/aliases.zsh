# Shortcuts
alias back='cd "$OLDPWD"'
alias c="clear"
alias dotfiles="cd $HOME/.dotfiles"

# macOS
alias finder="open -a Finder"
alias safari="open -a Safari"
alias preview="open -a Preview"

# Zsh
alias zshsrc="source ~/.zshrc"
alias zshaliases="vi ~/.dotfiles/zsh/aliases.zsh"
alias zshconf="vi ~/.dotfiles/zsh/.zshrc"
alias zshenv="vi ~/.dotfiles/zsh/env.zsh"
alias zshexports="vi ~/.dotfiles/zsh/exports.zsh"
alias zshfuncs="vi ~/.dotfiles/zsh/functions.zsh"
alias zshpaths="vi ~/.dotfiles/zsh/paths.zsh"

# Terminal
alias alacrittyconf="vi ~/.dotfiles/alacritty/alacritty.yml"

# tmux
alias tmuxconf="vi ~/.tmux.conf.local"

# Editor
alias vi="nvim"
alias nvimconf="vi ~/.dotfiles/nvim/init.vim"
alias nvimplugins="vi ~/.dotfiles/nvim/plugins.vim"
alias nvimmappings="vi ~/.dotfiles/nvim/mappings.vim"
alias nvimfiletypes="vi ~/.dotfiles/nvim/filetypes.vim"
alias nvimsettings="vi ~/.dotfiles/nvim/settings.vim"
alias nvimlsp="vi ~/.dotfiles/nvim/lsp.vim"
alias nvimaugroups="vi ~/.dotfiles/nvim/augroups.vim"

# Tree
alias tree="tree --charset=utf-8"

# Window manager
alias yabaiconf="vi ~/.yabairc"
alias skhdconf="vi ~/.skhdrc"
alias wmstart="brew services start yabai; brew services start skhd;"
alias wmrestart="brew services restart yabai; brew services restart skhd;"
alias wmstop="brew services stop yabai; brew services stop skhd;"

# Miscallaneous
alias mp3-dl="youtube-dl --extract-audio --audio-format mp3"
alias texspellcheck="aspell --lang=en --mode=tex check"
alias python="python3"
alias history="history -E"
