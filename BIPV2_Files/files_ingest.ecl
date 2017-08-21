IMPORT ut, BIPV2_Files, BIPV2;

EXPORT files_ingest := MODULE
	/*---------- Default as_linking files (i.e. ingest inputs) ------------ */
	EXPORT ds_as_linking	:= BIPV2.File_Business_Sources;
	
	
	/*----------------- Filename Prefixes --------------------------------- */
  // export location := Data_Services.Data_Location.Prefix('BIPv2_Ingest');
  EXPORT location		:= '';
	SHARED filePrefix	:= '~thor_data400::bipv2_ingest::';
	
	
	/*----------------- SuperFiles --------------------------------- */
	SHARED l_base := BIPV2.CommonBase.Layout;
	SHARED l_err_rec := RECORD
		l_base.rcid;
		l_base.source;
		l_base.source_record_id;
		l_base.vl_id;
		STRING6		remedy; // BLANK/CLEAN/REJECT
		STRING50	reason;
	END;
	EXPORT FILE_BUILDING		  := filePrefix + 'building';
	EXPORT FILE_BASE				  := filePrefix + 'base';
	EXPORT FILE_FATHER			  := filePrefix + 'father';
	EXPORT FILE_GRANDFATHER	  := filePrefix + 'grandfather';
	EXPORT FILE_ERR     		  := filePrefix + 'err';
	EXPORT FILE_DROPPED_RCIDS := filePrefix + 'dropped_rcids';
	EXPORT DS_BUILDING			  := DATASET(location + FILE_BUILDING, l_base, THOR, OPT);
	EXPORT DS_BASE   				  := DATASET(location + FILE_BASE, l_base, THOR, OPT);
	EXPORT DS_FATHER   			  := DATASET(location + FILE_FATHER, l_base, THOR, OPT);
	EXPORT DS_GRANDFATHER		  := DATASET(location + FILE_GRANDFATHER, l_base, THOR, OPT);
	EXPORT DS_ERR	   				  := DATASET(location + FILE_ERR, l_err_rec, THOR, OPT);
	
	
  import tools;
  export file_versions  (string pversion) := tools.mod_FilenamesBuild('~thor_data400::bipv2_ingest::out_@version@',pversion );
  export ds_file        (string pversion) := tools.macf_FilesBase(file_versions(pversion) ,l_base                           );
  export ds_file_static (string pversion) := tools.macf_FilesBase(file_versions(pversion) ,BIPV2.CommonBase.Layout_Static   );

	/*----------------- Logical File Prefixes ------------------------------------------ */
	EXPORT FILE_IN	:= filePrefix + 'in';
	EXPORT FILE_OUT := filePrefix + 'out';
	EXPORT FILE_TYP := filePrefix + 'typ';
	
	
	/*-------------------- Update SuperFiles ----------------------------------------------------*/
	EXPORT updateSuperFiles(string inFile) := FUNCTION
		action := SEQUENTIAL(
			FileServices.PromoteSuperFileList([FILE_BASE,
																				 FILE_FATHER,
																				 FILE_GRANDFATHER], inFile, true)
		);
		RETURN action;
	END;
	
	EXPORT updateBuilding(string inFile) := FUNCTION
		RETURN FileServices.PromoteSuperFileList([FILE_BUILDING], inFile, FALSE);
	END;

	EXPORT updateErrorFile(string inFile) := FUNCTION
		RETURN FileServices.PromoteSuperFileList([FILE_ERR], inFile, FALSE);
	END;

	EXPORT revertSuperFiles() := FUNCTION
		action := SEQUENTIAL(
			FileServices.PromoteSuperFileList([FILE_GRANDFATHER,
																				 FILE_FATHER,
																				 FILE_BASE])
		);
		RETURN action;
	END;
	
	
	/*-------------------- Clear SuperFiles ----------------------------------------------------*/
	EXPORT clearSuperFiles := parallel(
		FileServices.ClearSuperFile(FILE_BASE);
		FileServices.ClearSuperFile(FILE_FATHER);
		FileServices.ClearSuperFile(FILE_GRANDFATHER)
	);

	EXPORT clearBuilding := FileServices.ClearSuperFile(FILE_BUILDING);
	
	EXPORT clearErrorFiles := FileServices.ClearSuperFile(FILE_ERR);

END;