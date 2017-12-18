Import Data_Services;

d := Seed_Files.file_HealthCareAttributes;

newrec := record
	data16 hashvalue := Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zipcode, d.phone10, '');
	d;
end;
newtable := table(d, newrec);

// export Key_HealthCareAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.foreign_dataland+'thor_data400::key::testseed::qa::healthcareattributes');
export Key_HealthCareAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::healthcareattributes');