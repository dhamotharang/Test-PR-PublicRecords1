import MDR;
import STD;
import BIPV2;
import Bipv2_Best;
import BIPV2_Statuses;

base_rec        := layout_Entity_Report.base_rec;
slim_rec        := layout_Entity_Report.slim_rec;
prox_range_rec  := layout_Entity_Report.prox_range_rec;
fein_range_rec  := layout_Entity_Report.fein_range_rec;
source_type_rec := layout_Entity_Report.source_type_rec;
count_rec       := layout_Entity_Report.count_rec;
tally_rec       := layout_Entity_Report.tally_rec;
report_rec      := layout_Entity_Report.report_rec;
percent_rec     := layout_Entity_Report.percent_rec;

EXPORT EntityReport(dataset(BIPV2.CommonBase.Layout) header_raw,
                    dataset(Bipv2_Best.Layouts.base) best_raw,
                    unsigned reportDate = STD.Date.Today()
                    ):= module
 
  shared header_rec   := distribute(header_raw,                         hash32(seleid));
  shared best_recs    := distribute(best_raw,                           hash32(seleid)); 
	 // In certain cirumstances, BIPV2.CommonBase.clean() can insert records.
	 // The following 3 lines removes those from the stats. - see Bob Pressel
	 raw_cleaned := BIPV2.CommonBase.clean(header_rec);
	 null_cleaned := BIPV2.CommonBase.clean(dataset([],BIPV2.CommonBase.Layout));
  shared clean_adjusted := join(raw_cleaned, null_cleaned, left=right, left only, lookup); 
  shared header_clean := distribute(clean_adjusted, hash32(seleid)): independent;
  
  // -- recalc new gold
  shared ds_recalc_gold_clean := BIPV2_Statuses.mac_Calculate_Gold(clean_adjusted);
  shared header_clean_newgold := distribute(ds_recalc_gold_clean, hash32(seleid)): independent;
  shared header_rec_newgold   := distribute(join(header_raw,table(ds_recalc_gold_clean(sele_gold = 'G')  ,{seleid} ,seleid ,merge),left.seleid = right.seleid  ,transform(recordof(left),self.sele_gold := if(right.seleid != 0,'G',''),self := left ),left outer ,hash) ,hash32(seleid));
 
  shared header_layout := Bipv2.commonbase.layout;
  shared seleidType := typeof(header_layout.seleid);
 

  // ********************** State start **************************
  // The state for a company seleid is determined by the following
  // 1) Use the Best proess address if present
  // 2) Use the 'st' field if unique in the header records
  // 3) Use 'company_inc_state' if unique in header records
  // 4) Use most common 'st' field value
  // 5) Use most common 'company_inc_state' value
  // 6) There is no state information available: assign state of '??'
  seleStateRec := {
    header_layout.seleid;
    typeof(header_layout.st) state;
  };
 
  seleStateCntRec := {
    header_layout.seleid;
    typeof(header_layout.st) state;
    unsigned cnt;
  };

  // Pick a non null state value from the best method (lowest method #)
  seleStateCntRec trans(recordof(best_recs) l) := transform
    goodvals := l.company_address(company_st<>'');
    goodvals_sorted := sort(goodvals, company_address_method);
    self.state := if(exists(goodvals_sorted), goodvals[1].company_st, '');
    self.seleid := l.seleid;
    self.cnt:=1;
  end;

  bestStateSeleLevel := project(best_recs(proxid=0), trans(left)); 

  // Given a set of records, return record with seleid and count of non blank values of field 
  countOfUniqueFieldValuesPerSele(recs, field) := functionmacro
    allsele2 := dedup(sort(recs, seleid, local), seleid, local);

    recsWithState := recs(trim(field)<>'');
    sele_st_unique := dedup(sort(recsWithState, seleid, field, local), seleid, field, local);
		
    // Ignore the warning &quot;TABLE does not appear to be properly defined by grouping conditions&quot; - we will only care about state when cnt=1
    sele_num_with_states := project(table(sele_st_unique, {seleid, field, unsigned cnt := count(group)}, seleid, local, skew(1.0)), transform(seleStateCntRec, self.state:=left.field, self:=left));
    missing := join(allsele2, sele_num_with_states, 
                    left.seleid=right.seleid, 
                    transform(recordof(sele_num_with_states), self.seleid:=left.seleid, self.state:='??'; self.cnt:=0), 
                    left only, local);
		
    sele_num_states := sele_num_with_states + missing;												
    return sele_num_states; 
  endmacro;
 
  mostCommonStateData(recs, field) := functionmacro
    allsele := dedup(sort(recs, seleid, local), seleid, local);

    recsWithState := recs(trim(field)<>'');
    sele_st_unique := dedup(sort(recsWithState, seleid, field, local), seleid, field, local);
    sele_state_cnts := sort(table(sele_st_unique, {seleid, field, unsigned cnt := count(group)}, seleid, field, local, skew(1.0)), seleid, -cnt, skew(1.0), local);;
    sele_most_common_state := project(dedup(sele_state_cnts, seleid, left, local), transform(seleStateCntRec, self.state:=left.field, self:=left));

    missing := join(allsele, sele_most_common_state, 
                    left.seleid=right.seleid, 
                    transform(recordof(sele_most_common_state), self.seleid:=left.seleid; self.state:=''; self.cnt:=0), 
                    left only, local);					

    sele_num_states := sele_most_common_state + missing;												
    return sele_num_states; 
  endmacro;

  // Assumes records distributed by seleid
  shared determineStatesForSeleids(dataset(header_layout) scopeOfAllStateRecs) := function

    uniqueStateSeleids := dedup(sort(scopeOfAllStateRecs, seleid, local), seleid, local);
 
    // 1) Use Best Info
    bestseleWithState := bestStateSeleLevel(state<>'');
    best_rec_shared_sele := join(bestseleWithState, uniqueStateSeleids, left.seleid=right.seleid, transform({seleStateCntRec}, self :=LEFT), local);
    tablebest_rec_shared_sele := sort(table(best_rec_shared_sele, {state, cntx:=count(group)}, state), -cntx);
    SeleNoBestState := join(bestseleWithState, uniqueStateSeleids, left.seleid=right.seleid, transform({header_layout.seleid}, self :=RIGHT), right only, local);
 
    // 2) 'st' -  Handle what Best Cant
    SeleNoBestStateRecords := join(scopeOfAllStateRecs, SeleNoBestState, left.seleid=right.seleid, transform(left), local);
    noBestStateTabledSt := countOfUniqueFieldValuesPerSele(SeleNoBestStateRecords, st);
    choseByUniqueStField := noBestStateTabledSt(cnt=1);
    tablechoseByUniqueStField := sort(table(choseByUniqueStField, {state, cntx:=count(group)}, state), -cntx);
 
    // 3) 'company_inc_state'  -  Handle what Best and St cant
    SeleNoBestNoStRecords := join(SeleNoBestStateRecords, noBestStateTabledSt(cnt<>1), left.seleid=right.seleid, transform(left), local);
    noBestStateNoUniqueStTabledCIS := countOfUniqueFieldValuesPerSele(SeleNoBestNoStRecords, company_inc_state);
    choseByUnicIncField := noBestStateNoUniqueStTabledCIS(cnt=1);
    tablechoseByUnicIncField := sort(table(choseByUnicIncField, {state, cntx:=count(group)}, state), -cntx);
 
    // 4) most common 'st'
    SeleNoBestNoStNoCISRecords := join(SeleNoBestNoStRecords, noBestStateNoUniqueStTabledCIS(cnt<>1), left.seleid=right.seleid, transform(left), local);
    mostCommmonStStats := mostCommonStateData(SeleNoBestNoStNoCISRecords, st);
    mostCommonStYes := mostCommmonStStats(cnt<>0);
    mostCommonStNo := mostCommmonStStats(cnt=0);
    tablemostCommonStYes := sort(table(mostCommonStYes, {state, cntx:=count(group)}, state), -cntx);
 
    // 5) most common 'company_inc_state'
    SeleNoBestNoStNoCISNoStRecords := join(SeleNoBestNoStNoCISRecords, mostCommonStNo, left.seleid=right.seleid, transform(left), local);
    mostCommmonIncStStats := mostCommonStateData(SeleNoBestNoStNoCISNoStRecords, company_inc_state);
    mostCommonIncStYes := mostCommmonIncStStats(cnt<>0);
    mostCommonIncStNo := project(mostCommmonIncStStats(cnt=0), transform(recordof(mostCommmonIncStStats), self.state:='??'; self:=left));
    tablemostCommonIncStYes := sort(table(mostCommonIncStYes, {state, cntx:=count(group)}, state), -cntx);
 
    return project(best_rec_shared_sele + choseByUniqueStField + choseByUnicIncField + mostCommonStYes + mostCommonIncStYes + mostCommonIncStNo, transform(seleStateRec, self:=left));
  end;
