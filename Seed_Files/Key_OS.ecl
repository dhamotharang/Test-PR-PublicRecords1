IMPORT Data_Services, Seed_Files;

d :=  seed_files.file_OS;

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.social, ''/*fein*/, d.zip, d.homephone, ''/*cmpy name*/);
	d;
end;
newtable := table(d, newrec);


export Key_OS := index(newtable,{table_name, hashvalue}, {newtable}, 
	Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::os');