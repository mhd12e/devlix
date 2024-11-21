//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"  : ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},

	{" : ", "date '+%b %d (%a) %I:%M %p'",					5,		0},

	{"󰕾 : ","amixer get Master | grep -m 1 -o '[0-9]*%'",1,0} ,

	{" : ","upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}'",30,0},

	{"󰖩 : ","nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2",5,0}
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
