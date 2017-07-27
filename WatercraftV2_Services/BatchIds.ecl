import BatchServices, Autokey_batch, AutokeyB2, watercraft, ut, BIPV2;

EXPORT BatchIds := MODULE

	shared AutoKeyBatchMaster := Autokey_batch.Layouts.rec_inBatchMaster;
	shared AcctRec := WatercraftV2_Services.Layouts.acct_rec;
	
	export AutoKeyIds(dataset(AutoKeyBatchMaster) ds_batch_in) := function
			
		// 1. Define domain-specific values for obtaining autokeys and payloads. 		
		ak_keyname	:= WatercraftV2_Services.Constants('').ak_keyname;   
		ak_dataset	:= DATASET([], WatercraftV2_services.Layouts.ak_payload_rec);   
		ak_typeStr	:= WatercraftV2_Services.Constants('').ak_typestr;  	
		
		// 2. Configure the autokey search.			
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			EXPORT UseAllLookUps := TRUE;
			EXPORT skip_set := [];
		END;			
					
		// 3. Get autokey 'fake' ids (fids) based on batch input.
		ds_fids := UNGROUP(Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data));
		
		// 4. Get autokey payloads (the real DIDs/BDIDs, record ids, and other goodies) based on fids.			
		AutokeyB2.mac_get_payload(ds_fids, ak_keyname, ak_dataset, outpl, ldid, lbdid, ak_typestr);
		
		// 5. Slim the autokey payload (outpl) to just what's needed for matching. Then sort and dedup.
		ds_ids_by_ak := dedup(sort(project(outpl, TRANSFORM(AcctRec,SELF := LEFT,SELF := [])), 
															acctno, watercraft_key, sequence_key, state_origin),
											acctno, watercraft_key, sequence_key, state_origin);
											
		return ds_ids_by_ak;

	end;
	
	export byDIDIds(dataset(AutoKeyBatchMaster) ds_batch_in, 
									boolean runDeepDive,
									boolean isFCRA = false) := function
		// Key
		keyWCDID := watercraft.key_watercraft_did (isFCRA);
		
		// Deep Dive if necessary
		deep_dids1 := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in(did = 0));
		deep_dids := project(deep_dids1, transform(AcctRec, 
																							 self.ldid := left.did,
																							 self.isDeepDive := TRUE, 
																							 self := left, self := []));
																							 
		AcctRec xformToAcctRec(AutoKeyBatchMaster L) := transform
			self.ldid := L.did;
			self.acctno := L.acctno;
			self.isDeepDive := FALSE; 
			self := []; //lbdid, watercraft_key, sequence_key, state_origin
		end;	
		accts_wDID := project(ds_batch_in(did <> 0), xformToAcctRec(LEFT));				
		
		// if RunDeepDive, combine deep dive and non deep dive for non FCRA																						 
		withDID_nonFCRA := if(runDeepDive, accts_wDID + deep_dids(ldid <> 0), accts_wDID);
		// for FCRA we have DIDs at this point and we do not want to use AK or deep dive
		withDID_FCRA := project(ds_batch_in, xformToAcctRec(LEFT)); 
		// choose 
		withDID := if(isFCRA, withDID_FCRA, withDID_nonFCRA);
		
		// Look for Ids via DIDs
		AcctRec fromKeyWCDID(AcctRec l, keyWCDID r) := TRANSFORM
			self.watercraft_key := R.watercraft_key;
			self.sequence_key := R.sequence_key;
			self.state_origin := R.state_origin;
			self := L; //acctno, ldid, lbdid, isDeepDive	
		END;		
		ds_ids_by_did := JOIN(withDID, keyWCDID, KEYED(LEFT.ldid = RIGHT.l_did), fromKeyWCDID(LEFT, RIGHT), keep(ut.limits.WATERCRAFT_PER_DID));
		
    return ds_ids_by_did;																					 
  end;				
	
	EXPORT byLinkIds(DATASET(WatercraftV2_Services.Layouts.batch_in) ds_batch_in, 
										STRING1 BIPFetchLevel) := FUNCTION
										
		
		ds_linkIds := PROJECT(ds_batch_in(ultid !=0),BIPV2.IDlayouts.l_xlink_ids2);
		
		// Kfetch to get watercraft records
		ds_from_linkids := PROJECT(Watercraft.Key_LinkIds.kFetch2(ds_linkIds,BIPFetchLevel),
															 TRANSFORM(AcctRec,
																					SELF := LEFT,
																					SELF := []));
		// Add back acctno 
		fromLinkids := JOIN(ds_from_linkids,ds_batch_in(ultid !=0),
													BIPV2.IDmacros.mac_JoinLinkids(BIPFetchLevel),
															TRANSFORM(AcctRec,
																						SELF.acctno := RIGHT.acctno,
																						SELF := LEFT));

		return(fromLinkids);
	end;
END;