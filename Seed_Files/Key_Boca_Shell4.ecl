﻿Import Data_Services, Seed_Files, STD;

EXPORT Key_Boca_Shell4 (boolean IsFCRA = false) := function
  
	d := if(IsFCRA, Seed_Files.file_boca_shell4_fcra, Seed_Files.file_boca_shell4);

	newrec := record
		data16 hashvalue := Hash_InstantID(
													STD.Str.ToUpperCase(d.fname), 
													STD.Str.ToUpperCase(d.lname), 
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
