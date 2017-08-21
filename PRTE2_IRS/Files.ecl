EXPORT Files := module

	export incoming := dataset(constants.in_prefix_name, layouts.incoming, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n','\r']), QUOTE('"')));
	export base			:= dataset(constants.base_prefix_name, layouts.base, thor);
	
end;