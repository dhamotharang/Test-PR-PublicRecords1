
EXPORT Files := module

	export infile := dataset(Constants.in_prefix_name, Layouts.incoming, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	export basefile_nonfcra := dataset(Constants.base_prefix_name+ 'nonfcra::additionalevents', Layouts.Base, thor);
	export fcra_recs := fGetFCRARecs(basefile_nonfcra);

END;
