IMPORT STD;
EXPORT mod_PrepEcrashAnalyticKeys(DATASET(Layout_eCrash.Consolidation) EcrashIn = FLAccidents_Ecrash.File_KeybuildV2.out) := MODULE

//Infile := FLAccidents_Ecrash.File_KeybuildV2.out(report_code in ['EA','TM','TF'] AND report_type_id = 'A' AND work_type_id NOT IN['2','3']) ;
Infile := EcrashIn((report_code IN ['EA','TF'] OR (report_code = 'TM' AND STD.Str.ToUpperCase(report_status) IN ['COMPLETED'] )) AND report_type_id = 'A' AND work_type_id NOT IN['2','3']) ;
 
Layout_eCrash.Consolidation transInFile(Layout_eCrash.Consolidation L) := TRANSFORM
 SELF.did := (STRING12) IF(L.did = '000000000000', '0', L.did);
 SELF := L;
END;
ModInfile:= PROJECT(InFile,transInFile(LEFT)); 

// dedup across sources 
tInfile := PROJECT (ModInfile, TRANSFORM( Layout_PrepEcrashAnalyticKeys.interim, 
                SELF:= LEFT ,
								SELF.orig_case_identifier := IF(LEFT.report_code = 'EA', LEFT.orig_accnbr , LEFT.addl_report_number);
								SELF.orig_state_report_number := IF(LEFT.report_code = 'EA', LEFT.addl_report_number, LEFT.orig_accnbr); 
								
								)); 
infiledup := DEDUP (SORT(DISTRIBUTE(tInfile	, HASH32(orig_case_identifier, orig_state_report_number)), orig_case_identifier, orig_state_report_number,	jurisdiction, jurisdiction_state, report_type_id , accident_date,creation_date, vehicle_incident_id,LOCAL),orig_case_identifier, orig_state_report_number,	jurisdiction, jurisdiction_state, report_type_id , accident_date,RIGHT,LOCAL); 
	
// Join back to all records 
Jformat := JOIN (DISTRIBUTE(ModInfile ,HASH32(vehicle_incident_id)), DISTRIBUTE(infiledup ,HASH32(vehicle_incident_id)), LEFT.vehicle_incident_id = RIGHT.vehicle_incident_id , LOCAL); 

SHARED BaseKey := Jformat:INDEPENDENT;

Dedup1 := DEDUP(SORT(DISTRIBUTE(BaseKey(DID > '0'),HASH32(Vehicle_Incident_Id)),DID , Vehicle_Incident_id, local),DID , Vehicle_Incident_id,local);
Dedup2 := DEDUP(SORT(DISTRIBUTE(BaseKey(DID = '0'), HASH32(Vehicle_Incident_Id)), Vehicle_Incident_Id ,fname , lname , name_suffix , dob , driver_license_nbr,local)
														,Vehicle_Incident_Id ,fname , lname , name_suffix , dob , driver_license_nbr, local );

SHARED DedupedKey := SORT(Dedup1 + Dedup2, jurisdiction_nbr + Vehicle_Incident_id + Vehicle_unit_number):INDEPENDENT;

//***********************************************************************
//                 Key_eCrash_ByAgencyID
//***********************************************************************
Layout_PrepEcrashAnalyticKeys.accidents_by_AgencyID_slim getCounts({DedupedKey} L) := TRANSFORM
  SELF.AgencyID								:= L.Jurisdiction_nbr;
	SELF.accident_date 					:= L.accident_date;
	SELF.precinct  							:= L.precinct; 
	SELF.beat      							:= L.beat;
	SELF.Report_Code						:= L.Report_Code;
	SELF.Vehicle_Incident_ID		:= L.Vehicle_Incident_ID;
	SELF.AccidentCnt						:= 1;	
  CountInjuries               := FLAccidents_Ecrash.Functions.CountInjuries(L.Report_Injury_Status);
	SELF.InjuryCnt							:= CountInjuries.InjuryCnt;
	SELF.FatalCnt								:= CountInjuries.FatalCnt;
	SELF.InjuryUnkCnt						:= CountInjuries.InjuryUnkCnt;
END;

dsWithCounts := PROJECT(DedupedKey, getCounts(LEFT));

