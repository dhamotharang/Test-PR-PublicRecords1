IMPORT Data_Services, Seed_Files;

d := Seed_Files.file_AMLRiskAttributesV2;

newrec := record
	data16 hashvalue := Hash_InstantID(d.FIRST_NM, d.LAST_NM, d.Individual_SSN, '',  d.zip, d.phone,'');
	d;
end;
newtable := table(d, newrec);

ExPORT key_AMLRiskAttributesV2 := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::amlriskattributesV2');