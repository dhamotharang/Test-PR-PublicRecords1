import Autokey_batch, AutokeyB2, SexOffender, BatchServices;

EXPORT batch_ids := MODULE

	export AutoKeyIds(dataset(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in) := function
			
		// 1. Define values for obtaining autokeys and payloads.		
		ak_keyname := SexOffender.Constants.ak_keyname;
		ak_dataset := SexOffender.Constants.ak_dataset;
		ak_skipSet := SexOffender.Constants.ak_skipset;
		ak_typestr := SexOffender.Constants.ak_typeStr;
		
		// 2. Configure the autokey search.		
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
			export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			export skip_set        := auto_skip + ak_skipSet;
		END;
					
		// 3. Get autokey 'fake' ids (fids) based on batch input.
		ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
		
		// 4. Get seisint_primary_key via autokey payload (outpl).			
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr )
				
		// 5. Slim the autokey payload (outpl) to just what's needed for matching.
		ds_outpl_slim := project(outpl, 
													transform(SexOffender_Services.Layouts.lookup_id_rec, 
																		// self.err_search := Standard.Errors.MapAutokeySearchStatus(left.search_status),
																		self := left, 
																		self := []));
			
		// ... Then sort and dedup.
		ds_ids_by_ak := dedup(sort(ds_outpl_slim,acctno,seisint_primary_key),
													acctno,seisint_primary_key);
													
		return ds_ids_by_ak;

	end;


	export IdsByDID(dataset(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in,
										 boolean runDeepDive,
										 boolean isFCRA = false) := function
		// Key
		key_soff 						:= SexOffender.Key_SexOffender_DID(isFCRA);
		
		// search rec with did
		acct_rec:= RECORD
			SexOffender_Services.Layouts.lookup_id_rec;
			unsigned6 ldid;
		END;
	
		//Deep dive if necessary
		deep_dids        		:= project(BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in(did = 0)), 
																	 transform(acct_rec, 
																						 self.ldid := left.did,
																						 self.isDeepDive := true,
																						 self.seisint_primary_key := '',
																						 self := left));
		
		acct_rec xformToAcctRec(Autokey_batch.Layouts.rec_inBatchMaster L) := transform
			self.ldid := L.did;
			self.isDeepDive := false;
			self.seisint_primary_key := '';
			self := L;
		end;
		accts_wDID			 		:= project(ds_batch_in(did <> 0), xformToAcctRec(left));
		
		withDID_nonFCRA  		:= if(runDeepDive, accts_wDID + deep_dids(ldid <> 0), accts_wDID);
		withDID_FCRA 		 		:= project(ds_batch_in(did <> 0), xformToAcctRec(left));
		
		ds_acctnos_and_dids := if(isFCRA, withDID_fcra, withDID_nonFCRA);
		
		// .. go look for ids via dids.
	  ds_ids_by_did 			:= JOIN(ds_acctnos_and_dids, key_soff,
		                                          LEFT.ldid = RIGHT.did,
		                                          TRANSFORM(SexOffender_Services.Layouts.lookup_id_rec,
		                                                    SELF.acctno              := LEFT.acctno,
		                                                    SELF.seisint_primary_key := RIGHT.seisint_primary_key,
																												SELF.isDeepDive          := LEFT.isDeepDive),
		                                          INNER, LIMIT(SexOffender_Services.Constants.MAX_RECS_PERDID, skip));
																					
    return ds_ids_by_did;																					 
  end;				

END;