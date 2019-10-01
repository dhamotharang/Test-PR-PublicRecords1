import data_services, Seed_Files;

d :=  Seed_Files.file_FraudPoint;

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_FraudPoint := index(newtable,{dataset_name,hashvalue}, {newtable}, data_services.data_location.prefix() + 'thor_data400::key::testseed::qa::fraudpoint');
