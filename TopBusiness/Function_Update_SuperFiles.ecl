export Function_Update_SuperFiles(string superfile_name,string in_version) := function

	DELETE_SUBFILE := TRUE;
	COPY_FILE_CONTENTS := TRUE;
	
	create_base := if(not FileServices.SuperfileExists(superfile_name),
		FileServices.CreateSuperFile(superfile_name));
	// create_father := if(not FileServices.SuperfileExists(superfile_name + '_father'),
		// FileServices.CreateSuperFile(superfile_name + '_father'));
	// create_grandfather := if(not FileServices.SuperfileExists(superfile_name + '_grandfather'),
		// FileServices.CreateSuperFile(superfile_name + '_grandfather'));
	
	return sequential(
		parallel(
			 create_base
			// ,create_father
			// ,create_grandfather
		),
		FileServices.StartSuperFileTransaction(),
			// FileServices.ClearSuperFile(superfile_name + '_grandfather', DELETE_SUBFILE),
			// FileServices.AddSuperFile(superfile_name   + '_grandfather', superfile_name + '_father',,COPY_FILE_CONTENTS),
			// FileServices.ClearSuperFile(superfile_name + '_father'),
			// FileServices.AddSuperFile(superfile_name   + '_father', superfile_name,,COPY_FILE_CONTENTS),

			FileServices.ClearSuperFile(superfile_name, DELETE_SUBFILE),
			// FileServices.ClearSuperFile(superfile_name),
			FileServices.AddSuperFile(superfile_name, superfile_name + in_version), 
		FileServices.FinishSuperFileTransaction());

end;
