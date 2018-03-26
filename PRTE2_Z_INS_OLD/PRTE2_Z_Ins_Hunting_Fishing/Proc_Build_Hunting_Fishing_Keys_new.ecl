import	ut, PRTE_CSV, RoxieKeyBuild, AutokeyB2, eMerges, PRTE2_Hunting_Fishing,PRTE2_Common;

// THIS NEEDS TO MOVE BACK INTO THE PRTE MODULE WHEN WE ARE DONE TESTING

export Proc_Build_Hunting_Fishing_Keys_new(string fileVersion, boolean isUpdateVersion=TRUE) := FUNCTION

	CTPrefix := '~PRTE::';
	finalMasterLayout := eMerges.layout_hunters_out;
	
	DSBoca	:= 	PRTE2_Hunting_Fishing.Files.HuntFish_Boca_SF_DS;					// CREATE A DEFINITION IN PRTE_CSV
	// DSAlpha	:= 	PRTE2_Hunting_Fishing.Files.HuntFish_Alpha_SF_DS;			// CREATE A DEFINITION IN PRTE_CSV
	// inFile := DSBoca + DSAlpha;
	inFile := DSBoca;
	
	// ------------------ from eMerges.HuntFish_SearchFile ----------------------------------------------
	layoutWithRID := RECORD
	  unsigned6 rid;
		finalMasterLayout;
	END;
	ut.MAC_Sequence_Records_NewRec(inFile, layoutWithRID,rid,outf);
	dbase := outf;
	KEY_PREFIX := PRTE2_Hunting_Fishing.files.KEY_PREFIX;
	
	// ------------------ from eMerges.Key_HuntFish_Rid -------------------------------------------------
	RID_KEY		:= INDEX(dbase,{rid, persistent_record_id},{dbase},KEY_PREFIX+'rid');
	// ------------------ from eMerges.Key_HuntFish_Did -------------------------------------------------
	DID_KEY		:= INDEX(dbase(did_out!=''),{unsigned6 did := (unsigned6)dbase.did_out},{rid},KEY_PREFIX+'did');
	
	// ------------------ from eMerges.Proc_Build_HF_Keys -----------------------------------------------
	SuperKeyName := CTPrefix+'key::hunting_fishing::';
	BaseKeyName  := SuperKeyName+fileVersion;

/*
// IF I DID IT RIGHT, THE TWO LINES BELOW THIS SHOULD REPLACE ALL THESE LINES.
   	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(DID_KEY,SuperKeyName+'did',BaseKeyName+'::did',key1);
   	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(RID_KEY,SuperKeyName+'rid',BaseKeyName+'::rid',key2);
   	Keys := parallel(key1,key2);
   												 
   	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::did',BaseKeyName+'::did',mv1,2);
   	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::rid',BaseKeyName+'::rid',mv2,2);
   	Move_keys := parallel(mv1, mv2);	
   
   	RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName+'@version@::did','Q',toq1,2);
   	RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName+'@version@::rid','Q',toq2,2);						
   	To_qa    :=parallel(toq1, toq2);
		buildkeys 			:= sequential(Keys,Move_keys,To_qa);
*/
	kBuild1 := PRTE2_Common.IndexBuildTriplet(DID_KEY, SuperKeyName+'did', BaseKeyName+'::did', SuperKeyName+'@version@::did');
	kBuild2 := PRTE2_Common.IndexBuildTriplet(RID_KEY, SuperKeyName+'rid', BaseKeyName+'::rid', SuperKeyName+'@version@::rid');
	buildkeys := PARALLEL( kBuild1, kBuild2 );
	// --------------------------------------------------------------------------------------------------

	// ------------------- from eMerges.Proc_HuntFish_AutokeyBuild --------------------------------------
	b := PRTE2_Hunting_Fishing.file_huntfish_SearchAutokey(dbase);

	ak_keyname     			:= CTPrefix+ 'key::hunting_fishing::@version@::autokey::';
	ak_logicalname 			:= CTPrefix+ 'key::hunting_fishing::' + fileVersion + '::autokey::';
	ak_QAname      			:= CTPrefix+ 'key::hunting_fishing::qa::autokey::';
	ak_typeStr     			:= 'BC';
	
	ak_keyname_fcra 			:= CTPrefix+ 'key::hunting_fishing::fcra::@version@::autokey::';
	ak_logicalname_fcra 	:= CTPrefix+ 'key::hunting_fishing::fcra::' + fileVersion + '::autokey::';
	ak_QAname_fcra				:= CTPrefix+ 'key::hunting_fishing::fcra::qa::autokey::';	
	skip_set := ['P','B'];

	string srcType := 'hunting_fishing';

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
							did,
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
	buildAutoKeys 		:= sequential( outaction, mymove );
	// ------------------- partial: PRTE.Proc_Build_Emerges_Keys ----------------------------------------
	copyFCRAKeys 						:= PRTE2_Hunting_Fishing.fn_Copy_FCRA_Keys(fileVersion, inFile);
	// copyFCRAKeys 						:= OUTPUT('TEMP');
	buildAllKeySteps 				:= sequential( buildkeys, buildAutoKeys, copyFCRAKeys );	
	// --------------------------------------------------------------------------------------------------
	postProcessing 					:= PRTE2_Hunting_Fishing.post_processing_actions(fileVersion);
	yesPostProcessingSteps 	:= sequential( buildAllKeySteps, postProcessing );
	noPostProcessingSteps 	:= sequential( buildAllKeySteps );
	// --------------------------------------------------------------------------------------------------
	
	allStepsToDo := IF (isUpdateVersion, yesPostProcessingSteps, noPostProcessingSteps);
	
	return	sequential( allStepsToDo );

end;
