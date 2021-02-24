import Data_Services,Seed_Files;

d :=  seed_files.file_LNSmallBusiness;

seed_layout := record
	data16 hashvalue := seed_files.Hash_InstantID(
		StringLib.StringToUpperCase(trim(d.rep_first)),   // fname,
		StringLib.StringToUpperCase(trim(d.rep_last)),    // lname,
		'',                  // ssn -- not used in business products,
		StringLib.StringToUpperCase(trim(d.bus_fein)),    // fein,
		StringLib.StringToUpperCase(trim(d.bus_zip5)),    // zip,
		StringLib.StringToUpperCase(trim(d.bus_phone10)), // phone,
		StringLib.StringToUpperCase(trim(d.bus_name))     // company_name
	);  
	d;
end;

withHash := table( d, seed_layout );

export Key_LNSmallBusiness := index(withHash,{hashvalue}, {withHash}, data_services.data_location.prefix() + 'thor_data400::key::testseed::qa::lnsmallbusiness');