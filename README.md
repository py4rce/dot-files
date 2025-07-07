# Config files that I use 

- kitty
- nvim
- .tmux.conf
- ArrowKeyRemap.ahk : requires AHK software
- Utilidades: fzf



## compilar nvim desde código:

Asegúrate de haber instalado todo:

```bash
sudo apt install ninja-build gettext cmake unzip curl build-essential libtool libtool-bin autoconf automake pkg-config libuv1-dev libmsgpack-dev libunibilium-dev
```

Y luego compilar correctamente:

```bash
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
```

---


## SETUP FZF 

fix ctrl-r binding
- Bash

Append this line to ~/.bashrc to enable fzf keybindings for Bash:

   source /usr/share/doc/fzf/examples/key-bindings.bash

Append this line to ~/.bashrc to enable fuzzy auto-completion for Bash:

   source /usr/share/doc/fzf/examples/completion.bash

- Zsh

Append this line to ~/.zshrc to enable fzf keybindings for Zsh:

   source /usr/share/doc/fzf/examples/key-bindings.zsh

Append this line to ~/.zshrc to enable fuzzy auto-completion for Zsh:

   source /usr/share/doc/fzf/examples/completion.zsh
