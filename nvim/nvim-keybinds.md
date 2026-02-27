## Notable Nvim Keybinds

### Most Critical (Use These More)

| Key                | Mode            | Description                       |
| ------------------ | --------------- | --------------------------------- |
| `<leader>if`       | I forget        | Open the nvim-keybinds.md         |
| `<leader>/`        | Normal          | Live grep (search across project) |
| `<leader>/`        | Normal          | Live grep (search across project) |
| `<leader>ff`       | Normal          | Find files                        |
| `<leader>fb`       | Normal          | Browse open buffers               |
| `<leader>fr`       | Normal          | Recent files                      |
| `<leader>e`        | Normal          | Toggle file explorer              |
| `<S-h>` / `<S-l>`  | Normal          | Previous / next buffer            |
| `<leader>gg`       | Normal          | Open LazyGit                      |
| `<leader>ca`       | Normal          | Code action                       |
| `<leader>cr`       | Normal          | Rename symbol                     |
| `gd`               | Normal          | Go to definition                  |
| `gr`               | Normal          | Go to references                  |
| `K`                | Normal          | Hover documentation               |
| `gcc`              | Normal          | Toggle line comment               |
| `gc`               | Visual          | Toggle comment on selection       |
| `ys{motion}{char}` | Normal          | Add surround (e.g. `ysiw"`)       |
| `ds{char}`         | Normal          | Delete surround (e.g. `ds"`)      |
| `cs{old}{new}`     | Normal          | Change surround (e.g. `cs"'`)     |
| `<C-\>`            | Normal/Terminal | Toggle floating terminal          |

---

### Custom Keybinds

| Key          | Mode            | Description                          |
| ------------ | --------------- | ------------------------------------ |
| `jk`         | Insert/Terminal | Escape to normal mode                |
| `<leader>ud` | Normal          | Toggle diagnostics on/off for buffer |
| `<leader>df` | Normal          | Open PDF in tmux horizontal split    |
| `<C-.>`      | Normal          | Toggle Trouble diagnostics panel     |
| `<leader>bd` | Normal          | Delete buffer (keep window layout)   |
| `<leader>bD` | Normal          | Force delete buffer (keep window)    |

### nvim-surround

| Key                | Mode   | Description                                      |
| ------------------ | ------ | ------------------------------------------------ |
| `ys{motion}{char}` | Normal | Add surround (e.g. `ysiw"` wraps word in `"`)    |
| `ds{char}`         | Normal | Delete surround (e.g. `ds"` removes `"`)         |
| `cs{old}{new}`     | Normal | Change surround (e.g. `cs"'` changes `"` to `'`) |
| `S{char}`          | Visual | Surround selection                               |

### Comment.nvim

| Key          | Mode   | Description                                          |
| ------------ | ------ | ---------------------------------------------------- |
| `gcc`        | Normal | Toggle line comment                                  |
| `gbc`        | Normal | Toggle block comment                                 |
| `gc{motion}` | Normal | Comment with motion (e.g. `gcap` comments paragraph) |
| `gc`         | Visual | Toggle comment on selection                          |
| `gb`         | Visual | Toggle block comment on selection                    |

### File Navigation

| Key                        | Description                     |
| -------------------------- | ------------------------------- |
| `<leader>ff`               | Find files                      |
| `<leader>fg` / `<leader>/` | Live grep (search in files)     |
| `<leader>fb`               | Browse open buffers             |
| `<leader>fr`               | Recent files                    |
| `<leader>fc`               | Find config files               |
| `<leader>fn`               | New file                        |
| `<leader>e`                | Toggle file explorer (neo-tree) |
| `<leader>E`                | Explorer at cwd                 |

### Buffers & Windows

| Key             | Description                     |
| --------------- | ------------------------------- |
| `<S-h>`         | Previous buffer                 |
| `<S-l>`         | Next buffer                     |
| `<C-h/j/k/l>`   | Navigate between windows/splits |
| `<leader>-`     | Horizontal split                |
| `<leader>\|`    | Vertical split                  |
| `<leader>wd`    | Delete window                   |
| `<leader><tab>` | Switch to other/last buffer     |

### LSP

| Key          | Description            |
| ------------ | ---------------------- |
| `K`          | Hover documentation    |
| `gd`         | Go to definition       |
| `gD`         | Go to declaration      |
| `gr`         | Go to references       |
| `gI`         | Go to implementation   |
| `gy`         | Go to type definition  |
| `<leader>ca` | Code action            |
| `<leader>cr` | Rename symbol          |
| `<leader>cd` | Line diagnostics       |
| `]d` / `[d`  | Next / prev diagnostic |
| `]e` / `[e`  | Next / prev error      |
| `]w` / `[w`  | Next / prev warning    |

### Git

| Key           | Description      |
| ------------- | ---------------- |
| `<leader>gg`  | Open LazyGit     |
| `<leader>gf`  | Git file history |
| `<leader>gb`  | Git blame line   |
| `]h` / `[h`   | Next / prev hunk |
| `<leader>ghp` | Preview hunk     |
| `<leader>ghs` | Stage hunk       |
| `<leader>ghr` | Reset hunk       |

### Toggles & UI

| Key          | Description              |
| ------------ | ------------------------ |
| `<leader>ur` | Redraw / clear hlsearch  |
| `<leader>uf` | Toggle autoformat        |
| `<leader>us` | Toggle spelling          |
| `<leader>uw` | Toggle word wrap         |
| `<leader>ul` | Toggle line numbers      |
| `<leader>uL` | Toggle relative numbers  |
| `<leader>sn` | Notification history     |
| `<leader>qq` | Quit all                 |
| `<leader>l`  | Open Lazy plugin manager |

### VimTeX

| Key   | Description               |
| ----- | ------------------------- |
| `\ll` | Toggle continuous compile |
| `\lv` | View PDF                  |
| `\lk` | Stop compilation          |
| `\le` | Show errors/warnings      |
| `\lc` | Clean auxiliary files     |
| `\lt` | Table of contents         |

### Claude Code (Inline Diff)

| Key          | Mode   | Description                    |
| ------------ | ------ | ------------------------------ |
| `<leader>aa` | Normal | Accept inline Claude diff      |
| `<leader>ad` | Normal | Deny/reject inline Claude diff |

### Spell Checker

| Command        | Description                                           |
| -------------- | ----------------------------------------------------- |
| `:set spell`   | Enable spell checking                                 |
| `:set nospell` | Disable spell checking                                |
| `<leader>us`   | Toggle spelling                                       |
| `]s`           | Jump to next misspelled word                          |
| `[s`           | Jump to previous misspelled word                      |
| `z=`           | Show spelling suggestions for word under cursor       |
| `zg`           | Add word under cursor to the spellfile (mark as good) |
| `zw`           | Mark word as wrong (add to bad words list)            |
| `1z=`          | Auto-accept the first spelling suggestion             |
