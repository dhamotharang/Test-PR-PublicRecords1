IMPORT ProfileBooster, _Control, Doxie, eMerges, RiskWise, Risk_Indicators, ut;
onThor := _Control.Environment.OnThor;

EXPORT V2_Key_getSports(DATASET(ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim) PBslim1) := FUNCTION

PBSlim := PBslim1(did<>0);

//hunting and fishing
sportsDIDkey := eMerges.Key_HuntFish_Did(false);

ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_sports	addSportsIDs(PBslim le, sportsDIDkey ri) := transform
      self.rid 	:= ri.rid;
			self 			:= le;
      self 			:= [];
	end; 

sportsDIDs_roxie := join(PBslim, sportsDIDkey,
							Keyed(left.did = right.did),
							addSportsIDs(left,right),
							atmost(riskwise.max_atmost));
							
sportsDIDs_thor := join(
	distribute(PBslim, did), 
	distribute(pull(sportsDIDkey), did),
							left.did = right.did,
							addSportsIDs(left,right),
							atmost(riskwise.max_atmost), 
	local);

#IF(onThor)
	sportsDIDs := sportsDIDs_thor;
#ELSE
	sportsDIDs := sportsDIDs_roxie;
#END

sportsRIDkey := eMerges.Key_HuntFish_Rid(false);

ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_sports	addSportsDetails(sportsDIDs le, sportsRIDkey ri) := transform
			dateLicense					      := if(ri.dateLicense[5..6] = '', ri.dateLicense[1..4] + '1201', ri.dateLicense[1..6] + '01');  //default month to 12 if not populated and just default day to 01
			validdate 					      := Doxie.DOBTools((integer)dateLicense).IsValidDOB;
			monthsApart					      := if(~validdate, 99, ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],dateLicense)); //if date isn't valid, don't use
			self.IntSportPersonFlagEv := if(ri.file_id in ['HUNT', 'FISH'], 1, 0);
			self.IntSportPersonFlag1Y := if(ri.file_id in ['HUNT', 'FISH'] and monthsApart < 13, 1, 0);
			self.IntSportPersonFlag5Y := if(ri.file_id in ['HUNT', 'FISH'] and monthsApart < 61, 1, 0);
			self.IntSportPersonTravelerFlagEv := if(ri.file_id in ['HUNT', 'FISH'] and TRIM(ri.source_state)[1..2]<>TRIM(le.st)[1..2] and TRIM(ri.source_state)<>'' AND TRIM(le.st)[1..2]<>'', 1, 0);
			self 								      := le;
			self 								      := [];
	end;
	
sportsDetails_roxie := join(sportsDIDs, sportsRIDkey,
							Keyed(left.RID = right.RID) and
							right.dateLicense <> '',
							addSportsDetails(left,right),
							atmost(riskwise.max_atmost));

sportsDetails_thor := join(
	distribute(sportsDIDs, rid), 
	distribute(pull(sportsRIDkey(dateLicense <> '')), rid),
							left.RID = right.RID,
							addSportsDetails(left,right),
							atmost(riskwise.max_atmost),
	local);

#IF(onThor)
	sportsDetails := sportsDetails_thor;
#ELSE
	sportsDetails := sportsDetails_roxie;
#END

//conceal and carry
ccwDIDkey := eMerges.key_ccw_did(false);

ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_sports	addCCWIDs(PBslim le, ccwDIDkey ri) := transform
      self.rid 	:= ri.rid;
			self 			:= le;
      self 			:= [];
	end; 

ccwDIDs_roxie := join(PBslim, ccwDIDkey,
							Keyed(left.did = right.did_out6),
							addCCWIDs(left,right),
							atmost(riskwise.max_atmost));

ccwDIDs_thor := join(
	distribute(PBslim, did), 
	distribute(pull(ccwDIDkey), did_out6),
							left.did = right.did_out6,
							addCCWIDs(left,right),
							atmost(riskwise.max_atmost),
	local);
							
#IF(onThor)
	ccwDIDs := ccwDIDs_thor;
#ELSE
	ccwDIDs := ccwDIDs_roxie;
#END

ccwRIDkey := eMerges.key_ccw_rid(false);

ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_sports	addCCWDetails(ccwDIDs le, ccwRIDkey ri) := transform
			dateLicense					      := if(ri.ccwregdate[5..6] = '', ri.ccwregdate[1..4] + '1201', ri.ccwregdate[1..6] + '01');  //default month to 12 if not populated and just default day to 01
			validdate 					      := Doxie.DOBTools((integer)dateLicense).IsValidDOB;
			monthsApart					      := if(~validdate, 99, ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],dateLicense)); //if date isn't valid, don't use
      
      self.IntSportPersonFlagEv := if(ri.rid<>0, 1, 0); 
			self.IntSportPersonFlag1Y := if(ri.rid<>0 and monthsApart < 13, 1, 0);
			self.IntSportPersonFlag5Y := if(ri.rid<>0 and monthsApart < 61, 1, 0);
			self.IntSportPersonTravelerFlagEv := if(ri.rid<>0 and TRIM(ri.source_state)[1..2]<>TRIM(ri.res_state)[1..2] and TRIM(ri.source_state)<>'' AND TRIM(ri.res_state)[1..2]<>'', 1, 0);
			self 								:= le;
			self 								:= [];
	end;
	
ccwDetails_roxie := join(ccwDIDs, ccwRIDkey,
							Keyed(left.RID = right.RID) and
							right.ccwregdate <> '',
							addCCWDetails(left,right),
							atmost(riskwise.max_atmost));
							
ccwDetails_thor := join(
	distribute(ccwDIDs, rid), 
	distribute(pull(ccwRIDkey(ccwregdate <> '')), rid),
							left.RID = right.RID,
							addCCWDetails(left,right),
							atmost(riskwise.max_atmost),
	local);
							
#IF(onThor)
	ccwDetails := ccwDetails_thor;
#ELSE
	ccwDetails := ccwDetails_roxie;
#END

sortSportsdetails := sort(sportsDetails + ccwDetails, seq, did, RID);

ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_sports rollSports(sportsDetails le, sportsDetails ri) := TRANSFORM
	self.IntSportPersonFlagEv := max(le.IntSportPersonFlagEv, ri.IntSportPersonFlagEv);	
	self.IntSportPersonFlag1Y := max(le.IntSportPersonFlag1Y, ri.IntSportPersonFlag1Y);	
	self.IntSportPersonFlag5Y := max(le.IntSportPersonFlag5Y, ri.IntSportPersonFlag5Y);	
	self.IntSportPersonTravelerFlagEv := max(le.IntSportPersonTravelerFlagEv, ri.IntSportPersonTravelerFlagEv);	
	self								:= le;
END;

rolledSports :=  rollup(sortSportsdetails, left.seq = right.seq and left.did = right.did,
										rollSports(left, right));
										
//DEBUGGING
output(choosen(PBslim1,1000), named('sample_PBslim1'));
// output(choosen(sportsDIDs,1000), named('sample_sportsDIDs'));
// output(choosen(sportsDetails,1000), named('sample_sportsDetails'));
// output(choosen(ccwDIDs,1000), named('sample_ccwDIDs'));
// output(choosen(ccwDetails,1000), named('sample_ccwDetails'));
// output(choosen(rolledSports,1000), named('sample_rolledSports'));

RETURN rolledSports;

END;										