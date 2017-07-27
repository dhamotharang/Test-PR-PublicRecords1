d :=  seed_files.file_RVTelecom;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_RVTelecom := index(newtable,{dataset_name,hashvalue}, {newtable}, '~thor_data400::key::testseed::qa::rvtelecom');