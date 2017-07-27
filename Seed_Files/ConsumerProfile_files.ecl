EXPORT ConsumerProfile_files := MODULE

	export get_filename(string section) := FUNCTION
	
		fn := case (section,
									'report'						=> '~thor_data400::in::consumerprofile::report',           
									'addresshistory'  	=> '~thor_data400::in::consumerprofile::addresshistory',
									'akas'							=> '~thor_data400::in::consumerprofile::akas',
									'' );
		if( fn='', FAIL('Unknown Section') );
		return fn;
	end;
	

	export Report := dataset(get_filename('report'), Seed_Files.ConsumerProfile_layouts.Report, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export AddressHistory := dataset(get_filename('addresshistory'), Seed_Files.ConsumerProfile_layouts.AddressHistory, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export AKAs := dataset(get_filename('akas'), Seed_Files.ConsumerProfile_layouts.AKAs, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));

END;