{dsWithCounts} RollAccidents({dsWithCounts} L, {dsWithCounts} R):=TRANSFORM
  SELF.agencyid 						:= L.agencyid;
	SELF.accident_date 				:= L.accident_date;
  SELF.precinct							:= L.precinct;
  SELF.beat									:= L.beat;
	SELF.report_code					:= L.report_code;
	SELF.vehicle_incident_id	:= L.vehicle_incident_id;
	SELF.accidentCnt					:= L.accidentCnt;
	SELF.InjuryCnt						:= L.InjuryCnt + R.InjuryCnt;
	SELF.FatalCnt							:= L.FatalCnt + R.FatalCnt;
	SELF.InjuryUnkCnt					:= L.InjuryUnkCnt + R.InjuryUnkCnt;
END;
dsRolled := ROLLUP(dsWithCounts, 
                   LEFT.vehicle_incident_id = RIGHT.vehicle_Incident_id AND
									 LEFT.report_code = RIGHT.report_code,
									 RollAccidents(LEFT,RIGHT));
									 
by_AgencyID_interim := RECORD
	dsRolled.AgencyID;
	dsRolled.Accident_date;
	dsRolled.Precinct;
	dsRolled.Beat;
	INTEGER  AccidentCnt    := SUM(GROUP, dsRolled.accidentcnt);
	INTEGER  InjuryCnt 			:= SUM(GROUP, dsRolled.InjuryCnt);
	INTEGER  FatalCnt  			:= SUM(GROUP, dsRolled.FatalCnt);
	INTEGER  UnknownCnt			:= SUM(GROUP, dsRolled.InjuryUnkCnt);
END;

EXPORT by_AgencyID := TABLE(dsRolled, {by_AgencyID_interim}, AgencyID, accident_date, precinct, beat);

//***********************************************************************
//                Key_eCrash_ByCollisionType
//***********************************************************************
/* Dedup1 := DEDUP(BaseKey(DID > '0'),DID + Vehicle_Incident_id);
   Dedup2 := DEDUP(BaseKey(DID = '0'),Vehicle_Incident_Id + fname + lname + name_suffix);
*/
Layout_PrepEcrashAnalyticKeys.accidents_by_CT_slim CTslim({DedupedKey} L) := TRANSFORM
  SELF.AGENCYID 						:= L.Jurisdiction_nbr;
	SELF := L;
END;

dsSlimmed := PROJECT(DedupedKey, CTslim(LEFT));

{dsSlimmed} RollVehicles({dsSlimmed} L, {dsSlimmed} R):=TRANSFORM
  SELF.agencyID 		 				:= L.agencyID;
	SELF.accident_date 				:= L.accident_date;
	SELF.report_code					:= L.report_code;
	SELF.vehicle_incident_id  := L.vehicle_incident_id;
	SELF.vehicle_unit_number	:= L.vehicle_unit_number;
	SELF.Report_Collision_Type := L.Report_Collision_Type;
END;
	
dsVehiclesRolled := ROLLUP(dsSlimmed,
														LEFT.vehicle_incident_id = RIGHT.vehicle_Incident_id AND
									          LEFT.report_code = RIGHT.report_code AND
														LEFT.vehicle_unit_number = RIGHT.vehicle_unit_number,
						                RollVehicles(LEFT,RIGHT)); //,AgencyId, Accident_Date);

Layout_PrepEcrashAnalyticKeys.accidents_by_CT_slim2 CountCT({dsVehiclesRolled} L) := TRANSFORM
	SELF.AccidentCnt					:= 1;
  NewCTString               := STD.Str.ToUpperCase(TRIM(L.Report_Collision_Type,LEFT,RIGHT));
	SELF.CTFrontRear					:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.FRONTREAR) > 0,1,0); 
	SELF.CTFrontFront					:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.FRONTFRONT) > 0,1,0);
	SELF.CTAngle							:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.ANGLE) > 0,1,0);
	SELF.CTSideSwipeSame			:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.SIDESWIPESAME) > 0,1,0);
	SELF.CTSideSwipeOpposite	:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.SIDESWIPEOPPOSITE) > 0,1,0);
	SELF.CTRearSide						:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.REARSIDE) > 0,1,0);
	SELF.CTRearRear						:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.REARREAR) > 0,1,0);
	SELF.CTOther							:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.OTHER) > 0,1,0);
	SELF.CTUnknown						:= FLAccidents_Ecrash.Functions.UnknownCT(NewCTString);
	SELF := L;
END;

dsCTCounted := PROJECT(dsVehiclesRolled, CountCT(LEFT));														

