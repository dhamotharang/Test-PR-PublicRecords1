IMPORT AutoKeyI, BIPV2, BIPV2_Best, Business_Risk_BIP, BusinessBatch_BIP, MDR, ut;

EXPORT Records( DATASET(BusinessBatch_BIP.Layouts.Input_Processed) ds_BatchIn,
                BusinessBatch_BIP.iParam.BatchParams               inMod
              ) :=
FUNCTION

  // Identify marketing and append mode
  marketing_mode := inMod.ExcludeMarketing;
  append_mode := (inMod.Use_Append OR marketing_mode);      // marketing mode will always use bip append

  // Passthrough records are those that supply BIP ids directly and don't require a search
  is_valid_passthrough := ds_BatchIn.seleid <> 0;

  // Verify the minimum input requirements for the marketing search
  BusinessBatch_BIP.Layouts.Input_Processed verifyInput(BusinessBatch_BIP.Layouts.Input_Processed rec) := TRANSFORM
    // minimum requirements for index search
    valid_addr := TRIM(rec.prim_name) <> '' AND TRIM(rec.city_name) <> '' AND TRIM(rec.st) <> '' AND TRIM(rec.z5) <> '';
    valid0 := IF(valid_addr, 1, 0);
    valid1 := IF(TRIM(rec.comp_name) <> '', valid0 + 1, valid0);
    valid2 := IF(TRIM(rec.fein) <> '', valid1 + 1, valid1);
    valid3 := IF(TRIM(rec.workphone) <> '', valid2 + 1, valid2);
    valid_rec := (valid3 > 1);

    SELF.error_code := IF(valid_rec, 0, AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT);
    SELF := rec;
  END;

  // split into search and passthrough records and set error_code
  ds_batchPass0 := ds_batchIn(is_valid_passthrough);
  ds_batchSearch0 := PROJECT(ds_batchIn(~is_valid_passthrough), verifyInput(LEFT));
  empty_input := dataset([], BusinessBatch_BIP.Layouts.Input_Processed);

  // minimum input requirements depend on service configuration
  use_input_err := marketing_mode;

  ds_batchSearch1 := IF(use_input_err, ds_batchSearch0(error_code = 0), ds_batchSearch0);
  ds_batchSearchErr := IF(use_input_err, ds_batchSearch0(error_code <> 0), empty_input);

  // Add the passthrough records (as they are considered valid) to the search recs
  ds_batchSearch := ds_batchSearch1 + ds_batchPass0;
  ds_batchErr := ds_batchSearchErr;

  // Get links ids for the search criteria
  // Format to BIP search layout and append layout
  BIPV2.IDfunctions.rec_SearchInput tFormat2SearchInput(BusinessBatch_BIP.Layouts.Input_Processed pInput) :=
  TRANSFORM
    SELF.company_name     := pInput.comp_name;
    SELF.city             := pInput.city_name;
    SELF.state            := pInput.st;
    SELF.zip5             := pInput.z5;
    SELF.phone10          := pInput.workphone;
    SELF.inSeleid					:= (STRING) pInput.SeleID;
    SELF.zip_radius_miles := IF ((INTEGER)pInput.mileradius > 10, 10, (INTEGER)pInput.mileradius);
    SELF.Hsort            := TRUE; // this boolean only affect the proxid level returns not SELEID level.
    SELF                  := pInput;
    SELF                  := [];
  END;

  BIPV2.IdAppendLayouts.appendInput AppendFormat(BusinessBatch_BIP.Layouts.Input_Processed pInput) := TRANSFORM
  SELF.request_id := (unsigned)pInput.acctno;
  SELF.company_name := pInput.comp_name;
  SELF.prim_range := pInput.prim_range;
  SELF.prim_name := pInput.prim_name;
  SELF.sec_range := pInput.sec_range;
  SELF.city := pInput.city_name;
  SELF.state := pInput.st;
  SELF.zip5 := pInput.z5;
  SELF.zip_radius_miles := IF ((integer)pInput.mileradius > 10, 10, (integer)pInput.mileradius);
  SELF.phone10 := pInput.workphone;   // TODO: convert to 10-digit??
  SELF.fein := pInput.fein;
  SELF.seleid := pInput.seleid;
  SELF.proxid := pInput.proxid;
  SELF := [];
