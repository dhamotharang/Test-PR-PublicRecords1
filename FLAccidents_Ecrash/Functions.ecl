IMPORT FLAccidents_Ecrash, lib_stringlib, STD, ut;
EXPORT Functions := MODULE

	EXPORT INTEGER GetTour(STRING CrashTime):= FUNCTION
		INTEGER CrashHour := (INTEGER) CrashTime[1..2];
		INTEGER Tour := MAP(CrashTime = '' OR CrashTime NOT BETWEEN '00' AND '23' => 4,
												CrashHour >= 7 AND CrashHour <= 14 => 1,
												CrashHour >= 15 AND CrashHour <= 22 => 2,
												CrashHour >= 23 OR CrashHour <= 6 => 3,
												4);
		RETURN Tour;
	END;


	EXPORT CountInjuries(STRING Report_Injury_Status) := MODULE
	  SHARED STRING UpStringInjury := stringlib.StringToUpperCase(Report_Injury_Status);

		EXPORT INTEGER FatalCnt	 := IF(STD.Str.FindCount(UpStringInjury, FLAccidents_Ecrash.Constants.FATAL) > 0, 1, 0);

	  SHARED INTEGER Injuries := MAP(STD.Str.FindCount(UpStringInjury, FLAccidents_Ecrash.Constants.INCAPACITATING) > 0 => 1,
		  											       STD.Str.FindCount(UpStringInjury, FLAccidents_Ecrash.Constants.POSSIBLE) > 0 => 1,
														       0);
    
    EXPORT INTEGER InjuryCnt := MAP(FatalCnt > 0 AND Injuries > 0 => Injuries - 1,
                                    FatalCnt = 0 AND Injuries > 0 => 1,
												            0);
		
	  EXPORT INTEGER InjuryUnkCnt := IF(InjuryCnt = 0 AND FatalCnt = 0,
																			MAP(STD.Str.FindCount(UpStringInjury, FLAccidents_Ecrash.Constants.Unknown) > 0  => 1,
																					STD.Str.FindCount(UpStringInjury, FLAccidents_Ecrash.Constants.NoInjury) > 0 => 0,
																					1),
																			0);
	END; 
	
	EXPORT DayOfWeek(STRING8 accident_date) := FUNCTION
		INTEGER DayOfWeek  := IF(ut.isNumeric(accident_date),
	                          CASE(ut.WeekDay((INTEGER) Accident_date),
														     FLAccidents_Ecrash.Constants.Monday 		=> 1,
	                               FLAccidents_Ecrash.Constants.Tuesday 	=> 2,
																 FLAccidents_Ecrash.Constants.Wednesday => 3,
																 FLAccidents_Ecrash.Constants.Thursday 	=> 4,
																 FLAccidents_Ecrash.Constants.Friday		=> 5,
																 FLAccidents_Ecrash.Constants.Saturday 	=> 6,
																 FLAccidents_Ecrash.Constants.Sunday 		=> 7,8),8);
																 
		RETURN DayOfWeek;

  END;

  EXPORT UnknownCT(STRING NewCTString) := FUNCTION
    //Remove all known collision types out of the string and see if we have anything left over, if we do, then
		//we have a collision type that is unknown
	  PipeRemoved   						:= stringlib.StringFindReplace(NewCTString, '|', '');
	  FrontRearRemoved  				:= stringlib.StringFindReplace(PipeRemoved, FLAccidents_Ecrash.Constants.FRONTREAR, ''); 
    FrontFrontRemoved 				:= stringlib.StringFindReplace(FrontRearRemoved, FLAccidents_Ecrash.Constants.FRONTFRONT, '');
    AngleRemoved							:= stringlib.StringFindReplace(FrontFrontRemoved, FLAccidents_Ecrash.Constants.ANGLE, '');
		SideSwipeSameRemoved			:= stringlib.StringFindReplace(AngleRemoved, FLAccidents_Ecrash.Constants.SIDESWIPESAME, '');
		SideSwipeOppositeRemoved 	:= stringlib.StringFindReplace(SideSwipeSameRemoved, FLAccidents_Ecrash.Constants.SIDESWIPEOPPOSITE, '');
		RearSideRemoved						:= stringlib.StringFindReplace(SideSwipeOppositeRemoved, FLAccidents_Ecrash.Constants.REARSIDE, '');
		RearRearRemoved						:= stringlib.StringFindReplace(RearSideRemoved, FLAccidents_Ecrash.Constants.REARREAR, '');
		OtherRemoved							:= stringlib.StringFindReplace(RearRearRemoved, FLAccidents_Ecrash.Constants.OTHER, '');	
		
		INTEGER Cnt := IF(OtherRemoved > '' OR NewCTString = '', 1, 0);
    RETURN Cnt;
	END;
	
	EXPORT KnownVT(STRING NewBTString) := FUNCTION
    INTEGER TypeCnt := MAP(STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.PASSENGERCAR) > 0 => 1,     	
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.SUV) > 0 => 1,								
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.PASSENGERVAN) > 0 => 1,    	
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.CARGOVAN) > 0 => 1,        	
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.PICKUP) > 0 => 1,          	
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.MOTORHOME) > 0 => 1,					
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.SCHOOLBUS) > 0 => 1,       	
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.TRANSITBUS) > 0 => 1,      	
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.MOTORCOACH) > 0 => 1,      	
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.OTHERBUS) > 0 => 1,					
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.MOPED) > 0 => 1,							
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.LOWSPEEDVEHICLE) > 0 => 1,		
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.ATV) > 0 => 1,								
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.SNOWMOBILE) > 0 => 1,      	
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.OTHERLIGHTTRUCK) > 0 => 1, 	
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.MEDIUMHEAVYTRUCK) > 0 => 1,
													 STD.Str.FindCount(NewBTString, FLAccidents_Ecrash.Constants.OTHER) > 0 => 1,
													 0);
	    RETURN TypeCnt;	
	END;

