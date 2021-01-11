IMPORT Autokey_batch, AutokeyB2, BatchServices, BIPV2, LiensV2;

EXPORT Batch_ids := MODULE
  SHARED out_rec := LiensV2_Services.Batch_Layouts.layout_batchids;
  
  EXPORT AutoKeyIds(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in,
                    SET OF STRING party_types) := FUNCTION
    
    // ************************** TMSIDS BY AUTOKEY **************************
    
    // 1. Define values for obtaining autokeys and payloads.
    ak_keyname := LiensV2.str_AutokeyName;
    ak_dataset := LiensV2.file_SearchAutokey(DATASET([],LiensV2.Layout_liens_party));
    ak_typeStr := 'BC';
      
    // 2. Configure the autokey search.
    ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
      EXPORT workHard := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at ALL.
      EXPORT useAllLookups := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
      //export PenaltThreshold := 20; // not needed here already set inside "interfaces" above.
      EXPORT skip_set := auto_skip + ['P'];
    END;
              
    // Get autokeys and payloads based on batch input. Filter autokey records by party_type. Slim to
    // just acctnos and tmsids.
    
    // 3. Get autokey 'fake' ids (fids) based on batch input.
    ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
    
    // 4. Get tmsid via autokey payload (outpl).
    AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outpl, intdid, intbdid, ak_typeStr )
    
    // 5. Slim the autokey payload (outpl) to just what's needed for matching.
    outpl_filtered_by_party_type := outpl(name_type[1] IN party_types);
    ds_ids_by_ak := PROJECT(outpl_filtered_by_party_type, TRANSFORM(out_rec,
                                                                    SELF.acctno := LEFT.acctno,
                                                                    SELF.tmsid := LEFT.tmsid,
                                                                    SELF := []
                                                                    // self.did := (unsigned6)left.did,
                                                                    // self.bdid := (unsigned6)left.bdid
                                                                    ));
                    
    RETURN ds_ids_by_ak;

  END;

  EXPORT IdsByDID(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in,
                     BOOLEAN runDeepDive,
                     BOOLEAN isFCRA = FALSE) := FUNCTION
    
    // ************************** TMSIDS BY THE HEADER **************************
    //key
    did_key := IF(isFCRA, liensv2.key_liens_did_fcra, liensv2.key_liens_did);
    
    //Deep dive if necessary
    out_rec xformToAcctRec(Autokey_batch.Layouts.rec_inBatchMaster L) := TRANSFORM
      SELF.tmsid := '';
      SELF.bdid := 0;
      SELF.ultid := 0;
      SELF.orgid := 0;
      SELF.seleid := 0;
      SELF.proxid := 0;
      SELF.empid := 0;
      SELF.powid := 0;
      SELF.dotid := 0;
      SELF := L; // acctno, did
    END;
    
    deep_dids := PROJECT(BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in(did = 0)),
                                   TRANSFORM(out_rec,
                                             SELF.tmsid := '',
                                             SELF.bdid := 0,
                                             SELF.ultid := 0,
                                             SELF.orgid := 0,
                                             SELF.seleid := 0,
                                             SELF.proxid := 0,
                                             SELF.empid := 0,
                                             SELF.powid := 0,
                                             SELF.dotid := 0,
                                             SELF := LEFT)); // acctno, did
    
    accts_wDID := PROJECT(ds_batch_in(did <> 0), xformToAcctRec(LEFT));
    
    withDID_nonFCRA := IF(runDeepDive, accts_wDID + deep_dids(did <> 0), accts_wDID); //runDeepDive is the equivalent of ~no_did_append
    withDID_FCRA := accts_wDID;
    
    ds_acctnos_and_dids := IF(isFCRA, withDID_fcra, withDID_nonFCRA);
        
    ds_ids_by_did := JOIN(ds_acctnos_and_dids,did_key,
                          KEYED(LEFT.did = RIGHT.did),
                          TRANSFORM(out_rec,
                                    SELF.acctno := LEFT.acctno,
                                    SELF.tmsid := RIGHT.tmsid,
                                    SELF.did := LEFT.did,
                                    SELF.bdid := 0,
                                    SELF.ultid := 0,
                                    SELF.orgid := 0,
                                    SELF.seleid := 0,
                                    SELF.proxid := 0,
                                    SELF.empid := 0,
                                    SELF.powid := 0,
                                    SELF.dotid := 0),
                                    KEEP(LiensV2.Constants.LIENS_DID_KEEP)); // actual number might be higher than that...
                                          
    RETURN ds_ids_by_did;
  END;
  
  EXPORT IdsByBDID(
    DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in, //no FCRA for this
    BOOLEAN runDeepDive) := FUNCTION
    
    // ************************** TMSIDS BY THE HEADER **************************
    //key
    bdid_key := liensv2.key_liens_bdid;
    
    //Deep dive if necessary
    out_rec xformToAcctRec(Autokey_batch.Layouts.rec_inBatchMaster L) := TRANSFORM
      SELF.tmsid := '';
      SELF.did := 0;
      SELF.ultid := 0;
      SELF.orgid := 0;
      SELF.seleid := 0;
      SELF.proxid := 0;
      SELF.empid := 0;
      SELF.powid := 0;
      SELF.dotid := 0;
      SELF := L; // acctno, bdid
    END;
    
    deep_bdids := PROJECT(BatchServices.Functions.fn_find_bdids_and_append_to_acctno(ds_batch_in(bdid = 0)),
                                   TRANSFORM(out_rec,
                                             SELF.tmsid := '',
                                             SELF.did := 0,
                                             SELF.ultid := 0,
                                             SELF.orgid := 0,
                                             SELF.seleid := 0,
                                             SELF.proxid := 0,
                                             SELF.empid := 0,
                                             SELF.powid := 0,
                                             SELF.dotid := 0,
                                             SELF := LEFT)); // acctno, bdid
    
    accts_wBDID := PROJECT(ds_batch_in(bdid <> 0), xformToAcctRec(LEFT));
    
    ds_acctnos_and_bdids := IF(runDeepDive, accts_wBDID + deep_bdids(bdid <> 0), accts_wBDID); //runDeepDive is the equivalent of ~no_bdid_append
    
    ds_ids_by_bdid := JOIN(ds_acctnos_and_bdids, bdid_key,
                            KEYED(LEFT.bdid = RIGHT.p_bdid),
                            TRANSFORM(out_rec,
                                      SELF.acctno := LEFT.acctno,
                                      SELF.tmsid := RIGHT.tmsid,
                                      SELF.bdid := LEFT.bdid,
                                      SELF.did := 0,
                                      SELF.UltId := LEFT.ultid,
                                      SELF.OrgId := LEFT.OrgId,
                                      SELF.SeleId := LEFT.SeleId,
                                      SELF.ProxId := LEFT.ProxId,
                                      SELF.EmpId := 0,
                                      SELF.PowId := 0,
                                      SELF.dotid := 0
                                      ),
                            KEEP(LiensV2.Constants.LIENS_DID_KEEP));
                                          
    RETURN ds_ids_by_bdid;
  END;

  EXPORT IdsByLinkId(DATASET(LiensV2_Services.Batch_Layouts.batch_in) ds_batch_in,
                     LiensV2_Services.IParam.batch_params configData
                    ) :=
    FUNCTION

      ds_linkIds := PROJECT(ds_batch_in,BIPV2.IDlayouts.l_xlink_ids2);
      ds_linkIdRecs := LiensV2.Key_LinkIds.KFetch2(ds_linkIds,
                                                   configData.BIPFetchLevel,,
                                                   LiensV2.Constants.JOIN_LIMIT,
                                                   LiensV2.Constants.JOIN_TYPE );
      
      ds_batch_in_fetchLevel :=
        PROJECT(ds_batch_in,
                TRANSFORM(LiensV2_Services.Batch_Layouts.batch_in,
                          SELF.OrgId := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down, LEFT.OrgID, 0),
                          SELF.SeleId := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
                          SELF.ProxId := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
                          SELF.EmpId := 0, // Not used/needed
                          SELF.PowId := 0, // Not used/needed
                          SELF.DotId := 0, // Not used/needed
                          SELF := LEFT));
        
      ds_linkIdRecs_fetchLevel :=
        PROJECT(ds_linkIdRecs,
                TRANSFORM(RECORDOF(ds_linkIdRecs),
                          SELF.OrgId := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down, LEFT.OrgID, 0),
                          SELF.SeleId := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
                          SELF.ProxId := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
                          SELF.EmpId := 0, // Not used/needed
                          SELF.PowId := 0, // Not used/needed
                          SELF.DotId := 0, // Not used/needed
                          SELF := LEFT));
      
      ds_LinkIdKeyWithAcctNo :=
        JOIN( ds_batch_in_fetchLevel, ds_linkIdRecs_fetchLevel,
              BIPV2.IDmacros.mac_JoinAllLinkids(),
              TRANSFORM( LiensV2_Services.Batch_Layouts.layout_batchids,
                         SELF.DID := (UNSIGNED6)RIGHT.DID,
                         SELF.BDID := (UNSIGNED6)RIGHT.BDID,
                         SELF.TMSID := RIGHT.TMSID,
                         SELF := LEFT));

    RETURN ds_LinkIdKeyWithAcctNo;
    
    END;
END;
  
