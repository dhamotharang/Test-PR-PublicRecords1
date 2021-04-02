IMPORT ProfileBooster, _Control, BIPV2, BIPV2_Crosswalk, paw, riskwise, ut, risk_indicators, AML, MDR, Doxie, Suppress ;
onThor := _Control.Environment.OnThor; 

EXPORT V2_getBusnAssoc( DATASET(ProfileBooster.V2_Layouts.Layout_PB2_Slim) PBslim, 
									 doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION;

// BIPV2 Crosswalk ////http://10.173.101.101:8010/?NodeGroup=roxie_cert_pull&LogicalName=key::bipv2::crosswalk::20210202::consumer2biz&Widget=ResultWidget
// BIPV2_Crosswalk.BusinessLinks
// BusAssocFlagEv - Crosswalk:Indicates that the prospect has a formal connection with a business, based on business association records
// BusAssocOldMSnc - Crosswalk:Time (in months) since a formal business association with the prospect was first reported
// BusLeadershipTitleFlag
// BusAssocCntEv
// modAccessDefault := MODULE(doxie.IDataAccess) END;
// modaccess := module(Doxie.iDataAccess)
// 	EXPORT BOOLEAN isMarketing := TRUE;
// end;

// inputDs := PROJECT(PBslim, TRANSFORM(BIPV2_Crosswalk.IdLinkLayouts.crosswalkInput,
// 	SELF.request_id := LEFT.seq;
// 	SELF.consumer.did := LEFT.did2;
// 	SELF := LEFT;
// 	SELF := [];
// ));
	// export crosswalkInput := {
	// 	BIPV2.IdAppendLayouts.AppendInput.request_id,
	// 	consumerInput consumer,
	// 	businessInput business,
	// };
	
	// export consumerInput := {
	// 	DidVille.Layout_Did_InBatch - seq,
	// 	unsigned8 did
	// };
//   EXPORT Layout_PB2_Slim := RECORD
//     unsigned4 seq;
//     unsigned6 DID;
//     unsigned6 DID2;
//     unsigned3 historydate := 999999;
//     unsigned1 rec_type := 1; //1=Prospect, 2=Household, 3=Relative/Associate
//     string20  fname;
//     string20  lname;
//     string10  prim_range;
//     string2   predir;
//     string28  prim_name;
//     string4   addr_suffix;
//     string2   postdir;
//     string10  unit_desig;
//     string8   sec_range;
//     string25  p_city_name;
//     string2   st;
//     string5   z5;
//   END;

// cw := bipv2_crosswalk.BusinessLinks(inputDs
// 	,useInputLexid := TRUE
// 	,useInputBipId := FALSE
// 	,bipWeight := 0
// 	,consumerScore := 51
// 	,bipScore := 0
// 	,onlyTopContact := FALSE
// 	,onlyTopBusiness := FALSE
// 	,allowNoLexid := FALSE
// 	,fetchLevel := BIPV2.IDconstants.Fetch_Level_SeleID
// 	,consumerSegmentation := ALL
// 	,businessSegmentation := ALL
// 	,sourcesToInclude := ALL
// 	,mod_access := mod_access
// );
// s := cw.summary;
// output(cw);

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

ProfileBooster.V2_Layouts.Layout_PB2_Slim_Crosswalk append_crosswalk(pbslim le, BIPV2_Crosswalk.Layouts.ConsumerToBipFinalRec rt) := TRANSFORM
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
    // SELF.sourceInfo := rt.sourceInfo;
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

ProfileBooster.V2_Layouts.Layout_PB2_Slim_Crosswalk roll_crosswalk(ProfileBooster.V2_Layouts.Layout_PB2_Slim_Crosswalk le, ProfileBooster.V2_Layouts.Layout_PB2_Slim_Crosswalk ri) := TRANSFORM
	// sameDID := le.did2=ri.did2;
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


// ProfileBooster.V2_Layouts.Layout_PB2_Slim_PAW append_contact_id(pbslim le, paw.key_did rt) := transform
// 	SELF.seq := le.seq;
// 	SELF.did := le.did;
// 	SELF.did2 := le.did2;
// 	SELF.historydate := le.historydate;
// 	SELF.rec_type := le.rec_type;
// 	SELF.contact_id := rt.contact_id;
// 	self := [];
// end;

// with_contactID_thor := join(
// 	distribute(PBslim(did2<>0), did2),
// 	distribute(pull(paw.Key_Did(contact_id<>0)), did),
// 								left.did2=right.did, 
// 								append_contact_id(left, right),
// 								atmost(riskwise.max_atmost), keep(100), local);
								
// with_contactID := with_contactID_thor;

// {ProfileBooster.V2_Layouts.Layout_PB2_Slim_PAW, UNSIGNED4 global_sid} append_paw_details(with_contactID le, paw.Key_contactid rt) := transform
// 	SELF.global_sid := rt.global_sid;
// 	SELF.seq := le.seq;
// 	SELF.did := le.did;
// 	SELF.did2 := le.did2;
// 	SELF.historydate := le.historydate;								
// 	SELF.rec_type := le.rec_type;								
// 	SELF.contact_id := le.contact_id;
// 	SELF.bid :=  (string)rt.bdid;  
// 	SELF.company_title := rt.company_title;  // most recent company title
// 	SELF.dt_first_seen := rt.dt_first_seen;
// 	SELF.dt_last_seen := rt.dt_last_seen;											
// 	SELF.OccBusinessAssociation := if(rt.contact_id <> 0, 1, 0);
// 	monthsAgo := ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],rt.dt_first_seen[1..6]);
// 	SELF.OccBusinessAssociationTime := monthsAgo;	
// 	titleRank := AML.AMLTitleRank(rt.company_title);
// 	SELF.OccBusinessTitleLeadership := if(titleRank <= 3, 2, 1);											
// 	self := le;
// end;
								
// pawTitle_thor_unsuppressed := join(
// 	distribute(with_contactID, contact_id), 
// 	distribute(pull(paw.Key_contactid(contact_id<>0 and 
// 								 bdid <> 0 and
// 								 company_title <> '' and
// 								 dt_first_seen <> '' and
// 									trim(company_status)<>'DEAD' and source <> MDR.sourceTools.src_Dunn_Bradstreet)), contact_id),
// 								 left.contact_id=right.contact_id and  
// 								(unsigned)right.dt_first_seen[1..6] < left.historydate, 
// 								 append_paw_details(left, right),
// 								 atmost(left.contact_id=right.contact_id,riskwise.max_atmost), keep(1),
// 	local); 

// pawTitle_thor := Suppress.Suppress_ReturnOldLayout(pawTitle_thor_unsuppressed, mod_access, ProfileBooster.V2_Layouts.Layout_PB2_Slim_PAW);

// pawTitle := pawTitle_thor;

// SortPAW :=  sort(pawTitle, seq, did2, -dt_last_seen);

// ProfileBooster.V2_Layouts.Layout_PB2_Slim_PAW rollPAW(SortPAW le, SortPAW ri) := TRANSFORM
// 	SELF.OccBusinessAssociation 	:= max(le.OccBusinessAssociation,ri.OccBusinessAssociation);	
// 	SELF.OccBusinessAssociationTime	:= max(le.OccBusinessAssociationTime, ri.OccBusinessAssociationTime);	//save oldest 
// 	SELF.OccBusinessTitleLeadership	:= le.OccBusinessTitleLeadership;	  //keep most recent
// 	self								 						:= le;
// END;

// RolledPAW :=  rollup(SortPAW, left.seq = right.seq and left.did2 = right.did2,
// 										 rollPAW(left, right));
										
output(choosen(PBslim,100), NAMED('PBslim'));
output(choosen(with_crosswalk_thor,100), NAMED('with_crosswalk_thor'));
output(choosen(with_crosswalk_rolled_tmp,100), NAMED('with_crosswalk_rolled_tmp'));
// output(choosen(withPAW,100), NAMED('withPAW'));
// output(choosen(pawTitle,100), NAMED('pawTitle'));
// output(choosen(SortPAW,100), NAMED('SortPAW'));
// output(choosen(RolledPAW,100), NAMED('RolledPAW'));
// output(choosen(s,100), named('summary'));
RETURN with_crosswalk_rolled_tmp ;

END;