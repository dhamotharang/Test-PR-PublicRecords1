import LocationID_Ingest;
import LocationID_iLink;
import tools;

export files_locationid := module
	export l_base        := LocationID_Ingest.Layout_Base;
	export l_location_id := LocationID_iLink.Layout_LocationID;
	/*----------------- Filename Prefixes --------------------------------- */
 export location		:= '';
	shared filePrefix	:= '~thor_data::location_id_build::location_id::';
	
	//Superfiles
	export FILE_LOCATION_ID_IN := filePrefix + 'location_id_in';
 export FILE_BASE				       := filePrefix + 'base';
	export FILE_FATHER			      := filePrefix + 'father';
	export FILE_GRANDFATHER	   := filePrefix + 'grandfather';
	export DS_LOCATION_ID   			:= dataset(location + FILE_LOCATION_ID_IN, l_location_id, thor, opt);
	export DS_BASE   				      := dataset(location + FILE_BASE, l_base, thor, opt);
	export DS_FATHER   			     := dataset(location + FILE_FATHER, l_base, thor, opt);
	export DS_GRANDFATHER		    := dataset(location + FILE_GRANDFATHER, l_base, thor, opt);

 export file_versions  (string pversion) := tools.mod_FilenamesBuild(filePrefix + 'out_@version@',pversion );
 export ds_file        (string pversion) := tools.macf_FilesBase(file_versions(pversion) ,l_base           );
	
	/*----------------- Logical File Prefixes ------------------------------------------ */
	export FILE_IN	:= filePrefix + 'in';
	export FILE_OUT := filePrefix + 'out';
	
	/*-------------------- Update SuperFiles ----------------------------------------------------*/
	export updateSuperFiles(string inFile) := function
		action := SEQUENTIAL(
			FileServices.PromoteSuperFileList([FILE_BASE,
																				                  FILE_FATHER,
																				                  FILE_GRANDFATHER], inFile, true)
		);
		return action;
	end;


	export revertSuperFiles() := function
		return FileServices.PromoteSuperFileList([FILE_GRANDFATHER,
																				                        FILE_FATHER,
																				                        FILE_BASE]);
	end;
	
	export updateLocationid(string inFile) := function
		return FileServices.PromoteSuperFileList([FILE_LOCATION_ID_IN], inFile, FALSE);
	end;
	
	
	/*-------------------- Clear SuperFiles ----------------------------------------------------*/
	export clearSuperFiles := parallel(
		FileServices.ClearSuperFile(FILE_BASE);
		FileServices.ClearSuperFile(FILE_FATHER);
		FileServices.ClearSuperFile(FILE_GRANDFATHER)
	);

	export clearLocationid     := FileServices.ClearSuperFile(FILE_LOCATION_ID_IN);

	
end;