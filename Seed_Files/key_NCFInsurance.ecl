import ut, risk_indicators;

d :=  seed_files.file_NCFInsurance;

seed_layout := record
	data16 hashvalue := seed_files.Hash_InstantID(
		StringLib.StringToUpperCase(trim(d.request.first)),  // fname,
		StringLib.StringToUpperCase(trim(d.request.last)),   // lname,
		StringLib.StringToUpperCase(trim(d.request.ssn)),    // ssn,
		Risk_Indicators.nullstring,                          // fein -- not used
		StringLib.StringToUpperCase(trim(d.request.zip)),    // zip,
		Risk_Indicators.nullstring,                          // phone -- not used
		Risk_Indicators.nullstring                           // company_name -- not used
	);  
	d;
end;

withHash := table( d, seed_layout );

export key_NCFInsurance := index(withHash,{hashvalue,table_name,model_name}, {withHash},
	'~thor_data400::key::testseed::qa::ncfinsurance');