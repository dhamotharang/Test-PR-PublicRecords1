/*--SOAP--
<message name="ContactPlusSearchService" wuTimeout="300000">
 <part name="DedupePhones" type="tns:XmlDataSet" cols="70" rows="25"/>
 <part name="DPPAPurpose" type="xsd:unsignedInt"/>
 <part name="GLBPurpose" type="xsd:unsignedInt"/>
 <part name="KeepSamePhoneInDiffLevels" type="xsd:boolean"/>
 <part name="DedupAgainstInputPhones" type="xsd:boolean"/>
 <part name="MaxPhoneCount" type="xsd:unsignedInt"/>
 <part name="CountType1_Es_EDASEARCH" type="xsd:unsignedInt"/>
 <part name="CountType2_Se_SKIPTRACESEARCH" type="xsd:unsignedInt"/>
 <part name="CountType3_Ap_PROGRESSIVEADDRESSSEARCH" type="xsd:unsignedInt"/>
 <part name="CountType4_Sp_POSSIBLESPOUSE" type="xsd:unsignedInt"/>
 <part name="CountType4_Md_POSSIBLEPARENTS" type="xsd:unsignedInt"/>
 <part name="CountType4_Cl_CLOSESTRELATIVE" type="xsd:unsignedInt"/>
 <part name="CountType4_Cr_CORESIDENT" type="xsd:unsignedInt"/>
 <part name="CountType5_Sx_EXPANDEDSKIPTRACESEARCH" type="xsd:unsignedInt"/>
 <part name="CountType6_Pp_PHONESPLUSSEARCH" type="xsd:unsignedInt"/>
 <part name="CountType7_UNVERIFIEDPHONE" type="xsd:unsignedInt"/>
 <part name="CountType_Ne_CLOSESTNEIGHBOR" type="xsd:unsignedInt"/>
 <part name="CountType_Wk_PEOPLEATWORK" type="xsd:unsignedInt"/>
 <part name="CountType_Rl_POSSIBLERELOCATION" type="xsd:unsignedInt"/>
 <part name="CountType_TH_TRYHARDER" type="xsd:unsignedInt"/>
 <part name="DynamicOrdering" type="xsd:boolean"/>
 <part name="OrderType1_Es_EDASEARCH" type="xsd:unsignedInt"/>
 <part name="OrderType2_Se_SKIPTRACESEARCH" type="xsd:unsignedInt"/>
 <part name="OrderType3_Ap_PROGRESSIVEADDRESSSEARCH" type="xsd:unsignedInt"/>
 <part name="OrderType4_Sp_POSSIBLESPOUSE" type="xsd:unsignedInt"/>
 <part name="OrderType4_Md_POSSIBLEPARENTS" type="xsd:unsignedInt"/>
 <part name="OrderType4_Cl_CLOSESTRELATIVE" type="xsd:unsignedInt"/>
 <part name="OrderType4_Cr_CORESIDENT" type="xsd:unsignedInt"/>
 <part name="OrderType5_Sx_EXPANDEDSKIPTRACESEARCH" type="xsd:unsignedInt"/>
 <part name="OrderType6_Pp_PHONESPLUSSEARCH" type="xsd:unsignedInt"/>
 <part name="OrderType7_UNVERIFIEDPHONE" type="xsd:unsignedInt"/>
 <part name="OrderType_Ne_CLOSESTNEIGHBOR" type="xsd:unsignedInt"/>
 <part name="OrderType_Wk_PEOPLEATWORK" type="xsd:unsignedInt"/>
 <part name="OrderType_Rl_POSSIBLERELOCATION" type="xsd:unsignedInt"/>
 <part name="OrderType_TH_TRYHARDER" type="xsd:unsignedInt"/>
 <part name="IncludeBusinessPhone" type="xsd:boolean"/>
 <part name="IncludeLandlordPhone" type="xsd:boolean"/>
 <part name="IncludeRelativeCellPhones" type="xsd:boolean"/>
 <part name="IncludeLastResort" type="xsd:boolean"/>
 <part name="IncludePhonesFeedback" type="xsd:boolean"/>
 <part name="IncludeAddressFeedback" type="xsd:boolean"/>
 <part name="UniqueIDConfidenceTreshold" type="xsd:unsignedInt"/>
 <part name="ExcludeNonCellPhonesPlusData" type="xsd:boolean"/>
 <part name="ExcludeDeadContacts" type="xsd:boolean"/>
 <part name="StrictAPSXMatch" type="xsd:boolean"/>
 <part name="DID" type="xsd:string"/>
 <part name="email" type="xsd:string"/>
 <part name="DataPermissionMask" type="xsd:string"/>
 <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
 <part name="ReturnScore" type="xsd:boolean"/>
 <part name="UseMetronet" type="xsd:boolean"/>
 <part name="Confirmation_GoToGateway" type="xsd:boolean"/>
 <part name="MetronetLimit" type="xds:integer"/>
 <part name="UsePremiumSource_A" type="xsd:boolean"/>
 <part name="PremiumSource_A_limit" type="xds:integer"/>
 <part name="Gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
 <part name="Phone_Score_Model" type="xsd:string"/>
 <part name="MaxNumAssociate" type="xsd:unsignedInt"/>
 <part name="MaxNumAssociateOther" type="xsd:unsignedInt"/>
 <part name="MaxNumFamilyOther" type="xsd:unsignedInt"/>
 <part name="MaxNumFamilyClose" type="xsd:unsignedInt"/>
 <part name="MaxNumParent" type="xsd:unsignedInt"/>
 <part name="MaxNumSpouse" type="xsd:unsignedInt"/>
 <part name="MaxNumSubject" type="xsd:unsignedInt"/>
 <part name="MaxNumNeighbor" type="xsd:unsignedInt"/>
 <part name="ContactPlusSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- This service returns progressive phones with feedback.*/

