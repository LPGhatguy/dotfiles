# Setting up a new machine
Things to do when setting up a new Windows 10 machine.

- Fix Windows settings:
	1. Enable Developer Mode
	2. Set key repeat delay to the minimum
	3. Show hidden files and folder
	4. Unpin software from the start menu
	5. Hide recently used and tips from start menu
	6. Set 'Combine taskbar buttons' to never (Vista-style taskbar)
	7. Turn off animations (they make me motion sick)
- Install software
	1. Chrome
	3. Git
	2. Sublime Text
- Run [uncap](https://github.com/susam/uncap) to remap `Caps Lock` to `Escape`
- Create `bin`, `lang`, `projects` folders
- Create `PROJ` system environment variable
- Clone dotfiles repo (this one) into `projects/dotfiles`
- Create `~/.machine_profile` defining `$PROJ` variable
- Create configuration symlinks in `cmd.exe` (from home directory):
	1. Shell profile: `mklink .profile %PROJ%`
	2. Sublime Text config
		- `mklink "%APPDATA%\Sublime Text 3\Packages\User\Preferences.sublime-settings" "%PROJ%\dotfiles\Preferences.sublime-settings"`
		- `mklink "%APPDATA%\Sublime Text 3\Packages\User\Default (Windows).sublime-keymap" "%PROJ%\dotfiles\other\Default.sublime-keymap"`
		- `mklink "%APPDATA%\Sublime Text 3\Packages\User\Default (Windows).sublime-mousemap" "%PROJ%\dotfiles\other\Default.sublime-mousemap"`
	3. Alacritty config
		- `mklink /d "%APPDATA%\alacritty" "%PROJ%\dotfiles\other\alacritty"`