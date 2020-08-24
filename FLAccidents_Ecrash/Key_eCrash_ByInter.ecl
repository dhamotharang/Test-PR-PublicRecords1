// Ecrash Reports key, by Intersection

IMPORT FLAccidents_Ecrash, STD, UT, doxie,Data_Services;

BaseKey := FLAccidents_Ecrash.File_KeybuildV2.out(report_code = 'EA' AND report_type_id = 'A' AND work_type_id NOT IN['2','3'] AND (accident_street + accident_cross_street > ''));

Dedup1 := DEDUP(BaseKey(DID > '0'),DID + Vehicle_Incident_id);
Dedup2 := DEDUP(BaseKey(DID = '0'),Vehicle_Incident_Id + fname + lname + name_suffix);

DedupedKey := SORT(Dedup1 + Dedup2, jurisdiction_nbr + Vehicle_Incident_id + Vehicle_unit_number);


accidents_by_slim := RECORD
  STRING11  AgencyID;
	STRING8   accident_date;
	INTEGER   DayOfWeek;
	INTEGER   Tour;
	STRING104 Intersection;
	STRING    report_code;
	STRING    vehicle_incident_id;
	STRING    vehicle_unit_number;
	STRING    Report_vehicle_body_type;
	STRING    Report_first_harmful_event;
	STRING    Report_Collision_Type;
	INTEGER   AccidentCnt;
	INTEGER 	FatalCnt;       //only fatals
	INTEGER 	InjuryCnt;      //won't include fatals for the intersection report
	INTEGER 	PropDmgCnt;     //count of accidents having property damage
END;

accidents_by_slim PerformSlim({DedupedKey} L) := TRANSFORM
  SELF.AGENCYID 									:= L.Jurisdiction_nbr;
	SELF.DayOfWeek									:= FLAccidents_Ecrash.Functions.DayOfWeek(L.Accident_date);
	SELF.Tour												:= FLAccidents_Ecrash.Functions.GetTour(L.crash_time);
				both_streets := L.accident_street <> '' and L.accident_cross_street <> '';
			// remove periods for the POC so that 'RD' and 'RD.' are equivalent
			accident_street 						:= STD.Str.FilterOut(STD.Str.CleanSpaces(L.accident_street), '.');
			accident_cross_street 			:= STD.Str.FilterOut(STD.Str.CleanSpaces(L.accident_cross_street), '.');
			// only put the '&' in if both are present, otherwise treat it as a single street
	SELF.Intersection 							:= accident_street + if(both_streets, ' & ', '') + accident_cross_street;
	SELF.AccidentCnt								:= 1;
				CountInjuries := FLAccidents_Ecrash.Functions.CountInjuries(L.Report_Injury_Status);
	SELF.InjuryCnt							:= CountInjuries.InjuryCnt;
	SELF.FatalCnt								:= CountInjuries.FatalCnt;
	SELF.PropDmgCnt							:= IF(CountInjuries.InjuryCnt = 0 AND CountInjuries.FatalCnt = 0, 1, 0); 
	SELF := L;
END;

dsSlimmed := PROJECT(DedupedKey, PerformSlim(LEFT));

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

accidents_by_slim2 := RECORD
  STRING11 AgencyID;
	STRING8  accident_date;
	INTEGER  DayOfWeek;
	INTEGER  Tour;
	STRING   report_code;
	STRING   vehicle_incident_id;
	STRING   vehicle_unit_number;
	STRING   Intersection;
	INTEGER  AccidentCnt;
	INTEGER  ATVehicle;            
	INTEGER  ATPedestrian;
	INTEGER  ATBicycle;
	INTEGER  ATMotorcycle;
	INTEGER  ATAnimal;
	INTEGER  ATTrain;
	INTEGER  ATUnknown;
	INTEGER  CTFrontRear;
	INTEGER  CTFrontFront;
	INTEGER  CTAngle;
	INTEGER  CTSideSwipeSame;
	INTEGER  CTSideSwipeopposite;
	INTEGER  CTRearSide;
	INTEGER  CTRearRear;
	INTEGER  CTOther;
	INTEGER  CTUnknown;
	INTEGER  InjuryCnt;
	INTEGER  FatalCnt;
	INTEGER  PropDmgCnt;
END;

accidents_by_slim2 PerformCounts({dsVehiclesRolled} L) := TRANSFORM
	    NewBTString := stringlib.StringToUpperCase(TRIM(L.Report_vehicle_body_type,LEFT,RIGHT));
			NewFHEString := stringlib.StringToUpperCase(TRIM(L.Report_first_harmful_event,LEFT,RIGHT));
	SELF.ATVehicle 						:= FLAccidents_Ecrash.Functions.KnownVT(NewBTString);
	SELF.ATPedestrian         := IF(STD.Str.FindCount(NewFHEString, FLAccidents_Ecrash.Constants.PEDESTRIAN) > 0,1,0);
	SELF.ATBicycle            := IF(STD.Str.FindCount(NewFHEString, FLAccidents_Ecrash.Constants.BICYCLE) > 0,1,0);
	SELF.ATMotorcycle					:= IF(STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.MOTORCYCLE) > 0,1,0);
	SELF.ATAnimal							:= IF(STD.Str.FindCount(NewFHEString, FLAccidents_Ecrash.Constants.ANIMAL) > 0,1,0);
	SELF.ATTrain							:= IF(STD.Str.FindCount(NewFHEString, FLAccidents_Ecrash.Constants.TRAIN) > 0,1,0);
	SELF.ATUnknown            := IF((NewBTString = '') OR
	                                FLAccidents_Ecrash.Functions.UnknownVT(NewBTString) > 0 OR
																	FLAccidents_Ecrash.Functions.UnknownFHE(NewFHEString) > 0,1,0);
			NewCTString := stringlib.StringToUpperCase(TRIM(L.Report_Collision_Type,LEFT,RIGHT));
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
										 
inter_layout := RECORD
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

dsByInter := TABLE(dsSlimCounts, {inter_layout}, agencyid, Accident_date, DayOfWeek, Tour, Intersection);

EXPORT Key_ecrash_ByInter := INDEX(dsByInter, {agencyid, Accident_date}, {dsByInter}, 
                               Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2::analytics_byInter_' + doxie.Version_SuperKey);