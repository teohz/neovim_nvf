{
  description = "teralium.int.network neovim flakeee v20250716";

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
                theme = {
                  enable = true;
                  name = "tokyonight";
                  style = "night";
                };

                treesitter.enable = true;
                telescope.enable = true;

                undoFile.enable = true;

                utility = {
                  leetcode-nvim.enable = true;
                  leetcode-nvim.setupOpts.lang = "golang";

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
                  # hardtime-nvim.enable = true;
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

                  markdown.enable = true;
                  bash = {
                    enable = true;
                    extraDiagnostics = {
                      enable = true;
                      types = [ "shellcheck" ];
                    };
                    format.enable = true;
                  };
                  nix = {
                    enable = true;
                    format = {
                      enable = true;
                      type = "nixfmt";
                    };
                  };
                  go.enable = true;
                  yaml.enable = true;
                };

                visuals = {
                  nvim-web-devicons.enable = true;
                  highlight-undo.enable = true;
                  indent-blankline.enable = true;
                  nvim-cursorline.enable = true;
                };

                autopairs.nvim-autopairs.enable = true;

                options = {
                  tabstop = 8;
                  shiftwidth = 8;
                  softtabstop = 0;
                  expandtab = false;
                  smartindent = true;
                };

                keymaps = [
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
