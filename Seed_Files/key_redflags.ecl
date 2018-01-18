import  Risk_Indicators,data_services;


d :=  seed_files.file_redflags;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID((string20)d.fname,(string20)d.lname,
																								 (string9)d.ssn,Risk_Indicators.nullstring,
																								 (string5)d.zipcode,(string10)d.phone10,Risk_Indicators.nullstring);
	d;
end;



newtable := table(d,newrec);

export key_redflags := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	data_services.data_location.prefix() + 'thor_data400::key::testseed::qa::redflags');