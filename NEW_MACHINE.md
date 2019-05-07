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
- Create `C:\bin`, `C:\lang`, `C:\projects` folders
- Add to system path:
	- Add `PROJ`, pointing to `C:\projects`
	- Append to `PATH`: `C:\bin`
- Create `PROJ` system environment variable
- Clone dotfiles repo (this one) into `projects/dotfiles`
- Create `~/.machine_profile` defining `$PROJ` variable
- Create configuration symlinks in `cmd.exe` (from home directory):
	- Shell profile: `mklink .profile %PROJ%`
	- Git config:
		- `mklink .gitconfig "%PROJ%\dotfiles\home\.gitconfig"`
		- `mklink .gitignore-global "%PROJ%\dotfiles\home\.gitignore-global"`
	- Sublime Text config
		- `mklink C:\bin\subl.exe "C:\Program Files\Sublime Text 3\subl.exe"`
		- `mklink "%APPDATA%\Sublime Text 3\Packages\User\Preferences.sublime-settings" "%PROJ%\dotfiles\Preferences.sublime-settings"`
		- `mklink "%APPDATA%\Sublime Text 3\Packages\User\Default (Windows).sublime-keymap" "%PROJ%\dotfiles\other\Default.sublime-keymap"`
		- `mklink "%APPDATA%\Sublime Text 3\Packages\User\Default (Windows).sublime-mousemap" "%PROJ%\dotfiles\other\Default.sublime-mousemap"`
	- Alacritty config
		- `mklink /d "%APPDATA%\alacritty" "%PROJ%\dotfiles\other\alacritty"`
- Generate [GitHub personal access token](https://github.com/settings/tokens)