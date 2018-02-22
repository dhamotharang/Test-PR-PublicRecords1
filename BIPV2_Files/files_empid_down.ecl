IMPORT BIPV2,std, Data_Services;
EXPORT files_empid_down(string p_Emp_Module = 'bipv2_empid_down') := MODULE
	/*----------------- SuperFiles --------------------------------- */
	SHARED filePrefix				:= '~thor_data400::' + p_Emp_Module + '::';
	EXPORT FILE_BUILDING		:= filePrefix + 'building';
	EXPORT FILE_BASE				:= filePrefix + 'base';
	EXPORT FILE_FATHER			:= filePrefix + 'father';
	EXPORT FILE_GRANDFATHER := filePrefix + 'grandfather';
	EXPORT DS_BUILDING   		:= DATASET(FILE_BUILDING,			BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_BASE   				:= DATASET(FILE_BASE,					BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_FATHER   			:= DATASET(FILE_FATHER,				BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_GRANDFATHER		:= DATASET(FILE_GRANDFATHER,	BIPV2.CommonBase.Layout, THOR, OPT);
	
	IMPORT ut, _Control;
	SHARED FILE_BASE_PROD		:= Data_Services.foreign_prod+FILE_BASE[2..];
	EXPORT DS_BASE_PROD			:= DATASET(FILE_BASE_PROD, BIPV2.CommonBase.Layout_Static, THOR, OPT) : PERSIST('~persist::prod::' + p_Emp_Module + '::base');
	
	
	/*----------------- SALT Files ------------------------------------------ */
	EXPORT FILE_INIT		       				:= filePrefix + 'init';
	EXPORT FILE_SALT_OP       				:= filePrefix + 'salt_iter';
	export FILE_SALT_POSSIBLE_MATCH  	:= filePrefix + 'possiblematches';
	EXPORT FILE_SALT_LINK_HIST				:= filePrefix + 'linkinghistory';
	EXPORT FILE_SALT_DELETE_HIST			:= filePrefix + 'deletehistory';
	EXPORT FILE_SALT_PATCHFILE				:= filePrefix + 'patchfile';
	
	
	/*-------------------- Update SuperFiles ----------------------------------------------------*/
	EXPORT updateSuperFiles(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_BUILDING,
                                                   FILE_BASE,
																									 FILE_FATHER,
																									 FILE_GRANDFATHER], , true)
							);
		return action;
	END;
	EXPORT updateBuilding(string inFile) := FUNCTION
		return FileServices.PromoteSuperFileList([FILE_BUILDING], inFile, true);  //can delete previous because are outputting changes file.
	END;
	EXPORT updateLinkHist(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_SALT_LINK_HIST], inFile)
							);
		return action;
	END;
	EXPORT updateDeleteHist(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_SALT_DELETE_HIST], inFile)
							);
		return action;
	END;
	
	EXPORT revertSuperFiles() := FUNCTION
		action := Sequential(
				FileServices.PromoteSuperFileList([FILE_GRANDFATHER,
																									 FILE_FATHER,
																									 FILE_BASE])
							);
		return action;
	END;
	
	/*-------------------- Clear SuperFiles ----------------------------------------------------*/
	EXPORT clearSuperFiles := parallel(
		FileServices.ClearSuperFile(FILE_BASE);
		FileServices.ClearSuperFile(FILE_FATHER);
		FileServices.ClearSuperFile(FILE_GRANDFATHER)
	);
	
	EXPORT clearBuilding := parallel(
     STD.File.CreateSuperFile(FILE_BUILDING		 ,,true)  //create all superfiles during init process if they don't already exist
    ,STD.File.CreateSuperFile(FILE_BASE				 ,,true)
    ,STD.File.CreateSuperFile(FILE_FATHER			 ,,true)
    ,STD.File.CreateSuperFile(FILE_GRANDFATHER ,,true)
		,STD.File.ClearSuperFile (FILE_BUILDING     ,true)
	);
	
END;
