Import Data_Services, ut;

d := Seed_Files.file_AMLRiskAttributes;

newrec := record
	data16 hashvalue := Hash_InstantID(d.FIRST_NM, d.LAST_NM, d.Individual_TIN, '',  d.zip, d.phone,'');
	d;
end;
newtable := table(d, newrec);

// export key_AMLRiskAttributes := index(newtable,{dataset_name,hashvalue}, {newtable},  '~thor_data400::key::testseed::qa::amlriskattributes_test');
export Key_AMLRiskAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::amlriskattributes');