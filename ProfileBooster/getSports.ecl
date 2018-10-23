IMPORT _Control, Doxie, eMerges, RiskWise, Risk_Indicators, ut;
onThor := _Control.Environment.OnThor;

EXPORT getSports(DATASET(ProfileBooster.Layouts.Layout_PB_Slim) PBslim1) := FUNCTION

PBSlim := PBslim1(did2<>0);

//hunting and fishing
sportsDIDkey := eMerges.Key_HuntFish_Did(false);

ProfileBooster.Layouts.Layout_PB_Slim_sports	addSportsIDs(PBslim le, sportsDIDkey ri) := transform
      self.rid 	:= ri.rid;
			self 			:= le;
      self 			:= [];
	end; 

sportsDIDs_roxie := join(PBslim, sportsDIDkey,
							Keyed(left.did2 = right.did),
							addSportsIDs(left,right),
							atmost(riskwise.max_atmost));
							
sportsDIDs_thor := join(
	distribute(PBslim, did2), 
	distribute(pull(sportsDIDkey), did),
							left.did2 = right.did,
							addSportsIDs(left,right),
							atmost(riskwise.max_atmost), 
	local);

#IF(onThor)
	sportsDIDs := sportsDIDs_thor;
#ELSE
	sportsDIDs := sportsDIDs_roxie;
#END

sportsRIDkey := eMerges.Key_HuntFish_Rid(false);

ProfileBooster.Layouts.Layout_PB_Slim_sports	addSportsDetails(sportsDIDs le, sportsRIDkey ri) := transform
			dateLicense					:= if(ri.dateLicense[5..6] = '', ri.dateLicense[1..4] + '1201', ri.dateLicense[1..6] + '01');  //default month to 12 if not populated and just default day to 01
			validdate 					:= Doxie.DOBTools((integer)dateLicense).IsValidDOB;
			monthsApart					:= if(~validdate, 99, ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],dateLicense)); //if date isn't valid, don't use
			self.sportsInterest := if(ri.file_id in ['HUNT', 'FISH'] and monthsApart < 13, 1, 0);
			self 								:= le;
			self 								:= [];
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

ProfileBooster.Layouts.Layout_PB_Slim_sports	addCCWIDs(PBslim le, ccwDIDkey ri) := transform
      self.rid 	:= ri.rid;
			self 			:= le;
      self 			:= [];
	end; 

ccwDIDs_roxie := join(PBslim, ccwDIDkey,
							Keyed(left.did2 = right.did_out6),
							addCCWIDs(left,right),
							atmost(riskwise.max_atmost));

ccwDIDs_thor := join(
	distribute(PBslim, did2), 
	distribute(pull(ccwDIDkey), did_out6),
							left.did2 = right.did_out6,
							addCCWIDs(left,right),
							atmost(riskwise.max_atmost),
	local);
							
#IF(onThor)
	ccwDIDs := ccwDIDs_thor;
#ELSE
	ccwDIDs := ccwDIDs_roxie;
#END

ccwRIDkey := eMerges.key_ccw_rid(false);

ProfileBooster.Layouts.Layout_PB_Slim_sports	addCCWDetails(ccwDIDs le, ccwRIDkey ri) := transform
      self.sportsInterest := if(ri.rid<>0, 1, 0);  // instead of checking the date which is 8 characters and always greater than the historydate, check the presense of a RID instead
			self 								:= le;
			self 								:= [];
	end;
	
ccwDetails_roxie := join(ccwDIDs, ccwRIDkey,
							Keyed(left.RID = right.RID) and
							right.ccwExpDate <> '',
							addCCWDetails(left,right),
							atmost(riskwise.max_atmost));
							
ccwDetails_thor := join(
	distribute(ccwDIDs, rid), 
	distribute(pull(ccwRIDkey(ccwExpDate <> '')), rid),
							left.RID = right.RID,
							addCCWDetails(left,right),
							atmost(riskwise.max_atmost),
	local);
							
#IF(onThor)
	ccwDetails := ccwDetails_thor;
#ELSE
	ccwDetails := ccwDetails_roxie;
#END

sortSportsdetails := sort(sportsDetails + ccwDetails, seq, did2, RID);

ProfileBooster.Layouts.Layout_PB_Slim_sports rollSports(sportsDetails le, sportsDetails ri) := TRANSFORM
	self.sportsInterest := max(le.sportsInterest, ri.sportsInterest);	
	self								:= le;
END;

rolledSports :=  rollup(sortSportsdetails, left.seq = right.seq and left.did2 = right.did2,
										rollSports(left, right));
										

// output(sportsDIDs, named('sportsDIDs'));
// output(sportsDetails, named('sportsDetails'));
// output(ccwDIDs, named('ccwDIDs'));
// output(ccwDetails, named('ccwDetails'));
// output(rolledSports, named('rolledSports'));

RETURN rolledSports;

END;										