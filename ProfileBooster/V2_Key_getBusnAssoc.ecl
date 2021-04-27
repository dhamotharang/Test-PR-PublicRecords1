IMPORT ProfileBooster, _Control, BIPV2, BIPV2_Crosswalk, paw, riskwise, ut, risk_indicators, AML, MDR, Doxie, Suppress ;
onThor := _Control.Environment.OnThor; 

EXPORT V2_Key_getBusnAssoc( DATASET(ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim) PBslim, 
									 doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION;

l_lexid_links := record
          unsigned6 contact_did;
          unsigned6 uniqueID;
     end;

crosswalkInputs := PROJECT(PBslim, TRANSFORM(l_lexid_links, SELF.contact_did:=LEFT.did2; SELF.uniqueID:=LEFT.seq;));
string1 Level := BIPV2.IDconstants.Fetch_Level_SeleID;
BIPV2CrosswalkResult := BIPV2_Crosswalk.Key_ConsumerToBip.getDataFiltered(crosswalkInputs,Level, 
                    // BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
                    // boolean IncludeStatus = true,
                    // JoinLimit=25000,
                    // unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin,
                    // set of string sourcesToInclude = ALL,
                    // set of string sourceGroupsToInclude = ALL,
                    applyMarketingRestrictions := true,
                    mod_access := mod_access);

ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_Crosswalk append_crosswalk(pbslim le, BIPV2_Crosswalk.Layouts.ConsumerToBipFinalRec rt) := TRANSFORM
    SELF.seq := le.seq;
	SELF.did := le.did;
	SELF.did2 := le.did2;
	SELF.historydate := le.historydate;
	SELF.rec_type := le.rec_type;
	SELF.uniqueID := rt.uniqueID;
    SELF.ultid := rt.ultid;
    SELF.orgid := rt.orgid;
    SELF.seleid := rt.seleid;
    SELF.proxid := rt.proxid;
    SELF.contact_did := rt.contact_did;          
    SELF.dt_first_seen := rt.dt_first_seen;
    SELF.dt_last_seen := rt.dt_last_seen;
    SELF.dt_first_seen_at_business := rt.dt_first_seen_at_business;
    SELF.dt_last_seen_at_business := rt.dt_last_seen_at_business;
    SELF.executive_ind_order := rt.executive_ind_order;
    SELF.job_title1 := rt.job_title1;
    SELF.job_title2 := rt.job_title2;
    SELF.job_title3 := rt.job_title3;
	SELF.BusAssocFlagEv := IF(rt.contact_did>0,1,-99998);
	monthsAgo := ut.MonthsApart(((STRING8)risk_indicators.iid_constants.myGetDate(le.historydate))[1..6],((STRING8)rt.dt_first_seen_at_business)[1..6]);
	SELF.BusAssocOldMSnc := IF(rt.dt_first_seen_at_business=0,-99997,monthsAgo);
	job_title := MAP(rt.job_title1<>'' => rt.job_title1,
	                 rt.job_title2<>'' => rt.job_title2,
					                      rt.job_title3);	
	titleRank := AML.AMLTitleRank(job_title);
	SELF.BusLeadershipTitleFlag := MAP(job_title=''   => -99997,
		                               titleRank <= 3 => 1, 
									                     0);
	SELF.BusAssocCntEv := IF(rt.contact_did>0,1,0);	
	SELF := le;
	SELF := [];
END;

with_crosswalk_thor := JOIN(
	DISTRIBUTE(PBslim,did2), 
	DISTRIBUTE(BIPV2CrosswalkResult,contact_did),
	LEFT.did2=RIGHT.contact_did
	AND (UNSIGNED4)(((STRING8)RIGHT.dt_first_seen)[1..6])<=(UNSIGNED4)(((STRING8)LEFT.historydate)[1..6]),
	append_crosswalk(LEFT,RIGHT),
	KEEP(100), local);

ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_Crosswalk roll_crosswalk(ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_Crosswalk le, ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_Crosswalk ri) := TRANSFORM
    use_right := ri.dt_first_seen_at_business > le.dt_first_seen_at_business;
	SELF.BusAssocFlagEv := MAX(le.BusAssocFlagEv, ri.BusAssocFlagEv);
	SELF.BusAssocOldMSnc := MAX(le.BusAssocOldMSnc, ri.BusAssocOldMSnc);
	SELF.BusLeadershipTitleFlag := MAX(le.BusLeadershipTitleFlag, ri.BusLeadershipTitleFlag);
	SELF.BusAssocCntEv := le.BusAssocCntEv + ri.BusAssocCntEv;
	SELF.dt_first_seen_at_business := if(use_right, ri.dt_first_seen_at_business, le.dt_first_seen_at_business);
    SELF.dt_last_seen_at_business := if(use_right, ri.dt_last_seen_at_business, le.dt_last_seen_at_business);
    SELF.executive_ind_order := if(use_right, ri.executive_ind_order, le.executive_ind_order);
    SELF.job_title1 := if(use_right, ri.job_title1, le.job_title1);
    SELF.job_title2 := if(use_right, ri.job_title2, le.job_title2);
    SELF.job_title3 := if(use_right, ri.job_title3, le.job_title3);

	SELF := le;
END;

with_crosswalk_rolled_tmp := ROLLUP(SORT(with_crosswalk_thor,seq,did,did2,-dt_first_seen_at_business,-dt_last_seen_at_business,-dt_first_seen,-dt_last_seen), LEFT.did=RIGHT.did AND LEFT.did2=RIGHT.did2, roll_crosswalk(LEFT,RIGHT));

RETURN with_crosswalk_rolled_tmp ;

END;