import data_services;

d :=  seed_files.file_RVAuto;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_RVAuto := index(newtable,{dataset_name,hashvalue}, {newtable}, data_services.data_location.prefix() + 'thor_data400::key::testseed::qa::rvauto');