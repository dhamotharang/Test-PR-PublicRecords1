Import Data_Services, Seed_Files;

d := Seed_Files.file_AMLRiskAttributes;

newrec := record
	data16 hashvalue := Hash_InstantID(d.FIRST_NM, d.LAST_NM, d.Individual_TIN, '',  d.zip, d.phone,'');
	d;
end;
newtable := table(d, newrec);

EXPORT Key_AMLRiskAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::amlriskattributes');