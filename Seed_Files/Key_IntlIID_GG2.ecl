IMPORT Data_Services, Seed_Files;

d := Seed_Files.file_IntlIID_GG2(DatasetName!='Table_name');

newRec := RECORD,MAXLENGTH(10000)
	DATA16 hashvalue := Hash_IntlIID(d.hashFirstName,d.hashLastName,d.hashNationalID,d.hashPostalCode,d.hashTelephone);
	d;
END;

newTable := TABLE(d,newRec);

EXPORT Key_IntlIID_GG2 := INDEX(newTable,{DatasetName,hashvalue},{newTable},
													Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::intliid_gg2');