{dsCTCounted} RollAgencyLvl({dsCTCounted} L, {dsCTCounted} R):=TRANSFORM
	SELF.CTFrontRear	 				:= L.CTFrontRear + R.CTFrontRear;
	SELF.CTFrontFront					:= L.CTFrontFront	+ R.CTFrontFront;			
	SELF.CTAngle						  := L.CTAngle + R.CTAngle;					
	SELF.CTSideSwipeSame		  := L.CTSideSwipeSame + R.CTSideSwipeSame;		
	SELF.CTSideSwipeOpposite  := L.CTSideSwipeOpposite + R.CTSideSwipeOpposite;
	SELF.CTRearSide					  := L.CTRearSide + R.CTRearSide;					
	SELF.CTRearRear					  := L.CTRearRear + R.CTRearRear;					
	SELF.CTOther						  := L.CTOther + R.CTOther;						
	SELF.CTUnknown					  := L.CTUnknown + R.CTUnknown;		
	SELF := L;
END;
	
dsCTRolled := SORT(ROLLUP(dsCTCounted,
										 LEFT.vehicle_incident_id = RIGHT.vehicle_Incident_id AND
										 LEFT.report_code = RIGHT.report_code,
						         RollAgencyLvl(LEFT,RIGHT)),AgencyId, Accident_Date);

//Business decided they only want to count, per vehicle incident, injuries as occuring, not a total count of the injuries occuring. 
// In other words, if they have two people killed in a vehicle incident, that would only count as 1 not 2. This is going
// to be true for injuries counts, accident type counts and collision type counts. So, Slim Counts will slim down the counts
// based on this "new" understanding.								 
{dsCTRolled} SlimCounts({dsCTRolled} L) := TRANSFORM
   SELF.CTFrontRear					:= IF(L.CTFrontRear > 0, 1, 0);
	 SELF.CTFrontFront				:= IF(L.CTFrontFront > 0, 1, 0);
	 SELF.CTAngle							:= IF(L.CTAngle > 0, 1, 0);
   SELF.CTSideSwipeSame     := IF(L.CTSideSwipeSame > 0, 1, 0);
	 SELF.CTSideSwipeOpposite	:= IF(L.CTSideSwipeOpposite > 0, 1, 0);
	 SELF.CTRearSide					:= IF(L.CTRearSide > 0, 1, 0);
	 SELF.CTRearRear					:= IF(L.CTRearRear > 0, 1, 0);
	 SELF.CTOther							:= IF(L.CTOther > 0, 1, 0);
	 SELF.CTUnknown						:= IF(L.CTUnknown > 0, 1, 0);
	 SELF := L;
END;
dsSlimCounts := PROJECT(dsCTRolled, SlimCounts(LEFT));	 

by_CT_interim := RECORD
	dsSlimCounts.agencyid;
	dsSlimCounts.accident_date;
	INTEGER AccidentCnt     			:= SUM(GROUP, dsSlimCounts.accidentcnt);
	INTEGER CTFrontRear			 			:= SUM(GROUP, dsSlimCounts.CTFrontRear);
	INTEGER CTFrontFront					:= SUM(GROUP, dsSlimCounts.CTFrontFront);			
	INTEGER CTAngle						  	:= SUM(GROUP, dsSlimCounts.CTAngle);					
	INTEGER CTSideSwipeSame		  	:= SUM(GROUP, dsSlimCounts.CTSideSwipeSame);		
	INTEGER CTSideSwipeOpposite  	:= SUM(GROUP, dsSlimCounts.CTSideSwipeOpposite);
	INTEGER CTRearSide					  := SUM(GROUP, dsSlimCounts.CTRearSide);					
	INTEGER CTRearRear					  := SUM(GROUP, dsSlimCounts.CTRearRear);					
	INTEGER CTOther						  	:= SUM(GROUP, dsSlimCounts.CTOther);						
	INTEGER CTUnknown					  	:= SUM(GROUP, dsSlimCounts.CTUnknown);					
END;

EXPORT dsByCollisionType := TABLE(dsSlimCounts, {by_CT_interim}, agencyid, Accident_date);

