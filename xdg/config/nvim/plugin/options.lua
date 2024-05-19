local opt = vim.opt

opt.errorbells = false
opt.breakindent = true
opt.breakindent = true
opt.signcolumn = "yes"
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
opt.formatoptions = "jcroqlnt"
if not vim.env.SSH_TTY then
  opt.clipboard = "unnamedplus" -- Sync with system clipboard
end
opt.inccommand = "nosplit"
opt.cmdheight = 1
opt.showcmd = true
if vim.g.started_by_firenvim ~= nil then
  opt.laststatus = 0
else
  opt.laststatus = 2
end
opt.number = true
opt.cursorline = true
opt.virtualedit = { "block", "onemore" }
-- ignore filetype when file search
opt.wildignore:append({
  "*/tmp/*",
  "*.so",
  "*.swp",
  "*.png",
  "*.jpg",
  "*.jpeg",
  "*.gif",
  "*.class",
  "*.pyc",
  "*.pyd",
})
-- code indent
opt.cindent = true
opt.cinoptions = { "g0", ":0", "N-s", "(0" }
opt.smartindent = true
-- tab & space
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.softtabstop = 4
opt.sidescroll = 10

opt.list = true
opt.listchars = {
  tab = ">-",
  precedes = "«",
  extends = "»",
  trail = "·",
  lead = "·",
  eol = "↴",
  nbsp = "␣",
}
if vim.bo.buftype == "terminal" then
  opt.listchars:remove({ "eol" })
end

opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.wrap = true
opt.relativenumber = true
opt.mouse = "a"

-- search
opt.ignorecase = true

opt.autowrite = true
opt.confirm = true
opt.updatetime = 500
opt.fileencodings:append({ "gbk", "cp936", "gb2312", "gb18030", "big5", "euc-jp", "euc-kr", "prc" })
opt.termguicolors = true
opt.completeopt = { "menu", "menuone", "noinsert" }
opt.pumheight = 20
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.sessionoptions:append({ "winpos", "globals", "skiprtp" })

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
opt.foldlevel = 99
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.require'util'.foldexpr()"
  vim.opt.foldtext = ""
  vim.opt.fillchars = "fold: "
else
  vim.opt.foldmethod = "indent"
end

if not vim.g.vscode then
  vim.cmd.colorscheme("vscode")
else
  vim.notify = require("vscode-neovim").notify
end