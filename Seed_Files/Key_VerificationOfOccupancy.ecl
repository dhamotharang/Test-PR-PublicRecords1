Import Data_Services, ut;

d := Seed_Files.file_VerificationOfOccupancy;

newrec := record
	data16 hashvalue := Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zipcode, d.phone10, '');
	d;
end;
newtable := table(d, newrec);

// export Key_VerificationOfOccupancy := index(newtable,{dataset_name,hashvalue}, {newtable}, ut.foreign_dataland+'thor_data400::key::testseed::qa::verificationofoccupancy');
export Key_VerificationOfOccupancy := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::verificationofoccupancy');