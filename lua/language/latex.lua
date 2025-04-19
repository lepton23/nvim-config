return { -- LaTeX
  'lervag/vimtex',
  config = function()
    vim.g.vimtex_compiler = "xelatex --shell-escape"
  end
}