//***********************************************************************
//                 Key_eCrash_ByDOW
//***********************************************************************
/* Dedup1 := DEDUP(BaseKey(DID > '0'),DID + Vehicle_Incident_id);
   Dedup2 := DEDUP(BaseKey(DID = '0'),Vehicle_Incident_Id + fname + lname + name_suffix);
*/
Layout_PrepEcrashAnalyticKeys.accidents_by_dow_slim slim({DedupedKey} L) := TRANSFORM
  SELF.AGENCYID 			        := L.Jurisdiction_nbr;
	SELF.accident_date 	        := L.accident_date;
  SELF.DayOfWeek			        := FLAccidents_Ecrash.Functions.DayOfWeek(L.accident_date);
	SELF.Report_Code						:= L.Report_Code;
	SELF.Vehicle_Incident_ID		:= L.Vehicle_Incident_ID;
	SELF.AccidentCnt						:= 1;	
  CountInjuries               := FLAccidents_Ecrash.Functions.CountInjuries(L.Report_Injury_Status);
	SELF.InjuryCnt							:= CountInjuries.InjuryCnt;
	SELF.FatalCnt								:= CountInjuries.FatalCnt;
	SELF.InjuryUnkCnt						:= CountInjuries.InjuryUnkCnt;
END;

dsWithCounts := PROJECT(DedupedKey, slim(LEFT));

{dsWithCounts} RollAccidents({dsWithCounts} L, {dsWithCounts} R):=TRANSFORM
  SELF.agencyid 						:= L.agencyid;
	SELF.accident_date 				:= L.accident_date;
	SELF.DayOfWeek						:= L.DayOfWeek;
	SELF.report_code					:= L.report_code;
	SELF.vehicle_incident_id	:= L.vehicle_incident_id;
	SELF.accidentCnt					:= L.accidentCnt;
	SELF.InjuryCnt						:= L.InjuryCnt + R.InjuryCnt;
	SELF.FatalCnt							:= L.FatalCnt + R.FatalCnt;
	SELF.InjuryUnkCnt					:= L.InjuryUnkCnt + R.InjuryUnkCnt;
END;
dsRolled := ROLLUP(dsWithCounts, 
                   LEFT.vehicle_incident_id = RIGHT.vehicle_Incident_id AND
									 LEFT.report_code = RIGHT.report_code,
									 RollAccidents(LEFT,RIGHT));

by_dow_interim := RECORD
	dsRolled.agencyid;
	dsRolled.accident_date;
	dsRolled.DayOfWeek;
	INTEGER AccidentCnt     := SUM(GROUP, dsRolled.accidentcnt);
	INTEGER InjuryCnt 			:= SUM(GROUP, dsRolled.InjuryCnt);
	INTEGER FatalCnt  			:= SUM(GROUP, dsRolled.FatalCnt);
	INTEGER UnknownCnt			:= SUM(GROUP, dsRolled.InjuryUnkCnt);
END;

EXPORT by_DOW := TABLE(dsRolled, {by_dow_interim}, agencyid, Accident_date, DayOfWeek);

//***********************************************************************
//                 Key_eCrash_ByHOD
//***********************************************************************
/* Dedup1 := DEDUP(BaseKey(DID > '0'),DID + Vehicle_Incident_id);
   Dedup2 := DEDUP(BaseKey(DID = '0'),Vehicle_Incident_Id + fname + lname + name_suffix);
*/
Layout_PrepEcrashAnalyticKeys.accidents_by_hod_slim slim({DedupedKey} L) := TRANSFORM
  SELF.AGENCYID 			      := L.Jurisdiction_nbr;
	SELF.accident_date 	      := L.accident_date;
	SELF.HourOfDay  		      := IF(L.crash_time = '' OR L.crash_time[1..2] NOT BETWEEN '00' AND '23', 25, (INTEGER) L.crash_time[1..2] + 1);
	SELF.Report_Code				  := L.Report_Code;
	SELF.Vehicle_Incident_ID	:= L.Vehicle_Incident_ID;
	SELF.AccidentCnt					:= 1;	
  CountInjuries             := FLAccidents_Ecrash.Functions.CountInjuries(L.Report_Injury_Status);
	SELF.InjuryCnt				  	:= CountInjuries.InjuryCnt;
	SELF.FatalCnt						 	:= CountInjuries.FatalCnt;
	SELF.InjuryUnkCnt				  := CountInjuries.InjuryUnkCnt;
END;

dsWithCounts := PROJECT(DedupedKey, slim(LEFT));

{dsWithCounts} RollAccidents({dsWithCounts} L, {dsWithCounts} R):=TRANSFORM
  SELF.agencyid 						:= L.agencyid;
	SELF.accident_date 				:= L.accident_date;
	SELF.HourOfDay						:= L.HourOfDay;
	SELF.report_code					:= L.report_code;
	SELF.vehicle_incident_id	:= L.vehicle_incident_id;
	SELF.accidentCnt					:= L.accidentCnt;
	SELF.InjuryCnt						:= L.InjuryCnt + R.InjuryCnt;
	SELF.FatalCnt							:= L.FatalCnt + R.FatalCnt;
	SELF.InjuryUnkCnt					:= L.InjuryUnkCnt + R.InjuryUnkCnt;
