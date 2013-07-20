on run
	set the output to 0
	set the selected_files to {}
	
	tell application "System Events"
		tell (first application process whose frontmost is true)
			set visible of it to false
			set active_name to name of it
		end tell
		delay 0.2
		set bundleId to bundle identifier of first application process whose frontmost is true
	end tell
	
	if bundleId is "com.cocoatech.PathFinder" then
		set selected_files to retrieveSelectedFilesFromPathFinder(bundleId)
		
	else if bundleId is "com.apple.finder" then
		set selected_files to retrieveSelectedFilesFromFinder(bundleId)
	end if
	
	if selected_files is not {} then
		#sort files
		open_moai(selected_files)
	else
		set output to 1
	end if
	return output
	
end run

to retrieveSelectedFilesFromFinder(bundleId)
	set the selected_files to {}
	tell application id "com.apple.finder"
		activate
		set selected_items to selection
		if selected_items is not {} then
			if (count of selected_items) is 1 and kind of item 1 of selected_items is "folder" then
				#find lua selected_files in folder
			else
				repeat with selected_item in selected_items
					log selected_item
					if name extension of selected_item is "lua" then
						set lua_path to POSIX path of (selected_item as text)
						set the selected_files to selected_files & {lua_path}
					end if
				end repeat
			end if
		end if
	end tell
	return selected_files
end retrieve_selected_files_Finder

to retrieveSelectedFilesFromPathFinder(bundleId)
	set the selected_files to {}
	tell application id "com.cocoatech.PathFinder"
		activate
		set selected_items to selection
		if selected_items is not {} then
			if (count of selected_items) is 1 and kind of item 1 of selected_items is "folder" then
				#find lua selected_files in folder
			else
				repeat with selected_item in selected_items
					log selected_item
					if name extension of selected_item is "lua" then
						set lua_path to POSIX path of selected_item
						set the selected_files to selected_files & {lua_path}
					end if
				end repeat
			end if
		end if
	end tell
	return selected_files
end retrieve_selected_files_PathFinder

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