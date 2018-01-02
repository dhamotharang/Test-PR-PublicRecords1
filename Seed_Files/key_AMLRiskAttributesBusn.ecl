Import Data_Services;

d := Seed_Files.file_AMLRiskAttributesBusn;

newrec := record
	data16 hashvalue := Hash_InstantID('', '', '', d.Business_TIN, d.zip, d.phone, d.Business_Name);
	d;
end;
newtable := table(d, newrec);

// export key_AMLRiskAttributesBusn := index(newtable,{dataset_name,hashvalue}, {newtable},  Data_Services.foreign_dataland + 'thor_data400::key::testseed::qa::amlriskattributesBusn_test');
export Key_AMLRiskAttributesBusn := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::amlriskattributesbusn');
																																																					