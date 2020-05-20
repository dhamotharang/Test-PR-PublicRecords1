/*2017-03-22T17:50:04Z (Srilatha Katukuri)
ECH-4531 Analytics key Injury count correction
*/
IMPORT FLAccidents_Ecrash, STD, UT, doxie, Data_Services;

BaseKey := FLAccidents_Ecrash.File_Keybuild_analytics;

/* Dedup1 := DEDUP(BaseKey(DID > '0'),DID + Vehicle_Incident_id);
   Dedup2 := DEDUP(BaseKey(DID = '0'),Vehicle_Incident_Id + fname + lname + name_suffix);
*/

Dedup1 := DEDUP(SORT(DISTRIBUTE(BaseKey(DID > '0'),hash32(Vehicle_Incident_Id)),DID , Vehicle_Incident_id, local),DID , Vehicle_Incident_id,local);
Dedup2 := DEDUP(SORT(DISTRIBUTE(BaseKey(DID = '0'), hash32(Vehicle_Incident_Id)), Vehicle_Incident_Id ,fname , lname , name_suffix , dob , driver_license_nbr,local)
														,Vehicle_Incident_Id ,fname ,lname ,name_suffix ,dob ,driver_license_nbr, local );
														 
DedupedKey := SORT(Dedup1 + Dedup2, jurisdiction_nbr + Vehicle_Incident_id + Vehicle_unit_number);


accidents_by_CT_slim := RECORD
  STRING11 AgencyID;
	STRING8  accident_date;
	STRING   report_code;
	STRING   vehicle_incident_id;
	STRING   vehicle_unit_number;
	STRING   Report_Collision_Type;
END;

accidents_by_CT_slim CTslim({DedupedKey} L) := TRANSFORM
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

accidents_by_CT_slim2 := RECORD
  STRING11 AgencyID;
	STRING8  accident_date;
	STRING   report_code;
	STRING   vehicle_incident_id;
	STRING   vehicle_unit_number;
	INTEGER  AccidentCnt;
	INTEGER  CTFrontRear;
	INTEGER  CTFrontFront;
	INTEGER  CTAngle;
	INTEGER  CTSideSwipeSame;
	INTEGER  CTSideSwipeopposite;
	INTEGER  CTRearSide;
	INTEGER  CTRearRear;
	INTEGER  CTOther;
	INTEGER  CTUnknown;
END;

accidents_by_CT_slim2 CountCT({dsVehiclesRolled} L) := TRANSFORM
	SELF.AccidentCnt					:= 1;
	    NewCTString  := STD.Str.ToUpperCase(TRIM(L.Report_Collision_Type,LEFT,RIGHT));
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

inter_layout := RECORD
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

dsByCollisionType := TABLE(dsSlimCounts, {inter_layout}, agencyid, Accident_date);

EXPORT Key_ecrash_byCollisionType := INDEX(dsByCollisionType, {agencyid, Accident_date}, {dsByCollisionType},
                                           Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2::analytics_byCollisionType_' + doxie.Version_SuperKey);

