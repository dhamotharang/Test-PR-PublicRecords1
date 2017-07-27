IMPORT BankruptcyV3, BIPV2, iesp, LiensV2;

EXPORT SmallBizDataInvestigationReportService_Records(DataInvestigation_Services.IParam.DataInvestigationRawReport_IParams DataInvestigation_inmod ) := 
  FUNCTION
  
   /* ************************************************************************
	  *         Bankruptcy Keys                                                *
    *                                                                        *
    *  Note: bankruptcy keys used for this service came from                 *
    *        keys used in TopBusiness_Services.BankruptcySection which is    * 
    *        output in the BusinessCredit_Services.CreditReportService       *
	  ************************************************************************ */
    
    ds_bk_bip_raw_recs :=     
      BankruptcyV3.key_bankruptcyV3_linkids.kfetch2(DataInvestigation_inmod.BusinessIds,
                                                    DataInvestigation_inmod.FetchLevel,
                                                    DataInvestigation_Services.Constants.SCORE_THRESHOLD,
                                                    DataInvestigation_Services.Constants.FETCH_LIMIT
                                                   )
              (name_type[1] = DataInvestigation_Services.Constants.BANKRUPTCY_PARTY_TYPE_DEBTOR); // only want debtor recs not attorney recs.												

    //filter out just the business related BK recs
    ds_bk_BIP_recs_filtered_dedup := DEDUP(SORT(ds_bk_bip_raw_recs(tmsid != ''), tmsid),tmsid);
    
    // get the debtor and attorney recs by join 
    ds_bk_BIP_recs := 
      JOIN(ds_bk_BIP_recs_filtered_dedup, BankruptcyV3.key_bankruptcyV3_search_full_bip(),
           KEYED(LEFT.tmsid = RIGHT.tmsid),			
           TRANSFORM(RECORDOF(RIGHT),
                     SELF := RIGHT),
           LIMIT(DataInvestigation_Services.Constants.BANKRUPTCY_KEY_JOIN_LIMIT, 
                 SKIP));

    // get the trustee info and add linkids to link output together.
    ds_tmp_bk_raw_recs_main_fullV3 :=  
      JOIN(ds_bk_BIP_recs, BankruptcyV3.key_bankruptcyV3_main_full(),					 
           KEYED(LEFT.tmsid = RIGHT.tmsid),
           TRANSFORM(RIGHT), 
           LIMIT(DataInvestigation_Services.Constants.BANKRUPTCY_KEY_JOIN_LIMIT, 
                 SKIP));

    /* ************************************************************************
     *          Combine Bankruptcy Keys &                                     *
     *           Transform into IESP layouts                                  *
    ************************************************************************ */
     
    // Slim record layout to only deduped tmsids 
    ds_tmsids_found := 
      PROJECT(ds_bk_BIP_recs_filtered_dedup, 
              TRANSFORM({STRING50 TMSID},
                         SELF := LEFT));
    
    // now combine records from all three keys associated with the tmsid
    ds_bankruptcyRecords :=
      PROJECT(ds_tmsids_found, 
        TRANSFORM(iesp.smallbusinessdatainvestigation.t_BankruptcyRecord,
                  tmsid_to_match  :=  LEFT.TMSID;
                  SELF.TMSID      :=  LEFT.TMSID,                   // had to add this second project to get rid of unknown layout error
                  SELF.BankruptcyLinkIdsKeyRecords       := PROJECT(PROJECT(ds_bk_bip_raw_recs(TMSID = tmsid_to_match),RECORDOF(BankruptcyV3.key_bankruptcyV3_linkids.key)),
                                                              DataInvestigation_Services.xfm_BankruptcyLinkIds_intoIESP(LEFT));
                  SELF.BankruptcySearchFullBipKeyRecords := PROJECT(ds_bk_BIP_recs(TMSID = tmsid_to_match),
                                                              DataInvestigation_Services.xfm_BankruptcySearchFullBip_intoIESP(LEFT));
                  SELF.BankruptcyMainKeyRecords          := PROJECT(ds_tmp_bk_raw_recs_main_fullV3(TMSID = tmsid_to_match),
                                                              DataInvestigation_Services.xfm_BankruptcyMain_intoIESP(LEFT))
                 ));
                        
    /* ************************************************************************
     *         Liens & Judgment Keys                                          *
     *                                                                        *
     *  Note: Liens and Judgments keys used for this service came from        *
     *        keys used in TopBusiness_Services.LienSection which is          * 
     *        output in the BusinessCredit_Services.CreditReportService       *
     ************************************************************************ */
    
    // ****** Get the needed linkids key J&Ls info for each set of input linkids
    // *** Key fetch to get Liens tmsid/rmsid data from new bip2 linkids key file.
    ds_lj_linkids_keyrecs := LiensV2.Key_Linkids.KeyFetch(DataInvestigation_inmod.BusinessIds,  
                                                          DataInvestigation_inmod.FetchLevel,
                                                          DataInvestigation_Services.Constants.SCORE_THRESHOLD,
                                                          DataInvestigation_Services.Constants.FETCH_LIMIT);
     
    ds_lj_linkids_keyrecs_deduped := 
      dedup(sort(ds_lj_linkids_keyrecs,
                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                  tmsid,rmsid),
            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
            tmsid,rmsid);
              
    // Next join to get the Liens "main"(filing) data needed to output on the report.
    ds_lj_main_keyrecs := 
      JOIN(ds_lj_linkids_keyrecs_deduped, LiensV2.Key_liens_main_ID(),
           KEYED(LEFT.tmsid = RIGHT.tmsid AND
                 LEFT.rmsid = RIGHT.rmsid),
           TRANSFORM(RIGHT),
           LIMIT(DataInvestigation_Services.Constants.LIENS_KEY_JOIN_LIMIT, 
                 SKIP));

    // Lien Party Key
    ds_lj_party_keyrecs := 
      JOIN(ds_lj_linkids_keyrecs_deduped,LiensV2.key_liens_party_ID(),
           KEYED(LEFT.tmsid = RIGHT.tmsid AND
                 LEFT.rmsid = RIGHT.rmsid ),
           TRANSFORM(RIGHT),
           LIMIT(DataInvestigation_Services.Constants.LIENS_KEY_JOIN_LIMIT, 
                 SKIP));

    /* ************************************************************************
     *         Combine LiensAndJudgments Keys &                               *
     *           Transform into IESP layouts                                  *
     ************************************************************************ */
    // Slim record layout to tmsid & rmsids and dedup
    ds_lj_tmsid_rmsids_found := 
      PROJECT(ds_lj_linkids_keyrecs_deduped, 
              TRANSFORM({STRING50 TMSID; STRING50 RMSID},
                         SELF := LEFT));
              
    // now combine records from all three keys associated with the tmsid
    ds_lj_LienAndJudgmentRecords :=
      PROJECT(ds_lj_tmsid_rmsids_found, 
              TRANSFORM(iesp.smallbusinessdatainvestigation.t_LienAndJudgmentReportRecord,
                        tmsid_to_match  :=  LEFT.TMSID;
                        rmsid_to_match  :=  LEFT.RMSID;
                        SELF.TMSID      :=  LEFT.TMSID,
                        SELF.RMSID      :=  LEFT.RMSID,
                        SELF.LienLinkIdsKeyRecords := PROJECT(ds_lj_linkids_keyrecs_deduped(TMSID = tmsid_to_match AND RMSID = rmsid_to_match),
                                                       DataInvestigation_Services.xfm_LienLinkIds_intoIESP(LEFT)),
                        SELF.LienMainKeyRecords   := PROJECT(ds_lj_main_keyrecs(TMSID = tmsid_to_match AND RMSID = rmsid_to_match),
                                                       DataInvestigation_Services.xfm_LienMain_intoIESP(lEFT)),
                        SELF.LienPartyKeyRecords  := PROJECT(ds_lj_party_keyrecs(TMSID = tmsid_to_match AND RMSID = rmsid_to_match),
                                                       DataInvestigation_Services.xfm_LienParty_intoIESP(LEFT))
                       ));
                       
     /* ************************************************************************
      *         Transform into Final IESP Layout                               *
      ************************************************************************ */

    iesp.smallbusinessdatainvestigation.t_SmallBusinessDataInvestigationReportResponse xfm_ToFinalLayout() := 
      TRANSFORM
        SELF._Header          := iesp.ECL2ESP.GetHeaderRow();
        SELF.Bankruptcies     := ds_bankruptcyRecords; 
        SELF.LienAndJudgments := ds_lj_LienAndJudgmentRecords; 
        SELF                  := []; // echo input
      END;

    ds_keyResults := DATASET([xfm_ToFinalLayout()]);


    RETURN ds_keyResults; 
    
  END;