END;
dsRolled := ROLLUP(dsWithCounts, 
                   LEFT.vehicle_incident_id = RIGHT.vehicle_Incident_id AND
									 LEFT.report_code = RIGHT.report_code,
									 RollAccidents(LEFT,RIGHT));

by_hod_interim := RECORD
	dsRolled.agencyid;
	dsRolled.accident_date;
	dsRolled.HourOfDay;
	INTEGER AccidentCnt     := SUM(GROUP, dsRolled.accidentcnt);
	INTEGER InjuryCnt 			:= SUM(GROUP, dsRolled.InjuryCnt);
	INTEGER FatalCnt  			:= SUM(GROUP, dsRolled.FatalCnt);
	INTEGER UnknownCnt			:= SUM(GROUP, dsRolled.InjuryUnkCnt);
END;

EXPORT by_HOD := TABLE(dsRolled, {by_hod_interim}, agencyid, Accident_date, HourOfDay);
//***********************************************************************
//                 Key_eCrash_ByInter
//***********************************************************************
BaseKey_ByInter := BaseKey(accident_street + accident_cross_street > '');

/* Dedup1 := DEDUP(BaseKey_ByInter(DID > '0'),DID + Vehicle_Incident_id);
   Dedup2 := DEDUP(BaseKey_ByInter(DID = '0'),Vehicle_Incident_Id + fname + lname + name_suffix);
*/

Dedup1_ByInter := DEDUP(SORT(DISTRIBUTE(BaseKey_ByInter(DID > '0'),HASH32(Vehicle_Incident_Id)),DID , Vehicle_Incident_id, local),DID , Vehicle_Incident_id,local);
Dedup2_ByInter := DEDUP(SORT(DISTRIBUTE(BaseKey_ByInter(DID = '0'), HASH32(Vehicle_Incident_Id)), Vehicle_Incident_Id , fname , lname , name_suffix , dob , driver_license_nbr,local)
														,Vehicle_Incident_Id , fname , lname , name_suffix , dob , driver_license_nbr, local );
DedupedKey_ByInter := SORT(Dedup1_ByInter + Dedup2_ByInter, jurisdiction_nbr + Vehicle_Incident_id + Vehicle_unit_number);

Layout_PrepEcrashAnalyticKeys.accidents_by_slim PerformSlim({DedupedKey_ByInter} L) := TRANSFORM
  SELF.AGENCYID 					  := L.Jurisdiction_nbr;
	SELF.DayOfWeek					 	:= FLAccidents_Ecrash.Functions.DayOfWeek(L.Accident_date);
	SELF.Tour								  := FLAccidents_Ecrash.Functions.GetTour(L.crash_time);
  both_streets              := L.accident_street <> '' and L.accident_cross_street <> '';
  // remove periods for the POC so that 'RD' and 'RD.' are equivalent
  accident_street 				  := STD.Str.FilterOut(STD.Str.CleanSpaces(L.accident_street), '.');
  accident_cross_street 		:= STD.Str.FilterOut(STD.Str.CleanSpaces(L.accident_cross_street), '.');
  // only put the '&' in if both are present, otherwise treat it as a single street
	SELF.Intersection 			  := accident_street + if(both_streets, ' & ', '') + accident_cross_street;
	SELF.AccidentCnt				  := 1;
  CountInjuries             := FLAccidents_Ecrash.Functions.CountInjuries(L.Report_Injury_Status);
	SELF.InjuryCnt				 	  := CountInjuries.InjuryCnt;
	SELF.FatalCnt						 	:= CountInjuries.FatalCnt;
	SELF.PropDmgCnt					  := IF(CountInjuries.InjuryCnt = 0 AND CountInjuries.FatalCnt = 0, 1, 0); 
	SELF := L;
END;

dsSlimmed := PROJECT(DedupedKey_ByInter, PerformSlim(LEFT));

{dsSlimmed} RollVehicles({dsSlimmed} L, {dsSlimmed} R):=TRANSFORM
	SELF.InjuryCnt						:= L.InjuryCnt + R.InjuryCnt;
	SELF.FatalCnt							:= L.FatalCnt + R.FatalCnt;
	SELF.PropDmgCnt						:= L.PropDmgCnt + R.PropDmgCnt; 
	SELF := L;
END;
	
