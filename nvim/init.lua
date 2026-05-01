-- ==========================================================================
-- 1. PLUGIN MANAGER (LAZY.NVIM)
-- ==========================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- FIX 1: 'vim' deve ser minúsculo e corrigi o caminho para o provider
vim.g.python3_host_prog = 'C:/Users/mastd/AppData/Local/Python/pythoncore-3.14-64/python.exe'

-- FIX 2: Pasta temporária dinâmica (Windows usa %TEMP% em vez de /tmp/)
local tmp = os.getenv("TEMP"):gsub("\\", "/") .. "/"

-- ==========================================================================
-- 2. GENERAL EDITOR SETTINGS & CUSTOM KEYMAPS
-- ==========================================================================
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.conceallevel = 2 
vim.opt.statusline = "%f%m\\ %=3l:%-2c\\ %y"
vim.opt.splitbelow = true
vim.opt.splitright = true

local map = vim.keymap.set
map("v", "<leader>bl", "<Esc>:'<,''g/\\S/s/^\\s*\\zs/- /<CR>:noh<CR>", { desc = "Format: Add Bullets", silent = true })
map("v", "<leader>nl", "<Esc>:'<,'>g/^\\s*$/d<CR>:noh<CR>", { desc = "Remove All Newlines", silent = true })
map("i", "<C-l>", "<c-g>u<Esc>1z=`]a<c-g>u", { desc = "Correct current word" })

-- ==========================================================================
-- MARKDOWN FOLD SHIELDING
-- ==========================================================================
vim.opt.viewoptions = "folds,cursor"
local fold_fix_group = vim.api.nvim_create_augroup("FixMarkdownFolds", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = fold_fix_group, pattern = "*.md",
    callback = function() vim.cmd("silent! mkview 1") end
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = fold_fix_group, pattern = "*.md",
    callback = function() vim.cmd("silent! loadview 1") end
})

-- ==========================================================================
-- SMART BLOCKQUOTE TOGGLE
-- ==========================================================================
local function toggle_quote()
    local mode = vim.fn.mode()
    if mode == 'v' or mode == 'V' or mode == '\22' then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', false)
        vim.schedule(function()
            local r1, r2 = vim.fn.line("'<"), vim.fn.line("'>")
            if r1 > r2 then r1, r2 = r2, r1 end 
            for i = r1, r2 do
                local line = vim.fn.getline(i)
                if line:match("%S") then
                    if line:match("^%s*>%s?") then vim.fn.setline(i, line:gsub("^%s*>%s?", ""))
                    else vim.fn.setline(i, "> " .. line) end
                end
            end
        end)
    else
        local r1 = vim.fn.line(".")
        local line = vim.fn.getline(r1)
        if line:match("%S") then
            if line:match("^%s*>%s?") then vim.fn.setline(r1, line:gsub("^%s*>%s?", ""))
            else vim.fn.setline(r1, "> " .. line) end
        end
    end
end
vim.keymap.set({"n", "v"}, "<leader>q", toggle_quote, { desc = "Toggle Blockquote" })

-- ==========================================================================
-- OCTAVE: MATLAB IDE LAYOUT (ADAPTADO WINDOWS)
-- ==========================================================================
_G.run_octave_matlab_layout = function()
    if vim.bo.buftype ~= "" then return end
    vim.cmd("silent! update")
    local filedir, filename = vim.fn.expand("%:p:h"), vim.fn.expand("%:t:r")
    
    -- FIX 3: Usando a variável 'tmp' para caminhos do Windows
    local ws_file = tmp .. "octave_workspace.txt"
    local helper_file = tmp .. "refresh_ws.m"

    local helper_code = "function refresh_ws()\n  fid = fopen('" .. ws_file .. "', 'w');\n  if fid > 0\n    str = evalin('base', \"evalc('whos')\");\n    if ischar(str), fputs(fid, str); end\n    fclose(fid);\n  end\nendfunction\n"
    local f = io.open(helper_file, "w")
    if f then f:write(helper_code) f:close() end
    
    -- FIX 4: Substituído 'touch' (Linux) por comando Lua nativo
    local t = io.open(ws_file, "a") if t then t:close() end

    local uv = vim.uv or vim.loop
    if _G.ws_watcher then _G.ws_watcher:stop() end
    _G.ws_watcher = uv.new_fs_event()
    _G.ws_watcher:start(ws_file, {}, vim.schedule_wrap(function() vim.cmd("silent! checktime " .. ws_file) end))

    if not (_G.octave_term_buf and vim.api.nvim_buf_is_valid(_G.octave_term_buf)) then
        vim.cmd("botright vsplit " .. ws_file)
        vim.cmd("belowright split")
        vim.cmd("enew")
        _G.octave_term_buf = vim.api.nvim_get_current_buf()
        -- FIX 5: Removido 'env QT_QPA_PLATFORM' que é apenas para Linux
        _G.octave_job_id = vim.fn.termopen("octave --no-gui -q")
        vim.fn.chansend(_G.octave_job_id, "addpath('" .. tmp .. "'); clc;\n")
        vim.cmd("wincmd h")
    end
    vim.fn.chansend(_G.octave_job_id, string.format("clc; cd '%s'; %s; refresh_ws;\n", filedir, filename))
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "matlab", "octave" },
    callback = function() vim.keymap.set("n", "<leader>r", _G.run_octave_matlab_layout, { buffer = true }) end,
})

