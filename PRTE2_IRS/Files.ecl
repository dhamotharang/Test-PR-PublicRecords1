EXPORT Files := module

	Export incoming_boca := dataset(constants.in_boca, layouts.incoming, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n','\r']), QUOTE('"')));
	Export incoming_alpha := dataset(constants.in_alpha, layouts.incoming, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n','\r']), QUOTE('"')));
	
  export incoming:=incoming_boca + incoming_alpha;
	
	export base			:= dataset(constants.base_prefix_name, layouts.base, thor);
	
end;