dsVehiclesRolled := ROLLUP(dsSlimmed,
														LEFT.vehicle_incident_id = RIGHT.vehicle_Incident_id AND
									          LEFT.report_code = RIGHT.report_code AND
														LEFT.vehicle_unit_number = RIGHT.vehicle_unit_number,
						                RollVehicles(LEFT,RIGHT)); //,AgencyId, Accident_Date);

Layout_PrepEcrashAnalyticKeys.accidents_by_slim2 PerformCounts({dsVehiclesRolled} L) := TRANSFORM
  NewBTString               := STD.Str.ToUpperCase(TRIM(L.Report_vehicle_body_type,LEFT,RIGHT));
  NewFHEString              := STD.Str.ToUpperCase(TRIM(L.Report_first_harmful_event,LEFT,RIGHT));
	SELF.ATVehicle 						:= FLAccidents_Ecrash.Functions.KnownVT(NewBTString);
	SELF.ATPedestrian         := IF(STD.Str.FindCount(NewFHEString, FLAccidents_Ecrash.Constants.PEDESTRIAN) > 0,1,0);
	SELF.ATBicycle            := IF(STD.Str.FindCount(NewFHEString, FLAccidents_Ecrash.Constants.BICYCLE) > 0,1,0);
	SELF.ATMotorcycle					:= IF(STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.MOTORCYCLE) > 0,1,0);
	SELF.ATAnimal							:= IF(STD.Str.FindCount(NewFHEString, FLAccidents_Ecrash.Constants.ANIMAL) > 0,1,0);
	SELF.ATTrain							:= IF(STD.Str.FindCount(NewFHEString, FLAccidents_Ecrash.Constants.TRAIN) > 0,1,0);
	SELF.ATUnknown            := IF((NewBTString = '') OR
	                                FLAccidents_Ecrash.Functions.UnknownVT(NewBTString) > 0 OR
																	FLAccidents_Ecrash.Functions.UnknownFHE(NewFHEString) > 0,1,0);
  NewCTString               := STD.Str.ToUpperCase(TRIM(L.Report_Collision_Type,LEFT,RIGHT));
	SELF.CTFrontRear					:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.FRONTREAR) > 0,1,0); 
	SELF.CTFrontFront					:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.FRONTFRONT) > 0,1,0);
	SELF.CTAngle							:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.ANGLE) > 0,1,0);
	SELF.CTSideSwipeSame			:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.SIDESWIPESAME) > 0,1,0);
	SELF.CTSideSwipeOpposite	:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.SIDESWIPEOPPOSITE) > 0,1,0);
	SELF.CTRearSide						:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.REARSIDE) > 0,1,0);
	SELF.CTRearRear						:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.REARREAR) > 0,1,0);
	SELF.CTOther							:= IF(STD.Str.FindCount(NewCTString, FLAccidents_Ecrash.Constants.OTHER) > 0,1,0);
	SELF.CTUnknown						:= FLAccidents_Ecrash.Functions.UnknownCT(NewCTString);
  SELF := L;
END;

dsCounted := PROJECT(dsVehiclesRolled, PerformCounts(LEFT));														

{dsCounted} RollAgencyLvl({dsCounted} L, {dsCounted} R):=TRANSFORM
	SELF.ATVehicle			 			:= L.ATVehicle + R.ATVehicle;
  SELF.ATPedestrian 	      := L.ATPedestrian + R.ATPedestrian; 
	SELF.ATBicycle            := L.ATBicycle    + R.ATBicycle;    
	SELF.ATMotorcycle	        := L.ATMotorcycle + R.ATMotorcycle;	
	SELF.ATAnimal			        := L.ATAnimal + R.ATAnimal;			
	SELF.ATTrain			        := L.ATTrain + R.ATTrain;			
	SELF.ATUnknown            := L.ATUnknown + R.ATUnknown;
	SELF.CTFrontRear			 		:= L.CTFrontRear + R.CTFrontRear;
	SELF.CTFrontFront					:= L.CTFrontFront	+ R.CTFrontFront;			
	SELF.CTAngle						  := L.CTAngle + R.CTAngle;					
	SELF.CTSideSwipeSame		  := L.CTSideSwipeSame + R.CTSideSwipeSame;		
	SELF.CTSideSwipeOpposite  := L.CTSideSwipeOpposite + R.CTSideSwipeOpposite;
	SELF.CTRearSide					  := L.CTRearSide + R.CTRearSide;					
	SELF.CTRearRear					  := L.CTRearRear + R.CTRearRear;					
	SELF.CTOther						  := L.CTOther + R.CTOther;						
	SELF.CTUnknown					  := L.CTUnknown + R.CTUnknown;	
	SELF.InjuryCnt						:= L.InjuryCnt + R.InjuryCnt;
	SELF.FatalCnt							:= L.FatalCnt + R.FatalCnt;
	SELF.PropDmgCnt						:= L.PropDmgCnt + R.PropDmgCnt;
	SELF := L;
