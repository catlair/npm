# npm

npm alias  
Automatically select npm, yarn, or pnpm based on the environment.

## Installation

_Make sure you have [`fzf`](https://github.com/junegunn/fzf) and [`jq`](https://stedolan.github.io/jq/) installed._

### Try Online

Run the following command in your shell to try:

- `npmr` using npm scripts interactively
- `npmi <package>` using npm/yarn/pnpm to install packages
- `npmu <package>` using npm/yarn/pnpm to uninstall packages
- `npmid <package>` command `npm install -D` to install dev packages

without installing:

##### Bash and ZSH

```bash
source <(curl -Ss https://raw.githubusercontent.com/catlair/npm/master/npm.plugin.zsh)
```

### Installation using a ZSH Plugin manager

### [Zinit](https://github.com/zdharma/zinit)

```zsh
zinit 'catlair/npm'
```

### Manual Installation

Download and source `npm.plugin.zsh` in your shell config.

## Thanks

[torifat/npms](https://github.com/torifat/npms) [[TIM](https://github.com/torifat/npms/blob/master/LICENSE)]