END;

  ds_Format2SearchInput := PROJECT(ds_batchSearch, tFormat2SearchInput(LEFT));
  ds_Format2SearchInputAll := PROJECT(ds_batchIn, tFormat2SearchInput(LEFT));
  ds_Format2AppInput := PROJECT(ds_batchSearch, AppendFormat(LEFT));

  // begin new code *********		to emulate	top biz ranking
  tmpTopResultsScoredGrouped := BusinessBatch_BIP.Functions(inMod).getLINkidsAtProxidLevel(ds_Format2SearchInputAll);

  // get linking info through idAppend
  ds_AppIds := PROJECT(BIPV2.IdAppendRoxie(ds_Format2AppInput, inMod.Score_Threshold, reAppend := false).IdsOnly(), BIPV2.IdAppendLayouts.IdsOnly);

  // Get the seleid best information for the search criteria
  ds_BestInfoTmp := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_Format2SearchInput).SeleBest(company_name <> '');
  ds_BestInfoTmp_all := PROJECT(ds_BestInfoTmp, BusinessBatch_BIP.Layouts.ExpandedBestTmp);

  // append version
  // note - if marketing flag is set, the output should contain no marketing data
  ds_BestInfoApp_pre :=
    BusinessBatch_BIP.Functions(inMod).AppendBestSeleProx(ds_AppIds,
                                                          isMarketing := marketing_mode);

  ds_BestInfoApp_post := ds_BestInfoApp_pre(trim(company_name) <> '');
  ds_BestInfoApp_all := PROJECT(ds_BestInfoApp_post,
    TRANSFORM(BusinessBatch_BIP.Layouts.ExpandedBestTmp,
      SELF.acctno := (STRING)LEFT.request_id,
      SELF := LEFT,
      SELF := []));

  // Choose between append and search version
  ds_BestInfoTmp0 := IF(append_mode, ds_BestInfoApp_all, ds_BestInfoTmp_all);

  // JIRA RR-10621: Conditionallly remove Experian only records
  ds_BestInfoTmp1 := IF( inMod.ExcludeExperian,
                        Business_Risk_BIP.fnMac_ExcludeExperian_ChildDataset(ds_BestInfoTmp0, company_name_sources, source),
                        ds_BestInfoTmp0 );

  // Lose the results that are source = D only. The requirement is to not show ANY exclusive source = D information
  //     in the search results.
  ds_BestInfo := ds_BestInfoTmp1(count(company_name_sources) <> 1 OR company_name_sources[1].source <> MDR.sourceTools.src_Dunn_Bradstreet);

  // For appended results, we will need to get some additional information from the scored results
  ds_bestInfo2 := Join(ds_bestInfo,	tmpTopResultsScoredGrouped,
                            LEFT.acctno = RIGHT.acctno AND
                            LEFT.ultid = RIGHT.ultid AND
                            LEFT.orgid = RIGHT.orgid AND
                            LEFT.seleid = RIGHT.seleid,
                            TRANSFORM(BusinessBatch_BIP.Layouts.ExpandedBestTmp,
                                SElF.weight:= right.proxweight;
                                SELF := LEFT));

  ds_bestInfo2_app := join(ds_bestInfo, tmpTopResultsScoredGrouped,
    LEFT.acctno = RIGHT.acctno AND
    LEFT.ultid = RIGHT.ultid AND
    LEFT.orgid = RIGHT.orgid AND
    LEFT.seleid = RIGHT.seleid AND
    (LEFT.proxid = 0 OR LEFT.proxid = RIGHT.proxid),
    TRANSFORM(BusinessBatch_BIP.Layouts.ExpandedBestTmp,
        SELF.weight := RIGHT.proxweight,
        SELF.record_score := RIGHT.record_score,
        // get the parent info from the header data
        SELF.ParentAboveSELE := RIGHT.ultimate_proxid > 0 and RIGHT.sele_proxid > 0 and RIGHT.ultimate_proxid <> RIGHT.sele_proxid,
        SELF.parent_proxid := RIGHT.parent_proxid,
        SELF.sele_proxid := RIGHT.sele_proxid,
        SELF.org_proxid := RIGHT.org_proxid,
        SELF.ultimate_proxid := RIGHT.ultimate_proxid,
        //
        SELF := LEFT,
        SELF := []));

  ds_bestInfo3 := if (append_mode, ds_bestInfo2_app, ds_bestInfo2);

  // Restrict the max records for each acct# depending on user input
  ds_BestInfoRecs := UNGROUP(TOPN(GROUP(SORT(ds_bestInfo3, acctno, -weight, -record_score
                          ,record),acctno),inMod.MaxResultsPerAcct,acctno));

  // Get link ids
  ds_linkIdsWithAcctNoTmp := PROJECT(ds_BestInfoRecs,BusinessBatch_BIP.Layouts.LinkIdsWithAcctNo);
  ds_linkidsWithAcctno := SORT(DEDUP(SORT(ds_linkIdsWithAcctNoTmp,acctno, ultid, orgid, seleid, -weight,-record_score),
                                                acctno, ultid, orgid, seleid), acctno, -weight, -record_score, record);

  ds_linkIds := DEDUP(PROJECT(ds_BestInfoRecs,BIPV2.IDlayouts.l_xlink_ids),ALL);
  ds_linkIds2:= PROJECT(ds_linkIds,BIPV2.IDlayouts.l_xlink_ids2);

  // Get business header info  -- Experian records filtered in Best if needed
  ds_BestBatchRecs := BusinessBatch_BIP.Best.fullView(ds_BestInfoRecs,inMod,ds_Format2SearchInput).DS_BestParentNameAddressOUTPUT;

  // get BIP business Header metadata sic codes/naics/dba names
  ds_NameAddressBatchRecs := BusinessBatch_BIP.GetBusHeaderMetaData.fullView(ds_BestBatchRecs,inMod).ds_results;

  // Get Phones
  ds_GongPhones := BusinessBatch_BIP.Functions(inMod).GetPhones(ds_linkIdsWithAcctNo,ds_linkIds);

  // get corp linkids payloadinfo
  ds_Corps_linkidPayload := BusinessBatch_BIP.Functions(inMod).getCorpLinkids(ds_LinkIds);

  // Get corps RA and executive contact information
  ds_Corps := BusinessBatch_BIP.Functions(inMod).GetCorps(ds_linkIdsWithAcctNo,ds_Corps_linkidPayload);

  // get Bankruptcy info data
  ds_bk := BusinessBatch_BIP.Functions(inMod).GetBankruptcy(ds_linkIdsWithAcctNo,ds_linkids);

  // get liens info data
  ds_Liens :=  BusinessBatch_BIP.Functions(inMod).GetLiens(ds_linkIdsWithAcctNo,ds_linkids);

  // get ucc info data
  ds_UCCs :=  BusinessBatch_BIP.Functions(inMod).GetUCCs(ds_linkIdsWithAcctNo,ds_linkids);

  // get property data
  ds_propertys := BusinessBatch_BIP.Functions(inMod).GetProperty(ds_linkIdsWithAcctNo,ds_linkids);

  // get watchlists
  ds_watchlists := BusinessBatch_BIP.Functions(inMod).GetWatchList(ds_linkIdsWithAcctNo,ds_linkids,ds_BestBatchRecs);

  // Get flags
  ds_Flags := BusinessBatch_BIP.Functions(inMod).GetFlags(ds_linkIdsWithAcctNo,ds_linkIds);

  // Get executives  -- JIRA RR-10621 added inMod as parmeter for exclude Experian initiative
  ds_Executives := BusinessBatch_BIP.Functions(inMod).GetExecutives(ds_linkIdsWithAcctNo,ds_linkIds,inMod);

  // Get DCA info
  ds_DCAInfo := BusinessBatch_BIP.Functions(inMod).GetDCAInfo(ds_linkIdsWithAcctNo,ds_linkIds);

  // Get Diversity Cert info
  ds_DiversityCert := BusinessBatch_BIP.Functions(inMod).getDiversityCertInfo(ds_linkIdsWithAcctNo,ds_linkIds);

  // Get labor actions data
  ds_LaborActionsWHD := BusinessBatch_BIP.Functions(inMod).getLaborActionsWHDInfo(ds_linkIdsWithAcctNo,ds_linkIds);

  // Get OSHAIR data
  ds_OSHA := BusinessBatch_BIP.Functions(inMod).getOSHAInfo(ds_linkIdsWithAcctNo,ds_linkIds2);

  // Get Registered Agent Data pass in corp payload as param.
  ds_RegisteredAgents := BusinessBatch_BIP.Functions(inMod).getRegisteredAgentInfo(ds_linkIdsWithAcctNo,
                        ds_Corps_linkidPayload);

  // Merge all the results
  // Business header info
  ds_HeaderInfoAll := JOIN(ds_linkIdsWithAcctNo,ds_NameAddressBatchRecs,
                            LEFT.acctno = RIGHT.acctno AND
                            BIPV2.IDmacros.mac_JoinTop3Linkids(),
                            TRANSFORM(BusinessBatch_BIP.Layouts.FinalWithLinkIds,SELF := LEFT,SELF := RIGHT,SELF := []),
                            LEFT OUTER,
                            LIMIT(0),KEEP(1));

  // Phones
  BusinessBatch_BIP.Layouts.FinalWithLinkIds tDenormPhones(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,BusinessBatch_BIP.Layouts.Phones ri,INTEGER cnt) :=
  TRANSFORM
    SELF.phone_var1 := IF(cnt = 1,ri.phone10,le.phone_var1);
    SELF.phone_var1_first_seen := IF(cnt = 1,ut.date_YYYYMMDDtoDateSlashed((STRING)ri.dt_first_seen),le.phone_var1_first_seen);
    SELF.phone_var1_last_seen := IF(cnt = 1,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_last_seen),le.phone_var1_last_seen);
    SELF.phone_var2 := IF(cnt = 2,ri.phone10,le.phone_var2);
    SELF.phone_var2_first_seen := IF(cnt = 2,ut.date_YYYYMMDDtoDateSlashed((STRING)ri.dt_first_seen),le.phone_var2_first_seen);
    SELF.phone_var2_last_seen := IF(cnt = 2,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_last_seen),le.phone_var2_last_seen);
    SELF.phone_var3 := IF(cnt = 3,ri.phone10,le.phone_var3);
    SELF.phone_var3_first_seen := IF(cnt = 3,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_first_seen),le.phone_var3_first_seen);
    SELF.phone_var3_last_seen:= IF(cnt = 3,ut.date_YYYYMMDDtoDateSlashed((STRING)ri.dt_last_seen),le.phone_var3_last_seen);
    SELF.phone_var4 := IF(cnt = 4,ri.phone10,le.phone_var4);
    SELF.phone_var4_first_seen := IF(cnt = 4,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_first_seen),le.phone_var4_first_seen);
    SELF.phone_var4_last_seen := IF(cnt = 4,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_last_seen),le.phone_var4_last_seen);
    SELF.phone_var5 := IF(cnt = 5,ri.phone10,le.phone_var5);
    SELF.phone_var5_first_seen := IF(cnt = 5,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_first_seen),le.phone_var5_first_seen);
    SELF.phone_var5_last_seen := IF(cnt = 5,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_last_seen),le.phone_var5_last_seen);
    SELF.phone_var6 := IF(cnt = 6,ri.phone10,le.phone_var6);
    SELF.phone_var6_first_seen := IF(cnt = 6,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_first_seen),le.phone_var6_first_seen);
    SELF.phone_var6_last_seen := IF(cnt = 6,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_last_seen),le.phone_var6_last_seen);
    SELF.phone_var7 := IF(cnt = 7,ri.phone10,le.phone_var7);
    SELF.phone_var7_first_seen := IF(cnt = 7,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_first_seen),le.phone_var7_first_seen);
    SELF.phone_var7_last_seen := IF(cnt = 7,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_last_seen),le.phone_var7_last_seen);
    SELF.phone_var8 := IF(cnt = 8,ri.phone10,le.phone_var8);
    SELF.phone_var8_first_seen := IF(cnt = 8,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_first_seen),le.phone_var8_first_seen);
    SELF.phone_var8_last_seen := IF(cnt = 8,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_last_seen),le.phone_var8_last_seen);
    SELF.phone_var9 := IF(cnt = 9,ri.phone10,le.phone_var9);
    SELF.phone_var9_first_seen := IF(cnt = 9,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_first_seen),le.phone_var9_first_seen);
    SELF.phone_var9_last_seen := IF(cnt = 9,ut.date_YYYYMMDDtoDateSlashed((STRING) ri.dt_last_seen),le.phone_var9_last_seen);
    SELF.Total_phones := 0; // set in a future project

    SELF            := le;
  END;
  // add in logic to eliminate duplicate phones in the output
  // left only join from gongPhones to DS containing bestInfo
  //
  ds_GongPhoneSlim := SORT(
                          JOIN(ds_GongPhones,  ds_headerInfoAll,
                              LEFT.acctno = RIGHT.acctno AND
                              BIPV2.IDmacros.mac_JoinTop3Linkids() AND
                              LEFT.phone10 = RIGHT.Best_phone,
                              TRANSFORM(LEFT), LEFT ONLY),
                          acctno, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids())
                          );

  ds_Phones2FinalTmp := DENORMALIZE( ds_HeaderInfoAll,ds_GongPhoneSlim,
                                  LEFT.acctno = RIGHT.acctno AND
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                  tDenormPhones(LEFT,RIGHT,COUNTER),
                                  LEFT OUTER);

  ds_Phones2Final := Project(ds_Phones2FinalTmp, TRANSFORM(RECORDOF(LEFT),
                            SELF.Total_phones :=
                                if (LEFT.Phone_var1 <> '', 1, 0) +
                                if (LEFT.phone_var2 <> '', 1, 0) +
                                if (LEFT.phone_var3 <> '', 1, 0) +
                                if (LEFT.phone_var4 <> '', 1, 0) +
                                if (LEFT.phone_var5 <> '', 1, 0) +
                                if (LEFT.phone_var6 <> '', 1, 0) +
                                if (LEFT.phone_var7 <> '', 1, 0) +
                                if (LEFT.phone_var8 <> '', 1, 0) +
                                if (LEFT.phone_var9 <> '', 1, 0) +
                                if (LEFT.best_phone <> '', 1, 0);
                            SELF := LEFT;
                            ));

  // Corps
  BusinessBatch_BIP.Layouts.FinalWithLinkIds tCorps2Final(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,
                                                          BusinessBatch_BIP.Layouts.Corps ri,
                                                          INTEGER cnt) :=
  TRANSFORM
    SELF.ra_title       := ri.corp_ra_title1;
    SELF.ra_fname       := ri.corp_ra_fname1;
    SELF.ra_mname       := ri.corp_ra_mname1;
    SELF.ra_lname       := ri.corp_ra_lname1;
    SELF.ra_name_suffix := ri.corp_ra_name_suffix1;
    SELF.ra_cname       := ri.corp_ra_cname1;
    SELF.ra_phone       := ri.corp_ra_phone10;

    SELF.foreign_domestic_status := IF (ri.corp_foreign_domestic_ind = 'F', 'Foreign',
                                        IF (ri.corp_foreign_domestic_ind = 'D', 'Domestic',''));

    SELF.state_of_origin          := ri.corp_state_origin;
    SELF.profit                   := IF (ri.corp_for_profit_ind = 'Y', 'Yes',
                                        IF (ri.corp_for_profit_ind = 'N', 'No',''));
    SELF.corp_filing_jurisdiction :=  ri.corp_state_origin;
    Corp_expiration_date     := case (ri.corp_foreign_domestic_ind,
                                          'D' => ri.corp_term_exist_exp,
                                          'F' => ri.corp_forgn_term_exist_exp,
                                          '');
    self.corp_status_desc := ri.corp_status_desc;
    // not a new field just getting it from corp data not from best key.
    self.Business_type := ri.corp_filing_desc;
    SELF.Corp_filing_date := ri.Corp_filing_date;
    // ****** from TopBusiness_Services.IncorporationSection
    // Examine 3 fields to know know what to store in the existence/expiration fields
        // If regular ones are non-blank use them, otherwise use the foreign/corp_forgn ones.
        // Fields from the corp linkids key to use:
        // string1  corp_foreign_domestic_ind;
        // string8  corp_term_exist_cd;   //i.e. blank, D, P or N
        // string8	corp_term_exist_exp;  //i.e. an expiration_date(yyyymmdd), "P" or the # of years or ???
        // string60 corp_term_exist_desc; //i.e. the word "DATE OF EXPIRATION", "PERPETUAL", "nn YEARS", "INDEFINITE", etc.
        // string8	corp_forgn_term_exist_cd;  //same possible values as above
        // string8	corp_forgn_term_exist_exp;
        // string60 corp_forgn_term_exist_desc;
        //self.expiration_date := if(left.corp_term_exist_cd[1]  = 'P' or //blank, "D" or "P" ???
        //                           // corp_term_exist_exp sometimes blank, so check both ???
        //                           left.corp_term_exist_exp[1] = 'P',   //"P" or actual exp date(in yyyymmdd)???
        //                           left.corp_term_exist_desc,left.corp_term_exist_exp),
        UseForeign := ri.corp_forgn_term_exist_cd !='' or
                      ri.corp_forgn_term_exist_exp !='' or
                      ri.corp_forgn_term_exist_desc != '';
        tmpExistence_desc       := if (useForeign,ri.corp_forgn_term_exist_desc,ri.corp_term_exist_desc);

    SELF.Corp_expiration_date :=  if (tmpExistence_desc = 'DATE OF EXPIRATION',
                      ut.date_YYYYMMDDtoDateSlashed(corp_expiration_date),'');
    SELF.Corp_filing_type :=  ri.corp_filing_desc;

    SELF.corp_var1 := IF(cnt = 1,ri.Corp_sos_charter_nbr,le.corp_var1);
    SELF.Corp_var1_first_seen  := IF(cnt = 1,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_first_seen)),
                                                          le.corp_var1_first_seen);
    SELF.Corp_var1_last_seen :=  IF(cnt = 1,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_last_seen)),
                                                          le.Corp_var1_last_seen);
    SELF.corp_var1_state_origin := IF(cnt = 1,ri.corp_state_origin,le.corp_var1_state_origin);
      SELF.corp_var1_legal_name := IF(cnt = 1, ri.corp_legal_name, le.corp_var1_legal_name);

    SELF.corp_var2 := IF(cnt = 2,ri.Corp_sos_charter_nbr,le.corp_var2);
    SELF.Corp_var2_first_seen  := IF(cnt = 2,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_first_seen)),
                                                          le.corp_var2_first_seen);
    SELF.Corp_var2_last_seen :=  IF(cnt = 2,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_last_seen)),
                                                          le.Corp_var2_last_seen);
    SELF.corp_var2_state_origin := IF(cnt = 2,ri.corp_state_origin,le.corp_var2_state_origin);
        SELF.corp_var2_legal_name := IF(cnt = 2, ri.corp_legal_name, le.corp_var2_legal_name);

    SELF.corp_var3 := IF(cnt = 3,ri.Corp_sos_charter_nbr,le.corp_var3);
    SELF.Corp_var3_first_seen  := IF(cnt = 3,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_first_seen)),
                                                          le.corp_var3_first_seen);
    SELF.Corp_var3_last_seen :=  IF(cnt = 3,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_last_seen)),
                                                          le.Corp_var3_last_seen);
    SELF.corp_var3_state_origin := IF(cnt = 3,ri.corp_state_origin,le.corp_var3_state_origin);
  SELF.corp_var3_legal_name := IF(cnt = 3, ri.corp_legal_name, le.corp_var3_legal_name);

    SELF.corp_var4 := IF(cnt = 4,ri.Corp_sos_charter_nbr,le.corp_var4);
    SELF.Corp_var4_first_seen  := IF(cnt = 4,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_first_seen)),
                                                          le.corp_var4_first_seen);
    SELF.Corp_var4_last_seen :=  IF(cnt = 4,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_last_seen)),
                                                          le.Corp_var4_last_seen);
    SELF.corp_var4_state_origin := IF(cnt = 4,ri.corp_state_origin,le.corp_var4_state_origin);
    SELF.corp_var4_legal_name := IF(cnt = 4, ri.corp_legal_name, le.corp_var4_legal_name);

    SELF.corp_var5 := IF(cnt = 5,ri.Corp_sos_charter_nbr,le.corp_var5);
    SELF.Corp_var5_first_seen  := IF(cnt = 5,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_first_seen)),
                                                          le.corp_var5_first_seen);
    SELF.Corp_var5_last_seen :=  IF(cnt = 5,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_last_seen)),
                                                          le.Corp_var5_last_seen);
    SELF.corp_var5_state_origin := IF(cnt = 5,ri.corp_state_origin,le.corp_var5_state_origin);
      SELF.corp_var5_legal_name := IF(cnt = 5, ri.corp_legal_name, le.corp_var5_legal_name);

    SELF.corp_var6 := IF(cnt = 6,ri.Corp_sos_charter_nbr,le.corp_var6);
    SELF.Corp_var6_first_seen  := IF(cnt = 6,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_first_seen)),
                                                          le.corp_var6_first_seen);
    SELF.Corp_var6_last_seen :=  IF(cnt = 6,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_last_seen)),
                                                          le.Corp_var6_last_seen);
  SELF.corp_var6_state_origin := IF(cnt = 6,ri.corp_state_origin,le.corp_var6_state_origin);
  SELF.corp_var6_legal_name := IF(cnt = 6, ri.corp_legal_name, le.corp_var6_legal_name);

  SELF.corp_var7 := IF(cnt = 7,ri.Corp_sos_charter_nbr,le.corp_var7);
    SELF.Corp_var7_first_seen  := IF(cnt = 7,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_first_seen)),
                                                          le.corp_var7_first_seen);
    SELF.Corp_var7_last_seen :=  IF(cnt = 7,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_last_seen)),
                                                          le.Corp_var7_last_seen);
    SELF.corp_var7_state_origin := IF(cnt = 7,ri.corp_state_origin,le.corp_var7_state_origin);
    SELF.corp_var7_legal_name := IF(cnt = 7, ri.corp_legal_name, le.corp_var7_legal_name);

    SELF.corp_var8 := IF(cnt = 8,ri.Corp_sos_charter_nbr,le.corp_var8);
    SELF.Corp_var8_first_seen  := IF(cnt = 8,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_first_seen)),
                                                          le.corp_var8_first_seen);
    SELF.Corp_var8_last_seen :=  IF(cnt = 8,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_last_seen)),
                                                          le.Corp_var8_last_seen);
    SELF.corp_var8_state_origin := IF(cnt = 8,ri.corp_state_origin,le.corp_var8_state_origin);
    SELF.corp_var8_legal_name := IF(cnt = 8, ri.corp_legal_name, le.corp_var8_legal_name);

    SELF.corp_var9 := IF(cnt = 9,ri.Corp_sos_charter_nbr,le.corp_var9);
    SELF.Corp_var9_first_seen  := IF(cnt = 9,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_first_seen)),
                                                          le.corp_var9_first_seen);
    SELF.Corp_var9_last_seen :=  IF(cnt = 9,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_last_seen)),
                                                          le.Corp_var9_last_seen);
    SELF.corp_var9_state_origin := IF(cnt = 9,ri.corp_state_origin,le.corp_var9_state_origin);
    SELF.corp_var9_legal_name := IF(cnt = 9, ri.corp_legal_name, le.corp_var9_legal_name);

    SELF.corp_var10 := IF(cnt = 10,ri.Corp_sos_charter_nbr,le.corp_var10);
    SELF.Corp_var10_first_seen  := IF(cnt = 10,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_first_seen)),
                                                          le.corp_var10_first_seen);
    SELF.Corp_var10_last_seen :=  IF(cnt = 10,ut.date_YYYYMMDDtoDateSlashed((string)(ri.dt_last_seen)),
                                                          le.Corp_var10_last_seen);
    SELF.corp_var10_state_origin := IF(cnt = 10,ri.corp_state_origin,le.corp_var10_state_origin);
      SELF.corp_var10_legal_name := IF(cnt = 10, ri.corp_legal_name, le.corp_var10_legal_name);

    SELF.total_corp := 0;

    SELF := le;
  END;

  ds_Corps2FinalTmp := DENORMALIZE(ds_Phones2Final,ds_Corps,
                          LEFT.acctno = RIGHT.acctno AND
                          BIPV2.IDmacros.mac_JoinTop3Linkids(),
                          tCorps2Final(LEFT,RIGHT,COUNTER),
                          LEFT OUTER);


  ds_Corps2Final := PROJECT(ds_Corps2FinalTmp, TRANSFORM(RECORDOF(LEFT),

                            SELF.Total_Corp :=
                                if (LEFT.corp_var1 <> '', 1, 0) +
                                if (LEFT.corp_var2 <> '', 1, 0) +
                                if (LEFT.corp_var3 <> '', 1, 0) +
                                if (LEFT.corp_var4 <> '', 1, 0) +
                                if (LEFT.corp_var5 <> '', 1, 0) +
                                if (LEFT.corp_var6 <> '', 1, 0) +
                                if (LEFT.corp_var7 <> '', 1, 0) +
                                if (LEFT.corp_var8 <> '', 1, 0) +
                                if (LEFT.corp_var9 <> '', 1, 0) +
                                if (LEFT.corp_var10 <> '', 1, 0);
                            SELF := LEFT;
                            ));

  // Flags
  BusinessBatch_BIP.Layouts.FinalWithLinkIds tFlags2Final(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,BusinessBatch_BIP.Layouts.Flags ri) :=
  TRANSFORM
    SELF.judgmentlien_flag := ri.judgmentlien_flag;
    SELF.property_flag     := ri.property_flag;
    SELF.ucc_flag          := ri.ucc_flag;
    SELF.Vehicles          := ri.vehicles;
    SELF.WaterCraft        := ri.Watercraft;
    SELF.Aircraft          := ri.Aircraft;
    SELF                   := le;
  END;

  ds_Flags2Final := JOIN( ds_Corps2Final,ds_Flags,
                          LEFT.acctno = RIGHT.acctno AND
                          BIPV2.IDmacros.mac_JoinTop3Linkids(),
                          tFlags2Final(LEFT,RIGHT),
                          LEFT OUTER,
                          LIMIT(0),KEEP(1));

  BusinessBatch_BIP.Layouts.FinalWithLinkIds tBkInfo2Final(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,
                                                            BusinessBatch_BIP.Layouts.BankruptcyInfo ri) :=
  TRANSFORM
    SELF.Bankruptcy_date_filed := ut.date_YYYYMMDDtoDateSlashed(ri.bankruptcy_date_filed);
    SELF.total_bankruptcies   := ri.Total_bankruptcies;
    SELF                      := le;
  END;

  ds_BKInfoFinal := JOIN(ds_Flags2Final, ds_bk,
                      LEFT.acctno = RIGHT.acctno AND
                      BIPV2.IDmacros.mac_JoinTop3Linkids(),
                      tBkInfo2Final(LEFT,RIGHT),
                      LEFT OUTER,
                      LIMIT(0),KEEP(1));

  BusinessBatch_BIP.Layouts.FinalWithLinkIds tLienInfo2Final(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,
                                                              BusinessBatch_BIP.Layouts.LienInfo ri) :=
  TRANSFORM

    SELF.total_judgments_and_liens   := ri.Total_judgments_and_liens;
    SELF.Judgments_liens_satisfied := ri.judgments_Liens_satisfied;
    SELF.Judgment_Liens_date_filed := ut.date_YYYYMMDDtoDateSlashed(ri.Judgment_Liens_date_filed);
    SELF                      := le;
  END;

  ds_LienInfoFinal := JOIN(ds_BKInfoFinal, ds_Liens,
                      LEFT.acctno = RIGHT.acctno AND
                      BIPV2.IDmacros.mac_JoinTop3Linkids(),
                      tLienInfo2Final(LEFT,RIGHT),
                      LEFT OUTER,
                      LIMIT(0),KEEP(1));

  BusinessBatch_BIP.Layouts.FinalWithLinkIds tUCCInfo2Final(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,
                                                            BusinessBatch_BIP.Layouts.UccInfoLayout ri) :=
  TRANSFORM

    SELF.ucc_date_filed       := ut.date_YYYYMMDDtoDateSlashed(ri.ucc_date_filed);
    SELF.total_ucc            := ri.total_ucc;
    SELF.total_UCC_released   := ri.total_ucc_released;
    SELF                      := le;
  END;

  ds_UCCInfoFinal := JOIN(ds_LienInfoFinal, ds_UCCs,
                      LEFT.acctno = RIGHT.acctno AND
                      BIPV2.IDmacros.mac_JoinTop3Linkids(),
                      tUccInfo2Final(LEFT,RIGHT),
                      LEFT OUTER,
                      LIMIT(0),KEEP(1));

    BusinessBatch_BIP.Layouts.FinalWithLinkIds tPropertyInfo2Final(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,
                                                            BusinessBatch_BIP.Layouts.PropertyInfo ri) :=
  TRANSFORM

    SELF.property_owned_size  := (unsigned4) ri.Sproperty_owned_size;
    SELF.Property_owned       := ri.property_owned;
    SELF                      := le;
    SELF                      := [];
  END;

  ds_PropertyInfoFinal := JOIN(ds_UCCInfoFinal, ds_propertys,
                      LEFT.acctno = RIGHT.acctno AND
                      BIPV2.IDmacros.mac_JoinTop3Linkids(),
                      tPropertyInfo2Final(LEFT,RIGHT),
                      LEFT OUTER,
                      LIMIT(0),KEEP(1));

    BusinessBatch_BIP.Layouts.FinalWithLinkIds tWatchListInfo2Final(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,
                                                            BusinessBatch_BIP.Layouts.WatchListInfo ri) :=
  TRANSFORM
    SELF                      := ri;
    SELF                      := le;
    SELF                      := [];
  END;

  ds_WatchListInfoFinal := JOIN(ds_PropertyInfoFinal, ds_Watchlists,
                      LEFT.acctno = RIGHT.acctno AND
                      BIPV2.IDmacros.mac_JoinTop3Linkids(),
                      tWatchListInfo2Final(LEFT,RIGHT),
                      LEFT OUTER,
                      LIMIT(0),KEEP(1));

  // Executives
  BusinessBatch_BIP.Layouts.FinalWithLinkIds tExecs2Final(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,BusinessBatch_BIP.Layouts.Executives ri,INTEGER cnt) :=
  TRANSFORM
  SELF.executive_var1_lexid         := IF(cnt = 1,ri.contact_did,le.executive_var1_lexid);
    SELF.executive_title_var1         := IF(cnt = 1,ri.title,le.executive_title_var1);
    SELF.executive_fname_var1         := IF(cnt = 1,ri.fname,le.executive_fname_var1);
    SELF.executive_mname_var1         := IF(cnt = 1,ri.mname,le.executive_mname_var1);
    SELF.executive_lname_var1         := IF(cnt = 1,ri.lname,le.executive_lname_var1);
    SELF.executive_name_suffix_var1   := IF(cnt = 1,ri.name_suffix,le.executive_name_suffix_var1);
    SELF.executive_display_title_var1 := IF(cnt = 1,ri.contact_job_title_derived,le.executive_display_title_var1);
    SELF.executive_var1_first_seen := IF(cnt = 1,ut.date_YYYYMMDDtoDateSlashed(ri.dt_first_seen_contact),le.executive_var1_first_seen);
    SELF.executive_var1_last_seen := IF(cnt = 1,ut.date_YYYYMMDDtoDateSlashed(ri.dt_last_seen_contact),le.executive_var1_last_seen);

    SELF.executive_var2_lexid         := IF(cnt = 2,ri.contact_did,le.executive_var2_lexid);
    SELF.executive_title_var2         := IF(cnt = 2,ri.title,le.executive_title_var2);
    SELF.executive_fname_var2         := IF(cnt = 2,ri.fname,le.executive_fname_var2);
    SELF.executive_mname_var2         := IF(cnt = 2,ri.mname,le.executive_mname_var2);
    SELF.executive_lname_var2         := IF(cnt = 2,ri.lname,le.executive_lname_var2);
    SELF.executive_name_suffix_var2   := IF(cnt = 2,ri.name_suffix,le.executive_name_suffix_var2);
    SELF.executive_display_title_var2 := IF(cnt = 2,ri.contact_job_title_derived,le.executive_display_title_var2);
    SELF.executive_var2_first_seen := IF(cnt = 2,ut.date_YYYYMMDDtoDateSlashed(ri.dt_first_seen_contact),le.executive_var2_first_seen);
    SELF.executive_var2_last_seen := IF(cnt = 2,ut.date_YYYYMMDDtoDateSlashed(ri.dt_last_seen_contact),le.executive_var2_last_seen);

    SELF.executive_var3_lexid         := IF(cnt = 3,ri.contact_did,le.executive_var3_lexid);
    SELF.executive_title_var3         := IF(cnt = 3,ri.title,le.executive_title_var3);
    SELF.executive_fname_var3         := IF(cnt = 3,ri.fname,le.executive_fname_var3);
    SELF.executive_mname_var3         := IF(cnt = 3,ri.mname,le.executive_mname_var3);
    SELF.executive_lname_var3         := IF(cnt = 3,ri.lname,le.executive_lname_var3);
    SELF.executive_name_suffix_var3   := IF(cnt = 3,ri.name_suffix,le.executive_name_suffix_var3);
    SELF.executive_display_title_var3 := IF(cnt = 3,ri.contact_job_title_derived,le.executive_display_title_var3);
    SELF.executive_var3_first_seen := IF(cnt = 3,ut.date_YYYYMMDDtoDateSlashed(ri.dt_first_seen_contact),le.executive_var3_first_seen);
    SELF.executive_var3_last_seen := IF(cnt = 3,ut.date_YYYYMMDDtoDateSlashed(ri.dt_last_seen_contact),le.executive_var3_last_seen);


    SELF.executive_var4_lexid         := IF(cnt = 4,ri.contact_did,le.executive_var4_lexid);
          SELF.executive_title_var4         := IF(cnt = 4,ri.title,le.executive_title_var4);
    SELF.executive_fname_var4         := IF(cnt = 4,ri.fname,le.executive_fname_var4);
    SELF.executive_mname_var4         := IF(cnt = 4,ri.mname,le.executive_mname_var4);
    SELF.executive_lname_var4         := IF(cnt = 4,ri.lname,le.executive_lname_var4);
    SELF.executive_name_suffix_var4   := IF(cnt = 4,ri.name_suffix,le.executive_name_suffix_var4);
    SELF.executive_display_title_var4 := IF(cnt = 4,ri.contact_job_title_derived,le.executive_display_title_var4);
          SELF.executive_var4_first_seen := IF(cnt = 4,ut.date_YYYYMMDDtoDateSlashed(ri.dt_first_seen_contact),le.executive_var4_first_seen);
    SELF.executive_var4_last_seen := IF(cnt = 4,ut.date_YYYYMMDDtoDateSlashed(ri.dt_last_seen_contact),le.executive_var4_last_seen);

    SELF.executive_var5_lexid         := IF(cnt = 5,ri.contact_did,le.executive_var5_lexid);
          SELF.executive_title_var5         := IF(cnt = 5,ri.title,le.executive_title_var5);
    SELF.executive_fname_var5         := IF(cnt = 5,ri.fname,le.executive_fname_var5);
    SELF.executive_mname_var5         := IF(cnt = 5,ri.mname,le.executive_mname_var5);
    SELF.executive_lname_var5         := IF(cnt = 5,ri.lname,le.executive_lname_var5);
    SELF.executive_name_suffix_var5   := IF(cnt = 5,ri.name_suffix,le.executive_name_suffix_var5);
    SELF.executive_display_title_var5 := IF(cnt = 5,ri.contact_job_title_derived,le.executive_display_title_var5);
          SELF.executive_var5_first_seen := IF(cnt = 5,ut.date_YYYYMMDDtoDateSlashed(ri.dt_first_seen_contact),le.executive_var5_first_seen);
    SELF.executive_var5_last_seen := IF(cnt = 5,ut.date_YYYYMMDDtoDateSlashed(ri.dt_last_seen_contact),le.executive_var5_last_seen);

      SELF.executive_var6_lexid         := IF(cnt = 6,ri.contact_did,le.executive_var6_lexid);
          SELF.executive_title_var6         := IF(cnt = 6,ri.title,le.executive_title_var6);
    SELF.executive_fname_var6         := IF(cnt = 6,ri.fname,le.executive_fname_var6);
    SELF.executive_mname_var6         := IF(cnt = 6,ri.mname,le.executive_mname_var6);
    SELF.executive_lname_var6         := IF(cnt = 6,ri.lname,le.executive_lname_var6);
    SELF.executive_name_suffix_var6   := IF(cnt = 6,ri.name_suffix,le.executive_name_suffix_var6);
    SELF.executive_display_title_var6 := IF(cnt = 6,ri.contact_job_title_derived,le.executive_display_title_var6);
    SELF.executive_var6_first_seen := IF(cnt = 6,ut.date_YYYYMMDDtoDateSlashed(ri.dt_first_seen_contact),le.executive_var6_first_seen);
    SELF.executive_var6_last_seen := IF(cnt = 6,ut.date_YYYYMMDDtoDateSlashed(ri.dt_last_seen_contact),le.executive_var6_last_seen);


    SELF.executive_var7_lexid         := IF(cnt = 7,ri.contact_did,le.executive_var7_lexid);
          SELF.executive_title_var7         := IF(cnt = 7,ri.title,le.executive_title_var7);
    SELF.executive_fname_var7         := IF(cnt = 7,ri.fname,le.executive_fname_var7);
    SELF.executive_mname_var7         := IF(cnt = 7,ri.mname,le.executive_mname_var7);
    SELF.executive_lname_var7         := IF(cnt = 7,ri.lname,le.executive_lname_var7);
    SELF.executive_name_suffix_var7   := IF(cnt = 7,ri.name_suffix,le.executive_name_suffix_var7);
    SELF.executive_display_title_var7 := IF(cnt = 7,ri.contact_job_title_derived,le.executive_display_title_var7);
          SELF.executive_var7_first_seen := IF(cnt = 7,ut.date_YYYYMMDDtoDateSlashed(ri.dt_first_seen_contact),le.executive_var7_first_seen);
    SELF.executive_var7_last_seen := IF(cnt = 7,ut.date_YYYYMMDDtoDateSlashed(ri.dt_last_seen_contact),le.executive_var7_last_seen);

    SELF.executive_var8_lexid         := IF(cnt = 8,ri.contact_did,le.executive_var8_lexid);
          SELF.executive_title_var8         := IF(cnt = 8,ri.title,le.executive_title_var8);
    SELF.executive_fname_var8         := IF(cnt = 8,ri.fname,le.executive_fname_var8);
    SELF.executive_mname_var8         := IF(cnt = 8,ri.mname,le.executive_mname_var8);
    SELF.executive_lname_var8         := IF(cnt = 8,ri.lname,le.executive_lname_var8);
    SELF.executive_name_suffix_var8   := IF(cnt = 8,ri.name_suffix,le.executive_name_suffix_var8);
    SELF.executive_display_title_var8 := IF(cnt = 8,ri.contact_job_title_derived,le.executive_display_title_var8);
          SELF.executive_var8_first_seen := IF(cnt = 8,ut.date_YYYYMMDDtoDateSlashed(ri.dt_first_seen_contact),le.executive_var8_first_seen);
    SELF.executive_var8_last_seen := IF(cnt = 8,ut.date_YYYYMMDDtoDateSlashed(ri.dt_last_seen_contact),le.executive_var8_last_seen);

    SELF.executive_var9_lexid         := IF(cnt = 9,ri.contact_did,le.executive_var9_lexid);
        SELF.executive_title_var9         := IF(cnt = 9,ri.title,le.executive_title_var9);
    SELF.executive_fname_var9         := IF(cnt = 9,ri.fname,le.executive_fname_var9);
    SELF.executive_mname_var9         := IF(cnt = 9,ri.mname,le.executive_mname_var9);
    SELF.executive_lname_var9         := IF(cnt = 9,ri.lname,le.executive_lname_var9);
    SELF.executive_name_suffix_var9   := IF(cnt = 9,ri.name_suffix,le.executive_name_suffix_var9);
    SELF.executive_display_title_var9 := IF(cnt = 9,ri.contact_job_title_derived,le.executive_display_title_var9);
    SELF.executive_var9_first_seen := IF(cnt = 9,ut.date_YYYYMMDDtoDateSlashed(ri.dt_first_seen_contact),le.executive_var9_first_seen);
    SELF.executive_var9_last_seen := IF(cnt = 9,ut.date_YYYYMMDDtoDateSlashed(ri.dt_last_seen_contact),le.executive_var9_last_seen);

    SELF                              := le;
  END;

  ds_Execs2Final := DENORMALIZE(ds_WatchListInfoFinal,
                                ds_Executives,
                                LEFT.acctno = RIGHT.acctno AND
                                BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                tExecs2Final(LEFT,RIGHT,COUNTER),
                                LEFT OUTER);

    // Get Diversity Cert info

  ds_DivCertInfoFinal := JOIN(ds_Execs2Final, ds_DiversityCert,
                      LEFT.acctno = RIGHT.acctno AND
                      BIPV2.IDmacros.mac_JoinTop3Linkids(),
                      TRANSFORM(BusinessBatch_BIP.Layouts.FinalWithLinkIds,

                        SELF.div_dt_first_seen := RIGHT.div_dt_first_seen;
                        SELF.div_dt_last_seen := RIGHT.div_dt_last_seen;
                                  SELF.div_state := RIGHT.div_state;
                                  SELF.div_minorityAffiliation := RIGHT.div_minorityAffiliation;
                                  SELF.div_certificationtype1 := RIGHT.div_certificationtype1;
                                  SELF.div_certificatedatefrom1 := RIGHT.div_certificatedatefrom1;
                                  SELF.div_certificatedateto1  := RIGHT.div_certificatedateto1;
                                  SELF.div_certificatestatus1   := RIGHT.div_certificatestatus1;
                                  SELF.div_certificatenumber1   := RIGHT.div_certificatenumber1;

                                  SELF.div_certificationtype2 := RIGHT.div_certificationtype2;
                                  SELF.div_certificatedatefrom2 := RIGHT.div_certificatedatefrom2;
                                  SELF.div_certificatedateto2  := RIGHT.div_certificatedateto2;
                                  SELF.div_certificatestatus2   := RIGHT.div_certificatestatus2;
                                  SELF.div_certificatenumber2   := RIGHT.div_certificatenumber2;

                                  SELF.div_certificationtype3 := RIGHT.div_certificationtype3;
                                  SELF.div_certificatedatefrom3 := RIGHT.div_certificatedatefrom3;
                                  SELF.div_certificatedateto3  := RIGHT.div_certificatedateto3;
                                  SELF.div_certificatestatus3   := RIGHT.div_certificatestatus3;
                                  SELF.div_certificatenumber3   := RIGHT.div_certificatenumber3;

                                  SELF.div_certificationtype4 := RIGHT.div_certificationtype4;
                                  SELF.div_certificatedatefrom4 := RIGHT.div_certificatedatefrom4;
                                  SELF.div_certificatedateto4  := RIGHT.div_certificatedateto4;
                                  SELF.div_certificatestatus4   := RIGHT.div_certificatestatus4;
                                  SELF.div_certificatenumber4   := RIGHT.div_certificatenumber4;

                      SELF := LEFT),
                      LEFT OUTER,LIMIT(0),KEEP(1));

  ds_LaborActionsWHDFinal := JOIN(ds_DivCertInfoFinal,
                                    ds_LaborActionsWHD,
                      LEFT.acctno = RIGHT.acctno AND
                      BIPV2.IDmacros.mac_JoinTop3Linkids(),
                      TRANSFORM(BusinessBatch_BIP.Layouts.FinalWithLinkIds,
                          SELF.laborActionViolations := RIGHT.laborActionViolations;
                          SELF.laborActionBackWages := RIGHT.laborActionBackWages;
                          SELF.laborActionMoneyPenalties := RIGHT.laborActionMoneyPenalties;
                      SELF := LEFT),
                      LEFT OUTER, LIMIT(0), KEEP(1));


  ds_OSHAFinal := JOIN(ds_LaborActionsWHDFinal, DS_OSHA,
                      LEFT.acctno = RIGHT.acctno AND
                      BIPV2.IDmacros.mac_JoinTop3Linkids(),
                      TRANSFORM(BusinessBatch_BIP.Layouts.FinalWithLinkIds,
                      SELF.OshaViolations := RIGHT.OshaViolations;
                      SELF.Total_Inspections := RIGHT.Total_Inspections;
                      SELF := LEFT),
                      LEFT OUTER, LIMIT(0), KEEP(1));

  // Registered Agents
  BusinessBatch_BIP.Layouts.FinalWithLinkIds tRegisteredAgents2Final(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,BusinessBatch_BIP.Layouts.RegisteredAgentInfo ri,INTEGER cnt) :=
  TRANSFORM

    SELF.RA_title_var1                    := IF(cnt = 1,ri.RA_title,le.executive_title_var1);
    SELF.RA_fname_var1                    := IF(cnt = 1,ri.RA_fname,le.executive_fname_var1);
    SELF.RA_mname_var1                    := IF(cnt = 1,ri.RA_mname,le.executive_mname_var1);
    SELF.RA_lname_var1                    := IF(cnt = 1,ri.RA_lname,le.executive_lname_var1);
    SELF.RA_name_suffix_var1              := IF(cnt = 1,ri.RA_name_suffix,le.executive_name_suffix_var1);
    //SELF.position_title;
    SELF.RA_dt_first_seen_var1            := IF(cnt = 1,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_first_seen),le.RA_dt_first_seen_var1);
    SELF.RA_dt_last_seen_var1             := IF(cnt = 1,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_last_seen),le.RA_dt_last_seen_var1);
    SELF.RA_CompanyName_var1   := IF(cnt = 1,ri.RA_companyName,le.RA_companyName_var1);

    SELF.RA_prim_range_var1    := if (cnt = 1, ri.RA_prim_range, le.RA_prim_range_var1);
    SELF.RA_prim_name_var1     := if (cnt = 1, ri.RA_prim_name, le.RA_prim_name_var1);
    SELF.RA_predir_var1        := if (cnt = 1, ri.RA_predir, le.RA_predir_var1);
    SELF.RA_postdir_var1       := if (cnt = 1, ri.RA_postdir, le.RA_postdir_var1);
    SELF.RA_sec_range_var1     := if (cnt = 1, ri.RA_sec_range, le.RA_sec_range_var1);
    SELF.RA_unit_desig_var1    := if (cnt = 1, ri.RA_unit_desig, le.RA_unit_desig_var1);
    SELF.RA_addr_suffix_var1   := if (cnt = 1, ri.RA_addr_suffix, le.RA_addr_suffix_var1);
    SELF.RA_city_name_var1          := if (cnt = 1, ri.RA_city_name, le.RA_city_name_var1);
    SELF.RA_state_var1         := if (cnt = 1, ri.RA_state, le.RA_state_var1);
    SELF.RA_zip_var1           := if (cnt = 1, ri.RA_zip, le.RA_zip_var1);
    SELF.RA_zip4_var1          := if (cnt = 1, ri.RA_zip4, le.RA_zip4_var1);

    SELF.RA_title_var2                    := IF(cnt = 2,ri.RA_title,le.RA_title_var2);
    SELF.RA_fname_var2                    := IF(cnt = 2,ri.RA_fname,le.RA_fname_var2);
    SELF.RA_mname_var2                    := IF(cnt = 2,ri.RA_mname,le.RA_mname_var2);
    SELF.RA_lname_var2                    := IF(cnt = 2,ri.RA_lname,le.RA_lname_var2);
    SELF.RA_name_suffix_var2              := IF(cnt = 2,ri.RA_name_suffix,le.RA_name_suffix_var2);
    //SELF.position_title;
    SELF.RA_dt_first_seen_var2            := IF(cnt = 2,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_first_seen),le.RA_dt_first_seen_var2);
    SELF.RA_dt_last_seen_var2             := IF(cnt = 2,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_last_seen),le.RA_dt_last_seen_var2);
    SELF.RA_CompanyName_var2   := IF(cnt = 2,ri.RA_companyName,le.RA_companyName_var2);

    SELF.RA_prim_range_var2    := if (cnt = 2, ri.RA_prim_range, le.RA_prim_range_var2);
    SELF.RA_prim_name_var2     := if (cnt = 2, ri.RA_prim_name, le.RA_prim_name_var2);
    SELF.RA_predir_var2        := if (cnt = 2, ri.RA_predir, le.RA_predir_var2);
    SELF.RA_postdir_var2       := if (cnt = 2, ri.RA_postdir, le.RA_postdir_var2);
    SELF.RA_sec_range_var2     := if (cnt = 2, ri.RA_sec_range, le.RA_sec_range_var2);
    SELF.RA_unit_desig_var2    := if (cnt = 2, ri.RA_unit_desig, le.RA_unit_desig_var2);
    SELF.RA_addr_suffix_var2   := if (cnt = 2, ri.RA_addr_suffix, le.RA_addr_suffix_var2);
    SELF.RA_city_name_var2          := if (cnt = 2, ri.RA_city_name, le.RA_city_name_var2);
    SELF.RA_state_var2         := if (cnt = 2, ri.RA_state, le.RA_state_var2);
    SELF.RA_zip_var2           := if (cnt = 2, ri.RA_zip, le.RA_zip_var2);
    SELF.RA_zip4_var2          := if (cnt = 2, ri.RA_zip4, le.RA_zip4_var2);

    SELF.RA_title_var3                    := IF(cnt = 3,ri.RA_title,le.RA_title_var3);
    SELF.RA_fname_var3                    := IF(cnt = 3,ri.RA_fname,le.RA_fname_var3);
    SELF.RA_mname_var3                    := IF(cnt = 3,ri.RA_mname,le.RA_mname_var3);
    SELF.RA_lname_var3                    := IF(cnt = 3,ri.RA_lname,le.RA_lname_var3);
    SELF.RA_name_suffix_var3              := IF(cnt = 3,ri.RA_name_suffix,le.RA_name_suffix_var3);
    //SELF.position_title;
    SELF.RA_dt_first_seen_var3            := IF(cnt = 3,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_first_seen),le.RA_dt_first_seen_var3);
    SELF.RA_dt_last_seen_var3             := IF(cnt = 3,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_last_seen),le.RA_dt_last_seen_var3);
    SELF.RA_CompanyName_var3   := IF(cnt = 3, ri.RA_companyName,le.RA_companyName_var3);

    SELF.RA_prim_range_var3    := if (cnt = 3, ri.RA_prim_range, le.RA_prim_range_var3);
    SELF.RA_prim_name_var3     := if (cnt = 3, ri.RA_prim_name, le.RA_prim_name_var3);
    SELF.RA_predir_var3        := if (cnt = 3, ri.RA_predir, le.RA_predir_var3);
    SELF.RA_postdir_var3       := if (cnt = 3, ri.RA_postdir, le.RA_postdir_var3);
    SELF.RA_sec_range_var3     := if (cnt = 3, ri.RA_sec_range, le.RA_sec_range_var3);
    SELF.RA_unit_desig_var3    := if (cnt = 3, ri.RA_unit_desig, le.RA_unit_desig_var3);
    SELF.RA_addr_suffix_var3   := if (cnt = 3, ri.RA_addr_suffix, le.RA_addr_suffix_var3);
    SELF.RA_city_name_var3          := if (cnt = 3, ri.RA_city_name, le.RA_city_name_var3);
    SELF.RA_state_var3         := if (cnt = 3, ri.RA_state, le.RA_state_var3);
    SELF.RA_zip_var3           := if (cnt = 3, ri.RA_zip, le.RA_zip_var3);
    SELF.RA_zip4_var3          := if (cnt = 3, ri.RA_zip4, le.RA_zip4_var3);


    SELF.RA_title_var4                    := IF(cnt = 4,ri.RA_title,le.RA_title_var4);
    SELF.RA_fname_var4                    := IF(cnt = 4,ri.RA_fname,le.RA_fname_var4);
    SELF.RA_mname_var4                    := IF(cnt = 4,ri.RA_mname,le.RA_mname_var4);
    SELF.RA_lname_var4                    := IF(cnt = 4,ri.RA_lname,le.RA_lname_var4);
    SELF.RA_name_suffix_var4              := IF(cnt = 4,ri.RA_name_suffix,le.RA_name_suffix_var4);
    //SELF.position_title;
    SELF.RA_dt_first_seen_var4            := IF(cnt = 4,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_first_seen),le.RA_dt_first_seen_var4);
    SELF.RA_dt_last_seen_var4             := IF(cnt = 4,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_last_seen),le.RA_dt_last_seen_var4);
    SELF.RA_CompanyName_var4   := IF(cnt = 4, ri.RA_companyName,le.RA_companyName_var4);

    SELF.RA_prim_range_var4    := if (cnt = 4, ri.RA_prim_range, le.RA_prim_range_var4);
    SELF.RA_prim_name_var4     := if (cnt = 4, ri.RA_prim_name, le.RA_prim_name_var4);
    SELF.RA_predir_var4        := if (cnt = 4, ri.RA_predir, le.RA_predir_var4);
    SELF.RA_postdir_var4       := if (cnt = 4, ri.RA_postdir, le.RA_postdir_var4);
    SELF.RA_sec_range_var4     := if (cnt = 4, ri.RA_sec_range, le.RA_sec_range_var4);
    SELF.RA_unit_desig_var4    := if (cnt = 4, ri.RA_unit_desig, le.RA_unit_desig_var4);
    SELF.RA_addr_suffix_var4   := if (cnt = 4, ri.RA_addr_suffix, le.RA_addr_suffix_var4);
    SELF.RA_city_name_var4          := if (cnt = 4, ri.RA_city_name, le.RA_city_name_var4);
    SELF.RA_state_var4         := if (cnt = 4, ri.RA_state, le.RA_state_var4);
    SELF.RA_zip_var4           := if (cnt = 4, ri.RA_zip, le.RA_zip_var4);
    SELF.RA_zip4_var4          := if (cnt = 4, ri.RA_zip4, le.RA_zip4_var4);

    SELF.RA_title_var5                    := IF(cnt = 5,ri.RA_title,le.RA_title_var5);
    SELF.RA_fname_var5                    := IF(cnt = 5,ri.RA_fname,le.RA_fname_var5);
    SELF.RA_mname_var5                    := IF(cnt = 5,ri.RA_mname,le.RA_mname_var5);
    SELF.RA_lname_var5                    := IF(cnt = 5,ri.RA_lname,le.RA_lname_var5);
    SELF.RA_name_suffix_var5              := IF(cnt = 5,ri.RA_name_suffix,le.RA_name_suffix_var5);
    //SELF.position_title;
    SELF.RA_dt_first_seen_var5            := IF(cnt = 5,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_first_seen),le.RA_dt_first_seen_var5);
    SELF.RA_dt_last_seen_var5             := IF(cnt = 5,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_last_seen),le.RA_dt_last_seen_var5);
    SELF.RA_CompanyName_var5   := IF(cnt = 5, ri.RA_companyName,le.RA_companyName_var5);

    SELF.RA_prim_range_var5    := if (cnt = 5, ri.RA_prim_range, le.RA_prim_range_var5);
    SELF.RA_prim_name_var5     := if (cnt = 5, ri.RA_prim_name, le.RA_prim_name_var5);
    SELF.RA_predir_var5        := if (cnt = 5, ri.RA_predir, le.RA_predir_var5);
    SELF.RA_postdir_var5       := if (cnt = 5, ri.RA_postdir, le.RA_postdir_var5);
    SELF.RA_sec_range_var5     := if (cnt = 5, ri.RA_sec_range, le.RA_sec_range_var5);
    SELF.RA_unit_desig_var5    := if (cnt = 5, ri.RA_unit_desig, le.RA_unit_desig_var5);
    SELF.RA_addr_suffix_var5   := if (cnt = 5, ri.RA_addr_suffix, le.RA_addr_suffix_var5);
    SELF.RA_city_name_var5          := if (cnt = 5, ri.RA_city_name, le.RA_city_name_var5);
    SELF.RA_state_var5         := if (cnt = 5, ri.RA_state, le.RA_state_var5);
    SELF.RA_zip_var5           := if (cnt = 5, ri.RA_zip, le.RA_zip_var5);
    SELF.RA_zip4_var5          := if (cnt = 5, ri.RA_zip4, le.RA_zip4_var5);

    SELF.RA_title_var6                    := IF(cnt = 6,ri.RA_title,le.RA_title_var6);
    SELF.RA_fname_var6                    := IF(cnt = 6,ri.RA_fname,le.RA_fname_var6);
    SELF.RA_mname_var6                    := IF(cnt = 6,ri.RA_mname,le.RA_mname_var6);
    SELF.RA_lname_var6                    := IF(cnt = 6,ri.RA_lname,le.RA_lname_var6);
    SELF.RA_name_suffix_var6              := IF(cnt = 6,ri.RA_name_suffix,le.RA_name_suffix_var6);
    //SELF.position_title;
    SELF.RA_dt_first_seen_var6            := IF(cnt = 6,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_first_seen),le.RA_dt_first_seen_var6);
    SELF.RA_dt_last_seen_var6             := IF(cnt = 6,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_last_seen),le.RA_dt_last_seen_var6);
    SELF.RA_CompanyName_var6   := IF(cnt = 6, ri.RA_companyName,le.RA_companyName_var6);

    SELF.RA_prim_range_var6    := if (cnt = 6, ri.RA_prim_range, le.RA_prim_range_var6);
    SELF.RA_prim_name_var6     := if (cnt = 6, ri.RA_prim_name, le.RA_prim_name_var6);
    SELF.RA_predir_var6        := if (cnt = 6, ri.RA_predir, le.RA_predir_var6);
    SELF.RA_postdir_var6       := if (cnt = 6, ri.RA_postdir, le.RA_postdir_var6);
    SELF.RA_sec_range_var6     := if (cnt = 6, ri.RA_sec_range, le.RA_sec_range_var6);
    SELF.RA_unit_desig_var6    := if (cnt = 6, ri.RA_unit_desig, le.RA_unit_desig_var6);
    SELF.RA_addr_suffix_var6   := if (cnt = 6, ri.RA_addr_suffix, le.RA_addr_suffix_var6);
    SELF.RA_city_name_var6          := if (cnt = 6, ri.RA_city_name, le.RA_city_name_var6);
    SELF.RA_state_var6         := if (cnt = 6, ri.RA_state, le.RA_state_var6);
    SELF.RA_zip_var6           := if (cnt = 6, ri.RA_zip, le.RA_zip_var6);
    SELF.RA_zip4_var6          := if (cnt = 6, ri.RA_zip4, le.RA_zip4_var6);

    SELF.RA_title_var7                    := IF(cnt = 7,ri.RA_title,le.RA_title_var7);
    SELF.RA_fname_var7                    := IF(cnt = 7,ri.RA_fname,le.RA_fname_var7);
    SELF.RA_mname_var7                    := IF(cnt = 7,ri.RA_mname,le.RA_mname_var7);
    SELF.RA_lname_var7                    := IF(cnt = 7,ri.RA_lname,le.RA_lname_var7);
    SELF.RA_name_suffix_var7              := IF(cnt = 7,ri.RA_name_suffix,le.RA_name_suffix_var7);
    //SELF.position_title;
    SELF.RA_dt_first_seen_var7            := IF(cnt = 7,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_first_seen),le.RA_dt_first_seen_var7);
    SELF.RA_dt_last_seen_var7             := IF(cnt = 7,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_last_seen),le.RA_dt_last_seen_var7);
    SELF.RA_CompanyName_var7   := IF(cnt = 7, ri.RA_companyName,le.RA_companyName_var7);

    SELF.RA_prim_range_var7    := if (cnt = 7, ri.RA_prim_range, le.RA_prim_range_var7);
    SELF.RA_prim_name_var7     := if (cnt = 7, ri.RA_prim_name, le.RA_prim_name_var7);
    SELF.RA_predir_var7        := if (cnt = 7, ri.RA_predir, le.RA_predir_var7);
    SELF.RA_postdir_var7       := if (cnt = 7, ri.RA_postdir, le.RA_postdir_var7);
    SELF.RA_sec_range_var7     := if (cnt = 7, ri.RA_sec_range, le.RA_sec_range_var7);
    SELF.RA_unit_desig_var7    := if (cnt = 7, ri.RA_unit_desig, le.RA_unit_desig_var7);
    SELF.RA_addr_suffix_var7   := if (cnt = 7, ri.RA_addr_suffix, le.RA_addr_suffix_var7);
    SELF.RA_city_name_var7          := if (cnt = 7, ri.RA_city_name, le.RA_city_name_var7);
    SELF.RA_state_var7         := if (cnt = 7, ri.RA_state, le.RA_state_var7);
    SELF.RA_zip_var7           := if (cnt = 7, ri.RA_zip, le.RA_zip_var7);
    SELF.RA_zip4_var7          := if (cnt = 7, ri.RA_zip4, le.RA_zip4_var7);

    SELF.RA_title_var8                    := IF(cnt = 8,ri.RA_title,le.RA_title_var8);
    SELF.RA_fname_var8                    := IF(cnt = 8,ri.RA_fname,le.RA_fname_var8);
    SELF.RA_mname_var8                    := IF(cnt = 8,ri.RA_mname,le.RA_mname_var8);
    SELF.RA_lname_var8                    := IF(cnt = 8,ri.RA_lname,le.RA_lname_var8);
    SELF.RA_name_suffix_var8              := IF(cnt = 8,ri.RA_name_suffix,le.RA_name_suffix_var8);
    //SELF.position_title;
    SELF.RA_dt_first_seen_var8            := IF(cnt = 8,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_first_seen),le.RA_dt_first_seen_var8);
    SELF.RA_dt_last_seen_var8             := IF(cnt = 8,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_last_seen),le.RA_dt_last_seen_var8);
    SELF.RA_CompanyName_var8   := IF(cnt = 8, ri.RA_companyName,le.RA_companyName_var8);

    SELF.RA_prim_range_var8    := if (cnt = 8, ri.RA_prim_range, le.RA_prim_range_var8);
    SELF.RA_prim_name_var8     := if (cnt = 8, ri.RA_prim_name, le.RA_prim_name_var8);
    SELF.RA_predir_var8        := if (cnt = 8, ri.RA_predir, le.RA_predir_var8);
    SELF.RA_postdir_var8       := if (cnt = 8, ri.RA_postdir, le.RA_postdir_var8);
    SELF.RA_sec_range_var8     := if (cnt = 8, ri.RA_sec_range, le.RA_sec_range_var8);
    SELF.RA_unit_desig_var8    := if (cnt = 8, ri.RA_unit_desig, le.RA_unit_desig_var8);
    SELF.RA_addr_suffix_var8   := if (cnt = 8, ri.RA_addr_suffix, le.RA_addr_suffix_var8);
    SELF.RA_city_name_var8     := if (cnt = 8, ri.RA_city_name, le.RA_city_name_var8);
    SELF.RA_state_var8         := if (cnt = 8, ri.RA_state, le.RA_state_var8);
    SELF.RA_zip_var8           := if (cnt = 8, ri.RA_zip, le.RA_zip_var8);
    SELF.RA_zip4_var8          := if (cnt = 8, ri.RA_zip4, le.RA_zip4_var8);

    SELF.RA_title_var9                    := IF(cnt = 9,ri.RA_title,le.RA_title_var9);
    SELF.RA_fname_var9                    := IF(cnt = 9,ri.RA_fname,le.RA_fname_var9);
    SELF.RA_mname_var9                    := IF(cnt = 9,ri.RA_mname,le.RA_mname_var9);
    SELF.RA_lname_var9                    := IF(cnt = 9,ri.RA_lname,le.RA_lname_var9);
    SELF.RA_name_suffix_var9              := IF(cnt = 9,ri.RA_name_suffix,le.RA_name_suffix_var9);
    //SELF.position_title;
    SELF.RA_dt_first_seen_var9            := IF(cnt = 9,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_first_seen),le.RA_dt_first_seen_var9);
    SELF.RA_dt_last_seen_var9             := IF(cnt = 9,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_last_seen),le.RA_dt_last_seen_var9);
    SELF.RA_CompanyName_var9   := IF(cnt = 9, ri.RA_companyName,le.RA_companyName_var9);

    SELF.RA_prim_range_var9    := if (cnt = 9, ri.RA_prim_range, le.RA_prim_range_var9);
    SELF.RA_prim_name_var9     := if (cnt = 9, ri.RA_prim_name, le.RA_prim_name_var9);
    SELF.RA_predir_var9        := if (cnt = 9, ri.RA_predir, le.RA_predir_var9);
    SELF.RA_postdir_var9       := if (cnt = 9, ri.RA_postdir, le.RA_postdir_var9);
    SELF.RA_sec_range_var9     := if (cnt = 9, ri.RA_sec_range, le.RA_sec_range_var9);
    SELF.RA_unit_desig_var9    := if (cnt = 9, ri.RA_unit_desig, le.RA_unit_desig_var9);
    SELF.RA_addr_suffix_var9   := if (cnt = 9, ri.RA_addr_suffix, le.RA_addr_suffix_var9);
    SELF.RA_city_name_var9     := if (cnt = 9, ri.RA_city_name, le.RA_city_name_var9);
    SELF.RA_state_var9         := if (cnt = 9, ri.RA_state, le.RA_state_var9);
    SELF.RA_zip_var9           := if (cnt = 9, ri.RA_zip, le.RA_zip_var9);
    SELF.RA_zip4_var9          := if (cnt = 9, ri.RA_zip4, le.RA_zip4_var9);

    SELF.RA_title_var10                    := IF(cnt = 10,ri.RA_title,le.RA_title_var10);
    SELF.RA_fname_var10                    := IF(cnt = 10,ri.RA_fname,le.RA_fname_var10);
    SELF.RA_mname_var10                    := IF(cnt = 10,ri.RA_mname,le.RA_mname_var10);
    SELF.RA_lname_var10                    := IF(cnt = 10,ri.RA_lname,le.RA_lname_var10);
    SELF.RA_name_suffix_var10              := IF(cnt = 10,ri.RA_name_suffix,le.RA_name_suffix_var10);
    //SELF.position_title;
    SELF.RA_dt_first_seen_var10            := IF(cnt = 10,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_first_seen),le.RA_dt_first_seen_var10);
    SELF.RA_dt_last_seen_var10             := IF(cnt = 10,ut.date_YYYYMMDDtoDateSlashed((STRING8) ri.RA_dt_last_seen),le.RA_dt_last_seen_var10);
    SELF.RA_CompanyName_var10   := IF(cnt = 10, ri.RA_companyName,le.RA_companyName_var10);

    SELF.RA_prim_range_var10    := if (cnt = 10, ri.RA_prim_range, le.RA_prim_range_var10);
    SELF.RA_prim_name_var10     := if (cnt = 10, ri.RA_prim_name, le.RA_prim_name_var10);
    SELF.RA_predir_var10        := if (cnt = 10, ri.RA_predir, le.RA_predir_var10);
    SELF.RA_postdir_var10       := if (cnt = 10, ri.RA_postdir, le.RA_postdir_var10);
    SELF.RA_sec_range_var10     := if (cnt = 10, ri.RA_sec_range, le.RA_sec_range_var10);
    SELF.RA_unit_desig_var10    := if (cnt = 10, ri.RA_unit_desig, le.RA_unit_desig_var10);
    SELF.RA_addr_suffix_var10   := if (cnt = 10, ri.RA_addr_suffix, le.RA_addr_suffix_var10);
    SELF.RA_city_name_var10          := if (cnt = 10, ri.RA_city_name, le.RA_city_name_var10);
    SELF.RA_state_var10         := if (cnt = 10, ri.RA_state, le.RA_state_var10);
    SELF.RA_zip_var10           := if (cnt = 10, ri.RA_zip, le.RA_zip_var10);
    SELF.RA_zip4_var10          := if (cnt = 10, ri.RA_zip4, le.RA_zip4_var10);

    SELF                         := le;
  END;

  // Registered Agent Info
  ds_RegisteredAgentsFinal := DENORMALIZE(ds_OSHAFinal,
                                ds_RegisteredAgents,
                                LEFT.acctno = RIGHT.acctno AND
                                BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                tRegisteredAgents2Final(LEFT,RIGHT,COUNTER),
                                LEFT OUTER);
  // DCA Info
  BusinessBatch_BIP.Layouts.FinalWithLinkIds tDCAInfo2Final(BusinessBatch_BIP.Layouts.FinalWithLinkIds le,BusinessBatch_BIP.Layouts.DCAInfo ri) :=
  TRANSFORM
    SELF.num_employees    := ri.num_employees;
    SELF.sales_or_revenue := ri.sales_or_revenue;
    SELF.sales            := ri.sales;
    SELF                  := le;
  END;

  ds_DCAInfo2Final := JOIN( Ds_RegisteredAgentsFinal,	ds_DCAInfo,
                            LEFT.acctno = RIGHT.acctno AND
                            BIPV2.IDmacros.mac_JoinTop3Linkids(),
                            tDCAInfo2Final(LEFT,RIGHT),
                            LEFT OUTER,
                            LIMIT(0),KEEP(1));

  ds_DCAInfo2FinalWithErr := ds_DCAInfo2Final +
    PROJECT(ds_batchErr, TRANSFORM(recordof(ds_DCAInfo2Final),
      SELF.acctno := LEFT.acctno,
      SELF.error_code := LEFT.error_code,
      SELF := []));

  ds_DCAInfo2FinalSorted := SORT(ds_DCAInfo2FinalWithErr, acctno, -weight, -record_score, RECORD);

  //output(tmpTopResultsScoredGrouped, named('tmpTopResultsScoredGrouped'));
  //output(ds_bestInfo, named('ds_bestInfo'));


  //OUTPUT(ds_BestInfo,NAMED('ds_BestInfo'));
  // OUTPUT(ds_linkIds,NAMED('ds_linkIds'));

  // OUTPUT(ds_linkIdsWithAcctNoTmp, NAMED('ds_linkIdsWithAcctNoTmp'));
  // output(ds_linkidsWithAcctno, named('ds_linkidsWithAcctno'));
    // OUTPUT(ds_Format2SearchInput, named('ds_Format2SearchInput'));

    //OUTPUT(ds_batchIn, named('ds_batchIn'));
    //OUTPUT(ds_batchSearch, named('ds_batchSearch'));
    //OUTPUT(ds_batchPass, named('ds_batchPass'));
    //OUTPUT(ds_batchErr, named('ds_batchErr'));

    //output(ds_AppIdsSearch, named('ds_AppIdsSearch'));
    //output(ds_AppIdsPass_pre0, named('ds_AppIdsPass_pre0'));
    //output(ds_AppIdsPass_pre1, named('ds_AppIdsPass_pre1'));
    //output(ds_AppIdsPass_full, named('ds_AppIdsPass_full'));
    //output(ds_AppIdsPass, named('ds_AppIdsPass'));
    //output(ds_AppIds, named('ds_AppIds'));

    //output(ds_BestInfoApp_pre, named('ds_BestInfoApp_pre'));
    //output(ds_BestInfoTmp_all, named('ds_BestInfoTmp_all'));
    //output(ds_BestInfoApp_all, named('ds_BestInfoApp_all'));

    //OUTPUT(ds_BestInfoTmp0, named('ds_BestInfoTmp0'));
    //output(ds_BestInfoTmp2, named('ds_BestInfoTmp2'));
    //output(ds_BestInfoMark, named('ds_BestInfoMark'));
    //output(ds_bestInfo3, named('ds_bestInfo3'));
    //OUTPUT(ds_BestBatchRecs, NAMED('ds_BestBatchRecs'));
      //output(ds_BestInfoRecs, named('ds_BestInfoRecs'));

  // output(ds_BestInfoTmp, named('ds_BestInfoTmp'));
    // OUTPUT(ds_bestKfetchSourceDResults, NAMED('ds_bestKfetchSourceDResults'));
    // OUTPUT(ds_BestInfoRecs, NAMED('ds_BestInfoRecs'));
    //output(ds_best, named('ds_best'));
  //OUTPUT(ds_NameAddressBatchRecs,NAMED('ds_NameAddressBatchRecs'));
  //OUTPUT(ds_HeaderInfoAll,NAMED('ds_HeaderInfoAll'));
  // output( ds_Corps, named('ds_Corps'));
  // OUTPUT(ds_GongPhones,NAMED('ds_GongPhones'));
  //output(ds_Phones2Final, NAMED('ds_Phones2Final'));