// ********************** State End **************************


  // Source Type Functions
  shared isPublicRecordFn(string2 source) := function
    return  MDR.sourceTools.SourceIsIRS_5500(source) or
            MDR.sourceTools.SourceIsLiens_v2(source) or
            MDR.sourceTools.SourceIsDCA(source) or
            MDR.sourceTools.SourceIsCorpV2(source) or
            MDR.sourceTools.SourceIsTXBUS(source) or
            MDR.sourceTools.SourceIsUCCV2(source) or
            MDR.sourceTools.SourceIsBankruptcy(source) or
            MDR.sourceTools.SourceIsCredit_Unions(source) or
            MDR.sourceTools.SourceIsDea(source) or
            MDR.sourceTools.SourceIsFAA(source) or
            MDR.sourceTools.SourceIsFDIC(source) or
            MDR.sourceTools.SourceIsIRS_Non_Profit(source) or
            MDR.sourceTools.SourceIsVehicle(source) or
            MDR.sourceTools.SourceIsOSHAIR(source) or
            MDR.sourceTools.SourceIsLnPropertyV2(source) or
            MDR.sourceTools.SourceIsCA_Sales_Tax(source) or
            MDR.sourceTools.SourceIsWC(source) or
            MDR.sourceTools.SourceIsWorkers_Compensation(source);
  end;	
	
  shared isDirectoryFn(string2 source) := function
    return  MDR.sourceTools.SourceIsFBNV2(source) or
            source in MDR.sourceTools.set_Business_Registration or
            MDR.sourceTools.SourceIsFrandx(source) or
            MDR.sourceTools.SourceIsBBB(source) or
            MDR.sourceTools.SourceIsCClue(source) or
            MDR.sourceTools.SourceIsINFOUSA_ABIUS_USABIZ(source) or
            source in MDR.sourceTools.set_Infutor_NARB;
  end;	
 
  shared isBureauFn(string2 source) := function
    return  MDR.sourceTools.SourceIsDunn_Bradstreet(source) or
            MDR.sourceTools.SourceIsDunn_Bradstreet_Fein(source) or
            MDR.sourceTools.SourceIsEBR(source) or
            MDR.sourceTools.SourceIsExperian_CRDB(source) or
            MDR.sourceTools.SourceIsExperian_FEIN(source) or
            MDR.sourceTools.SourceIsBusiness_Credit(source) or
            MDR.sourceTools.SourceIsCortera(source);
  end;
														
  shared isTelephoneFn(string2 source) := function
    return MDR.sourceTools.SourceIsYellow_Pages(source);
  end;
 
  shared slim_rec toSlimTrans(header_layout l) := transform
    hasAddr  := trim(l.prim_range)<>'' and trim(l.prim_name)<>'' and trim(l.p_city_name)<>'';
    predir   := if(trim(l.predir)<>'', l.predir+' ', '');
    addr     := STD.Str.toUpperCase(trim(l.prim_range)+' '+predir+trim(l.prim_name)+' '+trim(l.sec_range)+' '+trim(l.p_city_name)+' '+trim(l.st)+' '+trim(l.zip));
    self.address     := if(hasAddr, addr, '');
    self.state := l.st;
    self := l;
  end;
 	
  shared clean_slim_recs          := project(header_clean           , toSlimTrans(left), local);
  shared clean_slim_recs_newgold  := project(header_clean_newgold   , toSlimTrans(left), local);
  export raw_slim_recs            := project(header_rec             , toSlimTrans(left), local);
  export raw_slim_recs_newgold    := project(header_rec_newgold     , toSlimTrans(left), local);

  shared stateInfo                  := determineStatesForSeleids(header_rec);
  export all_clean_recs_with_state  := join(clean_slim_recs, stateInfo, left.seleid=right.seleid, transform(slim_rec, self.state:=right.state, self:=left;), left outer, local); 
  export active_clean_recs_with_state   := all_clean_recs_with_state(seleid_status_private='');
  export inactive_clean_recs_with_state := all_clean_recs_with_state(seleid_status_private='I');
  export defunct_clean_recs_with_state  := all_clean_recs_with_state(seleid_status_private='D');
  export gold_clean_recs_with_state := all_clean_recs_with_state(sele_gold='G');
 
  shared stateInfo_newgold                  := determineStatesForSeleids(header_rec_newgold);
  export all_clean_recs_with_state_newgold  := join(clean_slim_recs_newgold, stateInfo_newgold, left.seleid=right.seleid, transform(slim_rec, self.state:=right.state, self:=left;), left outer, local); 
  export gold_clean_recs_with_state_newgold := all_clean_recs_with_state_newgold(sele_gold='G');
  
  shared MONTHS_6  := 183;
  shared MONTHS_12 := 365;
  shared MONTHS_18 := 548;
  shared YEARS_2   := MONTHS_12 * 2;
  shared YEARS_3   := MONTHS_12 * 3;
  shared YEARS_5 		:= MONTHS_12 * 5;

  export calculateStatsByState(dataset(slim_rec) records, string name) := module
    // Calculate stats per Sele

    shared pre_tally_rec := {
            tally_rec -fein_range_rec -prox_range_rec -source_type_rec,
            header_layout.proxid;
            boolean has_dt_last_seen;
            integer4 daysOld;
            unsigned4 fein_tot;
            boolean src_p, 
            boolean src_b, 
            boolean src_d, 
            boolean src_t, 
            };
												
    shared pre_tally_rec toPreTallyTransform(slim_rec rec) := transform
            self.seleid_tot            := 1; 
            self.seleid_cnt            := 1; 
            self.proxid_tot            := 1; 
            self.proxid_cnt            := if(rec.proxid<>0, 1, 0); 
            self.lexid_tot             := 0; 
            self.lexid_cnt             := if(rec.contact_did<>0, 1, 0); 
            self.private_active_cnt    := if(rec.seleid_status_private='', 1, 0); 
 
            isPrivateInactive          := rec.seleid_status_private='I';
            self.private_inactive_cnt  := if(isPrivateInactive, 1, 0);
            isPrivateDefunt            := rec.seleid_status_private='D';
            self.private_defunct_cnt   := if(isPrivateDefunt, 1, 0);
            self.public_active_cnt     := if(rec.seleid_status_public='', 1, 0);	
 
            isPublicInactive           := rec.seleid_status_public='I';										
            self.public_inactive_cnt   := if(isPublicInactive, 1, 0);
 
            isPublicDefunct            := rec.seleid_status_public='D';
            self.public_defunct_cnt    := if(isPublicDefunct, 1, 0);
            self.gold_cnt              := if(rec.sele_gold='G', 1, 0);
            self.fein_cnt              := if(trim(rec.company_fein)<>'', 1, 0);
												
            self.charter_number_cnt    := if(trim(rec.company_charter_number)<>'', 1, 0);
            self.duns_number_cnt       := if(trim(rec.duns_number)<>'', 1, 0);
            self.enterprise_number_cnt := if(trim(rec.active_enterprise_number)<>'', 1, 0);
            self.phone_cnt             := if(trim(rec.company_phone)<>'', 1, 0);
            self.nonprofit_cnt         := if(MDR.sourceTools.SourceIsIRS_Non_Profit(rec.source), 1, 0);
            self.cortera_cnt           := if(MDR.sourceTools.SourceIsCortera(rec.source), 1, 0);
            self.sec_of_state_cnt      := if(MDR.sourcetools.SourceIsCorpV2(rec.source), 1, 0);
 					
            self.has_dt_last_seen      := rec.dt_last_seen<>0;
						      self.daysOld               := if(self.has_dt_last_seen, STD.Date.DaysBetween(rec.dt_last_seen, reportDate), 1000000);
 
            self.sbfe_cnt              := if(MDR.sourcetools.SourceIsBusiness_Credit(rec.source), 1, 0); 
            self.contact_did_cnt       := if(rec.contact_did<>0, 1, 0); 
            self.sic_cnt               := if(trim(rec.company_sic_code1)<>'' or
                                             trim(rec.company_sic_code2)<>'' or
                                             trim(rec.company_sic_code3)<>'' or
                                             trim(rec.company_sic_code4)<>'' or
                                             trim(rec.company_sic_code5)<>'', 1, 0);
            self.naics_cnt             := if(trim(rec.company_naics_code1)<>'' or
                                             trim(rec.company_naics_code2)<>'' or
                                             trim(rec.company_naics_code3)<>'' or
                                             trim(rec.company_naics_code4)<>'' or
                                             trim(rec.company_naics_code5)<>'', 1, 0);												
 						
            self.src_p                      := isPublicRecordFn(rec.source); 
            self.src_b                      := isBureauFn(rec.source); 
            self.src_d                      := isDirectoryFn(rec.source); 
            self.src_t                      := isTelephoneFn(rec.source); 

            self:=rec;
            self:=[];
    end;
	

					
	   shared pre_tally_rec tallyRoll(pre_tally_rec l, pre_tally_rec r) := transform
            self.seleid_tot            := l.seleid_tot + r.seleid_tot;               // seleid record counts
            self.seleid_cnt            := 1;                                         // 1 per sele
						
            self.gold_cnt              := if(l.gold_cnt=1 or r.gold_cnt=1,1,0);
            self.charter_number_cnt    := if(l.charter_number_cnt=1 or r.charter_number_cnt=1,1,0);
            self.duns_number_cnt       := if(l.duns_number_cnt=1 or r.duns_number_cnt=1,1,0);
            self.enterprise_number_cnt := if(l.enterprise_number_cnt=1 or r.enterprise_number_cnt=1,1,0);
            self.phone_cnt             := if(l.phone_cnt=1 or r.phone_cnt=1,1,0);
            self.nonprofit_cnt         := if(l.nonprofit_cnt=1 or r.nonprofit_cnt=1,1,0);
            self.cortera_cnt           := if(l.cortera_cnt=1 or r.cortera_cnt=1,1,0);
            self.sec_of_state_cnt      := if(l.sec_of_state_cnt=1 or r.sec_of_state_cnt=1,1,0);
 					
            self.has_dt_last_seen      := l.has_dt_last_seen or r.has_dt_last_seen;
            self.daysOld               := if(r.has_dt_last_seen, if(l.has_dt_last_seen, min(l.daysOld, r.daysold), r.daysOld), l.daysOld); 
 
            self.sbfe_cnt              := if(l.sbfe_cnt=1 or r.sbfe_cnt=1,1,0); 
            self.contact_did_cnt       := if(l.contact_did_cnt=1 or r.contact_did_cnt=1,1,0);
            self.sic_cnt               := if(l.sic_cnt=1 or r.sic_cnt=1,1,0); 
            self.naics_cnt             := if(l.naics_cnt=1 or r.naics_cnt=1,1,0); 
						
            self.src_p                 := l.src_p or r.src_p; 
            self.src_b                 := l.src_b or r.src_b; 
            self.src_d                 := l.src_d or r.src_d; 
            self.src_t                 := l.src_t or r.src_t; 
						
            self:=l;
    end;

   shared tally_rec toTallyTransform(pre_tally_rec rec) := transform

            self.recent_0to6m_cnt      := if(rec.daysOld <= MONTHS_6,                        1, 0);
            self.recent_6to12_cnt      := if(rec.daysOld between MONTHS_6  +1 and MONTHS_12, 1, 0);
            self.recent_12to18m_cnt    := if(rec.daysOld between MONTHS_12 +1 and MONTHS_18, 1, 0);
            self.recent_18to24m_cnt    := if(rec.daysOld between MONTHS_18 +1 and YEARS_2,   1, 0);
            recent_2to3y               := rec.daysOld between YEARS_2   +1 and YEARS_3;
            recent_3to5y               := rec.daysOld between YEARS_3   +1 and YEARS_5;
            recent_5y_plus             := rec.has_dt_last_seen and rec.daysOld > YEARS_5;
            self.recent_defunct_2to3y_cnt   := if(recent_2to3y   and rec.private_defunct_cnt>0, 1, 0);
            self.recent_defunct_3to5y_cnt   := if(recent_3to5y   and rec.private_defunct_cnt>0, 1, 0);
            self.recent_defunct_5y_plus_cnt := if(recent_5y_plus and rec.private_defunct_cnt>0, 1, 0);
            self.recent_inactive_2to3y_cnt  := if(recent_2to3y   and not rec.private_defunct_cnt>0, 1, 0);
            self.recent_inactive_3to5y_cnt  := if(recent_3to5y   and not rec.private_defunct_cnt>0, 1, 0);
            self.recent_inactive_5y_plus_cnt:= if(recent_5y_plus and not rec.private_defunct_cnt>0, 1, 0);
            self.recent_unknown_cnt    := if(rec.has_dt_last_seen, 0, 1);
 						
            self.proxid_1              := if(rec.proxid_tot=1, 1, 0);
            self.proxid_2              := if(rec.proxid_tot=2, 1, 0);
            self.proxid_3to4           := if(rec.proxid_tot>=3 and rec.proxid_tot<=4, 1, 0);
            self.proxid_5to10          := if(rec.proxid_tot>=5 and rec.proxid_tot<=10, 1, 0);
            self.proxid_11to25         := if(rec.proxid_tot>=11 and rec.proxid_tot<=25, 1, 0);
            self.proxid_26to100        := if(rec.proxid_tot>=26 and rec.proxid_tot<=100, 1, 0);
            self.proxid_101to500       := if(rec.proxid_tot>=101 and rec.proxid_tot<=500, 1, 0);
            isProxid_501to2000         := rec.proxid_tot>=501 and rec.proxid_tot<=2000;
            isProxid_2001_Plus         := rec.proxid_tot>=2001;
            self.proxid_501to2000      := if(isProxid_501to2000, 1, 0);
            self.proxid_2001_Plus      := if(isProxid_2001_Plus, 1, 0);
						
            self.fein_1                := if(rec.fein_tot=1, 1, 0);
            self.fein_2                := if(rec.fein_tot=2, 1, 0);
            self.fein_3to4             := if(rec.fein_tot>=3 and rec.fein_tot<=4, 1, 0);
            self.fein_5to10            := if(rec.fein_tot>=5 and rec.fein_tot<=10, 1, 0);
            self.fein_11to25           := if(rec.fein_tot>=11 and rec.fein_tot<=25, 1, 0);
            self.fein_26to100          := if(rec.fein_tot>=26 and rec.fein_tot<=100, 1, 0);
            self.fein_101to500         := if(rec.fein_tot>=101 and rec.fein_tot<=500, 1, 0);
            isFein_501to2000           := rec.fein_tot>=501 and rec.fein_tot<=2000;
            isFein_2001_Plus           := rec.fein_tot>=2001;
            self.fein_501to2000        := if(isFein_501to2000, 1, 0);
            self.fein_2001_Plus        := if(isFein_2001_Plus, 1, 0);
 
            self.src_pub               := if(    rec.src_p and not rec.src_b and not rec.src_d, 1, 0);
            self.src_bur               := if(not rec.src_p and     rec.src_b and not rec.src_d, 1, 0);
            self.src_dir               := if(not rec.src_p and not rec.src_b and     rec.src_d, 1, 0);
            self.src_pub_bur           := if(    rec.src_p and     rec.src_b and not rec.src_d, 1, 0);
            self.src_pub_dir           := if(    rec.src_p and not rec.src_b and     rec.src_d, 1, 0);
            self.src_bur_dir           := if(not rec.src_p and     rec.src_b and     rec.src_d, 1, 0);
            self.src_pub_bur_dir       := if(    rec.src_p and     rec.src_b and     rec.src_d, 1, 0);
            self.src_tel_only          := if(not rec.src_p and not rec.src_b and not rec.src_d and     rec.src_t, 1, 0);
            self.src_none              := if(not rec.src_p and not rec.src_b and not rec.src_d and not rec.src_t, 1, 0);
 					
            self:=rec;
    end;	
		
								
    shared tally_rec tallyRollup(tally_rec l, tally_rec r) := transform
            self.seleid_tot            := l.seleid_tot            + r.seleid_tot;
            self.seleid_cnt            := l.seleid_cnt            + r.seleid_cnt;
            self.proxid_tot            := l.proxid_tot            + r.proxid_tot;
            self.proxid_cnt            := l.proxid_cnt            + r.proxid_cnt;	
            self.lexid_tot             := l.lexid_tot             + r.lexid_tot;
            self.lexid_cnt             := l.lexid_cnt             + r.lexid_cnt;
            self.private_active_cnt    := l.private_active_cnt    + r.private_active_cnt;
            self.private_inactive_cnt  := l.private_inactive_cnt  + r.private_inactive_cnt;
            self.private_defunct_cnt   := l.private_defunct_cnt   + r.private_defunct_cnt;
            self.public_active_cnt     := l.public_active_cnt     + r.public_active_cnt;	
            self.public_inactive_cnt   := l.public_inactive_cnt   + r.public_inactive_cnt;
            self.public_defunct_cnt    := l.public_defunct_cnt    + r.public_defunct_cnt;
            self.gold_cnt              := l.gold_cnt              + r.gold_cnt;
            self.fein_cnt              := l.fein_cnt              + r.fein_cnt;
            self.charter_number_cnt    := l.charter_number_cnt    + r.charter_number_cnt;
            self.duns_number_cnt       := l.duns_number_cnt       + r.duns_number_cnt;
            self.enterprise_number_cnt := l.enterprise_number_cnt + r.enterprise_number_cnt;
            self.phone_cnt             := l.phone_cnt             + r.phone_cnt;
            self.nonprofit_cnt         := l.nonprofit_cnt         + r.nonprofit_cnt;
            self.cortera_cnt           := l.cortera_cnt           + r.cortera_cnt;
            self.sec_of_state_cnt      := l.sec_of_state_cnt      + r.sec_of_state_cnt;
            self.recent_0to6m_cnt      := l.recent_0to6m_cnt      + r.recent_0to6m_cnt;
            self.recent_6to12_cnt      := l.recent_6to12_cnt      + r.recent_6to12_cnt;
            self.recent_12to18m_cnt    := l.recent_12to18m_cnt    + r.recent_12to18m_cnt;
            self.recent_18to24m_cnt    := l.recent_18to24m_cnt    + r.recent_18to24m_cnt;					
            self.recent_inactive_2to3y_cnt   := l.recent_inactive_2to3y_cnt   + r.recent_inactive_2to3y_cnt; 
            self.recent_inactive_3to5y_cnt   := l.recent_inactive_3to5y_cnt   + r.recent_inactive_3to5y_cnt;
            self.recent_inactive_5y_plus_cnt := l.recent_inactive_5y_plus_cnt + r.recent_inactive_5y_plus_cnt;							
            self.recent_defunct_2to3y_cnt    := l.recent_defunct_2to3y_cnt    + r.recent_defunct_2to3y_cnt; 
            self.recent_defunct_3to5y_cnt    := l.recent_defunct_3to5y_cnt    + r.recent_defunct_3to5y_cnt;
            self.recent_defunct_5y_plus_cnt  := l.recent_defunct_5y_plus_cnt  + r.recent_defunct_5y_plus_cnt;
            self.recent_unknown_cnt    := l.recent_unknown_cnt    + r.recent_unknown_cnt;

            self.sbfe_cnt              := l.sbfe_cnt              + r.sbfe_cnt;
            self.contact_did_cnt       := l.contact_did_cnt       + r.contact_did_cnt;
            self.sic_cnt               := l.sic_cnt               + r.sic_cnt;
            self.naics_cnt             := l.naics_cnt             + r.naics_cnt;
            self.proxid_1              := l.proxid_1              + r.proxid_1;
            self.proxid_2              := l.proxid_2              + r.proxid_2;
            self.proxid_3to4           := l.proxid_3to4           + r.proxid_3to4;
            self.proxid_5to10          := l.proxid_5to10          + r.proxid_5to10;
            self.proxid_11to25         := l.proxid_11to25         + r.proxid_11to25;
            self.proxid_26to100        := l.proxid_26to100        + r.proxid_26to100;
            self.proxid_101to500       := l.proxid_101to500       + r.proxid_101to500;
            self.proxid_501to2000      := l.proxid_501to2000      + r.proxid_501to2000;
            self.proxid_2001_Plus      := l.proxid_2001_Plus      + r.proxid_2001_Plus;
            self.fein_1                := l.fein_1                + r.fein_1;
            self.fein_2                := l.fein_2                + r.fein_2;
            self.fein_3to4             := l.fein_3to4             + r.fein_3to4;
            self.fein_5to10            := l.fein_5to10            + r.fein_5to10;
            self.fein_11to25           := l.fein_11to25           + r.fein_11to25;
            self.fein_26to100          := l.fein_26to100          + r.fein_26to100;
            self.fein_101to500         := l.fein_101to500         + r.fein_101to500;
            self.fein_501to2000        := l.fein_501to2000        + r.fein_501to2000;
            self.fein_2001_Plus        := l.fein_2001_Plus        + r.fein_2001_Plus;
 
            self.src_pub               := l.src_pub               + r.src_pub;
            self.src_bur               := l.src_bur               + r.src_bur;
            self.src_dir               := l.src_dir               + r.src_dir;
            self.src_pub_bur           := l.src_pub_bur           + r.src_pub_bur;
            self.src_pub_dir           := l.src_pub_dir           + r.src_pub_dir;
            self.src_bur_dir           := l.src_bur_dir           + r.src_bur_dir;
            self.src_pub_bur_dir       := l.src_pub_bur_dir       + r.src_pub_bur_dir;
            self.src_tel_only          := l.src_tel_only          + r.src_tel_only;
            self.src_none              := l.src_none              + r.src_none;
 
            self:=l;
    end;


    shared percent_rec tallyPercent(tally_rec l) := transform
            self.Seleids           := l.seleid_cnt;
            self.Active_Private    := ( (real) l.private_active_cnt)    / l.seleid_cnt;
            self.Inactive_Private  := ( (real) l.private_inactive_cnt)  / l.seleid_cnt;
            self.Defunct_Private   := ( (real) l.private_defunct_cnt)   / l.seleid_cnt;
            self.Active_Public     := ( (real) l.public_active_cnt)     / l.seleid_cnt;
            self.Inactive_Public   := ( (real) l.public_inactive_cnt)   / l.seleid_cnt;
            self.Defunct_Public    := ( (real) l.public_defunct_cnt)    / l.seleid_cnt;
            self.FEIN_Total        := ( (real) l.fein_cnt)              / l.seleid_cnt;
            self.Charter_Num       := ( (real) l.charter_number_cnt)    / l.seleid_cnt;
            self.Duns_Num          := ( (real) l.duns_number_cnt)       / l.seleid_cnt;
            self.Enterprise_Num    := ( (real) l.enterprise_number_cnt) / l.seleid_cnt;
            self.Phone             := ( (real) l.phone_cnt)             / l.seleid_cnt;
            self.Sec_of_State      := ( (real) l.sec_of_state_cnt)      / l.seleid_cnt;
            self.Non_Profit        := ( (real) l.nonprofit_cnt)         / l.seleid_cnt;
            self.Cortera           := ( (real) l.cortera_cnt)           / l.seleid_cnt;												
            self.recent_0to6m      := ( (real) l.recent_0to6m_cnt)      / l.seleid_cnt;
            self.recent_6to12      := ( (real) l.recent_6to12_cnt)      / l.seleid_cnt;
            self.recent_12to18m    := ( (real) l.recent_12to18m_cnt)    / l.seleid_cnt; 
            self.recent_18to24m    := ( (real) l.recent_18to24m_cnt)    / l.seleid_cnt;			      
            self.recent_inactive_2to3y   := ( (real) l.recent_inactive_2to3y_cnt)   / l.seleid_cnt; 
            self.recent_inactive_3to5y   := ( (real) l.recent_inactive_3to5y_cnt)   / l.seleid_cnt;
            self.recent_inactive_5y_plus := ( (real) l.recent_inactive_5y_plus_cnt) / l.seleid_cnt;								   
            self.recent_defunct_2to3y    := ( (real) l.recent_defunct_2to3y_cnt)    / l.seleid_cnt; 
            self.recent_defunct_3to5y    := ( (real) l.recent_defunct_3to5y_cnt)    / l.seleid_cnt;
            self.recent_defunct_5y_plus  := ( (real) l.recent_defunct_5y_plus_cnt)  / l.seleid_cnt;									
            self.recent_unknown    := ( (real) l.recent_unknown_cnt)    / l.seleid_cnt;
 
            self.SBFE              := ( (real) l.sbfe_cnt)              / l.seleid_cnt;
            self.LexId             := ( (real) l.contact_did_cnt)       / l.seleid_cnt;
            self.SIC               := ( (real) l.sic_cnt)               / l.seleid_cnt;
            self.NAICS             := ( (real) l.naics_cnt)             / l.seleid_cnt;
            self.ProxID_1          := ( (real) l.ProxID_1)              / l.seleid_cnt;
            self.ProxID_2          := ( (real) l.ProxID_2)              / l.seleid_cnt;
            self.ProxID_3to4       := ( (real) l.ProxID_3to4)           / l.seleid_cnt;
            self.ProxID_5to10      := ( (real) l.ProxID_5to10)          / l.seleid_cnt;
            self.ProxID_11to25     := ( (real) l.ProxID_11to25)         / l.seleid_cnt;
            self.ProxID_26to100    := ( (real) l.ProxID_26to100)        / l.seleid_cnt;
            self.ProxID_101to500   := ( (real) l.ProxID_101to500)       / l.seleid_cnt;
            self.ProxID_501to2000  := ( (real) l.ProxID_501to2000)      / l.seleid_cnt;
            self.ProxID_2001_Plus  := ( (real) l.ProxID_2001_Plus)      / l.seleid_cnt;
            self.FEIN_1            := ( (real) l.FEIN_1)                / l.seleid_cnt;
            self.FEIN_2            := ( (real) l.FEIN_2)                / l.seleid_cnt;
            self.FEIN_3to4         := ( (real) l.FEIN_3to4)             / l.seleid_cnt;
            self.FEIN_5to10        := ( (real) l.FEIN_5to10)            / l.seleid_cnt;
            self.FEIN_11to25       := ( (real) l.FEIN_11to25)           / l.seleid_cnt;
            self.FEIN_26to100      := ( (real) l.FEIN_26to100)          / l.seleid_cnt;
            self.FEIN_101to500     := ( (real) l.FEIN_101to500)         / l.seleid_cnt;
            self.FEIN_501to2000    := ( (real) l.FEIN_501to2000)        / l.seleid_cnt;
            self.FEIN_2001_Plus    := ( (real) l.FEIN_2001_Plus)        / l.seleid_cnt;;
            self:=l;
    end;
								
    shared report_rec toReportRec(tally_rec l) := transform
            self.records            := l.seleid_tot;
            self.seleids            := l.seleid_cnt;
            self.Recs_per_Sele      := l.seleid_tot / l.seleid_cnt;
            self.Prox_per_Sele      := l.proxid_tot / l.seleid_cnt;
            self.Lexid_per_Sele     := l.lexid_tot  / l.seleid_cnt;

            self.Active_Private     := l.private_active_cnt;		
            self.Inactive_Private   := l.private_inactive_cnt;
            self.Defunct_Private    := l.private_defunct_cnt;
            self.Active_Public      := l.public_active_cnt;		
            self.Inactive_Public    := l.public_inactive_cnt;
            self.Defunct_Public     := l.public_defunct_cnt;

            self.Charter_Num        := l.charter_number_cnt;			
            self.Duns_Num           := l.duns_number_cnt;
            self.Enterprise_Num     := l.enterprise_number_cnt;
            self.Phone              := l.phone_cnt;
            self.Non_Profit         := l.nonprofit_cnt;
            self.Cortera            := l.cortera_cnt;
            self.Sec_of_State       := l.sec_of_state_cnt;

            self.recent_0to6m       := l.recent_0to6m_cnt;
            self.recent_6to12       := l.recent_6to12_cnt;
            self.recent_12to18m     := l.recent_12to18m_cnt;
            self.recent_18to24m     := l.recent_18to24m_cnt;
            self.recent_defunct_2to3y    := l.recent_defunct_2to3y_cnt;
            self.recent_defunct_3to5y    := l.recent_defunct_3to5y_cnt;
            self.recent_defunct_5y_plus  := l.recent_defunct_5y_plus_cnt;
            self.recent_inactive_2to3y   := l.recent_inactive_2to3y_cnt;
            self.recent_inactive_3to5y   := l.recent_inactive_3to5y_cnt;
            self.recent_inactive_5y_plus := l.recent_inactive_5y_plus_cnt;	
            self.recent_unknown     := l.recent_unknown_cnt;
 	
            self.SBFE               := l.sbfe_cnt;
            self.LexId              := l.contact_did_cnt;
            self.SIC                := l.sic_cnt;
            self.NAICS              := l.naics_cnt;
 
            self := l;
    end;
			
    export preTally := project(records, toPreTallyTransform(left));
    export preTallyRoll := rollup(sort(preTally, seleid, proxid, local), left.seleid=right.seleid, tallyRoll(left,right), local);

    export uniqueProxids := table(records(proxid<>0), {seleid, proxid}, seleid, proxid, local);
    export proxid_count := table(uniqueProxids, {seleid, cnt:=count(group)}, seleid, local);
    export preTallyWithProxid := join(preTallyRoll,    proxid_count, left.seleid=right.seleid, transform(pre_tally_rec, self.proxid_tot:=right.cnt; self.proxid_cnt:=if(right.cnt>0, 1, 0); self:=left), keep(1), left outer, local);

    export uniqueLexids := table(records(contact_did<>0), {seleid, contact_did}, seleid, contact_did, local);
    export lexid_count := table(uniqueLexids, {seleid, cnt:=count(group)}, seleid, local);
    export preTallyWithLexid := join(preTallyWithProxid,    lexid_count, left.seleid=right.seleid, transform(pre_tally_rec, self.lexid_tot:=right.cnt; self.lexid_cnt:=if(right.cnt>0, 1, 0); self.contact_did_cnt:=if(right.cnt>0, 1, 0); self:=left), keep(1), left outer, local);

    export uniqueFein := table(records(trim(company_fein)<>''), {seleid, company_fein}, seleid, company_fein, local);
    export fein_count := table(uniqueFein, {seleid, cnt:=count(group)}, seleid, local);	
    export preTallyWithFein  := join(preTallyWithLexid, fein_count,  left.seleid=right.seleid, transform(pre_tally_rec, self.fein_tot:=right.cnt; self.fein_cnt:=if(right.cnt>0, 1, 0); self:=left), keep(1), left outer, local);

    export statsBySele := project(preTallyWithFein, toTallyTransform(left));

    seleByStateDist := distribute(statsBySele, hash32(state));
    shared seleByStateDist_s := sort(seleByStateDist, state, skew(1.0), local);

    export  tallyByState := rollup(seleByStateDist_s, tallyRollup(LEFT, RIGHT), state, local);
		  
    // Doing this as a local rollup (gets 400 results) followed by non-local saves 5 min
    // each for the per state and per segmentation stat rollup.
            tallyLocal := rollup(statsBySele, true, tallyRollup(LEFT, RIGHT), LOCAL);
    export  tallyAll := rollup(tallyLocal, true, tallyRollup(LEFT, RIGHT));	
	
    export percentStateReport := project(tallyByState, tallyPercent(left));			
    export percentAllReport := project(project(tallyAll, tallyPercent(left)), transform(percent_rec, self.state:='ALL'; self:=left));
    export percentAllAndStateReport := sort(percentAllReport + percentStateReport, state<>'ALL', -seleids);				

    export countsStateReport := project(tallyByState, toReportRec(left));			
    export countsAllReport := project(project(tallyAll, toReportRec(left)), transform(report_rec, self.state:='ALL'; self:=left));
    export countsAllAndStateReport := sort(countsAllReport + countsStateReport, state<>'ALL', -seleids);				


    named_count_rec := {
        string name;
        report_rec;
    };
 
    export allCountSummary := sort(project(countsAllReport, transform(named_count_rec, self.name:=name; self:=left)), -seleids);
				
    named_percent_rec := {
        string name;
        percent_rec;
    };
				
    export allPercentSummary := sort(project(percentAllReport, transform(named_percent_rec, self.name:=name; self:=left)), -seleids);
  end;
 
  export allStats      := calculateStatsByState(all_clean_recs_with_state,     'All');
  export activeStats   := calculateStatsByState(active_clean_recs_with_state,  'Active');
  export inactiveStats := calculateStatsByState(inactive_clean_recs_with_state,'Inactive');
  export defunctStats  := calculateStatsByState(defunct_clean_recs_with_state, 'Defunct');
  export goldStats     := calculateStatsByState(gold_clean_recs_with_state,    'Gold');
 
  export allStats_newgold  := calculateStatsByState(all_clean_recs_with_state_newgold,  'All');
  export goldStats_newgold := calculateStatsByState(gold_clean_recs_with_state_newgold, 'Gold');

  segDsCleanCatagories  := BIPV2_PostProcess.segmentation_category.perSeleid(header_clean, (string) reportDate); 
  noSegRecords          := join(header_rec, segDsCleanCatagories, left.seleid=right.seleid, transform(left), left only, local);
  noSegOnlyCatagories   := BIPV2_PostProcess.segmentation_category.perSeleid(distribute(noSegRecords,hash32(seleid)), (string) reportDate);  
  shared segCatagories  := segDsCleanCatagories + noSegOnlyCatagories;
	
  shared generateSegStats(dataset(slim_rec) slim) := function
					 SC := BIPV2_PostProcess.segmentation_category;
      allRecsWithSeg := join(slim, segCatagories, left.seleid=right.seleid, 
                             transform(recordof(slim),
                                       self.state := map(right.seleid=0 => 'NO SEG',
                                                       right.category=SC.category.Gold => 'Gold',
                                                       right.category=SC.category.Active and right.subCategory=SC.subCategory.Valid => 'Active Valid',
                                                       right.category=SC.category.Active and right.subCategory=SC.subCategory.C_Merge => 'Active C-Merge',
                                                       right.category=SC.category.Active and right.subCategory=SC.subCategory.Noise => 'Active Noise',
                                                       right.category=SC.category.Inactive and right.subCategory=SC.subCategory.Valid => 'Inactive Valid',
                                                       right.category=SC.category.Inactive and right.subCategory=SC.subCategory.H_Merge => 'Inactive H-Merge',
                                                       right.category=SC.category.Inactive and right.subCategory=SC.subCategory.Noise => 'Inactive Noise',
                                                       right.category=SC.category.Defunct => 'Defunct',
                                                       'BLANK');
                                       self := left;),
                             left outer, keep(1), local);
      return calculateStatsByState(allRecsWithSeg, 'Seg');
  end;
	 
  export rawSegStats   := generateSegStats(raw_slim_recs);
  export cleanSegStats := generateSegStats(clean_slim_recs);
	
  segDsCleanCatagories_newgold  := BIPV2_PostProcess.segmentation_category.perSeleid(header_clean_newgold, (string) reportDate  ,true); 
  noSegRecords_newgold          := join(header_rec_newgold, segDsCleanCatagories_newgold, left.seleid=right.seleid, transform(left), left only, local);
  noSegOnlyCatagories_newgold   := BIPV2_PostProcess.segmentation_category.perSeleid(distribute(noSegRecords_newgold,hash32(seleid)), (string) reportDate ,true);  
  shared segCatagories_newgold  := segDsCleanCatagories_newgold + noSegOnlyCatagories_newgold;

