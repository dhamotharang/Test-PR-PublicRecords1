import Data_Services,Seed_Files;

d :=  Seed_Files.File_BInstantID;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.rep_fname,d.rep_lname,'',d.fein,d.z5,d.phone10,d.company);
	d;
end;

newtable := table(d,newrec);

export key_BInstantID := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::testseed::qa::binstantid');