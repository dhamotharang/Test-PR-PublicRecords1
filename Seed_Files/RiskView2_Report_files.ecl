
EXPORT Riskview2_Report_files := MODULE

	export get_filename(string section) := FUNCTION
	
		fn := case (section,
									'summary'							=> '~thor_data400::in::riskview2report::summary',           
									'addresshistory'  		=> '~thor_data400::in::riskview2report::addresshistory',
									'realproperty'				=> '~thor_data400::in::riskview2report::realproperty',
									'personalproperty'		=> '~thor_data400::in::riskview2report::personalproperty',
									'filing'							=> '~thor_data400::in::riskview2report::filing',
									'bankruptcy'					=> '~thor_data400::in::riskview2report::bankruptcy',
									'criminal'						=> '~thor_data400::in::riskview2report::criminal',
									'education'						=> '~thor_data400::in::riskview2report::education',
									'license'							=> '~thor_data400::in::riskview2report::license',
									'businessassociation' => '~thor_data400::in::riskview2report::businessassociation',
									'loanoffer'						=> '~thor_data400::in::riskview2report::loanoffer',
									'creditinquiry'				=> '~thor_data400::in::riskview2report::creditinquiry',
									'purchase'						=> '~thor_data400::in::riskview2report::purchase',
									'' );
		if( fn='', FAIL('Unknown Section') );
		return fn;
	end;
	

	export Summary := dataset(get_filename('summary'), Seed_Files.RiskView2_Report_layouts.Summary, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export AddressHistory := dataset(get_filename('addresshistory'), Seed_Files.RiskView2_Report_layouts.AddressHistory, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export RealProperty := dataset(get_filename('realproperty'), Seed_Files.RiskView2_Report_layouts.RealProperty, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export PersonalProperty := dataset(get_filename('personalproperty'), Seed_Files.RiskView2_Report_layouts.PersonalProperty, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export Filing := dataset(get_filename('filing'), Seed_Files.RiskView2_Report_layouts.Filing, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export Bankruptcy := dataset(get_filename('bankruptcy'), Seed_Files.RiskView2_Report_layouts.Bankruptcy, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export Criminal := dataset(get_filename('criminal'), Seed_Files.RiskView2_Report_layouts.Criminal, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export Education := dataset(get_filename('education'), Seed_Files.RiskView2_Report_layouts.Education, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export License := dataset(get_filename('license'), Seed_Files.RiskView2_Report_layouts.License, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export BusinessAssociation := dataset(get_filename('businessassociation'), Seed_Files.RiskView2_Report_layouts.BusinessAssociation, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export LoanOffer := dataset(get_filename('loanoffer'), Seed_Files.RiskView2_Report_layouts.LoanOffer, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export CreditInquiry := dataset(get_filename('creditinquiry'), Seed_Files.RiskView2_Report_layouts.CreditInquiry, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	export Purchase := dataset(get_filename('purchase'), Seed_Files.RiskView2_Report_layouts.PurchaseActivity, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));

END;