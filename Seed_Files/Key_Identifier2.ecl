import seed_files,data_services;

d := dataset(data_services.data_location.prefix() + 'thor_data400::base::testseed_identifier2', seed_files.layout_identifier2, csv(quote('"')));

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.name_first,d.name_last,d.ssn,'',d.zip5,d.home_phone,'');
	d;
end;

newtable := table(d,newrec);

export Key_Identifier2 := index(newtable,{table_name,hashvalue},
                                  {newtable},
																	data_services.data_location.prefix() + 'thor_data400::key::testseed::qa::identifier2');
																	