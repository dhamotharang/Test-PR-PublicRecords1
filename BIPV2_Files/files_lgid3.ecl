IMPORT BIPV2, Data_Services;
EXPORT files_lgid3 := MODULE
	/*----------------- Reduced layout for internal use only -----------------*/
	EXPORT Layout_LGID3 := RECORD
		BIPV2.CommonBase.Layout.rcid;
		BIPV2.CommonBase.Layout.source;
		BIPV2.CommonBase.Layout.dotid;
		BIPV2.CommonBase.Layout.proxid;
		BIPV2.CommonBase.Layout.lgid3;
		BIPV2.CommonBase.Layout.seleid;
		BIPV2.CommonBase.Layout.orgid;
		BIPV2.CommonBase.Layout.ultid;
		BIPV2.CommonBase.Layout.nodes_total;
		BIPV2.CommonBase.Layout.company_name;
		BIPV2.CommonBase.Layout.cnp_number;
		BIPV2.CommonBase.Layout.active_duns_number;
		BIPV2.CommonBase.Layout.duns_number;
		BIPV2.CommonBase.Layout.company_fein;
		BIPV2.CommonBase.Layout.company_inc_state;
		BIPV2.CommonBase.Layout.company_charter_number;
		BIPV2.CommonBase.Layout.cnp_btype;
		BIPV2.CommonBase.Layout.company_name_type_derived;
		BIPV2.CommonBase.Layout.hist_duns_number;
		BIPV2.CommonBase.Layout.active_domestic_corp_key;
		BIPV2.CommonBase.Layout.hist_domestic_corp_key;
		BIPV2.CommonBase.Layout.foreign_corp_key;
		BIPV2.CommonBase.Layout.unk_corp_key;
		BIPV2.CommonBase.Layout.cnp_name;
		BIPV2.CommonBase.Layout.cnp_hasNumber;
		BIPV2.CommonBase.Layout.cnp_lowv;
		BIPV2.CommonBase.Layout.cnp_translated;
		BIPV2.CommonBase.Layout.cnp_classid;
		BIPV2.CommonBase.Layout.prim_range;
		BIPV2.CommonBase.Layout.prim_name;
		BIPV2.CommonBase.Layout.sec_range;
		BIPV2.CommonBase.Layout.v_city_name;
		BIPV2.CommonBase.Layout.st;
		BIPV2.CommonBase.Layout.zip;
		BIPV2.CommonBase.Layout.dt_first_seen;
		BIPV2.CommonBase.Layout.dt_last_seen;
		typeof(BIPV2.CommonBase.Layout.vl_id) sbfe_id;
		typeof(BIPV2.CommonBase.Layout.vl_id) cortera_id;
		
 		BIPV2.CommonBase.Layout.has_lgid;					//For the postprocess update
   		BIPV2.CommonBase.Layout.is_sele_level;  	//For the postprocess update
   		BIPV2.CommonBase.Layout.is_org_level;			//For the postprocess update
   		BIPV2.CommonBase.Layout.is_ult_level;			//For the postprocess update
   		BIPV2.CommonBase.Layout.parent_proxid;		//For the postprocess update
   		BIPV2.CommonBase.Layout.sele_proxid;			//For the postprocess update
   		BIPV2.CommonBase.Layout.org_proxid;				//For the postprocess update
   		BIPV2.CommonBase.Layout.ultimate_proxid;	//For the postprocess update
   		BIPV2.CommonBase.Layout.levels_from_top;	//For the postprocess update
   	
   		string10 nodes_below_st;               //BIPV2.CommonBase.Layout.nodes_below;   //new
   		string20 Lgid3IfHrchy := '';						//new

			typeof(BIPV2.CommonBase.Layout.seleid) OriginalSeleId;
			typeof(BIPV2.CommonBase.Layout.orgid) OriginalOrgId;
			
	END;
	
	
	/*----------------- LGID3 SuperFiles --------------------------------- */
	SHARED filePrefix := '~thor_data400::bipv2_lgid3::';
	EXPORT FILE_BUILDING		:= filePrefix + 'building';
	EXPORT FILE_BASE				:= filePrefix + 'base';
	EXPORT FILE_FATHER			:= filePrefix + 'father';
	EXPORT FILE_GRANDFATHER := filePrefix + 'grandfather';
	EXPORT DS_BUILDING   		:= DATASET(FILE_BUILDING, Layout_LGID3, THOR, OPT);
	EXPORT DS_BASE   				:= DATASET(FILE_BASE, BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_FATHER   			:= DATASET(FILE_FATHER, BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_GRANDFATHER		:= DATASET(FILE_GRANDFATHER, BIPV2.CommonBase.Layout, THOR, OPT);
	
	IMPORT ut;
	SHARED FILE_BASE_PROD		:= Data_Services.foreign_prod+FILE_BASE[2..];
	EXPORT DS_BASE_PROD			:= DATASET(FILE_BASE_PROD, BIPV2.CommonBase.Layout_Static, THOR, OPT);
	
	SHARED FILE_BUILDING_PROD		:= Data_Services.foreign_prod+FILE_BUILDING[2..];
	EXPORT DS_BUILDING_PROD			:= DATASET(FILE_BUILDING_PROD, BIPV2.CommonBase.Layout_Static, THOR, OPT);
	
	/*----------------- LGID3 - SALT Files ------------------------------------------ */
	EXPORT FILE_INIT		       				:= filePrefix + 'init';
	EXPORT FILE_SALT_OP       				:= filePrefix + 'salt_iter';
	export FILE_SALT_POSSIBLE_MATCH  	:= filePrefix + 'possiblematches';
	EXPORT FILE_SALT_LINK_HIST				:= filePrefix + 'linkinghistory';
	EXPORT FILE_SALT_DELETE_HIST			:= filePrefix + 'deletehistory';
	EXPORT FILE_SALT_PATCHFILE				:= filePrefix + 'patchfile';
	
	
	/*-------------------- Update SuperFiles ----------------------------------------------------*/
	EXPORT updateSuperFiles(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_BASE,
																									 FILE_FATHER,
																									 FILE_GRANDFATHER], inFile, true)
							);
		return action;
	END;
	EXPORT updateBuilding(string inFile) := FUNCTION
		return FileServices.PromoteSuperFileList([FILE_BUILDING], inFile, true);  //hack so it will delete the previous iteration, we can alway go back with the changes file.
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
		FileServices.ClearSuperFile(FILE_BUILDING,true)
	);
	
end;