END;
	
dsRolled := SORT(ROLLUP(dsCounted,
										 LEFT.vehicle_incident_id = RIGHT.vehicle_Incident_id AND
										 LEFT.report_code = RIGHT.report_code,
						         RollAgencyLvl(LEFT,RIGHT)),AgencyId, Accident_Date);
										 
//Business decided they only want to count, per vehicle incident, injuries as occuring, not a total count of the injuries occuring. 
// In other words, if they have two people killed in a vehicle incident, that would only count as 1 not 2. This is going
// to be true for injuries counts, accident type counts and collision type counts. So, Slim Counts will slim down the counts
// based on this "new" understanding.								 
{dsRolled} SlimCounts({dsRolled} L) := TRANSFORM
	 SELF.ATVehicle			 			:= IF(L.ATVehicle > 0, 1, 0);
   SELF.ATPedestrian 	      := IF(L.ATPedestrian > 0, 1, 0); 
	 SELF.ATBicycle           := IF(L.ATBicycle > 0, 1, 0);    
	 SELF.ATMotorcycle	      := IF(L.ATMotorcycle > 0, 1, 0);	
	 SELF.ATAnimal			      := IF(L.ATAnimal > 0, 1, 0);			
	 SELF.ATTrain			        := IF(L.ATTrain > 0, 1, 0);			
	 SELF.ATUnknown           := IF(L.ATUnknown > 0, 1, 0);
   SELF.CTFrontRear					:= IF(L.CTFrontRear > 0, 1, 0);
	 SELF.CTFrontFront				:= IF(L.CTFrontFront > 0, 1, 0);
	 SELF.CTAngle							:= IF(L.CTAngle > 0, 1, 0);
   SELF.CTSideSwipeSame     := IF(L.CTSideSwipeSame > 0, 1, 0);
	 SELF.CTSideSwipeOpposite	:= IF(L.CTSideSwipeOpposite > 0, 1, 0);
	 SELF.CTRearSide					:= IF(L.CTRearSide > 0, 1, 0);
	 SELF.CTRearRear					:= IF(L.CTRearRear > 0, 1, 0);
	 SELF.CTOther							:= IF(L.CTOther > 0, 1, 0);
	 SELF.CTUnknown						:= IF(L.CTUnknown > 0, 1, 0);
	 SELF.FatalCnt						:= MAP(L.FatalCnt > 0 => 1,
	                                 0);
	 SELF.InjuryCnt           := MAP(L.FatalCnt > 0 => 0,
															     L.InjuryCnt > 0 => 1,
																	 0);
	 SELF.PropDmgCnt					:= MAP(L.FatalCnt > 0 OR L.InjuryCnt > 0 => 0,
	                                 L.PropDmgCnt > 0 => 1,
																	 0);

	 SELF := L;
END;
dsSlimCounts := PROJECT(dsRolled, SlimCounts(LEFT));	 
										 
