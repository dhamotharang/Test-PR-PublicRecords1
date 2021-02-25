import data_services,Seed_Files;

d :=  seed_files.file_CBD;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.first, d.last, d.social, ''/*fein*/, d.zip, d.homephone, ''/*cmpy name*/);
	d;
end;
newtable := table(d, newrec);


export Key_CBD := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::testseed::qa::cbd');