IMPORT BIPV2,std, Data_Services;
EXPORT files_dotid(string p_DotModule = 'bipv2_dotid') := module
	/*----------------- Reduced layout for internal use only -----------------*/
	EXPORT l_DOTID := RECORD
		BIPV2.CommonBase.Layout.rcid;
		BIPV2.CommonBase.Layout.source;
		BIPV2.CommonBase.Layout.dotid;
		BIPV2.CommonBase.Layout.proxid;
		BIPV2.CommonBase.Layout.lgid3;
		BIPV2.CommonBase.Layout.seleid;
		BIPV2.CommonBase.Layout.orgid;
		BIPV2.CommonBase.Layout.ultid;
		BIPV2.CommonBase.Layout.company_name;
		BIPV2.CommonBase.Layout.cnp_name;
		BIPV2.CommonBase.Layout.corp_legal_name;
		BIPV2.CommonBase.Layout.cnp_number;
		BIPV2.CommonBase.Layout.cnp_btype;
		BIPV2.CommonBase.Layout.cnp_lowv;
		BIPV2.CommonBase.Layout.cnp_translated;
		BIPV2.CommonBase.Layout.cnp_classid;
		BIPV2.CommonBase.Layout.company_fein;
		BIPV2.CommonBase.Layout.company_charter_number;
		BIPV2.CommonBase.Layout.company_inc_state;
		BIPV2.CommonBase.Layout.active_duns_number;
		BIPV2.CommonBase.Layout.active_enterprise_number;
		BIPV2.CommonBase.Layout.foreign_corp_key;
		BIPV2.CommonBase.Layout.active_domestic_corp_key;
		BIPV2.CommonBase.Layout.company_bdid;
		BIPV2.CommonBase.Layout.company_phone;
		BIPV2.CommonBase.Layout.prim_range;
		BIPV2.CommonBase.Layout.prim_name;
		BIPV2.CommonBase.Layout.sec_range;
		BIPV2.CommonBase.Layout.st;
		BIPV2.CommonBase.Layout.v_city_name;
		BIPV2.CommonBase.Layout.zip;
		BIPV2.CommonBase.Layout.isContact;
		BIPV2.CommonBase.Layout.title;
		BIPV2.CommonBase.Layout.fname;
		BIPV2.CommonBase.Layout.mname;
		BIPV2.CommonBase.Layout.lname;
		BIPV2.CommonBase.Layout.name_suffix;
		BIPV2.CommonBase.Layout.contact_ssn;
		BIPV2.CommonBase.Layout.contact_phone;
		BIPV2.CommonBase.Layout.contact_email;
		BIPV2.CommonBase.Layout.contact_job_title_raw;
		BIPV2.CommonBase.Layout.company_department;
		BIPV2.CommonBase.Layout.dt_first_seen;
		BIPV2.CommonBase.Layout.dt_last_seen;
	END;
	
	
	/*----------------- DotID and Ingest SuperFiles --------------------------------- */
	SHARED filePrefix				:= '~thor_data400::' + p_DotModule + '::';
	EXPORT FILE_BUILDING		:= filePrefix + 'building';
	EXPORT FILE_BASE				:= filePrefix + 'base';
	EXPORT FILE_FATHER			:= filePrefix + 'father';
	EXPORT FILE_GRANDFATHER := filePrefix + 'grandfather';
	EXPORT DS_BUILDING   		:= DATASET(FILE_BUILDING,			l_DOTID, THOR, OPT);
	EXPORT DS_BASE   				:= DATASET(FILE_BASE,					BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_STATIC 				:= DATASET(FILE_BASE,					BIPV2.CommonBase.Layout_Static, THOR, OPT);
	EXPORT DS_FATHER   			:= DATASET(FILE_FATHER,				BIPV2.CommonBase.Layout, THOR, OPT);
	EXPORT DS_GRANDFATHER		:= DATASET(FILE_GRANDFATHER,	BIPV2.CommonBase.Layout, THOR, OPT);
	
	IMPORT ut, _Control;
	SHARED FILE_BASE_PROD		:= Data_Services.foreign_prod+FILE_BASE[2..];
	EXPORT DS_BASE_PROD			:= DATASET(FILE_BASE_PROD, BIPV2.CommonBase.Layout_Static, THOR, OPT) : PERSIST('~persist::prod::bipv2_dotid::base');
	
  import tools;
  export file_versions  (string pversion = '20150420::it120') := tools.mod_FilenamesBuild('~thor_data400::' + p_DotModule + '::salt_iter::@version@_post',pversion);
  export ds_file        (string pversion = '20150420::it120') := tools.macf_FilesBase(file_versions(pversion),BIPV2.CommonBase.Layout       );
  export ds_file_static (string pversion = '20150420::it120') := tools.macf_FilesBase(file_versions(pversion),BIPV2.CommonBase.Layout_Static);
  
	/*----------------- BIPv2 DotID - SALT Files ------------------------------------------ */
	EXPORT FILE_INIT		       						:= filePrefix + 'init';
	EXPORT FILE_DOT_SALT_OP       				:= filePrefix + 'salt_iter';
	export FILE_DOT_SALT_POSSIBLE_MATCH  	:= filePrefix + 'possiblematches';
	EXPORT FILE_DOT_SALT_LINK_HIST				:= filePrefix + 'linkinghistory';
	EXPORT FILE_DOT_SALT_DELETE_HIST			:= filePrefix + 'deletehistory';
	EXPORT FILE_DOT_SALT_PATCHFILE				:= filePrefix + 'patchfile';
	
	
	/*-------------------- Update SuperFiles ----------------------------------------------------*/
	EXPORT updateDotIDSuperFiles(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_BASE,
																									 FILE_FATHER,
																									 FILE_GRANDFATHER], inFile, true)//start cleaning up previous builds
							);
		return action;
	END;
	EXPORT updateDotIDBuilding(string inFile) := FUNCTION
		return FileServices.PromoteSuperFileList([FILE_BUILDING], inFile, true);  //since we are outputting changes file, we can clean up as we go.
	END;
	EXPORT updateDotIDLinkHist(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_DOT_SALT_LINK_HIST], inFile)
							);
		return action;
	END;
	EXPORT updateDotIDDeleteHist(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_DOT_SALT_DELETE_HIST], inFile)
							);
		return action;
	END;
	
	EXPORT revertDotIDSuperFiles() := FUNCTION
		action := Sequential(
				FileServices.PromoteSuperFileList([FILE_GRANDFATHER,
																									 FILE_FATHER,
																									 FILE_BASE])
							);
		return action;
	END;
	
	/*-------------------- Clear SuperFiles ----------------------------------------------------*/
	EXPORT clearDotIDSuperFiles := parallel(
		 STD.File.ClearSuperFile(FILE_BASE)
		,STD.File.ClearSuperFile(FILE_FATHER)
		,STD.File.ClearSuperFile(FILE_GRANDFATHER)
	);
	
	EXPORT clearDotIDBuilding := sequential(
     STD.File.CreateSuperFile(FILE_BUILDING		 ,,true)  //create all superfiles during init process if they don't already exist
    ,STD.File.CreateSuperFile(FILE_BASE				 ,,true)
    ,STD.File.CreateSuperFile(FILE_FATHER			 ,,true)
    ,STD.File.CreateSuperFile(FILE_GRANDFATHER ,,true)
		,STD.File.ClearSuperFile (FILE_BUILDING,true)  //delete last build's final iteration at beginning of new build
	);
	
end;
