require("full-border"):setup()
require("relative-motions"):setup({ show_numbers="relative_absolute", show_motion = true })


function Header:host()
	if ya.target_family() ~= "unix" then
		return ui.Line {}
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
 end

function Header:render(area)
	self.area = area

	local right = ui.Line { self:count(), self:tabs() }
	local left = ui.Line { self:cwd(math.max(0, area.w - right:width())) }
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
	}
end