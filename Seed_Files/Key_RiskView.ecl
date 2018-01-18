import  data_services;

d :=  seed_files.file_RiskView;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_RiskView := index(newtable,{dataset_name,hashvalue}, {newtable}, data_services.data_location.prefix() + 'thor_data400::key::testseed::qa::riskview');