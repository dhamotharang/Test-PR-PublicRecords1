import data_services;

d :=  file_FlexID;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname,d.lname,d.ssn,'',d.zipcode,d.phone10,'');
	d;
end;
newtable := table(d,newrec);

export Key_FlexID := index(newtable,{dataset_name,hashvalue},
									{newtable},
									data_services.data_location.prefix() +'thor_data400::key::testseed::qa::flexid');