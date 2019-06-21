EXPORT Get_layout(logical_file) := FUNCTIONMACRO

  // get logical file layout and convert into set
	
	get_lay_logical_file:=STD.File.GetLogicalFileAttribute(logical_file,'ECL');
	regex_replace_logical_file:= regexreplace('[{RECORD ;DATASET( ) END}]',get_lay_logical_file,' ');
 
RETURN regex_replace_logical_file;
 
ENDMACRO;