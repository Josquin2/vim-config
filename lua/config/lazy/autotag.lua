-- autotags <script></script> and stuff

return {
	"windwp/nvim-ts-autotag",
	config = function()
		require("nvim-ts-autotag").setup({
			ensure_installed = { "html", "javascript", "typescript", "tsx", "vue" },
			highlight = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
		})
	end,
}
