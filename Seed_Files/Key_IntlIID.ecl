IMPORT Data_Services;
d := file_IntlIID(dataset_name <> 'Table_name');

newrec := record
	data16 hashvalue := Hash_IntlIID(d.inputecho.name.first,d.inputecho.name.last,d.inputecho.nationalidnumber,d.inputecho.address.postalcode,d.inputecho.homephone);
	d;
end;

newtable := table(d,newrec);

export Key_IntlIID := index(newtable,{dataset_name,hashvalue},
														{newtable},
														Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::intliid');
