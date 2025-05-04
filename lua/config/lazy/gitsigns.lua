-- signs what changed in git

return {
	"lewis6991/gitsigns.nvim",

	config = function()
		require("gitsigns").setup()
	end,
}
