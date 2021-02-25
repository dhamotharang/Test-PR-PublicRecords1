IMPORT Data_Services, Seed_Files;

d := Seed_Files.File_OSAttributes;

newrec := record
	data16 hashvalue := Hash_InstantID(d.fname, d.lname, d.social, '', d.zip, d.homephone, '');
	d;
end;
newtable := table(d, newrec);

export Key_OSAttributes := index(newtable,{table_name,hashvalue}, {newtable}, 
	Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::osattributes');