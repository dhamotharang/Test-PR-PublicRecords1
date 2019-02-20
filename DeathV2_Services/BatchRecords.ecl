IMPORT Autokey_batch, BatchServices, death_master, DeathV2_Services, Suppress, ut, STD;

EXPORT BatchRecords(DATASET(DeathV2_Services.Layouts.BatchIn) dBatchIn, 
										DeathV2_Services.IParam.BatchParams inMod) := 
FUNCTION

	dBatchInCommon := PROJECT(dBatchIn, Autokey_batch.Layouts.rec_inBatchMaster);			
	IsGLBOk		:= inMod.isValidGlb();
	deathRestrictions := DeathV2_Services.IParam.GetFromDataAccess(inMod);
	
	dAKDids 	:= DeathV2_Services.BatchIds(inMod).AutoKeyIds(dBatchInCommon);
	dDDDids 	:= DeathV2_Services.BatchIds(inMod).DeepDiveIds(dBatchInCommon, IsGLBOk, deathRestrictions);
	dSDidsAll	:= dAKDids + dDDDids;

	/* sort on -isdeepdive to give higher precedence to isdeepdive=true if a did is included with the search info */
	dAcctnosSDidsSortedDeduped := DEDUP(SORT(dSDidsAll, acctno, state_death_id, -isdeepdive), acctno, state_death_id);
	
	// only join the records that are valid for "days_back", if given
	dSDidsMainRecs := 
		JOIN(dAcctnosSDidsSortedDeduped, death_master.Key_Death_id_base_ssa,
			KEYED(left.state_death_id = RIGHT.state_death_id)
			AND ((ut.DaysApart(RIGHT.filedate, (STRING8) STD.Date.Today()) <= inMod.DaysBack) OR (inMod.DaysBack = 0))
			AND	NOT DeathV2_Services.Functions.Restricted(RIGHT.src, RIGHT.glb_flag, IsGLBOk, deathRestrictions) 
			AND (inMod.IncludeBlankDOD or RIGHT.dod8 <> ''),			
		TRANSFORM(Layouts.BatchOut,
			 //self.did := if((unsigned)right.did > 0, right.did, ''),
			 SELF := LEFT,
			 SELF := RIGHT,
			 SELF := []),
		INNER,
		LIMIT(DeathV2_Services.Constants.DEATH_SERVICE_JOIN_LIMIT, SKIP));

		// extra address info
		DeathV2_Services.Layouts.BatchIntermediateData xtAddIncoming(DeathV2_Services.Layouts.BatchOut L, DeathV2_Services.Layouts.BatchIn R) := TRANSFORM
			SELF.incoming_prim_range 	:= R.prim_range;
			SELF.incoming_predir			:= R.predir;
			SELF.incoming_prim_name		:= R.prim_name;
			SELF.incoming_addr_suffix	:= R.addr_suffix;
			SELF.incoming_postdir			:= R.postdir;
			SELF.incoming_unit_desig	:= R.unit_desig;
			SELF.incoming_sec_range		:= R.sec_range;
			SELF.incoming_p_city_name	:= R.p_city_name;
			SELF.incoming_st					:= R.st;
			SELF.incoming_z5					:= R.z5;
			SELF.incoming_zip4				:= R.zip4;
			SELF											:= L;
		END;
		
		dDeathExt := JOIN(dSDidsMainRecs, dBatchIn, 
									LEFT.acctno = RIGHT.acctno, 
									xtAddIncoming(LEFT, RIGHT), 
									LIMIT(DeathV2_Services.Constants.DEATH_SERVICE_JOIN_LIMIT, SKIP));							
									
		dSDidsMainRecsExtra := DeathV2_Services.GetExtraDeathInfo(dDeathExt);
		dSDids := if(inMod.AddSupplemental, dSDidsMainRecsExtra, dSDidsMainRecs);
		
		ds_mc := BatchServices.fn_add_xtra_dc_matchcodes(dSDids, dBatchInCommon, inMod.DidScoreThreshold, inMod.MatchCodeADLAppend, inMod.PartialNameMatchCodes);
		mc_include_str := DeathV2_Services.Functions.GetMatchCodeIncludeStr(inMod.MatchCodeIncludes, inMod.PartialNameMatchCodes);
		BatchServices.mac_filter_matchcodes(ds_mc, ds_mc_filtered, matchcode, mc_include_str, BatchServices.Matchcodes.delim, false);
		dOut := if(inMod.ExtraMatchCodes, ds_mc_filtered, ds_mc);		

		//apply some restrictions
	  Suppress.MAC_Suppress(dOut,pl1,inMod.application_type,Suppress.Constants.LinkTypes.DID,DID);
	  Suppress.MAC_Suppress(pl1,pl2,inMod.application_type,Suppress.Constants.LinkTypes.SSN,ssn);
    
	RETURN pl2;
	
END;