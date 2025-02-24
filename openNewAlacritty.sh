# made to be used with a keybind
# will open a new alacritty window in the same directory as the active one

TERM=alacritty

# get the PID of the currently active window
ACTIVE_PID=$(hyprctl activewindow | grep 'pid:' | cut -d ':' -f2 | tr -d ' ')

# if no active window, default to home 
[[ -z "$ACTIVE_PID" ]] && "$TERM" && exit 0

# find the shell process 
CHILD_PID=$(pgrep -P "$ACTIVE_PID" -o)

# if no child, default to home
[[ -z "$CHILD_PID" ]] && "$TERM" && exit 0

# get the CWD of the shell process
SHELL_CWD=$(readlink /proc/$CHILD_PID/cwd)

# start "$TERM" in the shell's CWD if valid, else in home 
[[ -d "$SHELL_CWD" ]] && "$TERM" --working-directory "$SHELL_CWD" || "$TERM"
exit 0