IMPORT progressive_phone, addrBest, iesp, PhonesFeedback_Services, ut, AutoHeaderV2, STD, Gateway,
       Doxie, Doxie_Raw, PersonSearch_Services, AutoStandardI, EmailService, Suppress, Royalty,
       AddressFeedback_Services, MDR, header;

EXPORT ContactPlusSearchService := MACRO
  #CONSTANT('SearchLibraryVersion', AutoHeaderV2.Constants.LibVersion.SALT);
  #CONSTANT('IncludeFraudDefenseNetwork', FALSE);
  rec_in := iesp.contactplus.t_ContactPlusSearchRequest;
  ds_in  := DATASET([], rec_in) : STORED('ContactPlusSearchRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  search_by := GLOBAL(first_row.SearchBy);
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
  iesp.ECL2ESP.SetInputName(search_by.Name);
  iesp.ECL2ESP.SetInputAddress(search_by.Address);
  #STORED('SSN', search_by.SSN);
  #STORED('Phone', search_by.Phone10);

  #STORED('DID', search_by.UniqueId);
  #STORED('EMAIL', search_by.email);
  #STORED('DedupePhones', search_by.DedupeInfo.phones);
  #STORED('ExcludeDeadContacts', ~first_row.options.IncludeDeadContacts);
  #STORED('DedupAgainstInputPhones', first_row.options.DedupeAgainstInputPhones);
  #STORED('KeepSamePhoneInDiffLevels', first_row.options.KeepSamePhoneInDiffLevels);

  #STORED('IncludePhonesFeedback', first_row.options.IncludePhonesFeedback);
  #STORED('IncludeAddressFeedback', first_row.options.IncludeAddressFeedback);
  #STORED('IncludeLastResort', first_row.options.IncludeLastResort);
  #STORED('UniqueIDConfidenceTreshold', first_row.options.UniqueIDConfidenceTreshold);
  #STORED('BlankOutDuplicatePhones', first_row.options.BlankOutDuplicatePhones);
  #STORED('MaxPhoneCount', first_row.options.MaxPhoneCount);
  #STORED('CountType1_ES_EDASEARCH', first_row.options.EDACount);
  #STORED('CountType2_SE_SKIPTRACESEARCH', first_row.options.SkipTraceCount);
  #STORED('CountType3_AP_PROGRESSIVEADDRESSSEARCH', first_row.options.ProgressiveAddressCount);
  #STORED('CountType4_SP_POSSIBLESPOUSE', first_row.options.SpouseCount);
  #STORED('CountType4_MD_POSSIBLEPARENTS', first_row.options.ParentsCount);
  #STORED('CountType4_CL_CLOSESTRELATIVE', first_row.options.ClosestRelativesCount);
  #STORED('CountType4_CR_CORESIDENT', first_row.options.CoResidentCount);
  #STORED('CountType5_SX_EXPANDEDSKIPTRACESEARCH', first_row.options.ExpandedSkipTraceCount);
  #STORED('CountType6_PP_PHONESPLUSSEARCH', first_row.options.PhonesPlusCount);
  #STORED('CountType7_UNVERIFIEDPHONE', first_row.options.UnverifiedCount);
  #STORED('CountType_NE_CLOSESTNEIGHBOR', first_row.options.ClosestNeighborCount);
  #STORED('CountType_WK_PEOPLEATWORK', first_row.options.PAWCount);
  #STORED('CountType_RL_POSSIBLERELOCATION', first_row.options.PossibleRelocationCount);
  #STORED('CountType_TH_TRYHARDER', first_row.options.TypeThTryHarderCount);
  #STORED('DynamicOrdering', first_row.options.DynamicOrdering);
  #STORED('OrderType1_ES_EDASEARCH', first_row.options.EDAOrder);
  #STORED('OrderType2_SE_SKIPTRACESEARCH', first_row.options.SkipTraceOrder);
  #STORED('OrderType3_AP_PROGRESSIVEADDRESSSEARCH', first_row.options.ProgressiveAddressOrder);
  #STORED('OrderType4_SP_POSSIBLESPOUSE', first_row.options.SpouseOrder);
  #STORED('OrderType4_MD_POSSIBLEPARENTS', first_row.options.ParentsOrder);
  #STORED('OrderType4_CL_CLOSESTRELATIVE', first_row.options.ClosestRelativesOrder);
  #STORED('OrderType4_CR_CORESIDENT', first_row.options.CoResidentOrder);
  #STORED('OrderType5_SX_EXPANDEDSKIPTRACESEARCH', first_row.options.ExpandedSkipTraceOrder);
  #STORED('OrderType6_PP_PHONESPLUSSEARCH', first_row.options.PhonesPlusOrder);
  #STORED('OrderType7_UNVERIFIEDPHONE', first_row.options.UnverifiedOrder);
  #STORED('OrderType_NE_CLOSESTNEIGHBOR', first_row.options.ClosestNeighborOrder);
  #STORED('OrderType_WK_PEOPLEATWORK', first_row.options.PAWOrder);
  #STORED('OrderType_RL_POSSIBLERELOCATION', first_row.options.PossibleRelocationOrder);
  #STORED('OrderType_TH_TRYHARDER', first_row.options.TypeThTryHarderOrder);

  #STORED('IncludeBusinessPhone', first_row.options.IncludeBusinessPhone);
  #STORED('IncludeLandlordPhone', first_row.options.IncludeLandlordPhone);

  #STORED('ExcludeNonCellPhonesPlusData', ~first_row.options.IncludeNonCellPhonesPlusData);
  #STORED('StrictAPSXMatch', first_row.options.StrictAPSXMatch);
  #STORED('ReturnScore', first_row.options.ReturnScore);

  #STORED('UsePremiumSource_A', first_row.options.UsePremiumSourceA);
  #STORED('PremiumSource_A_limit', first_row.options.PremiumSourceLimitA);

  #STORED('SkipPhoneScoring', first_row.options.SkipPhoneScoring);
  #STORED('Phone_Score_Model', first_row.options.ScoreModel);
  #STORED('IncludeHRI', TRUE);

  #STORED('MaxNumAssociate', first_row.options.MaxNumAssociate);
  #STORED('MaxNumAssociateOther', first_row.options.MaxNumAssociateOther);
  #STORED('MaxNumFamilyOther', first_row.options.MaxNumFamilyOther);
  #STORED('MaxNumFamilyClose', first_row.options.MaxNumFamilyClose);
  #STORED('MaxNumParent', first_row.options.MaxNumParent);
  #STORED('MaxNumSpouse', first_row.options.MaxNumSpouse);
  #STORED('MaxNumNeighbor', first_row.options.MaxNumNeighbor);

  vMaxNumSubject := IF(first_row.options.MaxNumSubject != 0, first_row.options.MaxNumSubject, 50);
  #STORED('MaxNumSubject', vMaxNumSubject);

  BOOLEAN IncludePhonesFeedback  := TRUE : STORED('IncludePhonesFeedback');
  BOOLEAN IncludeAddressFeedback := FALSE : STORED('IncludeAddressFeedback');
  BOOLEAN SkipPhonesScoring := FALSE : STORED('SkipPhoneScoring');
  BOOLEAN ShowPhoneScore    := FALSE : STORED('ReturnScore');

  BOOLEAN IncludeLastResort := FALSE : STORED('IncludeLastResort');
  BOOLEAN ReturnAddressesSeenInLast24Mos := first_row.options.ReturnAddressesSeenInLast24Mos;


  BOOLEAN UsePremiumSource_A := FALSE : STORED ('UsePremiumSource_A'); //equifax
  INTEGER PremiumSource_A_limit  := 0 : STORED ('PremiumSource_A_limit');

  STRING25 scoreModel := '' : STORED('Phone_Score_Model');

  UNSIGNED2 MaxNumAssociate := 0 : STORED('MaxNumAssociate');
  UNSIGNED2 MaxNumAssociateOther := 0 : STORED('MaxNumAssociateOther');
  UNSIGNED2 MaxNumFamilyOther := 0 : STORED('MaxNumFamilyOther');
  UNSIGNED2 MaxNumFamilyClose := 0 : STORED('MaxNumFamilyClose');
  UNSIGNED2 MaxNumParent := 0 : STORED('MaxNumParent');
  UNSIGNED2 MaxNumSpouse := 0 : STORED('MaxNumSpouse');
  UNSIGNED2 MaxNumSubject := vMaxNumSubject : STORED('MaxNumSubject');
  UNSIGNED2 MaxNumNeighbor := 0 : STORED('MaxNumNeighbor');


  Gateways := Gateway.Configuration.Get();

  g_mod := AutoStandardI.GlobalModule();
  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(g_mod);

  // stlf RQ-12930 - check the lines below that use this new attribute
  BOOLEAN isGLB_Ok := ut.glb_ok(g_mod.glbpurpose);

  app_type := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(g_mod, AutoStandardI.InterfaceTranslator.application_type_val.params));

  f_dedup_phones := IF(EXISTS(search_by.DedupeInfo.phones), search_by.DedupeInfo.phones, DATASET([],iesp.share.t_StringArrayItem));

  em_mod := MODULE(PROJECT(g_mod,EmailService.EmailSearch.params,OPT))
    EXPORT PenaltThreshold := g_mod.penalty_threshold;
    STRING120 email_raw0 := '' : STORED('email');
    STRING120 email_raw := IF(STD.Str.Find(email_raw0,'@',1) = 0,
                              TRIM(email_raw0) + '@', email_raw0);
    EXPORT email := TRIM(STD.Str.ToUpperCase(email_raw), ALL);
    EXPORT useGlobalScope := FALSE;
    EXPORT mult_results := FALSE;
    EXPORT STRING32 applicationType := app_type;
  END;
  
  email_dids := EmailService.EmailSearchService_IDs.val(em_mod).by_email_val;
  dids_fetched:= PROJECT(Doxie.Get_Dids(), Doxie.layout_references); // use pii to get dids
  best_pen_rec := RECORD(Doxie.layout_best)
    UNSIGNED pen;
  END;

  Doxie.mac_best_records(dids_fetched, did, ds_phone_match, ut.dppa_ok(g_mod.DPPApurpose), isGLB_Ok, FALSE, Doxie.DataRestriction.fixed_DRM)
  best_pen_rec bp_tran(ds_phone_match l) := TRANSFORM
    SELF := l;
    SELF.pen := Doxie.FN_Tra_Penalty(l.fname, l.mname, l.lname,
                                     '', (STRING)l.dob, '',
                                     '', '', '', '', '', '',
                                     l.city_name, '', l.st, l.zip,
                                     l.phone, allow_wildcard := FALSE);
  END;
  
  p_ds := PROJECT(ds_phone_match, bp_tran(LEFT));
  // if the phone number was provided and there was a name provided, then we are filtering down with hopes of getting just one did
  pii_dids := IF(COUNT(dids_fetched) > 1 AND g_mod.phone <> '' AND
                       (g_mod.lastname <> '' OR g_mod.firstName <>'') AND
                       (g_mod.addr = '' AND g_mod.ssn = '' ),
                 PROJECT(p_ds(pen < 10), Doxie.layout_references),
                 dids_fetched);

  total_dids := IF(g_mod.did <> '',
                   DATASET([{g_mod.did}], Doxie.layout_references),
                   DEDUP(pii_dids + PROJECT(email_dids, Doxie.layout_references), did, ALL));
  IF(COUNT(total_dids) > 1, FAIL(203, Doxie.ErrorCodes(203)));

  f_in_raw := PROJECT(total_dids, TRANSFORM(progressive_phone.layout_progressive_batch_in,
                                            SELF.did := LEFT.did,
                                            SELF := []));
  d := PROJECT(total_dids, Doxie.layout_references_hh);
  headerRecs := Doxie.header_records_byDID(d, TRUE, g_mod.allowwildcard, isrollup := TRUE);
  rids := DEDUP(SORT(PROJECT(headerRecs, TRANSFORM(Doxie.Layout_ref_rid, SELF := LEFT)), rid), rid);
  presRecs_ready := PROJECT(headerRecs, Doxie.layout_presentation);
  ta1_tmp := Doxie.rollup_presentation(presRecs_ready)[1].Results;
  Suppress.MAC_Suppress(ta1_tmp, ta1_tmp_pulled, g_mod.applicationtype, Suppress.Constants.LinkTypes.DID, did, '', '', FALSE, '');

  iesp.contactplus.t_ContactPlusSource tran_sources(Doxie_Raw.Occurrence.l_ref L) := TRANSFORM
    // 1.3.10 Requirement - ONLY 'Locator', 'Death' and 'Utility' sources
    // Note: This is now filtered inside progressive_phone.SourceSummary below.
    SELF.Source := L.src;
    SELF.Occurrences := L.occurrences;
    SELF.DateFirstSeen := iesp.ECL2ESP.toDate(L.dt_first_seen);
    SELF.DateLastSeen := iesp.ECL2ESP.toDate(L.dt_last_seen);
  END;

  iesp.contactplus.t_ContactPlusSourceSummary tran_source(Doxie_Raw.occurrence.l_out L) := TRANSFORM
    SELF.Name := L.datum,
    SELF.Sources := PROJECT(L.sources,tran_sources(LEFT)),
    SELF.SourceCount := COUNT(SELF.Sources);
  END;

  occurrences := progressive_phone.SourceSummary(rids, g_mod.DPPApurpose, g_mod.GLBpurpose, Gateways);
  loc_sources := CHOOSEN(PROJECT(occurrences, tran_source(LEFT)), iesp.Constants.Contact_Plus.MaxCountSources);

  iesp.contactPlus.t_ContactPlusSearchRecord trans_hfr(ta1_tmp_pulled l) := TRANSFORM
    iesp.share.t_NameWithGender tran_name(RECORDOF(l.namerecs) lna) := TRANSFORM
      SELF := iesp.ECL2ESP.setName(lna.fname, lna.mname, lna.lname, lna.name_suffix, lna.title);
      SELF.Gender := PersonSearch_Services.Functions.gender(lna.fname,lna.title);
    END;
    iesp.contactPlus.t_ContactPlusDOB tran_dob(RECORDOF(l.dobrecs) ld) := TRANSFORM
      SELF := iesp.ECL2ESP.toDate(ld.dob);
      SELF.age := ld.age;
    END;
    iesp.contactPlus.t_ContactPlusDOD tran_dod(RECORDOF(l.dodrecs) ld) := TRANSFORM
      SELF := iesp.ECL2ESP.toDate(ld.dod);
      SELF.deadage := ld.dead_age;
      SELF.deceased := ld.deceased;
      SELF.IsLimitedAccessDMF := ld.IsLimitedAccessDMF;
    END;

    iesp.contactplus.t_ContactPlusAddress tran_addr(progressive_phone.layout_addr_connect_date la) := TRANSFORM
      SELF := iesp.ECL2ESP.SetAddressEx(la.prim_name, la.prim_range, la.predir, la.postdir,
                                        la.suffix, la.unit_desig, la.sec_range, la.city_name,
                                        la.st, la.zip, la.zip4, la.county_name,
                                        HRIs := PROJECT(la.hri_address, TRANSFORM(iesp.share.t_RiskIndicator, 
                                                                                  SELF.riskcode := LEFT.hri, SELF.description := LEFT.desc)));

      SELF.dateFirstSeen := iesp.ECL2ESP.toDateYM(la.first_seen);
      SELF.dateLastSeen  := iesp.ECL2ESP.toDateYM(la.last_seen);
      SELF.UtilityConnectDate := iesp.ECL2ESP.toDate(la.connect_date);
      SELF.UtilityType := la.util_type;
      SELF.AddressFeedback.FeedbackCount := la.address_feedback[1].feedback_count;
      SELF.AddressFeedback.LastFeedbackResult := la.address_feedback[1].Last_Feedback_Result;
      SELF.AddressFeedback.LastFeedbackResultProvided := (STRING8)la.address_feedback[1].Last_Feedback_Result_Provided;
      SELF.IsCurrent  := la.tnt IN iesp.Constants.TNT_CURRENT_SET;
      SELF.LocationID := (STRING)la.Location_ID;
    END;

    SELF.names := CHOOSEN(PROJECT(l.namerecs, tran_name(LEFT)), iesp.Constants.Contact_Plus.MaxCountNameRecords);
    SELF.dobs  := CHOOSEN(PROJECT(l.dobrecs, tran_dob(LEFT)), iesp.Constants.Contact_Plus.MaxCountDobRecords);
    SELF.dods  := CHOOSEN(PROJECT(l.dodrecs, tran_dod(LEFT)), iesp.Constants.Contact_Plus.MaxCountDODRecords);
    addrsWithConnectDate := progressive_phone.UtilityConnect((UNSIGNED)l.did, l.addrrecs, isGLB_Ok);
    addrsFiltered := CHOOSEN(addrsWithConnectDate((~ReturnAddressesSeenInLast24Mos) OR ut.daysApart((STRING8)Std.Date.Today(), (STRING8)(last_seen * 100)) < ut.DaysInNYears(2)),
                             iesp.Constants.Contact_Plus.MaxCountAddressRecords);

    AddressFeedback_Services.MAC_Append_Feedback(addrsFiltered, addrsFilteredWithFeedback, Address_Feedback);

    addresses := IF(IncludeAddressFeedback, addrsFilteredWithFeedback, addrsFiltered);
    // Sort based on address hierarchy
    addresses_ranked_pre := header.MAC_Append_addr_ind(addresses, addr_ind, /*src*/, did, prim_range, prim_name, sec_range,
              city_name, st, zip, predir, postdir, suffix, first_seen, last_seen, dt_vendor_first_reported, dt_vendor_last_reported);
                            
    addresses_ranked := PROJECT(addresses_ranked_pre,
                           TRANSFORM(progressive_phone.layout_addr_connect_date,
                              SELF.tnt := doxie.enhanceTNT(TRUE, LEFT.tnt, LEFT.addr_ind, LEFT.best_addr_rank),
                              SELF.Location_ID := LEFT.locid,
                              SELF := LEFT));
                                
    SELF.addresses := PROJECT(addresses_ranked, tran_addr(LEFT));
    SELF.ssns := CHOOSEN(PROJECT(l.ssnrecs, TRANSFORM(iesp.share.t_StringArrayItem, SELF.value := LEFT.ssn)), iesp.Constants.Contact_Plus.MaxCountSSNRecords);

    SELF.alsoFound.Properties := l.prop_count;
    SELF.alsoFound.Vehicles := l.veh_cnt;
    SELF.alsoFound.ProfessionalLicenses := l.prof_count;
    SELF.alsoFound.CorporateAffiliations := l.corp_affil_count;
    SELF.alsoFound.Emails := l.email_count;
    SELF.alsoFound.Accidents := l.accident_count;
    SELF.alsoFound.DriverLicenses := l.dl_cnt;
    SELF.alsoFound.Headers := l.head_cnt;
    SELF.alsoFound.Criminals := l.crim_cnt;
    SELF.alsoFound.SexualOffenses := l.sex_cnt;
    SELF.alsoFound.ConcealedWeapons := l.ccw_cnt;
    SELF.alsoFound.Relatives := l.rel_count;
    SELF.alsoFound.Firearms := l.fire_count;
    SELF.alsoFound.FAAPilots := l.faa_count;
    SELF.alsoFound.MerchantVessels := l.vess_count;
    SELF.alsoFound.Businesses := l.bus_count;
    SELF.alsoFound.PeopleAtWork := l.paw_count;
    SELF.alsoFound.BusinessContact := l.bc_count;
    SELF.alsoFound.PropertyAssessment := l.prop_asses_count;
    SELF.alsoFound.PropertyDeeds := l.prop_deeds_count;
    SELF.alsoFound.Bankruptcies := l.bk_count;
    SELF.alsoFound.CurrentlyOwnedProperties := l.comp_prop_count;
    SELF.uniqueId := (STRING)l.did;
    SELF.sources  := loc_sources;
  END;

  contactPlus := PROJECT(ta1_tmp_pulled, trans_hfr(LEFT));

  f_out := PROJECT(UNGROUP(addrBest.Progressive_phone_common(f_in_raw,
                                , // progressive_phone.waterfall_phones_options
                                f_dedup_phones,
                                Gateways,
                                , // type_a_with_did = FALSE
                                , // useNeustar = TRUE
                                , // default_sx_match_limit = FALSE
                                , // isPFR = FALSE
                                scoreModel, // this decides if Phone_Shell is called. Send COMMON_SCORE to call the Phone_Shell (or deprecated values PHONESCORE_V2 or COLLECTIONSCORE_V3)
                                MaxNumAssociate,
                                MaxNumAssociateOther,
                                MaxNumFamilyOther,
                                MaxNumFamilyClose,
                                MaxNumParent,
                                MaxNumSpouse,
                                MaxNumSubject,
                                MaxNumNeighbor,
                                UsePremiumSource_A,
                                PremiumSource_A_limit)), progressive_phone.layout_progressive_online_out);

  // mainly to filter out results for CP_V3 to ensure that we track EQX and LR royalties on the final output only unlike metronet
  v_enum       := progressive_phone.Constants.Running_Version;
  version      := progressive_phone.HelperFunctions.FN_GetVersion(scoreModel, UsePremiumSource_A);
  tempresults1 := IF(version = v_enum.CP_V3, UNGROUP(progressive_phone.HelperFunctions.FN_FilterPerScore(f_out)), f_out);

  Royalty.MAC_RoyaltyLastResort(tempresults1, lastresort_royalties, vendor, subj_phone10);

  Royalty.RoyaltyEFXDataMart.MAC_GetWebRoyalties(tempresults1, equifax_royalties, subj_phone_type_new, MDR.sourceTools.src_EQUIFAX);

  royalties := lastresort_royalties + equifax_royalties;
  OUTPUT(royalties, NAMED('RoyaltySet'));

  PhonesFeedback_Services.Mac_Append_Feedback(tempresults1, did, subj_phone10, f_out_w_fb, mod_access);
  rslt := IF(IncludePhonesFeedback, f_out_w_fb, tempresults1);
  ut.getTimeZone(rslt, subj_phone10, timeZone, finalout);
  // If we are skipping the phone scoring model sort by sort order, else sort by the phone score returned from the model
  // Note also that if scoreModel = '', then Phone_Shell was not run. GetPhonesV1 was run instead in addrBest.Progressive_phone_common above.
  sort_rslt := MAP(scoreModel <> ''  => finalout,
                   SkipPhonesScoring => SORT(finalout, sort_order, sort_order_internal),
                                        SORT(finalout, -phone_score));

  tempresults2 := iesp.transform_progressive_phones(sort_rslt, ShowPhoneScore, scoreModel, UsePremiumSource_A);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults2, Results, iesp.contactPlus.t_ContactPlusSearchResponse, Records, FALSE, , ContactPlus, contactPlus[1]);
  // OUTPUT('WithNewPLSources');
  // OUTPUT(presRecs_ready, NAMED('presRecs_ready'));
  // OUTPUT(ta1_tmp, NAMED('ta1_tmp'));

  OUTPUT(Results, NAMED('Results'));
ENDMACRO;
// progressive_phone.ContactPlusSearchService();