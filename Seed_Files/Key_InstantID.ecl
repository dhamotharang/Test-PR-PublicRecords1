import Data_Services,Seed_Files;


d :=  seed_files.file_InstantID;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname,d.lname,d.ssn,'',d.zipcode,d.phone10,'');
	d;
end;

newtable := table(d,newrec);

export key_InstantID := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::testseed::qa::instantid');