IMPORT _Control, paw, riskwise, ut, risk_indicators, AML, MDR;
onThor := _Control.Environment.OnThor;

export getBusnAssoc( DATASET(ProfileBooster.Layouts.Layout_PB_Slim) PBslim) := FUNCTION;


ProfileBooster.Layouts.Layout_PB_Slim_PAW append_contact_id(pbslim le, paw.key_did rt) := transform
	self.seq := le.seq;
	self.did := le.did;
	self.did2 := le.did2;
	self.historydate := le.historydate;
	self.rec_type := le.rec_type;
	self.contact_id := rt.contact_id;
	self := [];
end;

with_contactID_roxie := join(PBslim, paw.Key_Did,
								right.contact_id<>0 and left.did2<>0 and
								keyed(left.did2=right.did), 
								append_contact_id(left, right),
								atmost(riskwise.max_atmost), keep(100));

with_contactID_thor := join(
	distribute(PBslim(did2<>0), did2),
	distribute(pull(paw.Key_Did(contact_id<>0)), did),
								left.did2=right.did, 
								append_contact_id(left, right),
								atmost(riskwise.max_atmost), keep(100), local);
								
#IF(onThor)
	with_contactID := with_contactID_thor;
#ELSE
	with_contactID := with_contactID_roxie;
#END


ProfileBooster.Layouts.Layout_PB_Slim_PAW append_paw_details(with_contactID le, paw.Key_contactid rt) := transform
	self.seq := le.seq;
	self.did := le.did;
	self.did2 := le.did2;
	self.historydate := le.historydate;								
	self.rec_type := le.rec_type;								
	self.contact_id := le.contact_id;
	self.bid :=  (string)rt.bdid;  
	self.company_title := rt.company_title;  // most recent company title
	self.dt_first_seen := rt.dt_first_seen;
	self.dt_last_seen := rt.dt_last_seen;											
	self.OccBusinessAssociation := if(rt.contact_id <> 0, 1, 0);
	monthsAgo := ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],rt.dt_first_seen[1..6]);
	self.OccBusinessAssociationTime := monthsAgo;	
	titleRank := AML.AMLTitleRank(rt.company_title);
	self.OccBusinessTitleLeadership := if(titleRank <= 3, 2, 1);											
	self := le;
end;
								
pawTitle_roxie := join(with_contactID, paw.Key_contactid,
								 right.contact_id<>0 and 
								 right.bdid <> 0 and
								 right.company_title <> '' and
								 right.dt_first_seen <> '' and
								 trim(right.company_status)<>'DEAD' and
								 right.source <> MDR.sourceTools.src_Dunn_Bradstreet and
								 keyed(left.contact_id=right.contact_id) and  
								(unsigned)right.dt_first_seen[1..6] < left.historydate, 
								 append_paw_details(left, right),
								 atmost(riskwise.max_atmost), keep(1));  

pawTitle_thor := join(
	distribute(with_contactID, contact_id), 
	distribute(pull(paw.Key_contactid(contact_id<>0 and 
								 bdid <> 0 and
								 company_title <> '' and
								 dt_first_seen <> '' and
									trim(company_status)<>'DEAD' and source <> MDR.sourceTools.src_Dunn_Bradstreet)), contact_id),
								 left.contact_id=right.contact_id and  
								(unsigned)right.dt_first_seen[1..6] < left.historydate, 
								 append_paw_details(left, right),
								 atmost(left.contact_id=right.contact_id,riskwise.max_atmost), keep(1),
	local); 

#IF(onThor)
	pawTitle := pawTitle_thor;
#ELSE
	pawTitle := pawTitle_roxie;
#END

SortPAW :=  sort(pawTitle, seq, did2, -dt_last_seen);

ProfileBooster.Layouts.Layout_PB_Slim_PAW rollPAW(SortPAW le, SortPAW ri) := TRANSFORM
	self.OccBusinessAssociation 		:= max(le.OccBusinessAssociation,ri.OccBusinessAssociation);	
	self.OccBusinessAssociationTime	:= max(le.OccBusinessAssociationTime, ri.OccBusinessAssociationTime);	//save oldest 
	self.OccBusinessTitleLeadership	:= le.OccBusinessTitleLeadership;	  //keep most recent
	self								 						:= le;
END;

RolledPAW :=  rollup(SortPAW, left.seq = right.seq and left.did2 = right.did2,
										 rollPAW(left, right));
										
// output(PBslim, named('PBslim'));
// output(withPAW, named('withPAW'));
// output(pawTitle, named('pawTitle'));
// output(SortPAW, named('SortPAW'));
// output(RolledPAW, named('RolledPAW'));

return RolledPAW ;

END;