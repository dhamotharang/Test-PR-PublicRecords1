EXPORT Files := module

	export infile := dataset(Constants.in_prefix_name, Layouts.incoming, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	export basefile := dataset(Constants.base_prefix_name, Layouts.Base, thor);
	export header_frandx := project(basefile, {basefile} - [cust_name, bug_num]);
end;