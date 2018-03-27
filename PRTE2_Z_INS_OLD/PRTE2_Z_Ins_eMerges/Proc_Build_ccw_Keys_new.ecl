import	_control, ut, PRTE_CSV, RoxieKeyBuild, AutokeyB2, eMerges, PRTE2_Common, PRTE2_eMerges;

// THIS NEEDS TO MOVE BACK INTO THE PRTE MODULE WHEN WE ARE DONE TESTING

export proc_build_ccw_keys_new(string fileVersion, boolean isUpdateVersion=TRUE) := FUNCTION

	CTPrefix := '~PRTE::';
	finalMasterLayout := eMerges.layout_ccw_out; //did_out
	
	DSBoca	:= 	PRTE2_eMerges.Files.eMerges_Boca_SF_DS;					// CREATE A DEFINITION IN PRTE_CSV
	// DSAlpha	:= 	PRTE2_eMerges.Files.eMerges_Alpha_SF_DS;			  // CREATE A DEFINITION IN PRTE_CSV
	// F := DSBoca + DSAlpha;
	inFile := DSBoca;
	
	// ------------------ from eMerges.CCW_SearchFile ----------------------------------------------
	layoutWithRID := RECORD
	  unsigned6 rid;
		finalMasterLayout;
	END;
		
	ut.MAC_Sequence_Records_NewRec(inFile, layoutWithRID,rid,outf); 
	dbase := outf;
	

	KEY_PREFIX := PRTE2_eMerges.files.KEY_PREFIX;
	
	// ------------------ from eMerges.Key_ccw_rid -------------------------------------------------
	RID_KEY		:= INDEX(dbase,{rid, persistent_record_id},{dbase},KEY_PREFIX+'rid');
	
	// ------------------ from eMerges.Key_ccw_did -------------------------------------------------
	DID_KEY		:= INDEX(dbase(did_out!=''),{unsigned6 did_out6 := (unsigned6)dbase.did_out},{rid},KEY_PREFIX+'did');
	

	// ------------------ from eMerges.Proc_Build_Keys -----------------------------------------------
	SuperKeyName := CTPrefix+'key::ccw::';
	BaseKeyName  := SuperKeyName+fileVersion;
	
	
	kBuild1 := PRTE2_Common.IndexBuildTriplet(DID_KEY, SuperKeyName+'did', BaseKeyName+'::did', SuperKeyName+'@version@::did');
	kBuild2 := PRTE2_Common.IndexBuildTriplet(RID_KEY, SuperKeyName+'rid', BaseKeyName+'::rid', SuperKeyName+'@version@::rid');
	buildkeys := PARALLEL( kBuild1, kBuild2 );
	
/*

	//BUILD NON-FCRA KEYS
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(DID_KEY,SuperKeyName+'did',BaseKeyName+'::did',key1);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(RID_KEY,SuperKeyName+'rid',BaseKeyName+'::rid',key2);
	Keys := parallel(key1,key2);
	
	//MOVE NON-FCRA KEYS 
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::did',BaseKeyName+'::did',mv1,2);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::rid',BaseKeyName+'::rid',mv2,2);
	Move_keys := parallel(mv1, mv2);	
  
	//TO_QA
	RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName+'@version@::did','Q',toq1,2);
	RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName+'@version@::rid','Q',toq2,2);						
	To_qa    :=parallel(toq1, toq2);

	buildkeys := sequential(Keys,Move_keys,To_qa); 

*/


	// --------------------------------------------------------------------------------------------------

	// ------------------- from eMerges.Proc_CCW_AutokeyBuild --------------------------------------
	b := PRTE2_eMerges.file_ccw_searchautokey(dbase); 
	ak_keyname     			:= CTPrefix+ 'key::ccw::@version@::autokey::';
	ak_logicalname 			:= CTPrefix+ 'key::ccw::' + fileVersion + '::autokey::';
	ak_QAname      			:= CTPrefix+ 'key::ccw::qa::autokey::';
	ak_typeStr     			:= 'BC';
	
	ak_keyname_fcra 			:= CTPrefix+ 'key::ccw::fcra::@version@::autokey::';
	ak_logicalname_fcra 	:= CTPrefix+ 'key::ccw::fcra::' + fileVersion + '::autokey::';
	ak_QAname_fcra				:= CTPrefix+ 'key::ccw::fcra::qa::autokey::';	
	skip_set := ['P','B'];

	string srcType := 'ccw';

		AutokeyB2.MAC_Build (b,
							fname,mname,lname, 
							best_ssn,
							zero,
							zero,
							prim_name,prim_range,st,city_name,zip,sec_range,
							zero,
							zero,zero,zero,
							zero,zero,zero,
							zero,zero,zero,
							zero,
							did_out6,
							blank,
							zero,
							zero,
							blank,blank,blank,blank,blank,blank,
							zero,
							ak_keyname,
							ak_logicalname,
							outaction,false,
							skip_set,
							true,
							ak_typeStr,
							true,,,zero);

	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,, skip_set)
	// --------------------------------------------------------------------------------------------------
	buildAutoKeys := sequential(outaction,mymove);
	
	// ------------------- partial: PRTE.Proc_Build_Emerges_Keys ----------------------------------------
	copyFCRAKeys 						:= PRTE2_eMerges.fn_Copy_FCRA_Keys(fileVersion, inFile);
	// copyFCRAKeys 						:= PRTE2_Hunting_Fishing.fn_Copy_FCRA_Keys(fileVersion, inFile);
	// copyFCRAKeys 						:= OUTPUT('TEMP');
	buildAllKeySteps 				:= sequential( buildkeys, buildAutoKeys, copyFCRAKeys );		
	// --------------------------------------------------------------------------------------------------
	postProcessing 					:= PRTE2_eMerges.post_processing_actions(fileVersion);
	yesPostProcessingSteps 	:= sequential( buildAllKeySteps, postProcessing );
	noPostProcessingSteps 	:= sequential( buildAllKeySteps );
	// --------------------------------------------------------------------------------------------------
	
	allStepsToDo := IF (isUpdateVersion, yesPostProcessingSteps, noPostProcessingSteps);
	
	return	sequential( allStepsToDo );
 
end;
