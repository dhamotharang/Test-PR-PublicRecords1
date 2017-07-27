import ut;

d := dataset('~thor_data400::base::testseed_bs_services_iid_address_history', seed_files.Layout_BS_Services, csv(quote('"'), maxlength(10000)) );

newrec := record
	data16 hashvalue := seed_files.Hash_InstantID(d.fname,d.lname,d.ssn,'',d.zipcode,d.phone10,'');
	d;
end;

newtable := table(d,newrec);

export Key_BS_Services := index(newtable,{dataset_name,hashvalue},
																	{newtable},
																	'~thor_data400::key::testseed::qa::bs_services_iid_address_history');
																	// ut.foreign_dataland + 'thor_data400::key::testseed::qa::bs_services_iid_address_history');