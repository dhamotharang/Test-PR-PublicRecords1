import data_services, seed_files;

d := seed_files.file_FDAttributes;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_FDAttributes := index(newtable,{dataset_name,hashvalue}, {newtable},data_services.data_location.prefix() + 'thor_data400::key::testseed::qa::fdattributes');