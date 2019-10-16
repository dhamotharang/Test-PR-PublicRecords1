IMPORT inql_ffd;
export clear_files(boolean isUpdate = true, boolean isFCRA = true, string pVersion = '') := module
	
	shared FS 		:= fileservices;
	
	export Input := sequential(
					FS.StartSuperFileTransaction(),
									nothor(FS.ClearSuperFile(filenames(isUpdate, isFCRA, pVersion).Input)),
					FS.FinishSuperFileTransaction()
						);
	
	export InputBuilding := sequential(
					FS.StartSuperFileTransaction(),
									nothor(FS.ClearSuperFile(filenames(isUpdate, isFCRA, pVersion).InputBuilding)),
					FS.FinishSuperFileTransaction()
						);
						
	export InputHistory := sequential(
					FS.StartSuperFileTransaction(),
									nothor(FS.ClearSuperFile(filenames(isUpdate, isFCRA, pVersion).InputHistory)),
					FS.FinishSuperFileTransaction()
						);
						
end;