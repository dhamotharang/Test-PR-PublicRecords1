IMPORT AutokeyB2, Autokey_batch, BatchServices, DeathV2_Services, doxie, dx_death_master;

EXPORT BatchIds(DeathV2_Services.IParam.BatchParams inMod) := MODULE

	EXPORT AutoKeyIds(dataset(Autokey_batch.Layouts.rec_inBatchMaster) dBatchIn) := 
	FUNCTION

			// Configure the autokey search.		
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := DeathV2_Services.Constants.Autokey.WORK_HARD;
			export useAllLookups   := TRUE; 
			export PenaltThreshold := 20;
			export skip_set        := DeathV2_Services.Constants.Autokey.SKIP_SET;
		END;
		
		// Get autokeys based on batch input.
		dFids := Autokey_batch.get_fids(dBatchIn, DeathV2_Services.Constants.Autokey.KEY_NAME, ak_config_data);

		// Get state death ids via autokey payload (outPL).
		AutokeyB2.mac_get_payload(UNGROUP(dFids), DeathV2_Services.Constants.Autokey.KEY_NAME, DeathV2_Services.Constants.Autokey.KEY_DATASET, outPL,did,zero)
			
		// Slim both datasets of sdids to just what's needed for matching (i.e. acctnos, sdids) 
		// Then sort and dedup.		
		dAKDids := PROJECT(outPL, DeathV2_Services.Layouts.search_ID_with_matchcode);			
		
		return dAKDids;
	
  END;	

	EXPORT DeepDiveIds(dataset(Autokey_batch.Layouts.rec_inBatchMaster) dBatchIn, DeathV2_Services.IParam.DeathRestrictions death_params) := function
		// Grab adl ids for candidates in ds_batch_in. 
		dDidsAcctno := BatchServices.Functions.fn_find_dids_and_append_to_acctno(dBatchIn(did=0)); // excluding records with DIDs to avoid extra work.

		dDDBatchIn := if(inMod.NoDIDAppend, DATASET([], Autokey_batch.Layouts.rec_inBatchMaster), 
				JOIN(dDidsAcctno, dBatchIn, 
						LEFT.acctno = RIGHT.acctno
						AND LEFT.did != 0,
						TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,
											SELF := LEFT,
											SELF := RIGHT),
				INNER,
				LIMIT(DeathV2_Services.Constants.DEATH_SERVICE_JOIN_LIMIT, SKIP)));

		/* 	Look for dids from input and use them to get state_death_ids and slim.
				These are labelled as 'deepdive' since they are coming from dids, 
				even though they are input to the query. This allows us to accurately tell which matches 
				are from DIDs and which are from autokeys */		
	
    dInputDids := dBatchIn(did != 0) + dDDBatchIn;
		
    ds_death_recs_raw  := dx_death_master.Get.byDid(dInputDids, did, death_params,,100);
    dDDDids := 
      JOIN(dInputDids, ds_death_recs_raw, 
      LEFT.did = RIGHT.did,
      TRANSFORM(DeathV2_Services.Layouts.search_ID_with_matchcode,
        SELF.isdeepdive := TRUE;
        SELF.state_death_id := RIGHT.death.state_death_id;
        SELF := LEFT;
      ),LIMIT(Constants.DEATH_SERVICE_JOIN_LIMIT, SKIP));

    RETURN dDDDids;
	END;	
	
END;