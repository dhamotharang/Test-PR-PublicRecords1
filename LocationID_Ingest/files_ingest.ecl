import LocationID_Ingest;

export files_ingest := module
	export l_base := LocationID_Ingest.Layout_Base;
	/*----------------- Filename Prefixes --------------------------------- */
 export location		:= '';
	shared filePrefix	:= '~thor_data::location_id::';
	
	//Superfiles
 export FILE_BASE				    := filePrefix + 'base';
	export FILE_FATHER			   := filePrefix + 'father';
	export FILE_GRANDFATHER	:= filePrefix + 'grandfather';
	export FILE_BUILDING		  := filePrefix + 'building';
	export DS_BUILDING			   := dataset(location + FILE_BUILDING, l_base, thor, opt);
	export DS_BASE   				   := dataset(location + FILE_BASE, l_base, thor, opt);
	export DS_FATHER   			  := dataset(location + FILE_FATHER, l_base, thor, opt);
	export DS_GRANDFATHER		 := dataset(location + FILE_GRANDFATHER, l_base, thor, opt);

 import tools;
 export file_versions  (string pversion) := tools.mod_FilenamesBuild(filePrefix + 'out_@version@',pversion );
 export ds_file        (string pversion) := tools.macf_FilesBase(file_versions(pversion) ,l_base           );
	
	/*----------------- Logical File Prefixes ------------------------------------------ */
	export FILE_IN	:= filePrefix + 'in';
	export FILE_OUT := filePrefix + 'out';
	export FILE_TYP := filePrefix + 'typ';
	
	/*-------------------- Update SuperFiles ----------------------------------------------------*/
	export updateSuperFiles(string inFile) := function
		action := SEQUENTIAL(
			FileServices.PromoteSuperFileList([FILE_BASE,
																				 FILE_FATHER,
																				 FILE_GRANDFATHER], inFile, true)
		);
		return action;
	end;
	
	export updateBuilding(string inFile) := function
		return FileServices.PromoteSuperFileList([FILE_BUILDING], inFile, FALSE);
	end;

	export revertSuperFiles() := function
		return FileServices.PromoteSuperFileList([FILE_GRANDFATHER,
																				      FILE_FATHER,
																				      FILE_BASE]);
	end;
	
	
	/*-------------------- Clear SuperFiles ----------------------------------------------------*/
	export clearSuperFiles := parallel(
		FileServices.ClearSuperFile(FILE_BASE);
		FileServices.ClearSuperFile(FILE_FATHER);
		FileServices.ClearSuperFile(FILE_GRANDFATHER)
	);

	export clearBuilding := FileServices.ClearSuperFile(FILE_BUILDING);
	
end;