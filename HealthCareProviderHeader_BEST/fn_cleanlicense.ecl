EXPORT fn_cleanlicense (string25 lic) := function
	RETURN((STRING)((STRING)(UNSIGNED8)REGEXREPLACE('[^0-9]', lic, '')));	
end;

