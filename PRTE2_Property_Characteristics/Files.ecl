EXPORT Files := module

	export infile := dataset(constants.IN_PREFIX_NAME, layouts.incoming, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')))(property_rid <> 0);
	
	export base := project(infile, transform(layouts.base, self := left, self := []));
	
end;	