// OUTPUT(ds_Corps,NAMED('ds_Corps'));
  // OUTPUT(ds_Flags,NAMED('ds_Flags'));
  // OUTPUT(ds_Executives,NAMED('ds_Executives'));
  // OUTPUT(ds_DCAInfo,NAMED('ds_DCAInfo'));
  // OUTPUT(ds_Phones2FinalTmp, named('Ds_phones2FinalTmp'));
  // OUTPUT(ds_Phones2Final,NAMED('ds_Phones2Final'));
  // OUTPUT(ds_Corps2Final,NAMED('ds_Corps2Final'));
  // OUTPUT(ds_Flags2Final,NAMED('ds_Flags2Final'));
// OUTPUT(ds_Execs2Final,NAMED('ds_Execs2Final'));
  //OUTPUT(ds_AppIds, NAMED('ds_AppIds'));
  //OUTPUT(ds_bestInfoApp_pre, NAMED('ds_bestInfoApp_pre'));
  //OUTPUT(ds_bestInfoApp_all, NAMED('ds_bestInfoApp_all'));
  //OUTPUT(ds_bestInfoApp2, NAMED('ds_bestInfoApp2'));

  //OUTPUT(ds_DCAInfo2FinalSorted ,NAMED('ds_DCAInfo2FinalSorted'));

  //output(ds_OSHAFinal, named('ds_OSHAFinal'));

  //output(ds_RegisteredAgents, named('ds_RegisteredAgents'));
  // OUTPUT(ds_BestInfoApp_pre, named('ds_BestInfoApp_pre'));

  RETURN PROJECT(IF(inmod.BestOnly,
                    ds_HeaderInfoAll,
                    ds_DCAInfo2FinalSorted),
                 BusinessBatch_BIP.Layouts.Final);

END;