// So to find Unknown Vehicle Types, I need to remove all the known types out of the string and see if there is anything left.
// If so, it is truly an unknown vehicle type.	
	EXPORT UnknownVT(STRING NewBTString) := FUNCTION
	    PipeRemoved 						:= stringlib.StringFindReplace(NewBTString, '|', '');
			PassengerCarRemoved 		:= stringlib.StringFindReplace(PipeRemoved, FLAccidents_Ecrash.Constants.PASSENGERCAR, '');
			SUVRemoved							:= stringlib.StringFindReplace(PassengerCarRemoved, FLAccidents_Ecrash.Constants.SUV, '');
			PASSENGERVANRemoved			:= stringlib.StringFindReplace(SUVRemoved, FLAccidents_Ecrash.Constants.PASSENGERVAN, '');
			CARGOVANRemoved					:= stringlib.StringFindReplace(PASSENGERVANRemoved, FLAccidents_Ecrash.Constants.CARGOVAN, '');
			PICKUPRemoved						:= stringlib.StringFindReplace(CARGOVANRemoved, FLAccidents_Ecrash.Constants.PICKUP, '');
			MOTORHOMERemoved				:= stringlib.StringFindReplace(PICKUPRemoved, FLAccidents_Ecrash.Constants.MOTORHOME, '');
			SCHOOLBUSRemoved				:= stringlib.StringFindReplace(MOTORHOMERemoved, FLAccidents_Ecrash.Constants.SCHOOLBUS, '');
			TRANSITBUSRemoved				:= stringlib.StringFindReplace(SCHOOLBUSRemoved, FLAccidents_Ecrash.Constants.TRANSITBUS, '');
			MOTORCOACHRemoved				:= stringlib.StringFindReplace(TRANSITBUSRemoved, FLAccidents_Ecrash.Constants.MOTORCOACH, '');
			OTHERBUSRemoved					:= stringlib.StringFindReplace(MOTORCOACHRemoved, FLAccidents_Ecrash.Constants.OTHERBUS, '');
			MOPEDRemoved						:= stringlib.StringFindReplace(OTHERBUSRemoved, FLAccidents_Ecrash.Constants.MOPED, '');
			LOWSPEEDVEHICLERemoved	:= stringlib.StringFindReplace(MOPEDRemoved, FLAccidents_Ecrash.Constants.LOWSPEEDVEHICLE, '');
			ATVRemoved							:= stringlib.StringFindReplace(LOWSPEEDVEHICLERemoved, FLAccidents_Ecrash.Constants.ATV, '');
			SNOWMOBILERemoved				:= stringlib.StringFindReplace(ATVRemoved, FLAccidents_Ecrash.Constants.SNOWMOBILE, '');
			OTHERLIGHTTRUCKRemoved	:= stringlib.StringFindReplace(SNOWMOBILERemoved, FLAccidents_Ecrash.Constants.OTHERLIGHTTRUCK, '');
			MEDIUMHEAVYTRUCKRemoved	:= stringlib.StringFindReplace(OTHERLIGHTTRUCKRemoved, FLAccidents_Ecrash.Constants.MEDIUMHEAVYTRUCK, '');
			OTHERRemoved						:= stringlib.StringFindReplace(MEDIUMHEAVYTRUCKRemoved, FLAccidents_Ecrash.Constants.OTHER, '');
			MOTORCYCLERemoved				:= stringlib.StringFindReplace(OTHERRemoved, FLAccidents_Ecrash.Constants.MOTORCYCLE, '');
			
			INTEGER Cnt := IF(MOTORCYCLERemoved > '', 1, 0);
			
			RETURN Cnt;
	END;
	
	EXPORT UnknownFHE(STRING NewFHEString) := FUNCTION
	    PipeRemoved             := stringlib.StringFindReplace(NewFHEString, '|', '');
			PEDESTRIANRemoved				:= stringlib.StringFindReplace(PipeRemoved, FLAccidents_Ecrash.Constants.PEDESTRIAN, '');
	    BICYCLERemoved 					:= stringlib.StringFindReplace(PEDESTRIANRemoved, FLAccidents_Ecrash.Constants.BICYCLE, '');
	    ANIMALRemoved  					:= stringlib.StringFindReplace(BICYCLERemoved, FLAccidents_Ecrash.Constants.ANIMAL, '');
	    TRAINRemoved						:= stringlib.StringFindReplace(ANIMALRemoved, FLAccidents_Ecrash.Constants.TRAIN, '');
			
			INTEGER Cnt := IF(TRAINRemoved > '', 1, 0);

	    RETURN Cnt;
	END; // UnknownFHE

END;