Import Data_Services, Seed_Files;

export Key_Boca_Shell (boolean IsFCRA = false) := function
  
	d := if(IsFCRA, Seed_Files.file_boca_shell_fcra, Seed_Files.file_boca_shell);

	newrec := record
		data16 hashvalue := Hash_InstantID(d.fname, d.lname, d.ssn, '', d.zip, d.hphone, '');
		d;
	end;
	newtable := table(d, newrec);

	file_name := if (IsFCRA, 
                   Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::boca_shell_fcra',
                   Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::testseed::qa::boca_shell');

	return index (newtable, {dataset_name,hashvalue}, {newtable}, file_name);
end;