// -- use new active status score fields in categories
  shared generateSegStats_withscores(dataset(slim_rec) slim) := 
  function
    SC := BIPV2_PostProcess.segmentation_category;
    allRecsWithSeg := join(slim, segCatagories_newgold, left.seleid=right.seleid, 
      transform(recordof(slim),
        self.state := map(
            right.seleid    = 0                                                                         => 'NO SEG'
           ,right.category  = SC.category.Gold                                                          => 'Gold'
           ,right.category  = SC.category.Active    and right.subCategory = SC.subCategory.High_Valid   => 'Active High Valid'
           ,right.category  = SC.category.Active    and right.subCategory = SC.subCategory.Medium_Valid => 'Active Medium Valid'
           ,right.category  = SC.category.Active    and right.subCategory = SC.subCategory.Low_Valid    => 'Active Low Valid'
           ,right.category  = SC.category.Active    and right.subCategory = SC.subCategory.C_Merge      => 'Active C-Merge'
           ,right.category  = SC.category.Active    and right.subCategory = SC.subCategory.Noise        => 'Active Noise'
           ,right.category  = SC.category.Inactive  and right.subCategory = SC.subCategory.Valid        => 'Inactive Valid'
           ,right.category  = SC.category.Inactive  and right.subCategory = SC.subCategory.H_Merge      => 'Inactive H-Merge'
           ,right.category  = SC.category.Inactive  and right.subCategory = SC.subCategory.Noise        => 'Inactive Noise'
           ,right.category  = SC.category.Defunct                                                       => 'Defunct'
           ,                                                                                               'BLANK'
        );
        self := left;),
      left outer, keep(1), local);
    return calculateStatsByState(allRecsWithSeg, 'Seg');
  end;
	 
  export rawSegStats_scores   := generateSegStats_withscores(raw_slim_recs_newgold   );
  export cleanSegStats_scores := generateSegStats_withscores(clean_slim_recs_newgold );

  export segSortOrder(x) := 
  functionmacro
             return sort(x
              ,state='NO SEG'
              ,state='Defunct'
              ,state='Inactive Noise'
              ,state='Inactive H-Merge'
              ,state='Inactive Valid'
              ,state='Active Noise'
              ,state='Active C-Merge'
              ,state='Active Valid'
              ,state='Active Low Valid'
              ,state='Active Medium Valid'
              ,state='Active High Valid'
              ,state='Gold'
              ,state='ALL'
  );
  endmacro;

  export formatBySegment(dataset(report_rec) report) := function
        format := project(report, {report_rec -SBFE -source_type_rec}); 
        return segSortOrder(format);
  end;

  export formatBySegmentSourceMakeup(dataset(report_rec) report) := function
      format := project(report, transform({report.state, report.records,	report.seleids, source_type_rec}, self:=left)); 
      return segSortOrder(format);
		end ;

	export formatBySegmentSourceMakeupSBFE(dataset(report_rec) report) := function
						format := project(report, transform({report.state, report.records,	report.seleids, source_type_rec, report.SBFE}, self:=left)); 
						return segSortOrder(format);
  end ;

  export formatCntActiveOnly(dataset(report_rec) report) := function 
      return project(report, {report_rec -seleids -SBFE -Inactive_Private -Defunct_Private -recent_defunct_2to3y -recent_defunct_3to5y -recent_defunct_5y_plus -recent_inactive_2to3y -recent_inactive_3to5y -recent_inactive_5y_plus -recent_unknown -source_type_rec });
		end ;

  export formatCntInactiveOnly(dataset(report_rec) report) := function 
      return project(report, {report_rec -seleids -SBFE -Active_Private -Defunct_Private  -recent_defunct_2to3y -recent_defunct_3to5y -recent_defunct_5y_plus -source_type_rec });
		end ;

  export formatCntDefunctOnly(dataset(report_rec) report) := function 
      return project(report, {report_rec -seleids -SBFE  -Active_Private -Inactive_Private  -recent_inactive_2to3y -recent_inactive_3to5y -recent_inactive_5y_plus -source_type_rec });
		end ;
    
		export formatCntAll(dataset(report_rec) report) := function 
      return project(report, {report_rec -seleids  -SBFE -source_type_rec});
  end ;
 
  export formatPercentActiveOnly(dataset(percent_rec) report) := function
      return project(report, {percent_rec -seleids -SBFE -Inactive_Private -Defunct_Private -recent_defunct_2to3y -recent_defunct_3to5y -recent_defunct_5y_plus -recent_inactive_2to3y -recent_inactive_3to5y -recent_inactive_5y_plus -recent_unknown});
  end ;

  export formatPercentInactiveOnly(dataset(percent_rec) report) := function
      return project(report, {percent_rec -seleids -SBFE -Active_Private -Defunct_Private -recent_defunct_2to3y -recent_defunct_3to5y -recent_defunct_5y_plus});
  end ;

  export formatPercentDefunctOnly(dataset(percent_rec) report) := function
      return project(report, {percent_rec -seleids -SBFE -Active_Private -Inactive_Private -recent_inactive_2to3y -recent_inactive_3to5y -recent_inactive_5y_plus});
  end ;
	
  export formatPercentAll(dataset(percent_rec) report) := function
      return project(report, {percent_rec -SBFE -seleids });
  end ;	

end;