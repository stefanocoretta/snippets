#!/bin/bash

# <bitbar.title>Agenda</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Matthew Kennard</bitbar.author>
# <bitbar.author.github>mgkennard</bitbar.author.github>
# <bitbar.desc>Shows the Org-mode agenda</bitbar.desc>
# <bitbar.dependencies>bash</bitbar.dependencies>

echo "Agenda"
echo "---"
echo "|dropdown=false"
echo "---"

echo "Refresh|refresh=true"
echo "---"
line_index=0
had_timed_entries=false
/usr/local/bin/emacs -batch -l ~/.emacs.d/init.el -eval '(org-batch-agenda "a" org-agenda-span (quote week))' 2>/dev/null | while IFS= read -r line ; do
	if [[ $line_index -gt 0 ]] && [[ ! $line = *"---" ]] && [[ ! $line = *"- - -"* ]] ; then
		if [[ $line = *"..."* ]] ; then
	    had_timed_entries=true
		elif [[ $had_timed_entries = true ]] ; then
	    echo "---"
	    had_timed_entries=false
		fi
		if [[ $line = *"TODO "* ]] ; then
	    font="BrandonGrotesque-Bold"
		else
	    font="BrandonGrotesque-Regular"
		fi
		if [[ $line = *"DONE "* ]] || [[ $line = *"CANCELLED "* ]] ; then
	    color="gray"
		elif [[ $line = *"x: "* ]] ; then
	    color="red"
		else
	    color="black"
		fi
		printf '%s\n' "$line | color=$color font=$font size=14 trim=false"
	fi
	line_index=$((line_index+1))
done
