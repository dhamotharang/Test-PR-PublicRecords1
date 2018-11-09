IMPORT BizLinkFull;
EXPORT svcBatch := MACRO
  BOOLEAN bIncludeBest:=FALSE:STORED('include_best');
  STRING sBestLevel:='SELEID':STORED('best_level');
  dInput:=DATASET([],BizLinkFull.lBatchInput):STORED('batch_in');
 
  // For any records where a proxid was not populated, perform a batch append
  dFormalized:=BizLinkFull._Search.macFormalize(dInput,,,FALSE);
  dResults:=BizLinkFull._Search.BatchSubmit(dFormalized,FALSE);
  dBatchSearch:=JOIN(dInput,dResults,LEFT.acctno=RIGHT.reference,TRANSFORM(BizLinkFull.lBatchOutput,
    SELF.proxid             := RIGHT.results[1].proxid;
    SELF.seleid             := RIGHT.results[1].seleid;
    SELF.orgid              := RIGHT.results[1].orgid;
    SELF.ultid              := RIGHT.results[1].ultid;
    SELF.powid              := RIGHT.results[1].powid;
    SELF.weight             := RIGHT.results[1].weight;
    SELF.parent_proxid      := RIGHT.results[1].parent_proxid;
    SELF.sele_proxid        := RIGHT.results[1].sele_proxid;
    SELF.org_proxid         := RIGHT.results[1].org_proxid;
    SELF.ultimate_proxid    := RIGHT.results[1].ultimate_proxid;
    SELF.score              := RIGHT.results[1].score;
    SELF.acctno             := LEFT.acctno;
    SELF.source             := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].source,'');
    SELF.source_record_id   := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].source_record_id,0);
    SELF.company_phone      := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].company_phone_3+RIGHT.results[1].company_phone_7,'');
    SELF.company_sic_code1  := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].company_sic_code1,'');
    // SELF.company_naics_code1:= IF(sBestLevel='FULLRESULTS',RIGHT.results[1].company_naics_code1,'');
    SELF.prim_range         := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].prim_range,'');
    SELF.prim_name          := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].prim_name,'');
    SELF.sec_range          := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].sec_range,'');
    SELF.city               := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].city,'');
    SELF.st                 := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].st,'');
    SELF.zip                := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].zip_cases[1].zip,'');
    SELF.company_url        := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].company_url,'');
    SELF.fname              := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].fname,'');
    SELF.mname              := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].mname,'');
    SELF.lname              := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].lname,'');
    SELF.contact_ssn        := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].contact_ssn,'');
    SELF.contact_email      := IF(sBestLevel='FULLRESULTS',RIGHT.results[1].contact_email,'');
    SELF.search_matches := BizLinkFull.matchCodes.batch_MatchCode(RIGHT.results[1]);
    SELF:=[];
  ));
  
  // For any records where a proxid was populated, pull results from MEOW_Biz
  dIDFormalized:=PROJECT(BizLinkFull._Search.macFormalize(TABLE(dInput(entered_proxid>0),{acctno;entered_proxid})),BizLinkFull.Process_Biz_Layouts.InputLayout);
  dIDSearch:=PROJECT(DEDUP(SORT(BizLinkFull.MEOW_Biz(dIDFormalized).Data_,uniqueid),uniqueid),TRANSFORM(BizLinkFull.lBatchOutput,
    SELF.acctno           := LEFT.uniqueid;
    SELF.proxid           := LEFT.proxid;
    SELF.seleid           := LEFT.seleid;
    SELF.orgid            := LEFT.orgid;
    SELF.ultid            := LEFT.ultid;
    self.powid            := LEFT.powid;
    SELF.parent_proxid    := LEFT.parent_proxid;
    SELF.sele_proxid      := LEFT.sele_proxid;
    SELF.org_proxid       := LEFT.org_proxid;
    SELF.ultimate_proxid  := LEFT.ultimate_proxid;
    SELF:=[];
  ));
  
  // Results are the sum of the two datasets above.
  dAppended:=DEDUP(SORT(dBatchSearch+dIDSearch,acctno,-weight),acctno);
  // Pull the data from the Best key for all of the IDs in the search results.
  MEOW:=BizLinkFull.MEOW_Biz(DATASET([],BizLinkFull.Process_Biz_Layouts.InputLayout));
  dLinkIDs:=BIPV2_Best.Key_LinkIds.kfetch(
    inputs:=DEDUP(PROJECT(dAppended,BIPV2.IDlayouts.l_xlink_ids),ALL),
    Level:=MAP(
      sBestLevel='PROXID' => BIPV2.IDconstants.Fetch_Level_PROXID,
      BIPV2.IDconstants.Fetch_Level_SELEID
    )
  )(IF(sBestLevel='PROXID',1=1,proxid=0));
  
  // Add in the IDs to the Best results.
  dWithSele:=JOIN(dLinkIDs,dAppended,LEFT.seleid=RIGHT.seleid,TRANSFORM({UNSIGNED acctno;UNSIGNED4 weight;UNSIGNED4 score;UNSIGNED parent_proxid;UNSIGNED sele_proxid;UNSIGNED org_proxid;UNSIGNED ultimate_proxid; STRING search_matches, RECORDOF(LEFT);},
    SELF.acctno:=RIGHT.acctno;
    SELF.proxid:=RIGHT.proxid;
    SELF.seleid:=RIGHT.seleid;
    SELF.orgid:=RIGHT.orgid;
    SELF.ultid:=RIGHT.ultid;
    SELF.powid:=RIGHT.powid;
    SELF.weight:=RIGHT.weight;  
    SELF.score:=RIGHT.score;
    SELF.parent_proxid:=RIGHT.parent_proxid;
    SELF.sele_proxid:=RIGHT.sele_proxid;
    SELF.org_proxid:=RIGHT.org_proxid;
    SELF.ultimate_proxid:=RIGHT.ultimate_proxid;
    SELF.search_matches := RIGHT.search_matches;
    SELF:=LEFT;
  ));
  
  // Score the best results.
  dSeleScored:=PROJECT(dWithSele,TRANSFORM({RECORDOF(MEOW.Raw_Data);UNSIGNED orig_uid;},
    ca := LEFT.company_address[1];
    SELF.orig_uid       := LEFT.acctno;
    SELF.uniqueid       := COUNTER;
    SELF.company_phone  := LEFT.company_phone[1].company_phone;
    SELF.company_name   := LEFT.company_name[1].company_name;
    SELF.dt_first_seen  := LEFT.company_name[1].dt_first_seen;
    SELF.dt_last_seen   := LEFT.company_name[1].dt_last_seen;
    SELF.company_fein   := LEFT.company_fein[1].company_fein;
    SELF.company_url    := LEFT.company_url[1].company_url;
    SELF.prim_range     := ca.company_prim_range; 
    SELF.prim_name      := ca.company_prim_name;
    SELF.sec_range      := ca.company_sec_range;  
    SELF.city           := ca.address_v_city_name;  
    SELF.st             := ca.company_st;
    SELF.zip            := ca.company_zip5;   
    SELF.zip4           := ca.company_zip4;
    SELF:=LEFT;
    SELF:=[];
  ));
  dSeleScoredFormalized:=PROJECT(BizLinkFull._Search.macFormalize(dSeleScored),BizLinkFull.Process_Biz_Layouts.InputLayout);
  dBestOut:=MEOW.ScoreData(dSeleScored,dSeleScoredFormalized);
  
  // Format the best results into the output layout
  dSeleBest:=JOIN(dBestOut,dWithSele,LEFT.orig_uid=RIGHT.acctno AND LEFT.seleid=RIGHT.seleid,TRANSFORM(BizLinkFull.lBatchOutput,
    SELF.acctno:=RIGHT.acctno;
    SELF.proxid:=RIGHT.proxid;
    SELF.seleid:=RIGHT.seleid;
    SELF.orgid:=RIGHT.orgid;
    SELF.ultid:=RIGHT.ultid;
    SELF.powid:=RIGHT.powid;
    SELF.weight:=RIGHT.weight;  
    SELF.score:=RIGHT.score;
    SELF.parent_proxid:=RIGHT.parent_proxid;
    SELF.sele_proxid:=RIGHT.sele_proxid;
    SELF.org_proxid:=RIGHT.org_proxid;
    SELF.ultimate_proxid:=RIGHT.ultimate_proxid;
    SELF.county_name:=RIGHT.company_address[1].county_name;
    SELF.v_city_name:=RIGHT.company_address[1].address_v_city_name;
    SELF.p_city_name:=RIGHT.company_address[1].company_p_city_name;
    SELF.duns_number:=RIGHT.duns_number[1].duns_number;
    SELF.best_matches := BizLinkFull.matchCodes.online_MatchCode(   
          project(left, transform(BizLinkFull.matchCodes.onlineMatchLayout, self := left)), dInput(acctno=RIGHT.acctno)[1]);
    SELF.search_matches := RIGHT.search_matches;
    SELF:=LEFT;
    SELF:=[];
  ),KEEP(1));
  
  // reply with the output type the user requested.
  OUTPUT(BIPV2_Suppression.macSuppress(IF(bIncludeBest,dSeleBest,dAppended)),NAMED('Results'));
ENDMACRO;

