
EXPORT RiskviewReport_files := MODULE

	export get_filename(string section) := FUNCTION
	
		fn := case (section,
										'summary'							=> '~thor_data400::in::riskviewreport::summary',           
									'addresshistory'  		=> '~thor_data400::in::riskviewreport::addresshistory',
									'realproperty'				=> '~thor_data400::in::riskviewreport::realproperty',
									'personalproperty'		=> '~thor_data400::in::riskviewreport::personalproperty',
									'filing'							=> '~thor_data400::in::riskviewreport::filing',
									'bankruptcy'					=> '~thor_data400::in::riskviewreport::bankruptcy',
									'criminal'						=> '~thor_data400::in::riskviewreport::criminal',
									'education'						=> '~thor_data400::in::riskviewreport::education',
									'license'							=> '~thor_data400::in::riskviewreport::license',
									'businessassociation' => '~thor_data400::in::riskviewreport::businessassociation',
									'loanoffer'						=> '~thor_data400::in::riskviewreport::loanoffer',
									'creditinquiry'				=> '~thor_data400::in::riskviewreport::creditinquiry',
									'' );
		if( fn='', FAIL('Unknown Section') );
		return fn;
	end;
	

	export Summary := dataset(get_filename('summary'), Seed_Files.RiskViewReport_layouts.Summary, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export AddressHistory := dataset(get_filename('addresshistory'), Seed_Files.RiskViewReport_layouts.AddressHistory, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export RealProperty := dataset(get_filename('realproperty'), Seed_Files.RiskViewReport_layouts.RealProperty, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export PersonalProperty := dataset(get_filename('personalproperty'), Seed_Files.RiskViewReport_layouts.PersonalProperty, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export Filing := dataset(get_filename('filing'), Seed_Files.RiskViewReport_layouts.Filing, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export Bankruptcy := dataset(get_filename('bankruptcy'), Seed_Files.RiskViewReport_layouts.Bankruptcy, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export Criminal := dataset(get_filename('criminal'), Seed_Files.RiskViewReport_layouts.Criminal, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export Education := dataset(get_filename('education'), Seed_Files.RiskViewReport_layouts.Education, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export License := dataset(get_filename('license'), Seed_Files.RiskViewReport_layouts.License, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export BusinessAssociation := dataset(get_filename('businessassociation'), Seed_Files.RiskViewReport_layouts.BusinessAssociation, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export LoanOffer := dataset(get_filename('loanoffer'), Seed_Files.RiskViewReport_layouts.LoanOffer, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export CreditInquiry := dataset(get_filename('creditinquiry'), Seed_Files.RiskViewReport_layouts.CreditInquiry, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));

END;