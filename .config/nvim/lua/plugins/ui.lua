return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
                                                     +#+              
               .-                                    *@@+        =#=  
    -=.       .%@:          %@@@%%##*=-:.             #@@-     .#@@*  
   #@@@#:    .%@@*          .-=+*%@@@@@@@#: .          %@%:   -%@%=   
   *@@@@@*.  #@@@%. =*:   :#+    =@@@=-==+=-@#         :%@%. +%%*.    
   +@@#-%@%=*@%#@@+:@@+   *@@-   +@@%      :@@#      +@*:%@%%@+.      
   =@@%. =%@@%:-@@% @@+   #@@+   #@@+ -#%- :@@@*     %@* +@@%:        
   :@@@+  .#@+  %@@:#@+   %@@%   %@%.  #@% :@@@@*   .@@+ :@@-         
    %@@#   -=   =@@*=@%  *@#%@: .@@+   .%@+:@@-%@%: :@@= -@@-         
    +@@@.        #@%.%@**@%:+@* -@@-    -@@=@@..#@@+-@@- +@@-         
    :@@@=        -@@:.+%%*. .%% =@@.     *@#:-   *@@%@@: %@@.         
     #@@*         *@=  .:    .- -@%       %@=     *@@@% :@@#          
     -@@%         .%*            ..       :%@=     +@@# =@@=          
      %@@:         ..                      .--      +=. #@@:          
      *@@=                                              %@%           
      .%@+                                              %@=           
       .-.                                              :-            
 ]],
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "classic",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        blink_cmp = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  { "rose-pine/neovim", name = "rose-pine" },

  {
    "folke/zen-mode.nvim",
  },
}
