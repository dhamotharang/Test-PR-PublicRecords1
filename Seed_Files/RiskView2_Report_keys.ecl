
IMPORT Data_Services, doxie, risk_indicators;


EXPORT RiskView2_Report_keys := MODULE

	shared locat := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::riskview2report::';
	// shared locat := Data_Services.foreign_dataland + 'thor_data400::key::riskview2report::';
	
	d := Seed_Files.Riskview2_Report_files.Summary;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring); 
	  d;
	end;
	newtable := table(d, newrec);
	export Summary := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'Summary');
											locat + 'Summary_'+ doxie.Version_SuperKey);

	d := Seed_Files.Riskview2_Report_files.AddressHistory;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export AddressHistory := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'addresshistory');		
											locat + 'addresshistory_'+ doxie.Version_SuperKey);		

	d := Seed_Files.Riskview2_Report_files.RealProperty;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export RealProperty := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'realproperty');		
											locat + 'realproperty_'+ doxie.Version_SuperKey);		

	d := Seed_Files.Riskview2_Report_files.PersonalProperty;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export PersonalProperty := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'personalproperty');		
											locat + 'personalproperty_'+ doxie.Version_SuperKey);		

	d := Seed_Files.Riskview2_Report_files.Filing;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export filing := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'filing');		
											locat + 'filing_'+ doxie.Version_SuperKey);		

	d := Seed_Files.Riskview2_Report_files.Bankruptcy;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export Bankruptcy := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'bankruptcy');		
											locat + 'bankruptcy_'+ doxie.Version_SuperKey);		

	d := Seed_Files.Riskview2_Report_files.Criminal;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export Criminal := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'criminal');		
											locat + 'criminal_'+ doxie.Version_SuperKey);		

	d := Seed_Files.Riskview2_Report_files.Education;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export Education := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'education');		
											locat + 'education_'+ doxie.Version_SuperKey);		

	d := Seed_Files.Riskview2_Report_files.License;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export License := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'license');		
											locat + 'license_'+ doxie.Version_SuperKey);		

	d := Seed_Files.Riskview2_Report_files.BusinessAssociation;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export BusinessAssociation := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'businessassociation');		
											locat + 'businessassociation_'+ doxie.Version_SuperKey);		

	d := Seed_Files.Riskview2_Report_files.LoanOffer;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export LoanOffer := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'loanoffer');		
											locat + 'loanoffer_'+ doxie.Version_SuperKey);		

	d := Seed_Files.Riskview2_Report_files.CreditInquiry;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export CreditInquiry := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'creditinquiry');
											locat + 'creditinquiry_'+ doxie.Version_SuperKey);
											
	d := Seed_Files.Riskview2_Report_files.Purchase;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d.fname)),
																									trim((string20)stringlib.stringtouppercase(d.lname)),
																									trim((string9)d.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d.zip),
																									trim((string10)d.hphone),
																									risk_indicators.nullstring);
	  d;
	end;
	newtable := table(d, newrec);
	export Purchase := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											// locat + 'purchase');
											locat + 'purchase_'+ doxie.Version_SuperKey);
END;