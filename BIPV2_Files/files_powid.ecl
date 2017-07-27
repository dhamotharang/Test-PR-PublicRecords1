IMPORT BIPV2;
EXPORT files_powid(string p_PowModule = 'bipv2_powid') := MODULE
	
	/*----------------- Extended layout for internal use only -----------------*/
	EXPORT Layout_POWID := RECORD
		BIPV2.CommonBase.Layout.rcid;
		BIPV2.CommonBase.Layout.source;
		BIPV2.CommonBase.Layout.powid;
		BIPV2.CommonBase.Layout.orgid;
		BIPV2.CommonBase.Layout.ultid;
		BIPV2.CommonBase.Layout.company_name;
		BIPV2.CommonBase.Layout.cnp_name;
		BIPV2.CommonBase.Layout.cnp_number;
		BIPV2.CommonBase.Layout.prim_range;
		BIPV2.CommonBase.Layout.prim_name;
		BIPV2.CommonBase.Layout.zip;
		BIPV2.CommonBase.Layout.zip4;
		BIPV2.CommonBase.Layout.sec_range;
		BIPV2.CommonBase.Layout.v_city_name;
		BIPV2.CommonBase.Layout.st;
		BIPV2.CommonBase.Layout.company_inc_state;
		BIPV2.CommonBase.Layout.company_charter_number;
		BIPV2.CommonBase.Layout.active_duns_number;
		BIPV2.CommonBase.Layout.hist_duns_number;
		BIPV2.CommonBase.Layout.active_domestic_corp_key;
		BIPV2.CommonBase.Layout.hist_domestic_corp_key;
		BIPV2.CommonBase.Layout.foreign_corp_key;
		BIPV2.CommonBase.Layout.unk_corp_key;
		BIPV2.CommonBase.Layout.company_fein;
		BIPV2.CommonBase.Layout.cnp_btype;
		BIPV2.CommonBase.Layout.company_name_type_derived;
		BIPV2.CommonBase.Layout.company_bdid;
		BIPV2.CommonBase.Layout.nodes_total;
		BIPV2.CommonBase.Layout.dt_first_seen;
		BIPV2.CommonBase.Layout.dt_last_seen;
		BIPV2.CommonBase.Layout.cnt_prox_per_lgid3;
    string20 RID_If_Big_Biz;
		UNSIGNED num_incs;
		UNSIGNED num_legal_names;
	END;
	
	
	/*----------------- POWID SuperFiles --------------------------------- */
	SHARED filePrefix				:= '~thor_data400::' + p_PowModule + '::';
	EXPORT FILE_BUILDING		:= filePrefix + 'building';
	EXPORT FILE_BASE				:= filePrefix + 'base';
	EXPORT FILE_FATHER			:= filePrefix + 'father';
	EXPORT FILE_GRANDFATHER := filePrefix + 'grandfather';
	EXPORT DS_BUILDING   		:= DATASET(FILE_BUILDING,			Layout_POWID, THOR, OPT);
	EXPORT DS_BASE   				:= DATASET(FILE_BASE,					BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_FATHER   			:= DATASET(FILE_FATHER,				BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_GRANDFATHER		:= DATASET(FILE_GRANDFATHER,	BIPV2.CommonBase.Layout, THOR, OPT);
	
	IMPORT ut, _Control;
	SHARED FILE_BASE_PROD		:= ut.foreign_prod+FILE_BASE[2..];
	EXPORT DS_BASE_PROD			:= DATASET(FILE_BASE_PROD, BIPV2.CommonBase.Layout_Static, THOR, OPT) : PERSIST('~persist::prod::bipv2_powid::base');
	
  import tools;
  export file_versions  (string pversion = '20150420::it120') := tools.mod_FilenamesBuild('~thor_data400::' + p_PowModule + '::salt_iter::@version@_post',pversion);
  export ds_file        (string pversion = '20150420::it120') := tools.macf_FilesBase(file_versions(pversion),BIPV2.CommonBase.Layout       );
  export ds_file_static (string pversion = '20150420::it120') := tools.macf_FilesBase(file_versions(pversion),BIPV2.CommonBase.Layout_Static);
	
	/*----------------- POWID - SALT Files ------------------------------------------ */
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
		return FileServices.PromoteSuperFileList([FILE_BUILDING], inFile, true);  //can delete previous because the changes file is being output.
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
	IMPORT STD;
	SHARED clearSuperNoFail(string fname,boolean pDelete = false) := IF(STD.File.SuperFileExists(fname), STD.File.ClearSuperFile(fname,pDelete));
	EXPORT clearSuperFiles := parallel(
		clearSuperNoFail(FILE_BASE);
		clearSuperNoFail(FILE_FATHER);
		clearSuperNoFail(FILE_GRANDFATHER)
	);
	
	EXPORT clearBuilding := parallel(
		clearSuperNoFail(FILE_BUILDING,true)
	);
	
	EXPORT clearLinkHist := parallel(
		clearSuperNoFail(FILE_SALT_LINK_HIST)
	);
	
	EXPORT clearDeleteHist := parallel(
		clearSuperNoFail(FILE_SALT_DELETE_HIST)
	);
	/*-------------------- Clear SuperFiles ----------------------------------------------------*/
	EXPORT clearPowIDSuperFiles := parallel(
		 STD.File.ClearSuperFile(FILE_BASE)
		,STD.File.ClearSuperFile(FILE_FATHER)
		,STD.File.ClearSuperFile(FILE_GRANDFATHER)
	);
	
	EXPORT clearPowIDBuilding := sequential(
     STD.File.CreateSuperFile(FILE_BUILDING		 ,,true)  //create all superfiles during init process if they don't already exist
    ,STD.File.CreateSuperFile(FILE_BASE				 ,,true)
    ,STD.File.CreateSuperFile(FILE_FATHER			 ,,true)
    ,STD.File.CreateSuperFile(FILE_GRANDFATHER ,,true)
		,STD.File.ClearSuperFile (FILE_BUILDING,true)  //delete last build's final iteration at beginning of new build
	);
	
END;
