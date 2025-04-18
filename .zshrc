# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    man
    tldr
  )

source $ZSH/oh-my-zsh.sh

bindkey -v

bindkey -s ^f "tmux-sessionizer\n"

## fzf key bindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source ~/.config/fzf/key-bindings.zsh
# source ~/.config/fzf/completion.zsh fzf!
#
bindkey -s ^s "cd **  "

#-------ALIASES-------#

alias standup='$HOME/scripts/standup.sh'
alias fn='nvim +FNotes'
alias gn='nvim +GNotes'
alias config='$HOME/.config'
alias nn='$HOME/scripts/new-note.sh'

sezen() {
  cd ~/code/work-projects/pop-up-club || return
  tmux new-session -d -s SEZEN -c ~/code/work-projects/pop-up-club/
  tmux rename-window -t SEZEN:1 "nvim"
  tmux send-keys -t SEZEN:1 "nvim ." C-m
  tmux new-window -t SEZEN: -n "backend" -c ~/code/work-projects/pop-up-club/backend/
  tmux new-window -t SEZEN: -n "frontend" -c ~/code/work-projects/pop-up-club/frontend/
  tmux select-window -t SEZEN:1
  if [ -n "$TMUX" ]; then
    tmux switch-client -t SEZEN
  else
    tmux attach-session -t SEZEN
  fi
}

onestep() {
  cd ~/code/work-projects/onestep || return
  tmux new-session -d -s ONESTEP -c ~/code/work-projects/onestep/recycling-app
  tmux rename-window -t ONESTEP:1 "recycling-nvim"
  tmux send-keys -t ONESTEP:1 "nvim ." C-m
  tmux new-window -t ONESTEP: -n "recycling-backend" -c ~/code/work-projects/onestep/recycling-app/backend
  tmux new-window -t ONESTEP: -n "recycling-frontend" -c ~/code/work-projects/onestep/recycling-app/frontend
  tmux new-window -t ONESTEP: -n "rewards-nvim" -c ~/code/work-projects/onestep/rewards-app
  tmux send-keys -t 'ONESTEP:rewards-nvim' "nvim ." C-m
  tmux new-window -t ONESTEP: -n "rewards-backend" -c ~/code/work-projects/onestep/rewards-app/backend
  tmux select-window -t ONESTEP:1
  if [ -n "$TMUX" ]; then
    tmux switch-client -t ONESTEP
  else
    tmux attach-session -t ONESTEP
  fi
}




japeto() {
  cd ~/code/work-projects/japeto || return
  # Create a new detached tmux session named "japeto" with working directory set to the project root.
  tmux new-session -d -s JAPETO -c ~/code/work-projects/japeto
  # Rename the first window (index 1, because base-index is set to 1) to "nvim" and open nvim.
  tmux rename-window -t JAPETO:1 "nvim"
  tmux send-keys -t JAPETO:1 "nvim ." C-m
  # Create additional windows in the session.
  tmux new-window -t JAPETO: -n "backend" -c ~/code/work-projects/japeto/backend
  tmux new-window -t JAPETO: -n "dashboard" -c ~/code/work-projects/japeto/dashboard-frontend
  tmux new-window -t JAPETO: -n "chatbot" -c ~/code/work-projects/japeto/chatbot-frontend
  tmux select-window -t JAPETO:1
  if [ -n "$TMUX" ]; then
    tmux switch-client -t JAPETO
  else
    tmux attach-session -t JAPETO
  fi
}


# alias japeto='cd ~/code/work-projects/japeto && \
# tmux rename-window "nvim" && tmux send-keys "nvim ." C-m && \
# tmux neww -n "backend" -c ~/code/work-projects/japeto/backend && \
# tmux neww -n "dashboard" -c ~/code/work-projects/japeto/dashboard-frontend && \
# tmux neww -n "chatbot" -c ~/code/work-projects/japeto/chatbot-frontend'

alias mvnlog='mvn spring-boot:run | fzf --ansi --tail=100000 --tac --no-sort --exact --wrap --layout=reverse --border --info=inline --prompt="Spring Boot Logs > " --header="╱ CTRL-R (reload) ╱ CTRL-D (page down) ╱ CTRL-U (page up) ╱ CTRL-C (exit) ╱" --bind="ctrl-r:reload(mvn spring-boot:run)" --bind="ctrl-d:half-page-down" --bind="ctrl-u:half-page-up"'

#---------------------#

# sdkman
source "$HOME/.sdkman/bin/sdkman-init.sh"

# GO
export PATH="/usr/bin:$PATH"

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# use fzf to checkout git branch
function br() {
  local branch
  branch=$(git branch --all | grep -v HEAD | sed 's/^[ *]*//;s/[ *]*$//' | fzf +m) &&
  git checkout $(echo "$branch" | sed "s#remotes/[^/]*/##")
}

# use fzf to switch or create a new worktree
function wt() {
  local action
  local branch
  local project_name
  local worktree_path
  local new_branch_name
  local current_dir=$(pwd)

  project_name=$(basename "$(git rev-parse --show-toplevel)")

  echo "Select Action: [n] New Worktree, [c] Checkout existing worktree, [r] Checkout remote as worktree"
  read action

  case $action in
    n|N)
      echo "Enter new branch name:"
      read new_branch_name
      new_branch_name=$(echo "$new_branch_name" | tr '/' '-' | xargs)  # Replace slashes, trim whitespace

      worktree_path="../${project_name}-wt-${new_branch_name}"

      git worktree add "$worktree_path" -b "$new_branch_name"
      echo "New worktree with branch '$new_branch_name' created at '$worktree_path'."
      
      cd "$worktree_path" || return
      echo "Switched to the new worktree at '$worktree_path'."
      ;;
    c|C)
      local worktrees=$(git worktree list | awk '{print $1}' | grep -v "^$current_dir$")
      worktree_path=$(echo "$worktrees" | fzf +m --header="Select a worktree to checkout:")

      if [ -z "$worktree_path" ]; then
        echo "No worktree selected or available."
      else
        cd "$worktree_path" || return
        echo "Switched to worktree at '$worktree_path'."
      fi
      ;;
    r|R)
      git fetch --all
      local remote_branches=$(git branch -r | grep -v '\->' | sed 's/origin\///' | xargs -n1)

      branch=$(echo "$remote_branches" | fzf +m --header="Select a remote branch to checkout:" | xargs)
      if [ -z "$branch" ]; then
        echo "No remote branch selected."
        return
      fi

      branch_name=$(echo "$branch" | tr '/' '-' | xargs)
      worktree_path="../${project_name}-wt-${branch_name}"

      # Create a new local branch for the worktree that tracks the remote branch
      git worktree add "$worktree_path" -b "$branch_name" "origin/$branch"
      echo "New worktree for remote branch '$branch' created at '$worktree_path', on new local branch '$branch_name'."

      cd "$worktree_path" || return
      echo "Switched to the new worktree at '$worktree_path'."
      ;;
    *)
      echo "Invalid option. Use 'n' for new worktree, 'c' to checkout an existing worktree, 'r' to checkout a remote branch as a new worktree."
      ;;
  esac
}


# Android SDK environment variables
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

export CHROME_EXECUTABLE=/usr/bin/brave-browser
export EDGE_PATH=/usr/bin/brave-browser

export ANDROID_EMULATOR_WAIT_TIME_BEFORE_KILL=1
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export MESA_LOADER_DRIVER_OVERRIDE=i965



