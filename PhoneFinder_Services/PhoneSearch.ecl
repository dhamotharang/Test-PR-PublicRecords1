﻿IMPORT DeathV2_Services,Didville,Doxie,Doxie_Raw,dx_death_master,Gateway,Suppress;

lBatchIn       := PhoneFinder_Services.Layouts.BatchInAppendDID;
lCommon        := PhoneFinder_Services.Layouts.PhoneFinder.Common;
lFinal         := PhoneFinder_Services.Layouts.PhoneFinder.Final;
lExcludePhones := PhoneFinder_Services.Layouts.PhoneFinder.ExcludePhones;
lPPResponse    := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;

EXPORT PhoneSearch( DATASET(lBatchIn)                        dIn,
										PhoneFinder_Services.iParam.SearchParams inMod,
										DATASET(Gateway.Layouts.Config)          dGateways) :=
FUNCTION

  mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
    EXPORT unsigned1 glb := inMod.GLBPurpose;
    EXPORT unsigned1 dppa := inMod.DPPAPurpose;
    EXPORT string DataPermissionMask := inMod.DataPermissionMask;
    EXPORT string DataRestrictionMask := inMod.DataRestrictionMask;
    EXPORT string5 industry_class := inMod.IndustryClass;
    EXPORT string32 application_type := inMod.ApplicationType;
    EXPORT boolean show_minors := inMod.IncludeMinors OR (inMod.GLBPurpose = 2);
    EXPORT string ssn_mask := inMod.SSNMask;
  END;

	dResultsByPhone := PhoneFinder_Services.GetPhones(dIn,inMod,dGateways);
	
	// Search by PII - Don't use royalty based sources when searching on PII when phone is also sent in
	// Experian File One and Waterfall process
	wfMod := MODULE(PROJECT(inMod,PhoneFinder_Services.iParam.SearchParams,OPT))
		EXPORT BOOLEAN UseQSent      := FALSE;
		EXPORT BOOLEAN UseLastResort := FALSE;
		EXPORT BOOLEAN UseInHousePhoneMetadata := FALSE;
	END;
	
	dInDIDPopulated       := dIn(orig_did != 0 or did != 0);
	dWaterfallPhonesByDID := IF(EXISTS(dInDIDPopulated),
															PhoneFinder_Services.GetWaterfallPhones(dInDIDPopulated,wfMod,,TRUE));
	
	// Check to see if the best waterfall phones contains the input phone number
	dWFPhonesFilter_ := dWaterfallPhonesByDID(phone = batch_in.homephone);
	
	lFinal tWFIdentity(dWFPhonesFilter_ pInput) :=
	TRANSFORM
		SELF.acctno        := pInput.acctno;
		SELF.did           := pInput.batch_in.did;
		SELF.phone         := pInput.phone; // populating phone and dates
		SELF.dt_first_seen := pInput.dt_first_seen;
		SELF.dt_last_seen  := pInput.dt_last_seen;
		SELF.penalt        := 0;
		SELF.src           := pInput.src;
		SELF.vendor_id     := pInput.vendor_id;
		SELF.phone_source  := pInput.phone_source;
		SELF.batch_in      := pInput.batch_in;
		SELF               := [];
	END;
	
	dWFPhonesFilter := PROJECT(dWFPhonesFilter_,tWFIdentity(LEFT));
				
	dWFDedup := DEDUP(SORT(dWFPhonesFilter,acctno,did),acctno,did);
	
	dWFDIDs := DEDUP(SORT(PROJECT(dWFDedup,doxie.layout_references),did),did);
	
	// Best information
	dWFBestInfo := Doxie.best_records(dWFDIDs, includeDOD:=TRUE, modAccess := mod_access);
	
	lFinal tAppendBestInfo(dWFDedup le,dWFBestInfo ri) :=
	TRANSFORM
		SELF.acctno := le.acctno;
		SELF.phone  := le.phone;
		SELF.dod    := (INTEGER)ri.dod;
		SELF        := ri;
		SELF        := le;
	END;
	
	dWFAppendBest := JOIN(dWFDedup,
                        dWFBestInfo,
                        LEFT.did = RIGHT.did,
                        tAppendBestInfo(LEFT,RIGHT),
                        LEFT OUTER,
                        LIMIT(1,SKIP));
	
	// Add WF/Experian records to records searched by phone only if there is a match on the phone number
	dWFOnly := JOIN(dResultsByPhone,
                  dWFAppendBest,
                  LEFT.acctno = RIGHT.acctno and
                  LEFT.did    = RIGHT.did,
                  TRANSFORM(RIGHT),
                  RIGHT ONLY);
	
	dAll := dResultsByPhone + dWFOnly;
	
	// Append DIDs
	dAppendDIDs := PhoneFinder_Services.Functions.AppendDIDs(dAll);
	
	rec_w_newseq :=
  RECORD(lFinal)
	 UNSIGNED8 new_seq;
	END;

  // adding new seq with counter values
  dAppendDIDs_w_new_seq := PROJECT(dAppendDIDs, TRANSFORM(rec_w_newseq, SELF.new_seq := COUNTER, SELF := LEFT));
	
  file_in_filter := dAppendDIDs_w_new_seq(did = 0 and (listing_type_bus = '' and fname <> '' and lname <> '' and prim_name <> ''));
	
  file_in := project(file_in_filter, TRANSFORM(didville.Layout_Did_OutBatch,
																							 SELF.did := LEFT.did,								 														 
																							 SELF.seq := LEFT.new_seq,				// passing in new_seq				 														 
																							 SELF.suffix := LEFT.name_suffix,
																							 SELF.addr_suffix := LEFT.suffix,
																							 SELF.p_city_name := LEFT.city_name,
																							 SELF.st := LEFT.st,
																							 SELF.z5  := LEFT.zip,
																							 SELF.phone10 := LEFT.phone,																						 
																							 SELF.email := '',																						 
																							 SELF.dob := (string)LEFT.dob,																						 
																							 SELF := LEFT, SELF := []));

  BOOLEAN glb_ok := mod_access.isValidGLB ();
	DIDsAdded := didville.did_service_common_function(file_in,
                                                    glb_flag := glb_ok, 
                                                    glb_purpose_value := mod_access.glb,
                                                    appType := mod_access.application_type,
                                                    IndustryClass_val := mod_access.industry_class);		
																							 
	dAll_wDIDs := JOIN(dAppendDIDs_w_new_seq,
                      DIDsAdded,
                      LEFT.new_seq = RIGHT.seq,
                      TRANSFORM(lFinal,SELF.DID:=IF(LEFT.DID = 0,RIGHT.DID,LEFT.DID),SELF:=LEFT),
                      LEFT OUTER, LIMIT(0), KEEP(1));			
	
  Suppress.MAC_Suppress(dAll_wDIDs,dSuppress,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did,'','',TRUE,'',TRUE);
	
	// Deceased flag
  death_params := DeathV2_Services.IParam.GetRestrictions(mod_access);

	dDeceasedAppend := dx_death_master.Append.ByDid(dSuppress,did,death_params);
  dDeceased := 
    PROJECT(dDeceasedAppend, 
      TRANSFORM(lfinal,
        SELF.deceased := IF(LEFT.death.is_deceased, 'Y', 'N');
        SELF.dod      := IF(LEFT.death.is_deceased, (UNSIGNED4)LEFT.death.dod8, 0);
        SELF          := LEFT;
        ));
  
  // Debug
	#IF(PhoneFinder_Services.Constants.Debug.PhoneNoSearch)
		OUTPUT(dIn,NAMED('dPhoneSearchIn'));
		OUTPUT(dResultsByPhone,NAMED('dResultsByPhone'));
		OUTPUT(dWaterfallPhonesByDID,NAMED('dWaterfallPhonesByDID'));
		OUTPUT(dWFPhonesFilter,NAMED('dWFPhonesFilter'));
		OUTPUT(dAll,NAMED('dAll'));
		OUTPUT(dAppendDIDs,NAMED('dAppendDIDs'));
		OUTPUT(dAppendDIDs_w_new_seq,NAMED('dAppendDIDs_w_new_seq'));
		OUTPUT(file_in_filter,NAMED('file_in_filter'));
		OUTPUT(file_in,NAMED('file_in'));
		OUTPUT(DIDsAdded,NAMED('DIDsAdded'));
		OUTPUT(dAll_wDIDs,NAMED('dAll_wDIDs'));
		OUTPUT(dSuppress,NAMED('dPhoneSearchSuppress'));
		OUTPUT(dDeceased,NAMED('dDeceased'));
	#END

	RETURN dDeceased;
END;