IMPORT BatchServices, Autokey_batch, AutokeyB2, watercraft, ut, BIPV2;

EXPORT BatchIds := MODULE

  SHARED AutoKeyBatchMaster := Autokey_batch.Layouts.rec_inBatchMaster;
  SHARED AcctRec := WatercraftV2_Services.Layouts.acct_rec;
  
  EXPORT AutoKeyIds(DATASET(AutoKeyBatchMaster) ds_batch_in) := FUNCTION
      
    // 1. Define domain-specific values for obtaining autokeys and payloads.
    ak_keyname := WatercraftV2_Services.Constants('').ak_keyname;
    ak_dataset := DATASET([], WatercraftV2_services.Layouts.ak_payload_rec);
    ak_typeStr := WatercraftV2_Services.Constants('').ak_typestr;
    
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
    ds_ids_by_ak := DEDUP(SORT(PROJECT(outpl, TRANSFORM(AcctRec,SELF := LEFT,SELF := [])),
                              acctno, watercraft_key, sequence_key, state_origin),
                      acctno, watercraft_key, sequence_key, state_origin);
                      
    RETURN ds_ids_by_ak;

  END;
  
  EXPORT byDIDIds(DATASET(AutoKeyBatchMaster) ds_batch_in,
                  BOOLEAN runDeepDive,
                  BOOLEAN isFCRA = FALSE) := FUNCTION
    // Key
    keyWCDID := watercraft.key_watercraft_did (isFCRA);
    
    // Deep Dive if necessary
    deep_dids1 := BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in(did = 0));
    deep_dids := PROJECT(deep_dids1, TRANSFORM(AcctRec,
      SELF.ldid := LEFT.did,
      SELF.isDeepDive := TRUE,
      SELF := LEFT, SELF := []));
                                               
    AcctRec xformToAcctRec(AutoKeyBatchMaster L) := TRANSFORM
      SELF.ldid := L.did;
      SELF.acctno := L.acctno;
      SELF.isDeepDive := FALSE;
      SELF := []; //lbdid, watercraft_key, sequence_key, state_origin
    END;
    accts_wDID := PROJECT(ds_batch_in(did <> 0), xformToAcctRec(LEFT));
    
    // if RunDeepDive, combine deep dive and non deep dive for non FCRA
    withDID_nonFCRA := IF(runDeepDive, accts_wDID + deep_dids(ldid <> 0), accts_wDID);
    // for FCRA we have DIDs at this point and we do not want to use AK or deep dive
    withDID_FCRA := PROJECT(ds_batch_in, xformToAcctRec(LEFT));
    // choose
    withDID := IF(isFCRA, withDID_FCRA, withDID_nonFCRA);
    
    // Look for Ids via DIDs
    AcctRec fromKeyWCDID(AcctRec l, keyWCDID r) := TRANSFORM
      SELF.watercraft_key := R.watercraft_key;
      SELF.sequence_key := R.sequence_key;
      SELF.state_origin := R.state_origin;
      SELF := L; //acctno, ldid, lbdid, isDeepDive
    END;
    ds_ids_by_did := JOIN(withDID, keyWCDID, KEYED(LEFT.ldid = RIGHT.l_did), fromKeyWCDID(LEFT, RIGHT), KEEP(ut.limits.WATERCRAFT_PER_DID));
    
    RETURN ds_ids_by_did;
  END;
  
  EXPORT byLinkIds(DATASET(WatercraftV2_Services.Layouts.batch_in) ds_batch_in,
                    STRING1 BIPFetchLevel) := FUNCTION
                    
    
    ds_linkIds := PROJECT(ds_batch_in(ultid !=0),BIPV2.IDlayouts.l_xlink_ids2);
    
    // Kfetch to get watercraft records
    ds_from_linkids := PROJECT(Watercraft.Key_LinkIds.kFetch2(ds_linkIds,BIPFetchLevel),
      TRANSFORM(AcctRec, SELF := LEFT, SELF := []));

    // Add back acctno
    fromLinkids := JOIN(ds_from_linkids,ds_batch_in(ultid !=0),
      BIPV2.IDmacros.mac_JoinLinkids(BIPFetchLevel),
      TRANSFORM(AcctRec,
        SELF.acctno := RIGHT.acctno,
        SELF := LEFT));

    RETURN fromLinkids;
  END;
END;
