import data_services,tools,BIPV2_ProxID;

EXPORT files_proxid(string pversion = '') := module

  export location := Data_Services.Data_Location.Prefix('BIPv2_ProxID');
		
	/*----------------- BIPv2 ProxID------------------------------------------ */
	// BaseFile
	export filenames  := BIPV2_ProxID.filenames(pversion);
  export files      := BIPV2_ProxID.Files(pversion);

	EXPORT DS_PROXID_BUILT   			:= files.base.built;

	EXPORT FILE_PROXID_BASE				:= filenames.base.qa;
	EXPORT DS_PROXID_BASE   			:= files.base.qa;
	
	// Father
	EXPORT FILE_PROXID_FATHER			:= filenames.base.father;
	EXPORT DS_PROXID_FATHER   		:= files.base.father;

	// GrandFather
	EXPORT FILE_PROXID_GRANDFATHER:= filenames.base.grandfather;
	EXPORT DS_PROXID_GRANDFATHER	:= files.base.grandfather;

	/*----------------- BIPv2 ProxID - SALT Files ------------------------------------------ */
	EXPORT FILE_PROX_SALT_OP       				:= filenames.salt_iter.root;
	export FILE_PROX_SALT_POSSIBLE_MATCH  := filenames.possiblematches.root;
	EXPORT FILE_PROX_SALT_LINK_HIST				:= filenames.linkinghistory.root;
	EXPORT FILE_PROX_SALT_DELETE_HIST			:= filenames.deletehistory.root;
	EXPORT FILE_PROX_STATS			     			:= filenames.stats.root;          
	
	// /*-------------------- updateProxIDSuperFiles ----------------------------------------------------*/
	// EXPORT updateProxIDSuperFiles(string inFile) := FUNCTION
		// action := Sequential(
								// FileServices.PromoteSuperFileList([FILE_PROXID_BASE,
																									 // FILE_PROXID_FATHER,
																									 // FILE_PROXID_GRANDFATHER], inFile)
							// );
		// return action;
	// END;

	// /*-------------------- updateProxIDLinkHist ----------------------------------------------------*/
	// EXPORT updateProxIDLinkHist(string inFile) := FUNCTION
		// action := Sequential(
								// FileServices.PromoteSuperFileList([FILE_PROX_SALT_LINK_HIST], inFile)
							// );
		// return action;
	// END;

	// /*-------------------- updateProxIDDeleteHist ----------------------------------------------------*/
	// EXPORT updateProxIDDeleteHist(string inFile) := FUNCTION
		// action := Sequential(
								// FileServices.PromoteSuperFileList([FILE_PROX_SALT_DELETE_HIST], inFile)
							// );
		// return action;
	// END;

end;