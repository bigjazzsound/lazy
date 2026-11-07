return {
  ---@module "atlas"
  "emrearmagan/atlas.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional but recommended
    "MeanderingProgrammer/render-markdown.nvim", -- optional but recommended
    "esmuellert/codediff.nvim", -- optional (PullRequest diff)
    "sindrets/diffview.nvim", -- optional; or "dlyongemallo/diffview-plus.nvim"
  },
  ---@type AtlasConfig
  opts = {
    providers = {
      ---@type AtlasJiraConfig
      jira = {
        base_url = "https://teslagovernment.atlassian.net/",
        email = "craig.fielder@teslagovernment.com",
        token = [[ATATT3xFfGF0fbNVrsh7xTxQFIIpb0M-TjjMrIihO7rTYzlo5ujUTpcddZVVfwyDmkyhrplHFUarqfGbsP0t8xH9lAPxLZWcF_FzBaLp0L-6FQUYeSjTXVztSu_Asnx8jIExeAJmwrOhw07xD_a5EGDpqoLH5thSUx9-SitmHoif8YfDhk-VJH8=A42D50F8]],
        auth_method = "basic",
        api_type = "cloud",
        cache_ttl = 300,
      },
    },
  },

  cmd = { "Atlas" },
}
