IMPORT AddrBest, Doxie_Raw, Gateway, MDR, Phones, PhoneFinder_Services, Progressive_phone;

  // Layouts
  lBatchIn       := PhoneFinder_Services.Layouts.BatchInAppendDID;
  lCommon        := PhoneFinder_Services.Layouts.PhoneFinder.Common;
  lFinal         := PhoneFinder_Services.Layouts.PhoneFinder.Final;
  lExcludePhones := PhoneFinder_Services.Layouts.PhoneFinder.ExcludePhones;
  lPPResponse    := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;

  EXPORT GetWaterfallPhones(DATASET(lBatchIn)                        dIn,
                          PhoneFinder_Services.iParam.SearchParams inMod,
                          DATASET(Gateway.Layouts.Config)          dGateways     = DATASET([], Gateway.Layouts.Config),
                          BOOLEAN                                  isPhoneExists = FALSE,
                          DATASET(lBatchIn)                        dInBestInfo   = DATASET([], lBatchIn)) :=
  FUNCTION
  // Waterfall constants
  tmpMod :=
  MODULE(progressive_phone.waterfall_phones_options)
    EXPORT BOOLEAN ExcludeDeadContacts   := FALSE;
    EXPORT BOOLEAN SkipPhoneScoring      := isPhoneExists;
    EXPORT BOOLEAN KeepAllPhones         := ~isPhoneExists;
    EXPORT BOOLEAN DedupOutputPhones     := IF(~SkipPhoneScoring, FALSE, NOT KeepAllPhones); // We need to keep all phones from all WF levels in order to run the model
    EXPORT INTEGER MaxPhoneCount         := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
    EXPORT INTEGER CountES               := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
    EXPORT INTEGER CountSE               := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
    EXPORT INTEGER CountAP               := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
    EXPORT INTEGER CountSX               := PhoneFinder_Services.Constants.WFConstants.MaxPhones;
    EXPORT INTEGER CountPP               := PhoneFinder_Services.Constants.WFConstants.MaxPhones;

    EXPORT BOOLEAN IncludeBusinessPhones := TRUE;
    EXPORT BOOLEAN IncludeLastResort     := ~isPhoneExists;
  END;

  qSentGateway := dGateways(inMod.UseQSent AND Gateway.Configuration.isQsentV2(servicename))[1];

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

  dFormat2ProgressivePhone := PROJECT(dIn, tFormat2ProgressivePhone(LEFT));

  WFConstants := PhoneFinder_Services.Constants.WFConstants;

  // sending in lexid only as the input to WF in a PII search
  dWaterfallPIISearch   := AddrBest.Progressive_phone_common(dFormat2ProgressivePhone, tmpMod, , , , TRUE,
                                                              TRUE, , progressive_phone.Constants.WFP_V8_CP_V3_MODEL_NAMES[2], , , , , , ,
                                                              WFConstants.MaxSubjects, , inMod.UseEquifax, WFConstants.MaxPremiumSource);
  dWaterfallPhoneSearch := AddrBest.Progressive_phone_common(dFormat2ProgressivePhone, tmpMod, , , , TRUE, TRUE);

  dWaterfallPhones_pre := UNGROUP(IF(isWaterfallphonesearch, dWaterfallPhoneSearch, dWaterfallPIISearch));

  dWaterfallPhones := IF(inMod.UseEquifax AND ~inMod.UseInhousePhones, dWaterfallPhones_pre(subj_phone_type_new = MDR.sourceTools.src_EQUIFAX), dWaterfallPhones_pre);

  // Format to common layout
  lFinal tWaterfall2Common(dWaterfallPhones pInput) :=
  TRANSFORM
    SELF.isPrimaryIdentity := ~isWaterfallphonesearch;
    SELF.did               := IF(pInput.p_did > 0, pInput.p_did, pInput.did);
    SELF.fname             := IF(pInput.subj_first <> '', pInput.subj_first, pInput.p_name_first);
    SELF.mname             := pInput.subj_middle;
    SELF.lname             := IF(pInput.subj_last <> '', pInput.subj_last, pInput.p_name_last);
    SELF.city_name         := pInput.p_city_name;
    SELF.zip               := pInput.zip5;
    SELF.phone             := pInput.subj_phone10;
    SELF.carrier_name      := pInput.phpl_phone_carrier;
    SELF.phone_region_city := pInput.phpl_carrier_city;
    SELF.phone_region_st   := pInput.phpl_carrier_state;
    SELF.listed_name       := pInput.subj_name_dual;
    SELF.listing_type_bus  := IF(pInput.phpl_phones_plus_type = 'B', pInput.phpl_phones_plus_type, '');
    SELF.listing_type_res  := IF(pInput.phpl_phones_plus_type = 'R', pInput.phpl_phones_plus_type, '');
    SELF.listing_type_gov  := IF(pInput.phpl_phones_plus_type = 'G', pInput.phpl_phones_plus_type, '');
    SELF.dt_first_seen     := CASE(LENGTH(TRIM(pInput.subj_date_first)),
                                    8 => pInput.subj_date_first,
                                    6 => pInput.subj_date_first + '01',
                                    '');
    SELF.dt_last_seen      := CASE(LENGTH(TRIM(pInput.subj_date_last)),
                                    8 => pInput.subj_date_last,
                                    6 => pInput.subj_date_last + '01',
                                    '');
    SELF.coctype           := pInput.switch_type;
    SELF.coc_description   := CASE(pInput.switch_type,
                                    'C' => PhoneFinder_Services.Constants.PhoneType.Wireless,
                                    'G' => PhoneFinder_Services.Constants.PhoneType.Pager,
                                    'P' => PhoneFinder_Services.Constants.PhoneType.Landline,
                                    'V' => PhoneFinder_Services.Constants.PhoneType.VoIP,
                                    // IF(pInput.switch_type IN ['I', 'P', 'T', 'W', ''], 'OTHER', 'UNKNOWN'));
                                    PhoneFinder_Services.Constants.PhoneType.Other);
    SELF.vendor_id         := pInput.vendor;
    // Distinguishing between gateway and non-gateway sourced records
    PhConstants := PhoneFinder_Services.Constants.PhoneSource;
    SELF.phone_source      := MAP(pInput.subj_phone_type_new = MDR.sourceTools.src_EQUIFAX => PhConstants.EquifaxPhones,
                                  pInput.vendor = MDR.sourceTools.src_wired_Assets_Royalty => PhConstants.LastResort,
                                  pInput.vendor = MDR.sourceTools.src_Inhouse_QSent => PhConstants.InHouseQSent,
                                  PhConstants.Waterfall);
    SELF.Phone_StarRating  := (STRING)pInput.Phone_StarRating;                              
    SELF                   := pInput;
    SELF                   := [];
  END;

  dWaterfallPhones2Common := PROJECT(dWaterfallPhones, tWaterfall2Common(LEFT));


	// Get the primary phone per acctno
  dWaterfallPhones2CommonGrp := GROUP(SORT(dWaterfallPhones2Common, acctno, -phone_score, -dt_last_seen, RECORD), acctno);

  lFinal tAssignPrimary(lFinal le, lFinal ri, INTEGER cnt) :=
  TRANSFORM
    SELF.isPrimaryPhone := cnt = 1;
    SELF                := ri;
  END;

  dWaterfallAssignPrimary := UNGROUP(ITERATE(dWaterfallPhones2CommonGrp, tAssignPrimary(LEFT, RIGHT, COUNTER)));

  // Primary phones
  dWaterfallPrimaryPhone := dWaterfallAssignPrimary(isPrimaryPhone);

  // Other waterfall phones
  dWaterfallOtherPhones := dWaterfallAssignPrimary(~isPrimaryPhone);

  // Exclude phones
  dExcludePhones := PROJECT(dWaterfallPhones2Common, TRANSFORM(lExcludePhones, SELF := LEFT));

  // QSent gateway data - iQ411
  dWFQSentIQ411 := IF(EXISTS(dIn) AND EXISTS(dInBestInfo) AND inMod.UseTransUnionIQ411,
                      PhoneFinder_Services.GetQSentPhones.GetQSentIQ411Data(dInBestInfo, dExcludePhones, inMod, qSentGateway));

  // Grab records from QSent where we didn't get a hit from waterfall
  dWFQSentOnly := JOIN( dWFQSentIQ411,
                        dExcludePhones,
                        LEFT.acctno = RIGHT.acctno,
                        TRANSFORM(LEFT),
                        LEFT ONLY);

  // If waterfall process doesn't return any hits, pick the first record from TU as the primary phone
  dWFQSentPrimaryPhone := dWFQSentOnly(isPrimaryPhone);
  dWFQSentOtherPhones  := dWFQSentOnly(~isPrimaryPhone);

  // Need to set isPrimaryPhone = FALSE for QSent records if we found a hit in waterfall phones
  dWFQSentMatches := JOIN(dWFQSentIQ411,
                          dWFQSentOnly,
                          LEFT.acctno = RIGHT.acctno,
                          TRANSFORM(lFinal, SELF.isPrimaryPhone := FALSE, SELF := LEFT),
                          LEFT ONLY);

  // Call the gateway again with the primary phone number using service type 'PVSD' to get the phone info
  // Since iQ411 service type doesn't return a PV record
  dPrimaryPhones := dWFQSentPrimaryPhone + dWaterfallPrimaryPhone;

  dWFQSentPrimaryPhoneDetail := IF(EXISTS(dPrimaryPhones) AND inMod.UseTransUnionPVS AND qSentGateway.url != '',
    PhoneFinder_Services.GetQSentPhones.GetQSentPVSData(dPrimaryPhones, inMod, qSentGateway));
  // dPrimaryPhones + dPrimaryPhoneDetail - Primary phones including Qsent if no Waterfall phones found
  // dWFQSentOtherPhones - If no phones found in waterfall, Qsent other phones
  // dWFQSentMatches - If phones found in waterfall, all Qsent phones other than Primary
  dOtherPhones := dWaterfallOtherPhones + dWFQSentOtherPhones + dWFQSentMatches;

  dInhouseMetadataPhones := dPrimaryPhones + dOtherPhones;

  dInhousePhoneDetail	:= IF(EXISTS(dInhouseMetadataPhones),
                            PhoneFinder_Services.GetPhoneDetails(PROJECT(dInhouseMetadataPhones,
                                                                          TRANSFORM(Phones.Layouts.PhoneAttributes.BatchIn,
                                                                                      SELF.acctno:= LEFT.acctno, SELF.phoneno:= LEFT.phone, SELF:= [])),
                                                                  dGateways, inMod));
 
  lFinal tAppendCarrierInfo (lFinal le, lFinal ri, BOOLEAN isPrimaryPhone) :=
  TRANSFORM
    SELF.carrier_name      := ri.carrier_name;
    SELF.phone_region_city := ri.phone_region_city;
    SELF.phone_region_st   := ri.phone_region_st;
    // for other phones keep metadata from transunion if we have it and we didn't find any in-house
    SELF.coc_description   := IF(ri.coc_description = '', le.coc_description, ri.coc_description);
    SELF.phonestatus       := ri.phonestatus;
    SELF.servicetype       := ri.servicetype;
    SELF.prepaid           := ri.prepaid;
    SELF.RealTimePhone_Ext := ri.RealTimePhone_Ext;
    SELF.typeflag          := IF(isPrimaryPhone, ri.typeflag, le.typeflag);
    SELF.phone_source      := ri.phone_source;
    SELF.dt_last_seen      := IF(isPrimaryPhone, ri.dt_last_seen, le.dt_last_seen);
    SELF.isPrimaryPhone    := isPrimaryPhone;
    SELF                   := le;
  END;

  dPrimaryInhousePhoneDetail := JOIN(dPrimaryPhones, dInhousePhoneDetail,
                                      LEFT.acctno = RIGHT.acctno AND
                                      LEFT.phone  = RIGHT.phone,
                                      tAppendCarrierInfo(LEFT, RIGHT, TRUE),
                                      LIMIT(0), KEEP(1));

  dOtherPhonesInHouseDetail := JOIN(dOtherPhones, dInhousePhoneDetail,
                                    LEFT.acctno = RIGHT.acctno AND
                                    LEFT.phone  = RIGHT.phone,
                                    tAppendCarrierInfo(LEFT, RIGHT, FALSE),
                                    LEFT OUTER,
                                    LIMIT(0), KEEP(1));

  dPrimaryPhoneDetail := IF(inMod.UseInHousePhoneMetadataOnly, dPrimaryInhousePhoneDetail, dWFQSentPrimaryPhoneDetail);

  dWaterfallCombined := IF(isPhoneExists,
                            dWaterfallAssignPrimary,
                            dPrimaryPhones + dPrimaryPhoneDetail + dOtherPhonesInHouseDetail);

  dDidRecs := PROJECT(PhoneFinder_Services.Functions.AppendDIDs(dWaterfallCombined, TRUE),
                      TRANSFORM(lFinal,
                                SELF.phonestatus := IF(inMod.UseInHousePhoneMetadataOnly,
                                                        LEFT.phonestatus,
                                                        PhoneFinder_Services.Functions.PhoneStatusDesc((INTEGER)LEFT.realtimephone_ext.statuscode)),
                                SELF             := LEFT));

  // Debug
  #IF(PhoneFinder_Services.Constants.Debug.Waterfall)
    wfWithPhone   := SEQUENTIAL(OUTPUT(dIn, NAMED('dPhone_Waterfall_In'), EXTEND),
                                OUTPUT(dFormat2ProgressivePhone, NAMED('dPhone_Format2ProgressivePhone'), EXTEND),
                                OUTPUT(dWaterfallPhoneSearch, NAMED('dWaterfallPhoneSearch'), EXTEND),
                                OUTPUT(dWaterfallPhones, NAMED('dPhone_WaterfallPhones'), EXTEND),
                                OUTPUT(dWaterfallPhones2Common, NAMED('dPhone_WaterfallPhones2Common'), EXTEND));

    wfWithNoPhone := SEQUENTIAL(OUTPUT(dIn, NAMED('dWaterfall_In'), EXTEND),
                                OUTPUT(dFormat2ProgressivePhone, NAMED('dFormat2ProgressivePhone'), EXTEND),
                                OUTPUT(dWaterfallPIISearch, NAMED('dWaterfallPIISearch'), EXTEND),
                                OUTPUT(dWaterfallPhones, NAMED('dWaterfallPhones'), EXTEND),
                                OUTPUT(dWaterfallPhones2Common, NAMED('dWaterfallPhones2Common'), EXTEND),
                                OUTPUT(dWaterfallPrimaryPhone, NAMED('dWaterfallPrimaryPhone'), EXTEND),
                                OUTPUT(dWaterfallOtherPhones, NAMED('dWaterfallOtherPhones'), EXTEND),
                                OUTPUT(dExcludePhones, NAMED('dExcludePhones'), EXTEND),
                                OUTPUT(dInhousePhoneDetail, NAMED('dInhousePhoneDetail_WF'), EXTEND),
                                OUTPUT(dPrimaryInhousePhoneDetail, NAMED('dPrimaryInhousePhoneDetail'), EXTEND),
                                OUTPUT(dOtherPhonesInHouseDetail, NAMED('dOtherPhonesInHouseDetail'), EXTEND),
                                OUTPUT(dPrimaryPhoneDetail, NAMED('dPrimaryPhoneDetail_WF'), EXTEND),
                                #IF(PhoneFinder_Services.Constants.Debug.QSent)
                                  SEQUENTIAL( OUTPUT(dWFQSentIQ411, NAMED('dWFQSentIQ411'), EXTEND),
                                              OUTPUT(dWFQSentOnly, NAMED('dWFQSentOnly'), EXTEND),
                                              OUTPUT(dWFQSentPrimaryPhone, NAMED('dWFQSentPrimaryPhone'), EXTEND),
                                              OUTPUT(dWFQSentOtherPhones, NAMED('dWFQSentOtherPhones'), EXTEND),
                                              OUTPUT(dWFQSentMatches, NAMED('dWFQSentMatches'), EXTEND),
                                              OUTPUT(dPrimaryPhones, NAMED('dPrimaryPhones'), EXTEND),
                                              OUTPUT(dWFQSentPrimaryPhoneDetail, NAMED('dWFQSentPrimaryPhoneDetail'), EXTEND),
                                #END
                                OUTPUT(dWaterfallCombined, NAMED('dWaterfallCombined_WF'), EXTEND),
                                OUTPUT(DATASET([], {STRING1 Dummy}), NAMED('DummyDS'), EXTEND));

    IF(isPhoneExists, wfWithPhone, wfWithNoPhone);
  #END

  RETURN dDidRecs;
  END;
