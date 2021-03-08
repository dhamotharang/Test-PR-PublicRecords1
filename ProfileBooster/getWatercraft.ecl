IMPORT _Control, Watercraft, RiskWise, ut, risk_indicators, Doxie, Suppress, ProfileBooster;
onThor := _Control.Environment.OnThor;

EXPORT getWatercraft(DATASET(ProfileBooster.Layouts.Layout_PB_Slim) PBslim,
										doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

WCidKey := Watercraft.key_watercraft_did(false); 
 
ProfileBooster.Layouts.Layout_PB_Slim_watercraft getWCKey(PBslim le, WCidKey ri) := TRANSFORM
	self.watercraft_key := ri.watercraft_key;
	self.sequence_key := ri.sequence_key;
	self.state_origin := ri.state_origin;
	self := le;
	self := [];
END;
 
isFCRA := False;
 
WatercraftKeys_roxie :=  join(PBslim, WCidKey,
												 keyed(right.l_did = left.did2) and 
												 right.state_origin in ProfileBooster.Constants.setWatercraftStates and
												 (unsigned3)(right.sequence_key[1..6]) < left.historydate,
												 getWCKey(left,right),
												 atmost(right.l_did=left.did2, riskwise.max_atmost));

WatercraftKeys_thor :=  join(distribute(PBslim, did2), 
												distribute(pull(WCidKey), l_did),
												 right.l_did = left.did2 and 
												 right.state_origin in ProfileBooster.Constants.setWatercraftStates and
												 (unsigned3)(right.sequence_key[1..6]) < left.historydate,
												 getWCKey(left,right), 
												 atmost(right.l_did=left.did2, riskwise.max_atmost), 
												 local);
												 
#IF(onThor)
	WatercraftKeys := WatercraftKeys_thor;
#ELSE
	WatercraftKeys := WatercraftKeys_roxie;
#END
output(WatercraftKeys,named('WatercraftKeys'));
WCDetailskey := watercraft.key_watercraft_sid(false);
											
{ProfileBooster.Layouts.Layout_PB_Slim_watercraft, UNSIGNED4 global_sid}  getWCDetails(WatercraftKeys le, WCDetailskey ri) := TRANSFORM
	self.global_sid	:= ri.global_sid;
	self.watercraft_key := le.watercraft_key;
	self.sequence_key := le.sequence_key;
	self.history_flag :=  map(ri.history_flag =	'' => 'Current',				
														ri.history_flag ='E' => 'Expired',
														ri.history_flag ='H' => 'Historical', 
														'');
	runningCurrent 				:= le.historyDate=risk_indicators.iid_constants.default_history_date;
	self.watercraftCount 	:= if(~runningCurrent, 1, if(ri.history_flag = '', 1, 0)); //this may change based on data team's answer
	monthsAgo 						:= ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],(string6)ri.date_first_seen);
	self.months_first_reg := monthsAgo;
	self.months_last_reg  := monthsAgo;		
	self.state_origin := le.state_origin;
	self := le;
END;

WatercraftDetails_roxie_unsuppressed :=  join(WatercraftKeys, WCDetailskey,
												 keyed(right.watercraft_key = left.watercraft_key and
												       right.state_origin = left.state_origin),
												 getWCDetails(left,right), 
												 atmost(right.watercraft_key = left.watercraft_key and right.state_origin = left.state_origin, riskwise.max_atmost));

WatercraftDetails_roxie := Suppress.Suppress_ReturnOldLayout(WatercraftDetails_roxie_unsuppressed, mod_access, ProfileBooster.Layouts.Layout_PB_Slim_watercraft);

WatercraftDetails_thor_unsuppressed :=  join(WatercraftKeys, WCDetailskey,
												 keyed(right.watercraft_key = left.watercraft_key and
												       right.state_origin = left.state_origin),
												 getWCDetails(left,right), 
												 atmost(right.watercraft_key = left.watercraft_key and right.state_origin = left.state_origin, riskwise.max_atmost));
			
WatercraftDetails_thor := Suppress.Suppress_ReturnOldLayout(WatercraftDetails_thor_unsuppressed, mod_access, ProfileBooster.Layouts.Layout_PB_Slim_watercraft);

#IF(onThor)
	WatercraftDetails := WatercraftDetails_thor;
#ELSE
	WatercraftDetails := WatercraftDetails_roxie;
#END

output(WatercraftDetails,named('WatercraftDetails'));
SortWCdetails :=  dedup(sort(WatercraftDetails, seq, did2, watercraft_key[1..10], -sequence_key),
																								seq, did2, watercraft_key[1..10]);

ProfileBooster.Layouts.Layout_PB_Slim_watercraft rollWatercrafts(WatercraftDetails le, WatercraftDetails ri) := TRANSFORM
	self.watercraftCount 	:= le.watercraftCount + iF(le.watercraft_key=ri.watercraft_key, 0,	ri.watercraftCount);	
	self.months_first_reg	:= max(le.months_first_reg, ri.months_first_reg);	//save oldest registration
	self.months_last_reg	:= min(le.months_last_reg, ri.months_last_reg);	  //save newest registration
	self								 	:= le;
END;

RolledWC :=  rollup(SortWCdetails, left.seq = right.seq and left.did2 = right.did2,
										rollWatercrafts(left, right));
										
// output(PBslim, named('PBslim'));
// output(WatercraftKeys, named('WatercraftKeys'));
// output(WatercraftDetails, named('WatercraftDetails'));
// output(SortWCdetails, named('SortWCdetails'));
// output(RolledWC, named('RolledWC'));

RETURN RolledWC;

END;										