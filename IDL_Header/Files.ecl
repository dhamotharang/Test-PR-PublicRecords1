import insuranceheader, header, data_services;
EXPORT Files := MODULE
	
  export location := Data_Services.Data_Location.Prefix('IDL_Header');
  // export location := '';                                    // ********** TEST *********
	
	SHARED BOCA_HEADER_LAYOUT					:= header.layout_header_v2_dl;
	SHARED IDL_POLICY_HEADER_LAYOUT		:= idl_header.Layout_Header_Link;
	SHARED IDL_HEADER_LAYOUT					:= idl_header.Layout_Header; 
	
	shared cluster := 'thor_data400::';
	shared ProjectName := 'base::insuranceheader::';
	shared filePrefix := location + cluster + ProjectName;
	
	/*----------------- Insurance Header File with Policy Data ------------------------------------------ */
	// Insurance Header Base File with policy data
	EXPORT FILE_IDL_POLICY_HEADER_BASE				:= filePrefix + 'idl_policy_header';
	EXPORT DS_IDL_POLICY_HEADER_BASE   				:= DATASET(FILE_IDL_POLICY_HEADER_BASE, IDL_POLICY_HEADER_LAYOUT, thor);
	
	// Insurance Header Father File with policy data
	EXPORT FILE_IDL_POLICY_HEADER_FATHER			:= filePrefix + 'idl_policy_header_father';
	EXPORT DS_IDL_POLICY_HEADER_FATHER  			:= DATASET(FILE_IDL_POLICY_HEADER_FATHER, IDL_POLICY_HEADER_LAYOUT, thor);

	// Insurance Header GrandFather File with policy data
	EXPORT FILE_IDL_POLICY_HEADER_GRANDFATHER	:= filePrefix + 'idl_policy_header_grandfather';
	EXPORT DS_IDL_POLICY_HEADER_GRANDFATHER  	:= DATASET(FILE_IDL_POLICY_HEADER_GRANDFATHER, IDL_POLICY_HEADER_LAYOUT, thor);
	
  /*----------------- Insurance Header Did To Rid Data ------------------------------------------ */
  shared recLayout := RECORD
    idl_header.Layout_Header_Link;
    string25  userid;
    unsigned4 dt_added;
  END;	

	/*----------------- Insurance Header DID2Rid Processed Header Data ---------------------------- */
  //Did2Rid Processed Super File Definitions	
	EXPORT FILE_IDL_DID2RID_PROCESSED_BASE		:= filePrefix + 'DID2RID_processed';
	EXPORT DS_IDL_DID2RID_PROCESSED_BASE  		:= DATASET(FILE_IDL_DID2RID_PROCESSED_BASE, recLayout, thor);
	
	EXPORT FILE_IDL_DID2RID_PROCESSED_FATHER		:= filePrefix + 'DID2RID_processed_father';
	EXPORT DS_IDL_DID2RID_PROCESSED_FATHER  		:= DATASET(FILE_IDL_DID2RID_PROCESSED_FATHER, recLayout, thor);
	
	EXPORT FILE_IDL_DID2RID_PROCESSED_GRANDFATHER := filePrefix + 'DID2RID_processed_grandfather';
	EXPORT DS_IDL_DID2RID_PROCESSED_GRANDFATHER  	:= DATASET(FILE_IDL_DID2RID_PROCESSED_GRANDFATHER, recLayout, thor);
	
	//Did2Rid Processed Locical File Definition
	EXPORT FILE_IDL_DID2RID_processed := filePrefix + 'did2rid_processed::' + workunit;
	EXPORT DS_IDL_DID2RID_processed   := DATASET(FILE_IDL_DID2RID_processed, recLayout, thor);
	
  /*----------------- Insurance Header DID2Rid Request Data -------------------------------------------- */  
	//Did2Rid SuperFile Definition	
	EXPORT FILE_IDL_DID2RID           := filePrefix + 'did2rid::qa';
	EXPORT DS_IDL_DID2RID           	:= IF(nothor(FileServices.GetSuperFileSubCount(FILE_IDL_DID2RID)>0),
	                                        DATASET(FILE_IDL_DID2RID, recLayout, flat),
																			    DATASET([],recLayout));
	
	/*----------------- Insurance Header Suppressed Header Data ----------------------------------- */
  //Suppressed Super File Definitions	
	EXPORT FILE_SUPPRESSED_BASE		     := filePrefix + 'suppressed';
	EXPORT DS_SUPPRESSED_BASE  		     := DATASET(FILE_SUPPRESSED_BASE, IDL_POLICY_HEADER_LAYOUT, thor);
	
  EXPORT FILE_SUPPRESSED_FATHER	     := filePrefix + 'suppressed_father';	
	EXPORT DS_SUPPRESSED_FATHER  		   := DATASET(FILE_SUPPRESSED_FATHER, IDL_POLICY_HEADER_LAYOUT, thor);
	
	EXPORT FILE_SUPPRESSED_GRANDFATHER := filePrefix + 'suppressed_grandfather';
	EXPORT DS_SUPPRESSED_GRANDFATHER   := DATASET(FILE_SUPPRESSED_GRANDFATHER, IDL_POLICY_HEADER_LAYOUT, thor);
	
	//Suppressed Logical File Defintion
	EXPORT FILE_Suppressed     				 := filePrefix + 'suppressed' + workunit;
	
  /*----------------- Insurance Header Suppressed Addback Header Data --------------------------- */
  //Suppressed Addback Super File Defintions	
	EXPORT FILE_SUPPRESSED_ADDBACK_PROCESSED_BASE		:= filePrefix + 'SUPPRESSED_ADDBACK_qa';
	EXPORT DS_SUPPRESSED_ADDBACK_PROCESSED_BASE  		:= DATASET(FILE_SUPPRESSED_ADDBACK_PROCESSED_BASE, recLayout, thor);
	
	EXPORT FILE_SUPPRESSED_ADDBACK_PROCESSED_FATHER		:= filePrefix + 'SUPPRESSED_ADDBACK_father';
	EXPORT DS_SUPPRESSED_ADDBACK_PROCESSED_FATHER  		:= DATASET(FILE_SUPPRESSED_ADDBACK_PROCESSED_FATHER, recLayout, thor);
	
	EXPORT FILE_SUPPRESSED_ADDBACK_PROCESSED_GRANDFATHER := filePrefix + 'SUPPRESSED_ADDBACK_grandfather';
	EXPORT DS_SUPPRESSED_ADDBACK_PROCESSED_GRANDFATHER  	:= DATASET(FILE_SUPPRESSED_ADDBACK_PROCESSED_GRANDFATHER, recLayout, thor);
		
  //Suppressed Addback Locial File Defintion	
	EXPORT FILE_Suppressed_Addback_processed := filePrefix + 'suppressed::addback' + workunit;
	EXPORT DS_Suppressed_Addback_processed   := DATASET(FILE_Suppressed_Addback_processed, recLayout, thor);	
	
  /*----------------- Insurance Header Suppressed Addback Request Data --------------------------- */	
	//Suppress Addback Request Super File Definition
	EXPORT FILE_Suppressed_Addback := filePrefix + 'suppress::addback::qa';
	EXPORT DS_Suppressed_Addback   := IF(nothor(FileServices.GetSuperFileSubCount(FILE_Suppressed_Addback)>0),
	                                     DATASET(FILE_Suppressed_Addback, recLayout, flat),
																			 DATASET([],recLayout));
	
	/*----------------- Salt Iterations ------------------------------------------ */
	EXPORT FILE_SALT_ITER_OUTPUT				:= filePrefix + 'SALT_ITER_OUTPUT';
	EXPORT DS_SALT_ITER_OUTPUT   				:= DATASET(FILE_SALT_ITER_OUTPUT, IDL_POLICY_HEADER_LAYOUT, thor);
	
	EXPORT FILE_SALT_ITER_OUTPUT_FATHER	:= filePrefix + 'SALT_ITER_OUTPUT_FATHER';
	EXPORT DS_SALT_ITER_OUTPUT_FATHER 	:= DATASET(FILE_SALT_ITER_OUTPUT_FATHER, IDL_POLICY_HEADER_LAYOUT, thor);

  /*----------------- Preprocess Iterations ------------------------------------------ */
	EXPORT FILE_PREPROCESS_OUTPUT				:= filePrefix + 'PreProcess_OUTPUT';
	EXPORT DS_PREPROCESS_OUTPUT   				:= DATASET(FILE_PREPROCESS_OUTPUT, IDL_POLICY_HEADER_LAYOUT, thor);
	
	EXPORT FILE_PREPROCESS_OUTPUT_FATHER	:= filePrefix + 'PreProcess_OUTPUT_FATHER';
	EXPORT DS_PREPROCESS_OUTPUT_FATHER 	:= DATASET(FILE_PREPROCESS_OUTPUT_FATHER, IDL_POLICY_HEADER_LAYOUT, thor);

	/*----------------- Boca Personal Header File ------------------------------------------------------*/
	// Boca Header Base File
	EXPORT FILE_BOCA_HEADER_BASE					:= filePrefix + 'boca_header';
	EXPORT DS_BOCA_HEADER_BASE    				:= DATASET(FILE_BOCA_HEADER_BASE, BOCA_HEADER_LAYOUT, thor);
	
	// Boca Header Father File
	EXPORT FILE_BOCA_HEADER_FATHER				:= filePrefix + 'boca_header_father';
	EXPORT DS_BOCA_HEADER_FATHER   				:= DATASET(FILE_BOCA_HEADER_FATHER, BOCA_HEADER_LAYOUT, thor);

	// Boca Header GrandFather File
	EXPORT FILE_BOCA_HEADER_GRANDFATHER		:= filePrefix + 'boca_header_grandfather';
	EXPORT DS_BOCA_HEADER_GRANDFATHER     := DATASET(FILE_BOCA_HEADER_GRANDFATHER, BOCA_HEADER_LAYOUT, thor);
	
  /*----------------- Insurance Header Preprocess ------------------------------------------ */
	// Insurance Header Base File
	EXPORT FILE_IDL_Preprocess_BASE				:= filePrefix + 'preprocess_input';
	EXPORT DS_IDL_Preprocess_BASE   			:= DATASET(FILE_IDL_preprocess_BASE, IDL_POLICY_HEADER_LAYOUT, thor);  
	
	// Pre processed file ready for the suppression process
	EXPORT FILE_IDL_PREPROCESS     				:= filePrefix + 'idl_preprocess_';	
	
	/*----------------- Insurance Header Salt Iterations ------------------------------------------ */
	// Insurance Header Base File
	EXPORT FILE_IDL_SALT_ITER_BASE				:= filePrefix + 'salt_iter_input';
	EXPORT DS_IDL_SALT_ITER_BASE   				:= DATASET(FILE_IDL_SALT_ITER_BASE, IDL_POLICY_HEADER_LAYOUT, thor);
	
	// Suppressed file ready for salt process
	EXPORT FILE_IDL_SALT_ITER     				:= filePrefix + 'idl_salt_iter_';
	
	/*----------------- Insurance Header Linking History ------------------------------------------ */
	EXPORT FILE_IDL_SALT_LINK_BASE				:= filePrefix + 'idl::linkinghistory';
	export FILE_IDL_SALT_POSSIBLE_MATCH   := filePrefix + 'idl_salt_iter_possiblematches';
	
	/*----------------- Insurance Header Delete History ------------------------------------------ */
	EXPORT FILE_IDL_SALT_DELETE_BASE			:= filePrefix + 'idl::deletehistory';

	/*----------------- Insurance Header stats ------------------------------------------ */
	EXPORT FILE_IDL_STATS			     				:= filePrefix + 'stats_';

  /*----------------- Address per DID Salt Iterations ------------------------------------------ */
	EXPORT FILE_ADDRLINK_SALT_ITER     		:= filePrefix + 'ADDRLINK_SALT_ITER_';
	
	EXPORT FILE_ADDRLINK_SALT_ITER_OUTPUT_BASE := filePrefix + 'ADDRLINK_SALT_ITER_OUTPUT';
	EXPORT DS_ADDRLINK_SALT_ITER_OUTPUT_BASE   := DATASET(FILE_ADDRLINK_SALT_ITER_OUTPUT_BASE, IDL_Header.Layout_Header_address, thor);
	
	EXPORT FILE_ADDRLINK_SALT_ITER_OUTPUT_FATHER := filePrefix + 'ADDRLINK_SALT_ITER_OUTPUT_FATHER';
	EXPORT DS_ADDRLINK_SALT_ITER_OUTPUT_FATHER 	 := DATASET(FILE_ADDRLINK_SALT_ITER_OUTPUT_FATHER, IDL_Header.Layout_Header_address, thor);

END;