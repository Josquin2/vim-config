-- signs what changed in git

return {
	"lewis6991/gitsigns.nvim",

	-- TODO: configure gitsigns
	config = function()
		require("gitsigns").setup()
	end,
}
