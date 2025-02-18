# made to be trigger by a keybind
# will send a notification with the current usage of Cpu, Gpu and Memorry
# requires libnotify

# get the % of idle cpu, and substract it to 100 to get total usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')

# get the used memorry 
MEM_USED=$(free | grep "^Mem" | tr -s " " | cut -d" " -f3)

# get the total of memorry in the pc
MEM_TT=$(free | grep "^Mem" | tr -s " " | cut -d" " -f2)

# calculate the % of used memorry
MEM_PERCENT=$((100 * MEM_USED / MEM_TT))

DISK_USAGE=$(df -h / | tail -n1 | tr -s " " | cut -d" " -f5)

notify-send "cpu usage" "$CPU_USAGE"
notify-send "memorry usage" "$MEM_PERCENT%"
notify-send "disk usage" "$DISK_USAGE"

exit 0
