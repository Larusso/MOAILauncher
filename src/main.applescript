on run
	set the output to 0
	set the selected_files to {}
	tell application "Path Finder"
		activate
		set selected_items to selection
		#log selected_items
		if selected_items is not {} then
			if (count of selected_items) is 1 and kind of item 1 of selected_items is "folder" then
				#find lua files in folder
			else
				repeat with selected_item in selected_items
					log selected_item
					if name extension of selected_item is "lua" then
						set the selected_files to selected_files & {POSIX path of selected_item}
					end if
				end repeat
			end if
		end if
	end tell
	
	if selected_files is not {} then
		#sort files
		open_moai(selected_files)
	else
		set output to 1
	end if
	return output
end run

on open listItems
	process_listItems(listItems)
end open

on process_listItems(listItems)
	
end process_listItems

on open_moai(lua_files)
	set script_path to (path to resource "Shell/moai_run.sh")
	do shell script POSIX path of script_path & " " & joinList(lua_files, " ")
end open_moai

to joinList(aList, delimiter)
	set retVal to ""
	set prevDelimiter to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delimiter
	set retVal to aList as string
	set AppleScript's text item delimiters to prevDelimiter
	return retVal
end joinList

to splitString(aString, delimiter)
	set retVal to {}
	set prevDelimiter to AppleScript's text item delimiters
	log delimiter
	set AppleScript's text item delimiters to {delimiter}
	set retVal to every text item of aString
	set AppleScript's text item delimiters to prevDelimiter
	return retVal
end splitString