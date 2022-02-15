function __getnpmpkg() {
  locks=("package-lock.json" "yarn.lock" "pnpm-lock.yaml")
  pkgs=("npm" "yarn" "pnpm")
  pkgcmd=npm
  i=0
  for lock in "${locks[@]}"; do
    i=$((i+1))
    if [ -f "$lock" ]; then
      pkgcmd=${pkgs[$i]}
      break
    fi
  done
  echo $pkgcmd
}

# 使用 fzf 查找 npm run
function npmr() {
  pkgcmd=$(__getnpmpkg)
  if [ ! -f package.json ]; then
    echo "package.json not found" >&2
  else 
    local command=$(jq -r '.scripts | keys[]' package.json | tr -d '"' | 
    fzf --reverse \
      --preview-window=:wrap \
      --preview "jq '.scripts.\"{}\"' package.json -r | tr -d '\"' | sed 's/^[[:blank:]]*//'")

    if [ -n "$command" ]; then
      eval "$pkgcmd run $command"
    fi
  fi
}

# 使用 node 包管理器 install package
function npmi() {
  pkgcmd=$(__getnpmpkg)
  # 如果 $1 为空，则是安装全部依赖
  if [ -z "$1" ]; then
    eval "$pkgcmd install"
  elif [ $1 = '-D' ] && [ -z $2 ]; then
    eval "$pkgcmd install -D"
  else
    # 如果是 yarn 安装依赖 使用 add
    if [ "$pkgcmd" = "yarn" ]; then
      eval "$pkgcmd add $@"
    else
      eval "$pkgcmd install $@"
    fi
  fi
}

alias npmid='npmi -D'

# 使用 node 包管理器 uninstall package
function npmu() {
  pkgcmd=$(__getnpmpkg)
  # 如果 $@ 为空，则使用 fzf 查找依赖
  if [ -z "$@" ]; then
    local command=$(jq -r '{dependencies, devDependencies} | to_entries[] | .value | keys[]' package.json |
    fzf --reverse \
      --preview-window=:wrap \
      -m)
    if [ -n "$command" ]; then
      eval $(echo -n "$pkgcmd remove $command")
    fi
  else
    eval "$pkgcmd remove $@"
  fi
}
