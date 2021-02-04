IMPORT Data_Services,Seed_Files;

d := Seed_Files.file_LeadIntegrityAttributes;

newrec := record
	data16 hashvalue := Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
	d;
end;
newtable := table(d, newrec);

export Key_LeadIntegrityAttributes := index(newtable,{dataset_name,hashvalue}, {newtable}, Data_Services.Data_location.Prefix('NONAMEGIVEN') + '~thor_data400::key::testseed::qa::leadintegrityattributes');