import doxie, Data_Services;
EXPORT ConsumerProfile_keys := MODULE

	shared locat := Data_Services.Data_location.Prefix('ConsumerProfile') + 'thor_data400::key::consumerprofile::';
	
	d := Seed_Files.ConsumerProfile_files.Report;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.in_zip5, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export Report := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'Report_'+ doxie.Version_SuperKey);


	d := Seed_Files.ConsumerProfile_files.AddressHistory;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.in_zip5, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export AddressHistory := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'addresshistory_'+ doxie.Version_SuperKey);		

	d := Seed_Files.ConsumerProfile_files.AKAs;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.in_zip5, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export AKAs := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'akas_'+ doxie.Version_SuperKey);		

END;