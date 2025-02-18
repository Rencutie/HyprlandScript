TERM=alacritty
FILE_MANAGER=thunar

# get the PID of the currently active window
ACTIVE_PID=$(hyprctl activewindow | grep 'pid:' | cut -d ':' -f2 | tr -d ' ')

# if no active window, default to home 
[[ -z "$ACTIVE_PID" ]] && "$FILE_MANAGER" && exit 0

# find the shell process 
CHILD_PID=$(pgrep -P "$ACTIVE_PID" -o)

# if no child, default to home
[[ -z "$CHILD_PID" ]] && "$FILE_MANAGER" && exit 0

# get the CWD of the shell process
SHELL_CWD=$(readlink /proc/$CHILD_PID/cwd)

# start "$FILE_MANAGER" in the shell's CWD if valid, else in home 
[[ -d "$SHELL_CWD" ]] && "$FILE_MANAGER" "$SHELL_CWD" || "$FILE_MANAGER"
exit 0
