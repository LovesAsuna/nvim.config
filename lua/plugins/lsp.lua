return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        rust_analyzer = {},
        kotlin_language_server = {},
        gopls = {},
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function(plugin, opts)
      local config = {
        cmd = { "/home/lovesasuna/.local/share/nvim/mason/bin/jdtls" },
        root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
      }
      require("jdtls").start_or_attach(config)
    end,
  },
}
