IMPORT _Control, faa, RiskWise, ut, Risk_Indicators;
onThor := _Control.Environment.OnThor;

EXPORT getAircraft(DATASET(ProfileBooster.Layouts.Layout_PB_Slim) PBslim) := FUNCTION

ACIdsKey := faa.key_aircraft_did(false);

ProfileBooster.Layouts.Layout_PB_Slim_aircraft	addAircraftIDs(PBslim le, ACIdsKey ri) := transform
      self.aircraft_id := ri.aircraft_id;
      self.n_number := ri.n_number;
			self := le;
      self := [];
	end; 

ACIds_roxie := join(PBslim, ACIdsKey,
							Keyed(left.did2 = right.did),
							addAircraftIDs(left,right),
							atmost(riskwise.max_atmost));

ACIds_thor := join(distribute(PBslim, did2), 
									 distribute(pull(ACIdsKey), did),
							left.did2 = right.did,
							addAircraftIDs(left,right),
							atmost(riskwise.max_atmost), local);
							
#IF(onThor)
	ACIds := ACIds_thor;
#ELSE
	ACIds := ACIds_roxie;
#END
							
ACDetailsKey := faa.key_aircraft_id(false);

ProfileBooster.Layouts.Layout_PB_Slim_aircraft	addAircraftDetails(ACIds le, ACDetailsKey ri) := transform
			self.aircraftCount := if(ri.current_flag = 'A' and trim(le.n_number)!='',	1, 0);
			monthsAgo 						:= ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],(string6)ri.date_first_seen);
			self.months_first_reg := monthsAgo;
			self.months_last_reg  := monthsAgo;					
			self := le;
			self := [];
	end;
	
ACDetails_roxie := join(ACIds, ACDetailsKey,
							Keyed(left.aircraft_id = right.aircraft_id) and
						 (unsigned)right.date_first_seen < (unsigned)Risk_Indicators.iid_constants.myGetDate(left.historydate) and
							right.current_flag = 'A',
							addAircraftDetails(left,right),
							atmost(riskwise.max_atmost));

ACDetails_thor := join(distribute(ACIds, aircraft_id), 
												distribute(pull(ACDetailsKey(current_flag = 'A')), aircraft_id),
							left.aircraft_id = right.aircraft_id and
						 (unsigned)right.date_first_seen < (unsigned)Risk_Indicators.iid_constants.myGetDate(left.historydate),
							addAircraftDetails(left,right),
							atmost(left.aircraft_id=right.aircraft_id, riskwise.max_atmost), local);
							
#IF(onThor)
	ACDetails := ACDetails_thor;
#ELSE
	ACDetails := ACDetails_roxie;
#END

SortACdetails :=  sort(ACDetails, seq, did2, aircraft_id);

ProfileBooster.Layouts.Layout_PB_Slim_aircraft rollAircrafts(ACDetails le, ACDetails ri) := TRANSFORM
	self.aircraftCount := le.aircraftCount + if(le.n_number=ri.n_number, 0 , ri.aircraftCount);	
	self.months_first_reg	:= max(le.months_first_reg, ri.months_first_reg);	//save oldest registration
	self.months_last_reg	:= min(le.months_last_reg, ri.months_last_reg);	  //save newest registration
	self	:= le;
END;

RolledAC :=  rollup(SortACdetails, left.seq = right.seq and left.did2 = right.did2,
										rollAircrafts(left, right));
										

// output(ACIds, named('ACIds'));
// output(SortACdetails, named('SortACdetails'));
// output(RolledAC, named('RolledAC'));

RETURN RolledAC;

END;										