IMPORT Data_Services, Seed_Files;

d := Seed_Files.file_HealthCareAttributes;

newrec := record
	data16 hashvalue := Seed_Files.Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zipcode, d.phone10, '');
	d;
end;
newtable := table(d, newrec);

EXPORT Key_HealthCareAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::healthcareattributes');