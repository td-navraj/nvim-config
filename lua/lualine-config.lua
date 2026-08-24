-- lualine configuration
require('lualine').setup {
    options = {
	theme = 'onedark',
	section_separators = '',
	component_separators = ''
    },
    sections = {
	lualine_b = {'branch'},
	lualine_c = {{'filename', path=3,}},
	lualine_x = {''}
    },
    inactive_sections = {
	lualine_c = {{'filename', path=4,}},
    }
}
