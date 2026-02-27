require("full-border"):setup {
	type = ui.Border.ROUNDED,
}

require("git"):setup {
	order = 1500,
}

th.git = th.git or {}
th.git.modified_sign = "M"
th.git.added_sign = "A"
th.git.untracked_sign = "?"
th.git.deleted_sign = "D"
th.git.updated_sign = "U"
th.git.ignored_sign = " "
th.git.clean_sign = "✔"

th.git.modified = ui.Style():fg("#f9e2af")
th.git.added = ui.Style():fg("#a6e3a1")
th.git.untracked = ui.Style():fg("#7f849c")
th.git.deleted = ui.Style():fg("#f38ba8"):bold()
th.git.updated = ui.Style():fg("#89b4fa")
th.git.ignored = ui.Style():fg("#585b70")
th.git.clean = ui.Style():fg("#a6e3a1")

require("relative-motions"):setup({ show_numbers = "relative", show_motion = true })
