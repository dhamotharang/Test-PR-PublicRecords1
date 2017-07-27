Import Data_Services, ut;

d := Seed_Files.file_AMLRiskAttributesBusnV2;

newrec := record
	data16 hashvalue := Hash_InstantID('', '', '', d.Business_TIN, d.zip, d.phone, d.Business_Name);
	d;
end;
newtable := table(d, newrec);

export key_AMLRiskAttributesBusnV2 := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.Data_location.Prefix('NONAMEGIVEN') +'thor_data400::key::testseed::qa::amlriskattributesBusnV2');

																																																					