

d :=  seed_files.file_blank_seed;

newrec := record
	string20 dataset_name := '';
	data16 hashvalue := GetHashMD5(d.fname,d.lname,d.ssn,d.z5,d.phone10);
	d;
end;

newtable := table(d,newrec);

export key_blank_testseed := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	'~thor_data400::key::testseed::qa::blank');