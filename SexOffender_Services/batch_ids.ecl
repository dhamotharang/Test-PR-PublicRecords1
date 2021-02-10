IMPORT Autokey_batch, AutokeyB2, SexOffender, BatchServices;

EXPORT batch_ids := MODULE

  EXPORT AutoKeyIds(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in) := FUNCTION
      
    // 1. Define values for obtaining autokeys and payloads.
    ak_keyname := SexOffender.Constants.ak_keyname;
    ak_dataset := SexOffender.Constants.ak_dataset;
    ak_skipSet := SexOffender.Constants.ak_skipset;
    ak_typestr := SexOffender.Constants.ak_typeStr;
    
    // 2. Configure the autokey search.
    ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
      EXPORT workHard := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at ALL.
      EXPORT useAllLookups := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
      EXPORT skip_set := auto_skip + ak_skipSet;
    END;
          
    // 3. Get autokey 'fake' ids (fids) based on batch input.
    ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
    
    // 4. Get seisint_primary_key via autokey payload (outpl).
    AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr )
        
    // 5. Slim the autokey payload (outpl) to just what's needed for matching.
    ds_outpl_slim := PROJECT(outpl,
      TRANSFORM(SexOffender_Services.Layouts.lookup_id_rec,
                // self.err_search := Standard.Errors.MapAutokeySearchStatus(left.search_status),
                SELF := LEFT,
                SELF := []));
      
    // ... Then sort and dedup.
    ds_ids_by_ak := DEDUP(SORT(ds_outpl_slim,acctno,seisint_primary_key),
                          acctno,seisint_primary_key);
                          
    RETURN ds_ids_by_ak;

  END;


  EXPORT IdsByDID(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in,
                  BOOLEAN runDeepDive,
                  BOOLEAN isFCRA = FALSE) := FUNCTION
    // Key
    key_soff := SexOffender.Key_SexOffender_DID(isFCRA);
    
    // search rec with did
    acct_rec:= RECORD
      SexOffender_Services.Layouts.lookup_id_rec;
      UNSIGNED6 ldid;
    END;
  
    //Deep dive if necessary
    deep_dids := PROJECT(BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in(did = 0)),
      TRANSFORM(acct_rec,
                SELF.ldid := LEFT.did,
                SELF.isDeepDive := TRUE,
                SELF.seisint_primary_key := '',
                SELF := LEFT));
    
    acct_rec xformToAcctRec(Autokey_batch.Layouts.rec_inBatchMaster L) := TRANSFORM
      SELF.ldid := L.did;
      SELF.isDeepDive := FALSE;
      SELF.seisint_primary_key := '';
      SELF := L;
    END;
    accts_wDID := PROJECT(ds_batch_in(did <> 0), xformToAcctRec(LEFT));
    
    withDID_nonFCRA := IF(runDeepDive, accts_wDID + deep_dids(ldid <> 0), accts_wDID);
    withDID_FCRA := PROJECT(ds_batch_in(did <> 0), xformToAcctRec(LEFT));
    
    ds_acctnos_and_dids := IF(isFCRA, withDID_fcra, withDID_nonFCRA);
    
    // .. go look for ids via dids.
    ds_ids_by_did := JOIN(ds_acctnos_and_dids, key_soff,
      LEFT.ldid = RIGHT.did,
      TRANSFORM(SexOffender_Services.Layouts.lookup_id_rec,
                SELF.acctno := LEFT.acctno,
                SELF.seisint_primary_key := RIGHT.seisint_primary_key,
                SELF.isDeepDive := LEFT.isDeepDive),
      INNER, LIMIT(SexOffender_Services.Constants.MAX_RECS_PERDID, SKIP));
                                          
    RETURN ds_ids_by_did;
  END;

END;
