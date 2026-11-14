# Config Neovim

Config Neovim en Lua, gérée par [lazy.nvim](https://github.com/folke/lazy.nvim), avec une disposition de touches **BÉPO**.

## Installation sur une nouvelle machine

### 1. Prérequis système

| Outil | Pourquoi | Vérifier |
|---|---|---|
| **Neovim ≥ 0.12** | requis par nvim-treesitter (branche `main`) | `nvim --version` |
| `git`, `curl`, `tar` | lazy.nvim, installation des parsers Treesitter | |
| **compilateur C** (`gcc`) | compilation des parsers Treesitter | `gcc --version` |
| **`tree-sitter-cli` ≥ 0.26.1** | compilation des parsers Treesitter | `tree-sitter --version` |
| **Node.js + npm** | Mason installe `pyright` et `bash-language-server` via npm | `node --version` |
| **ripgrep** (`rg`) | Telescope `live_grep` (`<C-d>`) | `rg --version` |
| **Java (JDK)** + **coursier** (`cs`) | Metals (Scala) | `java -version`, `cs --version` |
| `xclip` (X11) ou `wl-clipboard` (Wayland) | presse-papier système (`clipboard=unnamedplus`) | |
| une **Nerd Font** dans le terminal | icônes (devicons, lspkind) | |

Installer `tree-sitter-cli` **avec cargo ou le gestionnaire de paquets, pas avec npm** (recommandation de nvim-treesitter) :

```sh
cargo install --locked tree-sitter-cli
```

Facultatif : `firefox` (`<F12>f` ouvre le fichier courant), la CLI [Claude Code](https://claude.com/claude-code) (`claude`) pour claudecode.nvim, un compte GitHub Copilot.

### 2. Cloner la config

```sh
git clone git@github.com:rlecomte/neovim-setup.git ~/.config/nvim
```

### 3. Premier lancement

```sh
nvim
```

Au premier démarrage :

1. **lazy.nvim** s'installe tout seul, puis installe tous les plugins aux versions de `lazy-lock.json`.
2. **nvim-treesitter** télécharge et compile les parsers (lua, python, go, rust, scala, java, bash, json, yaml, markdown). Les messages `Compiling parser` sont normaux.
3. **Mason** installe, **à l'ouverture du premier fichier** (la config LSP est chargée à ce moment-là) :
   - les serveurs LSP (mason-lspconfig) : `lua_ls`, `rust_analyzer`, `gopls`, `pyright`, `ruff`, `bashls` ;
   - les autres outils (mason-tool-installer) : `shellcheck` (diagnostics shell), `shfmt` (formatage shell), `stylua` (formatage Lua).

   Les deux listes sont dans `lua/plugins/lsp.lua` (`ensure_installed`).

Ouvrir un fichier, attendre la fin (`:Lazy` et `:Mason` montrent l'avancement), puis **redémarrer Neovim**.

> Pour remettre les plugins exactement aux versions du lockfile : `:Lazy restore`.

### 4. Metals (Scala)

Ouvrir un fichier `.scala` ou `.sbt`, puis :

```vim
:MetalsInstall
```

Pour mettre Metals à jour plus tard : `:MetalsUpdate`. Version active : `:MetalsInfo`.

### 5. Comptes

- **Copilot** : `:Copilot auth`
- **Claude Code** : la CLI `claude` doit être installée et connectée. `<leader>ac` ouvre Claude dans Neovim.

### 6. Vérifier

```vim
:checkhealth
```

Points à regarder en priorité : `lazy`, `nvim-treesitter`, `mason`, `vim.lsp`.

## Organisation

```
init.lua              bootstrap lazy.nvim, puis options / autocmds / keymaps
lua/options.lua       options (seulement celles qui diffèrent des défauts Neovim)
lua/autocmds.lua      autocommandes (dernière position, espaces en fin de ligne...)
lua/keymaps.lua       mappings généraux et BÉPO
lua/plugins/*.lua     un fichier par domaine : ai, editor, git, lsp, metals, navigation, ui
lazy-lock.json        versions exactes des plugins
```

### Espaces en fin de ligne

Ils sont surlignés en rouge et supprimés à l'enregistrement, **sauf** dans les dépôts listés dans `trim_ws_excluded_repos` (`lua/autocmds.lua`), reconnus par le nom de leur dossier racine git. Actuellement : `conduktor-docs`.

## Raccourcis principaux

`<leader>` = espace.

**BÉPO** : `c` `t` `s` `r` = ← ↓ ↑ →, `é` = mot suivant. Les commandes déplacées : `j` = jusqu'à (t), `l` = changer (c), `h` = remplacer (r), `k` = substituer (s). Fenêtres : `w` + `c`/`t`/`s`/`r`. Onglets : `gb` / `gé`.

| Touche | Action |
|---|---|
| `<C-t>` / `<C-n>` / `<C-d>` | Telescope : fichiers git / récents / live grep |
| `<C-c>` | Hop : sauter à un mot |
| `<C-e>` | Oil (explorateur) |
| `gd` / `gD` / `gi` / `gh` | LSP : définition / déclaration / implémentation / doc |
| `grr` / `grn` / `gra` / `grt` / `grx` | LSP : références / renommer / code action / type / codelens |
| `<leader>rf` | formater le buffer |
| `<leader>ih` | afficher / masquer les indices de types (inlay hints) |
| `]d` / `[d`, `<leader>e` | diagnostics |
| `]h` / `[h`, `<leader>h…` | hunks git (gitsigns) |
| `<leader>a…` | Claude Code |
| `<leader>d…` | debug (DAP, Scala) |
