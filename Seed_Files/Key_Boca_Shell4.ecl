Import Data_Services, ut;

export Key_Boca_Shell4 (boolean IsFCRA = false) := function
  
	d := if(IsFCRA, seed_files.file_boca_shell4_fcra, seed_files.file_boca_shell4);

	newrec := record
		data16 hashvalue := Hash_InstantID(
													stringlib.stringtouppercase(d.fname), 
													stringlib.stringtouppercase(d.lname), 
													d.ssn, 
													'', 
													d.zip, 
													d.hphone, 
													'');
		d;
	end;
	newtable := table(d, newrec);

	file_name := if (IsFCRA, 
                    Data_Services.Data_location.Prefix('TestSeeds')+'thor_data400::key::testseed::qa::boca_shell4_fcra',
                    Data_Services.Data_location.Prefix('TestSeeds')+'thor_data400::key::testseed::qa::boca_shell4');

	return index (newtable, {dataset_name,hashvalue}, {newtable}, file_name);
end;
