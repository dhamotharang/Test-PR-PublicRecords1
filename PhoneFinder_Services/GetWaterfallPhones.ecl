IMPORT AddrBest,Doxie_Raw,Gateway,MDR,Phones,PhoneFinder_Services,Progressive_phone;

// Layouts
lBatchIn       := PhoneFinder_Services.Layouts.BatchInAppendDID;
lCommon        := PhoneFinder_Services.Layouts.PhoneFinder.Common;
lFinal         := PhoneFinder_Services.Layouts.PhoneFinder.Final;
lExcludePhones := PhoneFinder_Services.Layouts.PhoneFinder.ExcludePhones;
lPPResponse    := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;

EXPORT GetWaterfallPhones(DATASET(lBatchIn)                        dIn,
													PhoneFinder_Services.iParam.ReportParams inMod,
													DATASET(Gateway.Layouts.Config)          dGateways     = DATASET([],Gateway.Layouts.Config),
													BOOLEAN                                  isPhoneExists = FALSE,
													DATASET(lBatchIn)                        dInBestInfo   = DATASET([],lBatchIn)) :=
FUNCTION
	// Waterfall constants
	tmpMod :=
	MODULE(progressive_phone.waterfall_phones_options)
		EXPORT BOOLEAN ExcludeDeadContacts   := FALSE;
		EXPORT BOOLEAN SkipPhoneScoring      := isPhoneExists;
		EXPORT BOOLEAN KeepAllPhones         := ~isPhoneExists;		
		EXPORT BOOLEAN DedupOutputPhones     := IF(~SkipPhoneScoring,FALSE,NOT KeepAllPhones); // We need to keep all phones from all WF levels in order to run the model
		EXPORT INTEGER MaxPhoneCount         := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
		EXPORT INTEGER CountES               := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
		EXPORT INTEGER CountSE               := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
		EXPORT INTEGER CountAP               := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
		EXPORT INTEGER CountSX               := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
		EXPORT INTEGER CountPP               := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
		
		EXPORT BOOLEAN IncludeBusinessPhones := TRUE;
		EXPORT BOOLEAN IncludeLastResort     := ~isPhoneExists;
	END;
	
	qSentPVSV2Gateway := dGateways(inMod.IncludeTransUnionPVS AND Gateway.Configuration.isQsentV2(servicename))[1];
	qSentIQ411V2Gateway := dGateways(inMod.IncludeTransUnionIQ411 AND Gateway.Configuration.isQsentV2(servicename))[1];
		
	BOOLEAN isWaterfallphonesearch := inMod.useWaterfallv6 OR isPhoneExists;
	
 Progressive_phone.layout_progressive_batch_in tFormat2ProgressivePhone(dIn pInput) :=
	TRANSFORM
	
	 SELF.acctno  := pInput.acctno;
	 SELF.did     := pInput.did;
		SELF.phoneno := IF(isWaterfallphonesearch, pInput.homephone, '');
		SELF.suffix  := IF(isWaterfallphonesearch, pInput.addr_suffix, '');
		SELF.z4      := IF(isWaterfallphonesearch, pInput.zip4, '');
		SELF         := IF(isWaterfallphonesearch, pInput);
		SELF         := [];
	END;
	
	dFormat2ProgressivePhone := PROJECT(dIn,tFormat2ProgressivePhone(LEFT));	
	WFConstants := PhoneFinder_Services.Constants.WFConstants;				
	 // sending in lexid only as the input to WF in a PII search
	dWaterfallPIISearch 	:= AddrBest.Progressive_phone_common(dFormat2ProgressivePhone,tmpMod,,,,TRUE,
															TRUE,,progressive_phone.Constants.WFP_V8_CP_V3_MODEL_NAMES[2],,,,,,,
															WFConstants.MaxSubjects,,inMod.UseEquifax,WFConstants.MaxPremiumSource);																										
	dWaterfallPhoneSearch := AddrBest.Progressive_phone_common(dFormat2ProgressivePhone,tmpMod,,,,TRUE, TRUE);
	
	dWaterfallPhones := IF(isWaterfallphonesearch,dWaterfallPhoneSearch,dWaterfallPIISearch);
	
	// Format to common layout
	lFinal tWaterfall2Common(dIn le,dWaterfallPhones ri) :=
	TRANSFORM
		SELF.batch_in          := le;
		SELF.did               := IF(ri.p_did>0,ri.p_did,ri.did);
		SELF.fname             := IF(ri.subj_first <> '', ri.subj_first, ri.p_name_first);
  SELF.mname             := ri.subj_middle;
  SELF.lname             := IF(ri.subj_last <> '', ri.subj_last,ri.p_name_last);
		SELF.city_name         := ri.p_city_name;
		SELF.zip               := ri.zip5;
		SELF.phone             := ri.subj_phone10;
		SELF.carrier_name      := ri.phpl_phone_carrier;
		SELF.phone_region_city := ri.phpl_carrier_city;
		SELF.phone_region_st   := ri.phpl_carrier_state;
		SELF.listed_name       := ri.subj_name_dual;
		SELF.listing_type_bus  := IF(ri.phpl_phones_plus_type = 'B',ri.phpl_phones_plus_type,'');
		SELF.listing_type_res  := IF(ri.phpl_phones_plus_type = 'R',ri.phpl_phones_plus_type,'');
		SELF.listing_type_gov  := IF(ri.phpl_phones_plus_type = 'G',ri.phpl_phones_plus_type,'');
		SELF.dt_first_seen     := IF(LENGTH(TRIM(ri.subj_date_first)) = 8,ri.subj_date_first,ri.subj_date_first + '00');
		SELF.dt_last_seen      := IF(LENGTH(TRIM(ri.subj_date_last)) = 8,ri.subj_date_last,ri.subj_date_last + '00');
		SELF.coctype           := ri.switch_type;
		SELF.coc_description   := CASE(ri.switch_type,
																		'C' => PhoneFinder_Services.Constants.PhoneType.Wireless,
																		'G' => PhoneFinder_Services.Constants.PhoneType.Pager,
																		'P' => PhoneFinder_Services.Constants.PhoneType.Landline,
																		'V' => PhoneFinder_Services.Constants.PhoneType.VoIP,
																		// IF(ri.switch_type IN ['I','P','T','W',''],'OTHER','UNKNOWN'));
																		PhoneFinder_Services.Constants.PhoneType.Other);
		SELF.vendor_id         := ri.vendor;
		SELF.phone_source      := PhoneFinder_Services.Constants.PhoneSource.Waterfall;
		SELF                   := ri;
		SELF                   := [];
	END;
	
	dWaterfallPhones2Common := JOIN(dIn,
																	dWaterfallPhones,
																	LEFT.acctno = RIGHT.acctno,
																	tWaterfall2Common(LEFT,RIGHT),
																	LIMIT(PhoneFinder_Services.Constants.MaxPhones,SKIP));
	
	// Get the primary phone per acctno
	dWaterfallPrimaryPhone := PROJECT(DEDUP(SORT(dWaterfallPhones2Common,batch_in.acctno,-phone_score,-dt_last_seen,RECORD),batch_in.acctno),
																		TRANSFORM(lFinal,SELF.isPrimaryPhone := TRUE,SELF := LEFT));
	
	// Get other waterfall phones
	dWaterfallOtherPhones := JOIN(dWaterfallPhones2Common,
																dWaterfallPrimaryPhone,
																LEFT.batch_in.acctno = RIGHT.batch_in.acctno AND
																LEFT.phone           = RIGHT.phone,
																TRANSFORM(LEFT),
																LEFT ONLY);
	
	// Exclude phones
	dExcludePhones := PROJECT(dWaterfallPhones2Common,TRANSFORM(lExcludePhones,SELF.acctno := LEFT.batch_in.acctno,SELF := LEFT));
	
	// QSent gateway data - iQ411	
	dWFQSentIQ411 := IF(EXISTS(dIn) AND EXISTS(dInBestInfo) AND inMod.IncludeTransUnionIQ411,
											PhoneFinder_Services.GetQSentPhones.GetQSentIQ411Data(dInBestInfo,dExcludePhones,inMod,qSentIQ411V2Gateway));
	
	// Grab records from QSent where we didn't get a hit from waterfall
	dWFQSentOnly := JOIN( dWFQSentIQ411,
												dWaterfallPrimaryPhone,
												LEFT.acctno = RIGHT.acctno,
												TRANSFORM(LEFT),
												LEFT ONLY);
	
	// If waterfall process doesn't return any hits, pick the first record from TU as the primary phone
	dWFQSentPrimaryPhone := dWFQSentOnly(isPrimaryPhone);
	dWFQSentOtherPhones  := dWFQSentOnly(~isPrimaryPhone);
	
	dWFQSentMatches := JOIN(dWFQSentIQ411,
													dWFQSentOnly,
													LEFT.acctno = RIGHT.acctno,
													TRANSFORM(lFinal,SELF.isPrimaryPhone := FALSE,SELF := LEFT),
													LEFT ONLY);
	
	// Call the gateway again with the primary phone number using service type 'PVSD' to get the phone info
	// Since iQ411 service type doesn't return a PV record
	dPrimaryPhones := dWFQSentPrimaryPhone + dWaterfallPrimaryPhone;
	
	dWFQSentPrimaryPhoneDetail := IF(EXISTS(dPrimaryPhones) AND inMod.IncludeTransUnionPVS,
																		PhoneFinder_Services.GetQSentPhones.GetQSentPVSData(dPrimaryPhones,
																																												inMod,phone,acctno,
																																												TRUE,qSentPVSV2Gateway));
	
	dInhousePhoneDetail	:= IF(EXISTS(dPrimaryPhones),PhoneFinder_Services.GetPhoneDetails(PROJECT(dPrimaryPhones,TRANSFORM(Phones.Layouts.PhoneAttributes.BatchIn,
																																											SELF.acctno:=LEFT.acctno,SELF.phoneno:=LEFT.phone,SELF:=[])), dGateways, inMod));
																																											
	dInhousePhoneDetailWBatchIn := JOIN(dInhousePhoneDetail, dIn,
																																					LEFT.acctno = RIGHT.acctno,
																			 TRANSFORM(lFinal,
																			 SELF.isPrimaryPhone := TRUE, SELF.batch_in := RIGHT, SELF := LEFT));

 dPrimaryPhoneDetail := IF(inMod.UseInHousePhoneMetadata, dInhousePhoneDetailWBatchIn, dWFQSentPrimaryPhoneDetail);	
																																																												
	dWFQSentCombined := dPrimaryPhones + dPrimaryPhoneDetail + dWFQSentOtherPhones + dWFQSentMatches;
	
	BOOLEAN vHitQSent := inMod.useQSent AND (qSentPVSV2Gateway.url != '' OR qSentIQ411V2Gateway.url != '');
	
	dWFQSentRecs := IF(vHitQSent,dWFQSentCombined);
	
			
  dWaterfallCombined := IF(~isPhoneExists AND vHitQSent,dWaterfallOtherPhones + dWFQSentRecs,dWaterfallPrimaryPhone + dWaterfallOtherPhones);
	 
	 	dDidRecs := PROJECT(dWaterfallCombined, TRANSFORM(lFinal,
																					                       SELF.phonestatus :=  PhoneFinder_Services.Functions.PhoneStatusDesc((INTEGER)LEFT.realtimephone_ext.statuscode), 
																																             SELF := LEFT));
	
	// Debug
	#IF(PhoneFinder_Services.Constants.Debug.Waterfall)
		wfWithPhone   := SEQUENTIAL(OUTPUT(dIn,NAMED('dPhone_Waterfall_In'),EXTEND),
																OUTPUT(dFormat2ProgressivePhone,NAMED('dPhone_Format2ProgressivePhone'),EXTEND),
																OUTPUT(dWaterfallPhoneSearch,NAMED('dWaterfallPhoneSearch'),EXTEND),
																OUTPUT(dWaterfallPhones,NAMED('dPhone_WaterfallPhones'),EXTEND),
																OUTPUT(dWaterfallPhones2Common,NAMED('dPhone_WaterfallPhones2Common'),EXTEND));
		
		wfWithNoPhone := SEQUENTIAL(OUTPUT(dIn,NAMED('dWaterfall_In'),EXTEND),
																OUTPUT(dFormat2ProgressivePhone,NAMED('dFormat2ProgressivePhone'),EXTEND),
																OUTPUT(dWaterfallPIISearch,NAMED('dWaterfallPIISearch'),EXTEND),
																OUTPUT(dWaterfallPhones,NAMED('dWaterfallPhones'),EXTEND),
																OUTPUT(dWaterfallPhones2Common,NAMED('dWaterfallPhones2Common'),EXTEND),
																OUTPUT(dWaterfallPrimaryPhone,NAMED('dWaterfallPrimaryPhone'),EXTEND),
																OUTPUT(dWaterfallOtherPhones,NAMED('dWaterfallOtherPhones'),EXTEND),
																OUTPUT(dExcludePhones,NAMED('dExcludePhones'),EXTEND),
																#IF(PhoneFinder_Services.Constants.Debug.QSent)
																	SEQUENTIAL( OUTPUT(dWFQSentIQ411,NAMED('dWFQSentIQ411'),EXTEND),
																							OUTPUT(dWFQSentOnly,NAMED('dWFQSentOnly'),EXTEND),
																							OUTPUT(dWFQSentPrimaryPhone,NAMED('dWFQSentPrimaryPhone'),EXTEND),
																							OUTPUT(dWFQSentOtherPhones,NAMED('dWFQSentOtherPhones'),EXTEND),
																							OUTPUT(dWFQSentMatches,NAMED('dWFQSentMatches'),EXTEND),
																							OUTPUT(dPrimaryPhones,NAMED('dPrimaryPhones'),EXTEND),
																							OUTPUT(dWFQSentPrimaryPhoneDetail,NAMED('dWFQSentPrimaryPhoneDetail'),EXTEND),
																							OUTPUT(dInhousePhoneDetail,NAMED('dInhousePhoneDetail'),EXTEND),
																							OUTPUT(dPrimaryPhoneDetail,NAMED('dPrimaryPhoneDetail'),EXTEND),
																							OUTPUT(dWFQSentRecs,NAMED('dWFQSentRecs'),EXTEND)),
																#END
																OUTPUT(DATASET([],{STRING1 Dummy}),NAMED('DummyDS'),EXTEND));
		
		IF(isPhoneExists,wfWithPhone,wfWithNoPhone);
	#END
	
	RETURN dDidRecs;
END;