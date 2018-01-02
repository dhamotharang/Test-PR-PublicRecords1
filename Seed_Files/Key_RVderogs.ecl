import data_services;

d := file_RVderogs;

newrec := record
	data16 hashvalue := Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_RVderogs := index(newtable,{dataset_name,hashvalue}, {newtable}, data_services.data_location.prefix() + 'thor_data400::key::testseed::qa::rvderogs');