-- ==========================================================================
-- PYTHON: MATLAB IDE LAYOUT (ADAPTADO WINDOWS)
-- ==========================================================================
_G.run_python_ide_layout = function()
    if vim.bo.buftype ~= "" then return end
    vim.cmd("silent! update")
    local filepath = vim.fn.expand("%:p"):gsub("\\", "/")
    local ws_file = tmp .. "python_workspace.txt"
    local helper_file = tmp .. "dump_ws.py"

    local helper_code = "def dump(glbs):\n    with open('" .. ws_file .. "', 'w', encoding='utf-8') as f:\n        f.write(f\"{'Name'.ljust(15)} {'Type'.ljust(12)} Info\\n\")\n        f.write(\"-\" * 50 + \"\\n\")\n        for k, v in glbs.items():\n            if k.startswith('_'): continue\n            t = type(v).__name__\n            if t in ['module', 'function', 'builtin_function_or_method', 'type']: continue\n            val = str(v)[:30]\n            f.write(f\"{k.ljust(15)} {t.ljust(12)} {val}\\n\")\n"
    local f = io.open(helper_file, "w")
    if f then f:write(helper_code) f:close() end
    local t = io.open(ws_file, "a") if t then t:close() end

    if not (_G.python_term_buf and vim.api.nvim_buf_is_valid(_G.python_term_buf)) then
        vim.cmd("botright vsplit " .. ws_file)
        vim.cmd("belowright split")
        vim.cmd("enew")
        _G.python_term_buf = vim.api.nvim_get_current_buf()
        _G.python_job_id = vim.fn.termopen("ipython")
        vim.fn.chansend(_G.python_job_id, "import sys; sys.path.append('" .. tmp .. "'); from dump_ws import dump\nclear\n")
        vim.cmd("wincmd h")
    end
    vim.fn.chansend(_G.python_job_id, string.format("clear\n%%run -i '%s'\ndump(globals())\n", filepath))
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function() vim.keymap.set("n", "<leader>r", _G.run_python_ide_layout, { buffer = true }) end,
})

-- ==========================================================================
-- 3. VIMTEX (ADAPTADO PARA SUMATRAPDF NO WINDOWS)[cite: 1]
-- ==========================================================================
vim.g.vimtex_view_method = 'general'
vim.g.vimtex_view_general_viewer = 'SumatraPDF'
vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
vim.g.vimtex_compiler_method = 'latexmk'

vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'

-- ==========================================================================
-- 4. PLUGIN LIST (LAZY)
-- ==========================================================================
require("lazy").setup({
  { "folke/which-key.nvim", event = "VeryLazy", opts = { delay = 500 } },
  { 
    "sainnhe/gruvbox-material", lazy = false, priority = 1000, 
    config = function()
        vim.g.gruvbox_material_background = 'soft'
        vim.g.gruvbox_material_transparent_background = 1
        vim.cmd("colorscheme gruvbox-material")
    end
  },
  { "lervag/vimtex", ft = "tex" },
  { "sirver/ultisnips" },
  { "honza/vim-snippets" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() 
      -- FIX: pcall evita que o Neovim trave se o plugin ainda não estiver pronto
      local status, configs = pcall(require, "nvim-treesitter.configs")
      if not status then return end
      
      configs.setup({ 
        -- Removido "bash", que costuma dar erro de compilação no Windows
        ensure_installed = { "markdown", "markdown_inline", "lua", "vim", "latex", "python" },
        highlight = { enable = true },
      })
    end
  },
  { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown" } },
  { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" }, config = function() require("ufo").setup() end },
})
