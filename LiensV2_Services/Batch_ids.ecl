import Autokey_batch, AutokeyB2, BatchServices, BIPV2, LiensV2;

EXPORT Batch_ids := MODULE
	shared out_rec := LiensV2_Services.Batch_Layouts.layout_batchids;
	
	export AutoKeyIds(dataset(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in,
										SET OF STRING party_types) := function
		
		// ************************** TMSIDS BY AUTOKEY **************************
		
		// 1. Define values for obtaining autokeys and payloads.		
		ak_keyname := LiensV2.str_AutokeyName;
		ak_dataset := LiensV2.file_SearchAutokey(DATASET([],LiensV2.Layout_liens_party));
		ak_typeStr := 'BC';
			
		// 2. Configure the autokey search.		
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
			export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			//export PenaltThreshold := 20;  // not needed here already set inside "interfaces" above.
			export skip_set        := auto_skip + ['P'];
		END;
							
		// Get autokeys and payloads based on batch input. Filter autokey records by party_type. Slim to 
		// just acctnos and tmsids.
		
		// 3. Get autokey 'fake' ids (fids) based on batch input.
		ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
		
		// 4. Get tmsid via autokey payload (outpl).	
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outpl, intdid, intbdid, ak_typeStr )
		
		// 5. Slim the autokey payload (outpl) to just what's needed for matching.
		outpl_filtered_by_party_type := outpl(name_type[1] IN party_types);
		ds_ids_by_ak := PROJECT(outpl_filtered_by_party_type, transform(out_rec,
																																		self.acctno := left.acctno,
																																		self.tmsid := left.tmsid,
																																		self := []
																																		// self.did := (unsigned6)left.did,
																																		// self.bdid := (unsigned6)left.bdid
																																		));
										
		return ds_ids_by_ak;

	end;

	export IdsByDID(dataset(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in,
										 boolean runDeepDive,
										 boolean isFCRA = false) := function
		
		// ************************** TMSIDS BY THE HEADER **************************
		//key
		did_key := if(isFCRA, liensv2.key_liens_did_fcra, liensv2.key_liens_did);
		
		//Deep dive if necessary
		out_rec xformToAcctRec(Autokey_batch.Layouts.rec_inBatchMaster L) := transform
			self.tmsid  := '';
			self.bdid   := 0;
      self.ultid  := 0;
      self.orgid  := 0;
      self.seleid := 0;
      self.proxid := 0;
      self.empid  := 0;
      self.powid  := 0;
      self.dotid  := 0;
      self        := L;  // acctno, did
		end;
		
		deep_dids        		:= project(BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in(did = 0)), 
																	 transform(out_rec,
																						 self.tmsid  := '',
																						 self.bdid   := 0,
                                             self.ultid  := 0,
                                             self.orgid  := 0,
                                             self.seleid := 0,
                                             self.proxid := 0,
                                             self.empid  := 0,
                                             self.powid  := 0,
                                             self.dotid  := 0,
                                             self        := left)); // acctno, did
		
		accts_wDID			 		:= project(ds_batch_in(did <> 0), xformToAcctRec(left));
		
		withDID_nonFCRA  		:= if(runDeepDive, accts_wDID + deep_dids(did <> 0), accts_wDID); //runDeepDive is the equivalent of ~no_did_append
		withDID_FCRA 		 		:= accts_wDID;
		
		ds_acctnos_and_dids := if(isFCRA, withDID_fcra, withDID_nonFCRA);
				
		ds_ids_by_did := join(ds_acctnos_and_dids,did_key,
													keyed(left.did = right.did),
													transform(out_rec,
																		self.acctno := left.acctno,
																		self.tmsid  := right.tmsid,
																		self.did    := left.did,
																		self.bdid   := 0,
                                    self.ultid  := 0,
                                    self.orgid  := 0,
                                    self.seleid := 0,
                                    self.proxid := 0,
                                    self.empid  := 0,
                                    self.powid  := 0,
                                    self.dotid  := 0),
																		keep(LiensV2.Constants.LIENS_DID_KEEP)); // actual number might be higher than that...
																					
    return ds_ids_by_did;																					 
  end;
	
	export IdsByBDID(dataset(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in, //no FCRA for this
										 boolean runDeepDive) := function
		
		// ************************** TMSIDS BY THE HEADER **************************
		//key
		bdid_key := liensv2.key_liens_bdid;
		
		//Deep dive if necessary
		out_rec xformToAcctRec(Autokey_batch.Layouts.rec_inBatchMaster L) := transform
			self.tmsid  := '';
			self.did    := 0;
      self.ultid  := 0;
      self.orgid  := 0;
      self.seleid := 0;
      self.proxid := 0;
      self.empid  := 0;
      self.powid  := 0;
      self.dotid  := 0;
      self        := L; // acctno, bdid
		end;
		
		deep_bdids        	:= project(BatchServices.Functions.fn_find_bdids_and_append_to_acctno(ds_batch_in(bdid = 0)), 
																	 transform(out_rec, 
																						 self.tmsid  := '',
																						 self.did    := 0,
                                             self.ultid  := 0,
                                             self.orgid  := 0,
                                             self.seleid := 0,
                                             self.proxid := 0,
                                             self.empid  := 0,
                                             self.powid  := 0,
                                             self.dotid  := 0,
                                             self        := left)); // acctno, bdid
		
		accts_wBDID	:= project(ds_batch_in(bdid <> 0), xformToAcctRec(left));
		
		ds_acctnos_and_bdids := if(runDeepDive, accts_wBDID + deep_bdids(bdid <> 0), accts_wBDID); //runDeepDive is the equivalent of ~no_bdid_append
		
		ds_ids_by_bdid := join(ds_acctnos_and_bdids, bdid_key,
														keyed(left.bdid = right.p_bdid),
														transform(out_rec, 
																			self.acctno := left.acctno, 
																			self.tmsid  := right.tmsid,
																			self.bdid   := left.bdid,
																			self.did    := 0,
                                      self.UltId  := left.ultid,
                                      self.OrgId  := left.OrgId,
                                      self.SeleId := left.SeleId,
                                      self.ProxId := left.ProxId,
                                      self.EmpId  := 0,
                                      self.PowId  := 0,
                                      self.dotid  := 0
                                      ),
														keep(LiensV2.Constants.LIENS_DID_KEEP));    
																					
    return ds_ids_by_bdid;																					 
  end;				

	EXPORT IdsByLinkId(DATASET(LiensV2_Services.Batch_Layouts.batch_in) ds_batch_in,
                     LiensV2_Services.IParam.batch_params configData
                    ) := 
    FUNCTION

      ds_linkIds    := PROJECT(ds_batch_in,BIPV2.IDlayouts.l_xlink_ids2);
      ds_linkIdRecs := LiensV2.Key_LinkIds.KFetch2(ds_linkIds,		
                                                   configData.BIPFetchLevel,,
                                                   LiensV2.Constants.JOIN_LIMIT,
                                                   LiensV2.Constants.JOIN_TYPE );
      
      ds_batch_in_fetchLevel :=  
        PROJECT(ds_batch_in, 
                TRANSFORM(LiensV2_Services.Batch_Layouts.batch_in,
                          SELF.OrgId  := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  LEFT.OrgID,  0),
                          SELF.SeleId := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
                          SELF.ProxId := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
                          SELF.EmpId  := 0,  // Not used/needed
                          SELF.PowId  := 0,  // Not used/needed
                          SELF.DotId  := 0,  // Not used/needed
                          SELF        := LEFT));                                       
        
      ds_linkIdRecs_fetchLevel := 
        PROJECT(ds_linkIdRecs,
								TRANSFORM(RECORDOF(ds_linkIdRecs),
                          SELF.OrgId  := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  LEFT.OrgID,  0),
                          SELF.SeleId := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
                          SELF.ProxId := IF(configData.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
                          SELF.EmpId  := 0,  // Not used/needed
                          SELF.PowId  := 0,  // Not used/needed
                          SELF.DotId  := 0,  // Not used/needed
                          SELF        := LEFT));   
      
      ds_LinkIdKeyWithAcctNo := 
        JOIN( ds_batch_in_fetchLevel, ds_linkIdRecs_fetchLevel,
              BIPV2.IDmacros.mac_JoinAllLinkids(),
              TRANSFORM( LiensV2_Services.Batch_Layouts.layout_batchids, 
                         SELF.DID    := (UNSIGNED6)RIGHT.DID,
                         SELF.BDID   := (UNSIGNED6)RIGHT.BDID,
                         SELF.TMSID  := RIGHT.TMSID,
                         SELF        := LEFT));

    RETURN ds_LinkIdKeyWithAcctNo;
    
    END;
END;
	