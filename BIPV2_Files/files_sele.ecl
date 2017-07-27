IMPORT BIPV2;

EXPORT files_sele := MODULE

	/*----------------- Filename Prefixes --------------------------------*/
	SHARED filePrefix := '~thor_data400::bipv2_sele::';
	
	
	/*----------------- SELE SuperFiles ----------------------------------*/
	EXPORT FILE_BUILDING	:= filePrefix + 'building';
	EXPORT DS_BUILDING   	:= DATASET(FILE_BUILDING, BIPV2.CommonBase.Layout, THOR, OPT);
	
	
	/*----------------- Update SuperFiles --------------------------------*/
	EXPORT updateBuilding(STRING inFile) := FUNCTION
		return FileServices.PromoteSuperFileList([FILE_BUILDING], inFile, FALSE);
	END;
	
	
	/*----------------- Clear SuperFiles ---------------------------------*/
	EXPORT clearBuilding := PARALLEL(
		FileServices.ClearSuperFile(FILE_BUILDING)
	);
	
END;