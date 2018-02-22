IMPORT BIPV2, Data_Services;
EXPORT files_empid(string p_Emp_Module = 'bipv2_empid') := MODULE
	
	/*----------------- Extended layout for internal use only -----------------*/
	EXPORT Layout_EmpID := RECORD
		BIPV2.CommonBase.Layout.rcid;
		BIPV2.CommonBase.Layout.source;
		BIPV2.CommonBase.Layout.empid;
		BIPV2.CommonBase.Layout.seleid;
		BIPV2.CommonBase.Layout.orgid;
		BIPV2.CommonBase.Layout.ultid;
		BIPV2.CommonBase.Layout.contact_job_title_derived;
		BIPV2.CommonBase.Layout.prim_range;
		BIPV2.CommonBase.Layout.prim_name;
		BIPV2.CommonBase.Layout.zip;
		BIPV2.CommonBase.Layout.zip4;
		BIPV2.CommonBase.Layout.fname;
		BIPV2.CommonBase.Layout.lname;
		BIPV2.CommonBase.Layout.contact_phone;
		BIPV2.CommonBase.Layout.contact_did;
		BIPV2.CommonBase.Layout.contact_ssn;
		BIPV2.CommonBase.Layout.company_name;
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
		BIPV2.CommonBase.Layout.cnp_name;
		BIPV2.CommonBase.Layout.company_name_type_derived;
		BIPV2.CommonBase.Layout.company_bdid;
		BIPV2.CommonBase.Layout.nodes_total;
		BIPV2.CommonBase.Layout.dt_first_seen;
		BIPV2.CommonBase.Layout.dt_last_seen;
		BIPV2.CommonBase.Layout.isCorp;
		TYPEOF(BIPV2.CommonBase.Layout.company_name) cname_devanitize;
		STRING1 isCorpEnhanced;
	END;
	
	
	/*----------------- EmpID SuperFiles --------------------------------- */
	SHARED filePrefix				:= '~thor_data400::' + p_Emp_Module + '::';
	EXPORT FILE_BUILDING		:= filePrefix + 'building';
	EXPORT FILE_BASE				:= filePrefix + 'base';
	EXPORT FILE_FATHER			:= filePrefix + 'father';
	EXPORT FILE_GRANDFATHER := filePrefix + 'grandfather';
	EXPORT DS_BUILDING   		:= DATASET(FILE_BUILDING,			Layout_EmpID, THOR, OPT);
	EXPORT DS_BASE   				:= DATASET(FILE_BASE,					BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_FATHER   			:= DATASET(FILE_FATHER,				BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_GRANDFATHER		:= DATASET(FILE_GRANDFATHER,	BIPV2.CommonBase.Layout, THOR, OPT);
	
	IMPORT ut, _Control;
	SHARED FILE_BASE_PROD		:= Data_Services.foreign_prod+FILE_BASE[2..];
	EXPORT DS_BASE_PROD			:= DATASET(FILE_BASE_PROD, BIPV2.CommonBase.Layout_Static, THOR, OPT) : PERSIST('~persist::prod::' + p_Emp_Module + '::base');
	
	
	/*----------------- EmpID - SALT Files ------------------------------------------ */
	EXPORT FILE_INIT		       				:= filePrefix + 'init';
	EXPORT FILE_POST		       				:= filePrefix + 'post';
	EXPORT FILE_SALT_OP       				:= filePrefix + 'salt_iter';
	EXPORT FILE_SALT_POSSIBLE_MATCH  	:= filePrefix + 'possiblematches';
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
		return FileServices.PromoteSuperFileList([FILE_BUILDING], inFile, true);  //can do this because we are outputting the changes file
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
     STD.File.CreateSuperFile(FILE_BUILDING		 ,allowExist := true)  //create all superfiles during init process if they don't already exist
    ,STD.File.CreateSuperFile(FILE_BASE				 ,allowExist := true)
    ,STD.File.CreateSuperFile(FILE_FATHER			 ,allowExist := true)
    ,STD.File.CreateSuperFile(FILE_GRANDFATHER ,allowExist := true)
		,clearSuperNoFail        (FILE_BUILDING     ,true)  //delete previous build's last iteration upon the start of current build
	);
	
	EXPORT clearLinkHist := parallel(
		clearSuperNoFail(FILE_SALT_LINK_HIST)
	);
	
	EXPORT clearDeleteHist := parallel(
		clearSuperNoFail(FILE_SALT_DELETE_HIST)
	);
	
END;