by_interim := RECORD
	dsSlimCounts.agencyid;
	dsSlimCounts.accident_date;
	dsSlimCounts.DayOfWeek;
	dsSlimCounts.Tour;
	dsSlimCounts.Intersection;
	INTEGER AccidentCnt						:= SUM(GROUP, dsSlimCounts.accidentcnt);
	INTEGER ATVehicle							:= SUM(GROUP, dsSlimCounts.ATVehicle);
	INTEGER ATPedestrian 					:= SUM(GROUP, dsSlimCounts.ATPedestrian);
	INTEGER ATBicycle							:= SUM(GROUP, dsSlimCounts.ATBicycle);
	INTEGER ATMotorcycle					:= SUM(GROUP, dsSlimCounts.ATMotorcycle);			
	INTEGER ATAnimal					  	:= SUM(GROUP, dsSlimCounts.ATAnimal);					
	INTEGER ATTrain		  					:= SUM(GROUP, dsSlimCounts.ATTrain);		
	INTEGER ATUnknown  						:= SUM(GROUP, dsSlimCounts.ATUnknown);
	INTEGER CTFrontRear			 			:= SUM(GROUP, dsSlimCounts.CTFrontRear);
	INTEGER CTFrontFront					:= SUM(GROUP, dsSlimCounts.CTFrontFront);			
	INTEGER CTAngle						  	:= SUM(GROUP, dsSlimCounts.CTAngle);					
	INTEGER CTSideSwipeSame		  	:= SUM(GROUP, dsSlimCounts.CTSideSwipeSame);		
	INTEGER CTSideSwipeOpposite  	:= SUM(GROUP, dsSlimCounts.CTSideSwipeOpposite);
	INTEGER CTRearSide					  := SUM(GROUP, dsSlimCounts.CTRearSide);					
	INTEGER CTRearRear					  := SUM(GROUP, dsSlimCounts.CTRearRear);					
	INTEGER CTOther						  	:= SUM(GROUP, dsSlimCounts.CTOther);						
	INTEGER CTUnknown					  	:= SUM(GROUP, dsSlimCounts.CTUnknown);	
	INTEGER InjuryCnt						  := SUM(GROUP, dsSlimCounts.InjuryCnt);
	INTEGER FatalCnt							:= SUM(GROUP, dsSlimCounts.FatalCnt);
	INTEGER PropDmgCnt						:= SUM(GROUP, dsSlimCounts.PropDmgCnt);

END;

EXPORT dsByInter := TABLE(dsSlimCounts, {by_interim}, agencyid, Accident_date, DayOfWeek, Tour, Intersection);

//***********************************************************************
//                 Key_eCrash_byMOY
//***********************************************************************
/* Dedup1 := DEDUP(BaseKey(DID > '0'),DID + Vehicle_Incident_id);
   Dedup2 := DEDUP(BaseKey(DID = '0'),Vehicle_Incident_Id + fname + lname + name_suffix);
*/
Layout_PrepEcrashAnalyticKeys.accidents_by_moy_slim slim({DedupedKey} L) := TRANSFORM
  SELF.AGENCYID 			      := L.Jurisdiction_nbr;
	SELF.accident_date       	:= L.accident_date;
	SELF.MonthOfYear          := IF(L.Accident_date[5..6] BETWEEN '01' AND '12', L.Accident_date[5..6], '13');
	SELF.Report_Code				  := L.Report_Code;
	SELF.Vehicle_Incident_ID  := L.Vehicle_Incident_ID;
	SELF.AccidentCnt				  := 1;	
			CountInjuries         := FLAccidents_Ecrash.Functions.CountInjuries(L.Report_Injury_Status);
	SELF.InjuryCnt					  := CountInjuries.InjuryCnt;
	SELF.FatalCnt							:= CountInjuries.FatalCnt;
	SELF.InjuryUnkCnt				  := CountInjuries.InjuryUnkCnt;
END;

dsWithCounts := PROJECT(DedupedKey, slim(LEFT));

{dsWithCounts} RollAccidents({dsWithCounts} L, {dsWithCounts} R):=TRANSFORM
  SELF.agencyid 						:= L.agencyid;
	SELF.accident_date 				:= L.accident_date;
	SELF.MonthOfYear					:= L.MonthOfYear;
	SELF.report_code					:= L.report_code;
	SELF.vehicle_incident_id	:= L.vehicle_incident_id;
	SELF.accidentCnt					:= L.accidentCnt;
	SELF.InjuryCnt						:= L.InjuryCnt + R.InjuryCnt;
	SELF.FatalCnt							:= L.FatalCnt + R.FatalCnt;
	SELF.InjuryUnkCnt					:= L.InjuryUnkCnt + R.InjuryUnkCnt;
END;
dsRolled := ROLLUP(dsWithCounts, 
                   LEFT.vehicle_incident_id = RIGHT.vehicle_Incident_id AND
									 LEFT.report_code = RIGHT.report_code,
									 RollAccidents(LEFT,RIGHT));


by_moy_interim := RECORD
	dsRolled.agencyid;
	dsRolled.accident_date;
	dsRolled.MonthOfYear;
	INTEGER AccidentCnt     := SUM(GROUP, dsRolled.accidentcnt);
	INTEGER InjuryCnt 			:= SUM(GROUP, dsRolled.InjuryCnt);
	INTEGER FatalCnt  			:= SUM(GROUP, dsRolled.FatalCnt);
	INTEGER UnknownCnt			:= SUM(GROUP, dsRolled.InjuryUnkCnt);
END;

EXPORT by_MOY := TABLE(dsRolled, {by_moy_interim}, agencyid, Accident_date, MonthOfYear);

END;