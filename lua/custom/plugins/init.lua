-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'lervag/vimtex',
    -- VimTeX 2.17 requires Neovim 0.10; stay compatible with 0.9.5.
    tag = 'v2.16',
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = 'general'
      vim.g.vimtex_view_general_viewer = 'evince'

      if vim.fn.executable 'latexmk' == 0 then
        vim.g.vimtex_compiler_method = 'generic'
        vim.g.vimtex_compiler_generic = {
          command = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error @tex',
        }
      end
    end,
  },
  {
    -- Live LaTeX preview. Requires the `texpresso` binary on $PATH
    -- (build from https://github.com/let-def/texpresso).
    'let-def/texpresso.vim',
    ft = { 'tex', 'plaintex', 'bib' },
    config = function()
      vim.keymap.set('n', '<localleader>lp', '<cmd>TeXpresso %<CR>', { desc = 'TeXpresso live [p]review' })
      if vim.fn.executable 'texpresso' == 0 then
        vim.notify_once('texpresso.vim: `texpresso` binary not found on $PATH', vim.log.levels.WARN)
      end
    end,
  },
}
