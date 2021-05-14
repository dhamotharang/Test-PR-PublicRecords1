import riskwise, ut, faa, risk_indicators, _Control;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Aircraft(GROUPED DATASET(risk_indicators.Layout_Boca_Shell_ids) ids_only) := FUNCTION

aircraft_build_date := Risk_Indicators.get_Build_date('faa_build_version');	    

key_did := faa.key_aircraft_did();
RiskWise.Layouts.Layout_Aircraft_ids addAircraft_IDs(ids_only le, key_did ri) := transform
                self.aircraft_id := ri.aircraft_id;
                self.n_number := ri.n_number;
                self := le;
end;       

aircraftIDs_roxie := join(ids_only, key_did,
                          left.did!=0 and keyed(left.did=right.did),
                          addAircraft_IDs(left,right), left outer, atmost(keyed(left.did=right.did),riskwise.max_atmost));
                   
aircraftIDs_thor := join(DISTRIBUTE(ids_only, HASH64(did)),
                         DISTRIBUTE(PULL(key_did), HASH64(did)),
                         left.did!=0 and
                         left.did=right.did,
                         addAircraft_IDs(left,right), left outer, atmost(left.did=right.did,riskwise.max_atmost), LOCAL);
                   
#IF(onThor)
	aircraftIDs_correct := aircraftIDs_thor;
#ELSE
	aircraftIDs_correct := aircraftIDs_roxie;
#END

key_ids := faa.key_aircraft_id();
RiskWise.Layouts.Layout_Aircraft_plus addAircraft(aircraftIDs_correct le, key_ids ri) := transform
                myGetDate := if(le.historydate=999999, aircraft_build_date, risk_indicators.iid_constants.full_history_date(le.historydate));
                self.date_first_seen := if(ri.date_first_seen='', '999999', ri.date_first_seen);
                self.aircraft_count := if(trim(ri.n_number)!='', 1, 0);
                self.aircraft_count30 := if(trim(ri.n_number)!='' and risk_indicators.iid_constants.checkDays(myGetDate,ri.date_first_seen,30, le.historydate), 1, 0);
                self.aircraft_count90 := if(trim(ri.n_number)!='' and risk_indicators.iid_constants.checkDays(myGetDate,ri.date_first_seen,90, le.historydate), 1, 0);
                self.aircraft_count180 := if(trim(ri.n_number)!='' and risk_indicators.iid_constants.checkDays(myGetDate,ri.date_first_seen,180, le.historydate), 1, 0);
                self.aircraft_count12 := if(trim(ri.n_number)!='' and risk_indicators.iid_constants.checkDays(myGetDate,ri.date_first_seen,ut.DaysInNYears(1), le.historydate), 1, 0);
                self.aircraft_count24 := if(trim(ri.n_number)!='' and risk_indicators.iid_constants.checkDays(myGetDate,ri.date_first_seen,ut.DaysInNYears(2), le.historydate), 1, 0);
                self.aircraft_count36 := if(trim(ri.n_number)!='' and risk_indicators.iid_constants.checkDays(myGetDate,ri.date_first_seen,ut.DaysInNYears(3), le.historydate), 1, 0);
                self.aircraft_count60 := if(trim(ri.n_number)!='' and risk_indicators.iid_constants.checkDays(myGetDate,ri.date_first_seen,ut.DaysInNYears(5), le.historydate), 1, 0);
								self.aircraft_build_date := aircraft_build_date;             
								self := le;
end;
                                                                                                                                                                                
aircraftRecs_roxie := join(aircraftIDs_correct, key_ids,
                           left.aircraft_ID!=0 and keyed(left.aircraft_id=right.aircraft_id) and
                           (unsigned)right.date_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
                           addAircraft(left,right), left outer, atmost(riskwise.max_atmost));
                           
aircraftRecs_thor := join(DISTRIBUTE(aircraftIDs_correct, HASH64(aircraft_ID)),
                          DISTRIBUTE(PULL(key_ids), HASH64(aircraft_ID)),
                          left.aircraft_ID!=0 and
                          left.aircraft_id=right.aircraft_id and
                          (unsigned)right.date_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.historydate),
                          addAircraft(left,right), left outer, atmost(left.aircraft_id=right.aircraft_id,riskwise.max_atmost), LOCAL);
                          
#IF(onThor)
	aircraftRecs_correct := aircraftRecs_thor;
#ELSE
	aircraftRecs_correct := aircraftRecs_roxie;
#END
                                                
Riskwise.Layouts.Layout_Aircraft_Plus roll_aircraft(Riskwise.Layouts.Layout_Aircraft_Plus le, Riskwise.Layouts.Layout_Aircraft_Plus ri) := transform
                self.aircraft_count := le.aircraft_count+IF(le.n_number=ri.n_number,0,ri.aircraft_count);  // don't increment if the key is a duplicate
                self.aircraft_count30 := le.aircraft_count30+IF(le.n_number=ri.n_number,0,ri.aircraft_count30);
                self.aircraft_count90 := le.aircraft_count90+IF(le.n_number=ri.n_number,0,ri.aircraft_count90);
                self.aircraft_count180 := le.aircraft_count180+IF(le.n_number=ri.n_number,0,ri.aircraft_count180);
                self.aircraft_count12 := le.aircraft_count12+IF(le.n_number=ri.n_number,0,ri.aircraft_count12);
                self.aircraft_count24 := le.aircraft_count24+IF(le.n_number=ri.n_number,0,ri.aircraft_count24);
                self.aircraft_count36 := le.aircraft_count36+IF(le.n_number=ri.n_number,0,ri.aircraft_count36);
                self.aircraft_count60 := le.aircraft_count60+IF(le.n_number=ri.n_number,0,ri.aircraft_count60);
                self := ri;
end;

grp_sorted := group(sort(aircraftRecs_correct, seq, did, n_number,-date_first_seen), seq);

rolled_aircraft := rollup(grp_sorted, left.seq=right.seq and left.did=right.did, roll_aircraft(left,right));

rollAircraftFinal := group(sort(rolled_aircraft, seq, isrelat),seq);

return rollAircraftFinal;
                                                                
end;

