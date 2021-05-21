IMPORT tools,std,data_services;

EXPORT Files(boolean fcra = false, boolean pDaily = true) := MODULE

	/* Input File pVersions */
	foreign_fido_prod := '~foreign::10.194.93.1::';
	EXPORT FIDO_extract_in := dataset(foreign_fido_prod + 'thor::red::extract::inquiry_tracking_extract', INQL_v2.layouts.FIDO_extract_in, flat);

	FIDO_extract_out := project(FIDO_extract_in,
												transform(INQL_v2.layouts.FIDO_extract_out
													,self.opt_out := trim((string)left.opt_out, left,right)
													,self.disable_observation := trim((string)left.disable_observation,left,right)
													,self := left, self := []
													));

	//filter product_id and sub_product_id
	FIDO_has_valid_product_id := FIDO_extract_out(mbs_product_id in [0,1, 2, 5,13] or (mbs_product_id = 7 and mbs_sub_product_id in [70001, 70004, 70005]));
	EXPORT File_FIDO := dedup(FIDO_has_valid_product_id, all);
  
  Export MBS := dataset(data_services.foreign_new_logs + 'thor100_21::out::inquiry_acclogs::file_mbs', INQL_v2.layouts.FIDO_new_MBS, thor);

	//------------------------------------------------------------------------------------------------------------------------------------------------------
    //Input Files. 
	//File type - filetype='building' will read from building superfile.
	//File type - filetype='built' will read from built superfile.
	//File type - filetype='' will read from input superfile.

    EXPORT InputFiles(fcra,pdaily,source,filetype='') := FUNCTIONMACRO

    Separate := IF(source='bridger','\t', 
	            IF(source='batch','|',
				IF(source='ida',',',
			    IF(source='idm',',','~~')))); 

    Format   := IF(source='batchr3', 'thor,opt',
	            IF(source='batch','csv(separator(Separate),HEADING(1),QUOTE(\'"\'),TERMINATOR([\'\\n\',\'\\r\\n\'])),opt',
			    IF(source='idm','csv(separator(Separate),HEADING(1),TERMINATOR([\'\\n\',\'\\r\\n\'])),opt',
				IF(source='ida','csv(separator(Separate),HEADING(1),QUOTE(\'"\'),TERMINATOR([\'\\n\',\'\\r\\n\'])),opt',
			    'csv(separator(Separate),TERMINATOR([\'\\n\',\'\\r\\n\'])),opt'))));

	File     := IF(filetype='building',dataset(INQL_v2.Filenames(,FCRA,pDaily,source).InputBuilding, #EXPAND('INQL_v2.layouts.r'+source+'_In'),#EXPAND(Format)),
	            IF(filetype='built',dataset(INQL_v2.Filenames(,FCRA,pDaily,source).InputBuilt, #EXPAND('INQL_v2.layouts.r'+source+'_In'),#EXPAND(Format)),
		        dataset(INQL_v2.Filenames(,FCRA,pDaily,source).Input, #EXPAND('INQL_v2.layouts.r'+source+'_In'),#EXPAND(Format))));

    return File;

    ENDMACRO;
 
    //------------------------------------------------------------------------------------------------------------------------------------------------------
 	//Batchr3 temp
	export BatchR3_input      := dataset(INQL_v2.Filenames(,fcra,pDaily,).BatchR3, INQL_v2.layouts.rBatchR3_In, thor, opt);
    export BatchR3_input_bldg := dataset(INQL_v2.Filenames(,fcra,pDaily,).BatchR3_bldg, INQL_v2.layouts.rBatchR3_In, thor, opt);
	export BatchR3_input_hist := dataset(INQL_v2.Filenames(,fcra,pDaily,).BatchR3_hist, INQL_v2.layouts.rBatchR3_In_Ext, csv(separator('~~'), terminator(['\n', '\r\n'])), opt);

    //------------------------------------------------------------------------------------------------------------------------------------------------------
    //Temp for FCRA Scrubs.Will need remove after FCRA Spray V2
	export Accurint_input
	:= dataset(INQL_v2.Filenames(,true,pDaily,).accurint, INQL_v2.layouts.rAccurint_In, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);
    export Batch_input
	:= dataset(INQL_v2.Filenames(,true,pDaily,).Batch, INQL_v2.layouts.rBatch_In, csv( separator('|'), terminator(['\n', '\r\n']), quote('"')), opt);
	export Riskwise_input
	:= dataset(INQL_v2.Filenames(,true,pDaily,).Riskwise, INQL_v2.layouts.rRiskwise_In, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);
	
	//-----------------------------------------------------------------------------------------------------------------------------------------------------
	export bINQL_In_Bldg 		:= dataset(INQL_v2.Filenames(,fcra,pDaily).INQL_Base_In_Bldg, INQL_v2.Layouts.Common_layout, thor);
	export bINQL_Daily_Hist     := dataset(INQL_v2.Filenames(,fcra).INQL_Base_Daily_history, INQL_v2.Layouts.Common_layout, thor, opt);
  
    export LastDeployedDelta	:= dataset(INQL_v2.Filenames(,fcra,true).DeployedDelta, {string8 version, boolean Flushed}, flat);
	
 	/* Base File pVersions */
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).INQL_Base, INQL_v2.Layouts.Common_ThorAdditions, INQL_base);
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).INQL_Base_History_Appended, INQL_v2.layouts.Common_ThorAdditions_non_fcra, INQL_Base_History_Appended); 
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).INQL_Base_History_NewIds, INQL_v2.layouts.base_history_newids, INQL_Base_History_NewIds); 
	
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).INQL_Base_DIDVille, INQL_v2.Layouts.Common_ThorAdditions, INQL_base_DIDVille);
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).INQL_Base_History_Appended_DIDVille, INQL_v2.layouts.Common_ThorAdditions_non_fcra, INQL_Base_History_Appended_DidVille); 
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).INQL_Base_History_NewIds_DIDVille, INQL_v2.layouts.base_history_newids, INQL_Base_History_NewIds_DidVille); 
	
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).SBA_Base, INQL_v2.layouts.rSBA_Base, SBA_base, pOpt	:= 'false'); //this istemporary
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).Batch_PIIs_Base, INQL_v2.layouts.rBatch_PIIs_Base, Batch_PIIs_Base, pOpt	:= 'false');
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).MBS_Transaction_Base, INQL_v2.layouts.rTransaction_Base, MBS_Transaction_base, pOpt	:= 'false'); //this istemporary
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).MBS_Deconfliction_Base, INQL_v2.layouts.rDeconfliction_Base, MBS_Deconfliction_base, pOpt	:= 'false'); //this istemporary
	 
	/* Keybuild File */
	//pVersioncontrol.macBuildFilepVersions(Filenames(pVersion).keybuild, layouts.keybuild, keybuild); 
	 
END;