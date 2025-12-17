{
  description = "teralium.int.network neovim nvf flakeee v20250717";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      configuredNeovim = inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          (
            { lib, ... }:
            {
              config.vim = {
                lazy.plugins = {
                  nvim.paredit = {
                    package = pkgs.vimPlugins.nvim-paredit;
                    setupModule = "nvim-paredit";
                    setupOpts = {
                      option_name = true;
                    };
                    lazy = true;
                  };
                };
                theme = {
                  enable = true;
                  name = "tokyonight";
                  style = "night";
                };

                treesitter.enable = true;
                treesitter.autotagHtml = true;
                telescope.enable = true;
                repl.conjure.enable = true;

                undoFile.enable = true;

                utility = {
                  oil-nvim.enable = true;
                  sleuth.enable = true;
                  surround.enable = true;
                };

                statusline.lualine = {
                  enable = true;
                  theme = "tokyonight";
                };

                lsp = {
                  enable = true;
                  formatOnSave = true;
                  inlayHints.enable = true;
                  lspconfig.enable = true;
                };

                syntaxHighlighting = true;

                # autocomplete.nvim-cmp.enable = true;
                autocomplete.blink-cmp = {
                  enable = true;
                  friendly-snippets.enable = true;
                  sourcePlugins = {
                    # check
                    ripgrep.enable = true; # check
                    spell.enable = true; # check
                  };
                };

                binds = {
                  cheatsheet.enable = true; # check - telescope leader key
                  hardtime-nvim.enable = false;
                  whichKey.enable = true;
                };

                navigation.harpoon.enable = true;

                notes.todo-comments.enable = true;

                comments.comment-nvim = {
                  enable = true;
                };

                dashboard.startify.enable = true;

                git.enable = true;

                languages = {
                  enableFormat = true;
                  enableTreesitter = true;

                  markdown = {
                    enable = true;
                    lsp.enable = true;
                    extensions.render-markdown-nvim.enable = true;
                  };
                  clojure = {
                    enable = true;
                    lsp.enable = true;
                    treesitter.enable = true;
                  };
                  html = {
                    enable = true;
                    treesitter.enable = true;
                    treesitter.autotagHtml = true;
                  };
                  css = {
                    enable = true;
                    lsp.enable = true;
                    treesitter.enable = true;
                  };
                  bash = {
                    enable = true;
                    lsp.enable = true;
                    extraDiagnostics = {
                      enable = true;
                      types = [ "shellcheck" ];
                    };
                  };
                  python = {
                    enable = true;
                    lsp.enable = true;
                  };
                  nix = {
                    enable = true;
                    lsp.enable = true;
                    format = {
                      enable = true;
                      type = "nixfmt";
                    };
                  };
                  go = {
                    enable = true;
                    lsp.enable = true;
                  };
                  zig = {
                    enable = true;
                    lsp.enable = true;
                  };
                  yaml = {
                    enable = true;
                    lsp.enable = true;
                  };
                };

                visuals = {
                  nvim-web-devicons.enable = true;
                  highlight-undo.enable = true;
                  indent-blankline.enable = true;
                  nvim-cursorline.enable = true;
                  rainbow-delimiters.enable = true;
                };

                autopairs.nvim-autopairs.enable = true;
                autopairs.nvim-autopairs.setupOpts = {
                  # enable_check_bracket_line = false;
                };

                options = {
                  autoindent = true;
                  tabstop = 8;
                  shiftwidth = 8;
                  softtabstop = 0;
                  expandtab = false;
                  smartindent = true;
                  wrap = true;

                  hlsearch = true;
                  incsearch = true;

                  scrolloff = 8;
                  colorcolumn = "80,120";

                  list = true;
                  listchars = "tab:> ,trail:-,eol:$";
                };

                searchCase = "smart";

                keymaps = [
                  {
                    key = "jk";
                    mode = [ "i" ];
                    action = "<Esc>";
                    silent = true;
                    desc = "Exit input mode.";
                  }
                  {
                    key = "<leader>sa";
                    mode = [ "n" ];
                    action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
                    silent = true;
                    desc = "Replace all with ...";
                  }
                  {
                    key = "<leader>fo";
                    mode = [ "n" ];
                    action = "<CMD>Telescope oldfiles<CR>";
                    silent = true;
                    desc = "Old files [Telescope]";
                  }
                  {
                    key = "<leader>fa";
                    mode = [ "n" ];
                    action = "<CMD>Telescope find_files follow=true no_ignore=true hidder=true<CR>";
                    silent = true;
                    desc = "Find files; hidden + links [Telescope]";
                  }
                  {
                    key = "<leader>wq";
                    mode = [ "n" ];
                    action = ":x<CR>";
                    silent = true;
                    desc = "Save file and quit.";
                  }
                  {
                    key = "<leader>ww";
                    mode = [ "n" ];
                    action = ":w<CR>";
                    silent = true;
                    desc = "Save file.";
                  }
                  {
                    key = "<leader>qq";
                    mode = [ "n" ];
                    action = ":q!<CR>";
                    silent = true;
                    desc = "Quit without saving.";
                  }
                  {
                    key = "-";
                    mode = [ "n" ];
                    action = "<CMD>Oil<CR>";
                    silent = true;
                    desc = "Open parent directory.";
                  }
                  {
                    key = "<leader>?";
                    mode = [ "n" ];
                    action = "<CMD>Cheatsheet<CR>";
                    silent = true;
                    desc = "Open Cheatsheet.";
                  }
                  {
                    key = "<leader>nh";
                    mode = [ "n" ];
                    action = ":nohlsearch<CR>";
                    silent = true;
                    desc = "Clear search highlight.";
                  }
                  {
                    key = "<leader>nl";
                    mode = [ "n" ];
                    action = "<CMD>set list!<CR>";
                    silent = true;
                    desc = "Toggle list view.";
                  }
                  {
                    key = "J";
                    mode = [ "v" ];
                    action = ":m '>+1<CR>gv=gv";
                    silent = true;
                    desc = "Move selection down.";
                  }
                  {
                    key = "K";
                    mode = [ "v" ];
                    action = ":m '<-2<CR>gv=gv";
                    silent = true;
                    desc = "Move selection up.";
                  }
                  {
                    key = "<";
                    mode = [ "v" ];
                    action = "<gv";
                    silent = true;
                    desc = "Outdent.";
                  }
                  {
                    key = ">";
                    mode = [ "v" ];
                    action = ">gv";
                    silent = true;
                    desc = "Indent.";
                  }
                  {
                    key = "<leader>ee";
                    mode = [ "n" ];
                    action = "oif err != nil {<CR>}<Esc>Oreturn err";
                    silent = true;
                    desc = "GO - Add err check.";
                  }
                  {
                    key = "<Tab>";
                    mode = [ "n" ];
                    action = ":bn<CR>";
                    silent = true;
                    desc = "Switch to next buffer.";
                  }
                  {
                    key = "<S-Tab>";
                    mode = [ "n" ];
                    action = ":bp<CR>";
                    silent = true;
                    desc = "Switch to previous buffer.";
                  }
                  {
                    key = "<leader>bd";
                    mode = [ "n" ];
                    action = ":bd<CR>";
                    silent = true;
                    desc = "Delete buffer.";
                  }
                  {
                    key = "<leader>x";
                    mode = [ "n" ];
                    action = "<CMD>!chmod +x %<CR>";
                    silent = true;
                    desc = "Make file executable.";
                  }
                  {
                    key = "<C-d>";
                    mode = [ "n" ];
                    action = "<C-d>zz";
                    silent = true;
                    desc = "Move half page down.";
                  }
                  {
                    key = "<C-u>";
                    mode = [ "n" ];
                    action = "<C-u>zz";
                    silent = true;
                    desc = "Move half page up.";
                  }
                  {
                    key = "n";
                    mode = [ "n" ];
                    action = "nzzzv";
                    silent = true;
                    desc = "Repeat the last search; centered.";
                  }
                  {
                    key = "N";
                    mode = [ "n" ];
                    action = "Nzzzv";
                    silent = true;
                    desc = "Repeat the last search reversed; centered.";
                  }
                  {
                    key = "<leader>pp";
                    mode = [ "x" ];
                    action = "\"_dP";
                    silent = true;
                    desc = "Replace, keep register.";
                  }
                  {
                    key = "<leader>pp";
                    mode = [ "x" ];
                    action = "\"_dP";
                    silent = true;
                    desc = "Replace, keep register.";
                  }
                  {
                    key = "<leader>pp";
                    mode = [ "n" ];
                    action = "\"+p";
                    silent = true;
                    desc = "Paste from system register.";
                  }
                  {
                    key = "<leader>pp";
                    mode = [ "v" ];
                    action = "\"+p";
                    silent = true;
                    desc = "Paste from system register.";
                  }
                  {
                    key = "<leader>yy";
                    mode = [ "n" ];
                    action = "\"+y";
                    silent = true;
                    desc = "Copy to system register.";
                  }
                  {
                    key = "<leader>yy";
                    mode = [ "v" ];
                    action = "\"+y";
                    silent = true;
                    desc = "Copy to system register.";
                  }
                  {
                    key = "<leader>Y";
                    mode = [ "n" ];
                    action = "\"+Y";
                    silent = true;
                    desc = "Copy line to system register.";
                  }
                  {
                    key = "<leader>dd";
                    mode = [ "n" ];
                    action = "\"_d";
                    silent = true;
                    desc = "Delete to void register.";
                  }
                  {
                    key = "<leader>dd";
                    mode = [ "v" ];
                    action = "\"_d";
                    silent = true;
                    desc = "Delete to void register.";
                  }
                ];

                augroups = [ { name = "UserFileTypes"; } ];
                autocmds = [
                  {
                    event = [ "FileType" ];
                    pattern = [ "nix" ];
                    group = "UserFileTypes";
                    desc = "Use different tab settings for specific file types.";
                    callback = lib.generators.mkLuaInline ''
                      function()
                        vim.opt_local.tabstop = 2
                        vim.opt_local.shiftwidth = 2
                        vim.opt_local.expandtab = true
                      end
                    '';
                  }
                ];
              };
            }
          )
        ];
      };
    in
    {
      packages.x86_64-linux = {
        default = configuredNeovim.neovim;
      };
    };
}
