IMPORT AutoStandardI,DeathV2_Services,Didville,Doxie,Doxie_Raw,Experian_Phones,Gateway,Suppress,ut;

lBatchIn       := PhoneFinder_Services.Layouts.BatchInAppendDID;
lCommon        := PhoneFinder_Services.Layouts.PhoneFinder.Common;
lFinal         := PhoneFinder_Services.Layouts.PhoneFinder.Final;
lExcludePhones := PhoneFinder_Services.Layouts.PhoneFinder.ExcludePhones;
lPPResponse    := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;

EXPORT PhoneSearch( DATASET(lBatchIn)                        dIn,
										PhoneFinder_Services.iParam.ReportParams inMod,
										DATASET(Gateway.Layouts.Config)          dGateways) :=
FUNCTION
	dResultsByPhone := PhoneFinder_Services.GetPhones(dIn,inMod,dGateways);
	
	// Search by PII - Don't use royalty based sources when searching on PII when phone is also sent in
	// Experian File One and Waterfall process
	wfMod := MODULE(PROJECT(inMod,PhoneFinder_Services.iParam.ReportParams,OPT))
		EXPORT BOOLEAN UseQSent      := FALSE;
		EXPORT BOOLEAN UseMetronet   := FALSE;
		EXPORT BOOLEAN UseLastResort := FALSE;
	END;
	
	dInDIDPopulated       := dIn(orig_did != 0 or did != 0);
	dWaterfallPhonesByDID := IF(EXISTS(dInDIDPopulated),
															PhoneFinder_Services.GetWaterfallPhones(dInDIDPopulated,wfMod,,TRUE));
	
	// Check to see if the best waterfall phones contains the input phone number
	dWFPhonesFilter_ := dWaterfallPhonesByDID(phone = batch_in.homephone);
	
	lFinal tWFIdentity(dWFPhonesFilter_ pInput) :=
	TRANSFORM
		SELF.acctno       := pInput.acctno;
		SELF.did          := pInput.batch_in.did;
		SELF.penalt       := 0;
		SELF.src          := pInput.src;
		SELF.vendor_id    := pInput.vendor_id;
		SELF.phone_source := pInput.phone_source;
		SELF.batch_in     := pInput.batch_in;
		SELF              := [];
	END;
	
	dWFPhonesFilter := PROJECT(dWFPhonesFilter_,tWFIdentity(LEFT));
	
	// Join to Experian File One
	dExperianPhones := JOIN(dIn,
													Experian_Phones.Key_Did_Digits,
													KEYED(LEFT.did = RIGHT.did) and
													KEYED(LEFT.homephone[8..10] = RIGHT.Phone_digits) and
													RIGHT.rec_type != 'SP',
													KEEP(1),LIMIT(0)
													);
	
	lFinal tFormatExperian(dExperianPhones pInput) :=
	TRANSFORM
		SELF.acctno       := pInput.acctno;
		SELF.phone        := pInput.homephone;
		SELF.phone_source := PhoneFinder_Services.Constants.PhoneSource.ExpFileOne;
		SELF.batch_in     := pInput;
		SELF              := [];
	END;
	
	dFormatExperianPhones := PROJECT(dExperianPhones,tFormatExperian(LEFT));
	
	// Append best info for waterfall and experian file one records
	dWFExperianCombined := dWFPhonesFilter +
													IF(ut.PermissionTools.glb.OK(inMod.GLBPurpose) and ~Doxie.DataRestriction.ExperianPhones,dFormatExperianPhones);
	
	dWFExperianCombinedDedup := DEDUP(SORT(dWFExperianCombined,acctno,did),acctno,did);
	
	dWFExperianDIDs := DEDUP(SORT(PROJECT(dWFExperianCombinedDedup,doxie.layout_references),did),did);
	
	// Best information
	dWFExperianBestInfo := Doxie.best_records(dWFExperianDIDs,includeDOD:=true);
	
	lFinal tAppendBestInfo(dWFExperianCombinedDedup le,dWFExperianBestInfo ri) :=
	TRANSFORM
		SELF.acctno := le.acctno;
		SELF.phone  := le.phone;
		SELF.dod    := (INTEGER)ri.dod;
		SELF        := ri;
		SELF        := le;
	END;
	
	dWFExperianAppendBest := JOIN(dWFExperianCombinedDedup,
																dWFExperianBestInfo,
																LEFT.did = RIGHT.did,
																tAppendBestInfo(LEFT,RIGHT),
																LEFT OUTER,
																LIMIT(1,SKIP));
	
	// Add WF/Experian records to records searched by phone only if there is a match on the phone number
	dWFExperianOnly := JOIN(dResultsByPhone,
													dWFExperianAppendBest,
													LEFT.acctno = RIGHT.acctno and
													LEFT.did    = RIGHT.did,
													TRANSFORM(RIGHT),
													RIGHT ONLY);
	
	dAll := dResultsByPhone + dWFExperianOnly;
	
	// Append DIDs
	dAppendDIDs := PhoneFinder_Services.Functions.AppendDIDs(dAll);
	
		rec_w_newseq := record
	 lFinal;
	 UNSIGNED8     new_seq;
	end;
	
	// adding new seq with counter values
 dAppendDIDs_w_new_seq := project(dAppendDIDs, transform(recordof(rec_w_newseq), self.new_seq := counter, self := left));
	
 file_in_filter := dAppendDIDs_w_new_seq(did = 0 and (listing_type_bus = '' and fname <>'' and lname<>'' and prim_name<>''));
	
 file_in := project(file_in_filter, transform(didville.Layout_Did_OutBatch,
																							 self.did := left.did,								 														 
																							 self.seq := left.new_seq,				// passing in new_seq				 														 
																							 self.suffix := left.name_suffix,
																							 self.addr_suffix := left.suffix,
																							 self.p_city_name := left.city_name,
																							 self.st := left.st,
																							 self.z5  := left.zip,
																							 self.phone10 := left.phone,																						 
																							 self.email := '',																						 
																							 self.dob := (string)left.dob,																						 
																							 self := left, self := []));

	BOOLEAN glb_ok := AutoStandardI.InterfaceTranslator.glb_ok.val(PROJECT(inMod,AutoStandardI.InterfaceTranslator.glb_ok.params,OPT));
	DIDsAdded := didville.did_service_common_function(file_in,
																							 glb_flag := glb_ok, 
																							 glb_purpose_value := inMod.GLBPurpose, 
																							 appType := inMod.ApplicationType,
																							 IndustryClass_val := inMod.IndustryClass);		
																							 
	dAll_wDIDs := JOIN(dAppendDIDs_w_new_seq,DIDsAdded,
										LEFT.new_seq = RIGHT.seq,
										TRANSFORM(RECORDOF(dAppendDIDs),SELF.DID:=IF(LEFT.DID = 0,RIGHT.DID,LEFT.DID),SELF:=LEFT),
										LEFT OUTER, LIMIT(0), KEEP(1));			
																						 
											
	// Deceased flag	
	lFinal tDeceasedFlag(dAll_wDIDs le,Doxie.key_death_masterV2_ssa_DID ri) :=
	TRANSFORM
		SELF.deceased := IF(ri.l_did != 0,'Y','N');
		SELF.dod      := (UNSIGNED)ri.dod8;
		SELF          := le;
	END;
	
	deathParams := DeathV2_Services.IParam.GetDeathRestrictions(inMod);
	
	dDeceased := JOIN(dAll_wDIDs,
										Doxie.key_death_masterV2_ssa_DID,
										KEYED(LEFT.did = RIGHT.l_did) and
										not DeathV2_Services.Functions.Restricted(RIGHT.src, RIGHT.glb_flag, glb_ok, deathParams),
										tDeceasedFlag(LEFT,RIGHT),
										LEFT OUTER,
										LIMIT(0),KEEP(1));
	
	Suppress.MAC_Suppress(dDeceased,dSuppress,inMod.ApplicationType,Suppress.Constants.LinkTypes.DID,did,'','',TRUE,'',TRUE);
	
	// Debug
	#IF(PhoneFinder_Services.Constants.Debug.PhoneNoSearch)
		OUTPUT(dIn,NAMED('dPhoneSearchIn'));
		OUTPUT(dResultsByPhone,NAMED('dResultsByPhone'));
		OUTPUT(wfMod);
		OUTPUT(dWaterfallPhonesByDID,NAMED('dWaterfallPhonesByDID'));
		OUTPUT(dExperianPhones,NAMED('dExperianPhones'));
		OUTPUT(dFormatExperianPhones,NAMED('dFormatExperianPhones'));
		OUTPUT(dWFExperianCombined,NAMED('dWFExperianCombined'));
		OUTPUT(dWFExperianCombinedDedup,NAMED('dWFExperianCombinedDedup'));
		OUTPUT(dWFExperianDIDs,NAMED('dWFExperianDIDs'));
		OUTPUT(dWFExperianBestInfo,NAMED('dWFExperianBestInfo'));
		OUTPUT(dWFExperianAppendBest,NAMED('dWFExperianAppendBest'));
		OUTPUT(dWFExperianOnly,NAMED('dWFExperianOnly'));
		OUTPUT(dAll,NAMED('dAll'));
		OUTPUT(dAppendDIDs,NAMED('dAppendDIDs'));
		OUTPUT(dAppendDIDs_w_new_seq,NAMED('dAppendDIDs_w_new_seq'));
		OUTPUT(file_in_filter,NAMED('file_in_filter'));
		OUTPUT(file_in,NAMED('file_in'));
		OUTPUT(DIDsAdded,NAMED('DIDsAdded'));
		OUTPUT(dAll_wDIDs,NAMED('dAll_wDIDs'));
		OUTPUT(glb_ok,NAMED('glb_ok'));
		OUTPUT(dDeceased,NAMED('dDeceased'));
		OUTPUT(dSuppress,NAMED('dPhoneSearchSuppress'));
	#END

	RETURN dSuppress;
END;