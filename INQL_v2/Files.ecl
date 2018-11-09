IMPORT tools;

EXPORT Files(boolean fcra = false, boolean pDaily = true) := MODULE

	/* Input File pVersions */
	foreign_fido_prod := '~foreign::10.194.93.1::';
	FIDO_extract_in := dataset(foreign_fido_prod + 'thor::red::extract::inquiry_tracking_extract', INQL_v2.layouts.FIDO_extract_in, flat);

	FIDO_extract_out := project(FIDO_extract_in,
												transform(INQL_v2.layouts.FIDO_extract_out
													,self.opt_out := trim((string)left.opt_out, left,right)
													,self.disable_observation := trim((string)left.disable_observation,left,right)
													,self := left, self := []
													));

	//filter product_id and sub_product_id
	FIDO_has_valid_product_id := FIDO_extract_out(mbs_product_id in [0,1, 2, 5,13] or (mbs_product_id = 7 and mbs_sub_product_id in [70001, 70004, 70005]));
	EXPORT File_FIDO := dedup(FIDO_has_valid_product_id, all);

	export Accurint_input
		:= dataset(INQL_v2.Superfile_List(fcra).accurint_bldg, INQL_v2.layouts.rAccurint_In, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);
	
	export Custom_input
		:= dataset(INQL_v2.Superfile_List(fcra).Custom_bldg, INQL_v2.layouts.rCustom_In, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);

	export Banko_input
		:= dataset(INQL_v2.Superfile_List(fcra).Banko_bldg, INQL_v2.layouts.rBanko_In, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);

	export Batch_input
		:= dataset(INQL_v2.Superfile_List(fcra).Batch_bldg, INQL_v2.layouts.rBatch_In, csv( separator('|'), terminator(['\n', '\r\n']), quote('"')), opt);
	
	export BatchR3_input
		:= dataset(INQL_v2.Superfile_List(fcra).BatchR3_bldg, INQL_v2.layouts.rBatchR3_In, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);

	export Bridger_input
		:= dataset(INQL_v2.Superfile_List(fcra).Bridger_bldg, INQL_v2.layouts.rBridger_In, csv( separator('\t'), terminator(['\n', '\r\n'])), opt);
		
	export Riskwise_input
		:= dataset(INQL_v2.Superfile_List(fcra).Riskwise_bldg, INQL_v2.layouts.rRiskwise_In, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);
	
	export IDM_input
		:= dataset(INQL_v2.Superfile_List(fcra).IDM_bldg, INQL_v2.layouts.rIDM_In, csv( separator(','), terminator(['\n', '\r\n'])), opt);
		
	export SBA_input
		:= dataset(INQL_v2.Superfile_List(fcra).SBA_bldg, INQL_v2.layouts.rSBA_In, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);
	
	export Accurint_input_hist
		:= dataset(INQL_v2.Superfile_List(fcra).accurint_hist, INQL_v2.layouts.rAccurint_In_Ext, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);
	
	export Custom_input_hist
		:= dataset(INQL_v2.Superfile_List(fcra).Custom_hist, INQL_v2.layouts.rCustom_In_Ext, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);

	export Banko_input_hist
		:= dataset(INQL_v2.Superfile_List(fcra).Banko_hist, INQL_v2.layouts.rBanko_In_Ext, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);

	export Batch_input_hist
		:= dataset(INQL_v2.Superfile_List(fcra).Batch_hist, INQL_v2.layouts.rBatch_In_Ext, csv( separator('|'), terminator(['\n', '\r\n']), quote('"')), opt);
	
	export BatchR3_input_hist
		:= dataset(INQL_v2.Superfile_List(fcra).BatchR3_hist, INQL_v2.layouts.rBatchR3_In_Ext, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);

	export Bridger_input_hist
		:= dataset(INQL_v2.Superfile_List(fcra).Bridger_hist, INQL_v2.layouts.rBridger_In_Ext, csv( separator('\t'), terminator(['\n', '\r\n'])), opt);
		
	export Riskwise_input_hist
		:= dataset(INQL_v2.Superfile_List(fcra).Riskwise_hist, INQL_v2.layouts.rRiskwise_In_Ext, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);
	
	export IDM_input_hist
		:= dataset(INQL_v2.Superfile_List(fcra).IDM_hist, INQL_v2.layouts.rIDM_In_Ext, csv( separator(','), terminator(['\n', '\r\n'])), opt);
		
	export SBA_input_hist
		:= dataset(INQL_v2.Superfile_List(fcra).SBA_hist, INQL_v2.layouts.rSBA_In_Ext, csv( separator('~~'), terminator(['\n', '\r\n'])), opt);
        
	export bINQL_In_Bldg 		:= dataset(INQL_v2.Filenames(,fcra,pDaily).INQL_Base_In_Bldg, INQL_v2.Layouts.Common_layout, thor);
	export bINQL_Daily_Hist := dataset(INQL_v2.Filenames(,fcra).INQL_Base_Daily_history, INQL_v2.Layouts.Common_layout, thor, opt);
  
 export LastDeployedDelta	:= dataset(INQL_v2.Filenames(,fcra,true).DeployedDelta, {string8 version, boolean Flushed}, flat);
	
	/* Base File pVersions */
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).INQL_Base, INQL_v2.Layouts.Common_ThorAdditions, INQL_base);
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).SBA_Base, INQL_v2.layouts.rSBA_Base, SBA_base, pOpt	:= 'false'); //this istemporary
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).Batch_PIIs_Base, INQL_v2.layouts.rBatch_PIIs_Base, Batch_PIIs_Base, pOpt	:= 'false');
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).MBS_Transaction_Base, INQL_v2.layouts.rTransaction_Base, MBS_Transaction_base, pOpt	:= 'false'); //this istemporary
	tools.mac_FilesBase(INQL_v2.Filenames(,fcra,pDaily).MBS_Deconfliction_Base, INQL_v2.layouts.rDeconfliction_Base, MBS_Deconfliction_base, pOpt	:= 'false'); //this istemporary
	 
	/* Keybuild File */
	//pVersioncontrol.macBuildFilepVersions(Filenames(pVersion).keybuild, layouts.keybuild, keybuild); 
	 
END;