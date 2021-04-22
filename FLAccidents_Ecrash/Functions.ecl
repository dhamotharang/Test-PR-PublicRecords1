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
	  SHARED STRING UpStringInjury := STD.Str.ToUpperCase(Report_Injury_Status);

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
	  PipeRemoved   						:= STD.Str.FindReplace(NewCTString, '|', '');
	  FrontRearRemoved  				:= STD.Str.FindReplace(PipeRemoved, FLAccidents_Ecrash.Constants.FRONTREAR, ''); 
    FrontFrontRemoved 				:= STD.Str.FindReplace(FrontRearRemoved, FLAccidents_Ecrash.Constants.FRONTFRONT, '');
    AngleRemoved							:= STD.Str.FindReplace(FrontFrontRemoved, FLAccidents_Ecrash.Constants.ANGLE, '');
		SideSwipeSameRemoved			:= STD.Str.FindReplace(AngleRemoved, FLAccidents_Ecrash.Constants.SIDESWIPESAME, '');
		SideSwipeOppositeRemoved 	:= STD.Str.FindReplace(SideSwipeSameRemoved, FLAccidents_Ecrash.Constants.SIDESWIPEOPPOSITE, '');
		RearSideRemoved						:= STD.Str.FindReplace(SideSwipeOppositeRemoved, FLAccidents_Ecrash.Constants.REARSIDE, '');
		RearRearRemoved						:= STD.Str.FindReplace(RearSideRemoved, FLAccidents_Ecrash.Constants.REARREAR, '');
		OtherRemoved							:= STD.Str.FindReplace(RearRearRemoved, FLAccidents_Ecrash.Constants.OTHER, '');	
		
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
	    PipeRemoved 						:= STD.Str.FindReplace(NewBTString, '|', '');
			PassengerCarRemoved 		:= STD.Str.FindReplace(PipeRemoved, FLAccidents_Ecrash.Constants.PASSENGERCAR, '');
			SUVRemoved							:= STD.Str.FindReplace(PassengerCarRemoved, FLAccidents_Ecrash.Constants.SUV, '');
			PASSENGERVANRemoved			:= STD.Str.FindReplace(SUVRemoved, FLAccidents_Ecrash.Constants.PASSENGERVAN, '');
			CARGOVANRemoved					:= STD.Str.FindReplace(PASSENGERVANRemoved, FLAccidents_Ecrash.Constants.CARGOVAN, '');
			PICKUPRemoved						:= STD.Str.FindReplace(CARGOVANRemoved, FLAccidents_Ecrash.Constants.PICKUP, '');
			MOTORHOMERemoved				:= STD.Str.FindReplace(PICKUPRemoved, FLAccidents_Ecrash.Constants.MOTORHOME, '');
			SCHOOLBUSRemoved				:= STD.Str.FindReplace(MOTORHOMERemoved, FLAccidents_Ecrash.Constants.SCHOOLBUS, '');
			TRANSITBUSRemoved				:= STD.Str.FindReplace(SCHOOLBUSRemoved, FLAccidents_Ecrash.Constants.TRANSITBUS, '');
			MOTORCOACHRemoved				:= STD.Str.FindReplace(TRANSITBUSRemoved, FLAccidents_Ecrash.Constants.MOTORCOACH, '');
			OTHERBUSRemoved					:= STD.Str.FindReplace(MOTORCOACHRemoved, FLAccidents_Ecrash.Constants.OTHERBUS, '');
			MOPEDRemoved						:= STD.Str.FindReplace(OTHERBUSRemoved, FLAccidents_Ecrash.Constants.MOPED, '');
			LOWSPEEDVEHICLERemoved	:= STD.Str.FindReplace(MOPEDRemoved, FLAccidents_Ecrash.Constants.LOWSPEEDVEHICLE, '');
			ATVRemoved							:= STD.Str.FindReplace(LOWSPEEDVEHICLERemoved, FLAccidents_Ecrash.Constants.ATV, '');
			SNOWMOBILERemoved				:= STD.Str.FindReplace(ATVRemoved, FLAccidents_Ecrash.Constants.SNOWMOBILE, '');
			OTHERLIGHTTRUCKRemoved	:= STD.Str.FindReplace(SNOWMOBILERemoved, FLAccidents_Ecrash.Constants.OTHERLIGHTTRUCK, '');
			MEDIUMHEAVYTRUCKRemoved	:= STD.Str.FindReplace(OTHERLIGHTTRUCKRemoved, FLAccidents_Ecrash.Constants.MEDIUMHEAVYTRUCK, '');
			OTHERRemoved						:= STD.Str.FindReplace(MEDIUMHEAVYTRUCKRemoved, FLAccidents_Ecrash.Constants.OTHER, '');
			MOTORCYCLERemoved				:= STD.Str.FindReplace(OTHERRemoved, FLAccidents_Ecrash.Constants.MOTORCYCLE, '');
			
			INTEGER Cnt := IF(MOTORCYCLERemoved > '', 1, 0);
			
			RETURN Cnt;
	END;
	
	EXPORT UnknownFHE(STRING NewFHEString) := FUNCTION
	    PipeRemoved             := STD.Str.FindReplace(NewFHEString, '|', '');
			PEDESTRIANRemoved				:= STD.Str.FindReplace(PipeRemoved, FLAccidents_Ecrash.Constants.PEDESTRIAN, '');
	    BICYCLERemoved 					:= STD.Str.FindReplace(PEDESTRIANRemoved, FLAccidents_Ecrash.Constants.BICYCLE, '');
	    ANIMALRemoved  					:= STD.Str.FindReplace(BICYCLERemoved, FLAccidents_Ecrash.Constants.ANIMAL, '');
	    TRAINRemoved						:= STD.Str.FindReplace(ANIMALRemoved, FLAccidents_Ecrash.Constants.TRAIN, '');
			
			INTEGER Cnt := IF(TRAINRemoved > '', 1, 0);

	    RETURN Cnt;
	END; // UnknownFHE


	EXPORT CleanDate(string pDate) := function
   STRING yy := pDate[LENGTH(pDate)-1..];
	 STRING mm := pDate[4..6];
   INTEGER current_yy := (INTEGER)(stringlib.GetDateYYYYMMDD()[3..4]);
   STRING4 AdjustYear(STRING year) := MAP(LENGTH(year) <> 2 => year,
																				 (INTEGER)year <= (current_yy + 30) => (string4)(2000 + (integer)year),
											                   (STRING4)(1900 + (INTEGER)year));
   STRING Stdyear := AdjustYear(yy);
   STRING2 ConvertMonth(STRING3 mname) := MAP(mname = 'JAN' => '01',
																							mname = 'FEB' => '02',
																							mname = 'MAR' => '03',
																							mname = 'APR' => '04',
																							mname = 'MAY' => '05',
																							mname = 'JUN' => '06',
																							mname = 'JUL' => '07',
																							mname = 'AUG' => '08',
																							mname = 'SEP' => '09',
																							mname = 'OCT' => '10',
																							mname = 'NOV' => '11',
																							mname = 'DEC' => '12',
																							'00');
	STRING Stdmmonth := ConvertMonth(STD.Str.ToUpperCase( mm ));
	STRING day := pDate[1..2];

	RETURN Stdyear+Stdmmonth+day;
 END;

 EXPORT dateconv(STRING10 date) := FUNCTION
    trim_date      := TRIM(date, ALL);
    hasSpecialChar := REGEXFIND('[-,/]', trim_date);
    numDate_1_2    := (UNSIGNED1) trim_date[1..2];
    numDate_3_4    := (UNSIGNED1) trim_date[3..4];
    numDate_4_5    := (UNSIGNED1) trim_date[4..5];
    numDate_5_6    := (UNSIGNED1) trim_date[5..6];
    numDate_6_7    := (UNSIGNED1) trim_date[6..7];
    numDate_7_8    := (UNSIGNED1) trim_date[7..8];
    numDate_8_9    := (UNSIGNED1) trim_date[8..9];
    
    RETURN IF(trim_date <> '',
      CASE(LENGTH(trim_date),
        10 => MAP(numDate_1_2 <= 12 AND trim_date[3] IN ['/'] AND numDate_4_5 >= 1 AND trim_date[6] IN ['/'] AND trim_date[7..8] IN ['19','20'] => (STRING) STD.Date.FromStringToDate(trim_date, '%m/%d/%Y'),
                  numDate_1_2 <= 12 AND trim_date[3] IN ['-'] AND numDate_4_5 >= 1 AND trim_date[6] IN ['-'] AND trim_date[7..8] IN ['19','20'] => (STRING) STD.Date.FromStringToDate(trim_date, '%m-%d-%Y'),
                  trim_date[1..2] IN ['19','20'] AND trim_date[5] IN ['-', '/'] AND numDate_6_7 <= 12 => trim_date[1..4] + trim_date[6..7] + trim_date[9..10],
                  trim_date[1..2] IN ['19','20'] AND trim_date[5] IN ['-', '/'] AND numDate_6_7 > 12 => trim_date[1..4] + trim_date[9..10] + trim_date[6..7],
                  numDate_1_2 >= 1 AND trim_date[3] IN ['/'] AND numDate_4_5 <= 12 AND trim_date[6] IN ['/'] => (STRING) STD.Date.FromStringToDate(trim_date, '%d/%m/%Y'),
                  numDate_1_2 >= 1 AND trim_date[3] IN ['-'] AND numDate_4_5 <= 12 AND trim_date[6] IN ['-'] => (STRING) STD.Date.FromStringToDate(trim_date, '%d-%m-%Y'),
                  ''),
        9 => MAP(REGEXFIND('[aA-zZ]', trim_date) = TRUE => CleanDate(trim_date),
                 hasSpecialChar AND trim_date[1..2] IN ['19','20'] AND trim_date[3..4] NOT IN ['-', '/'] AND trim_date[5] IN ['-', '/'] AND trim_date[7] NOT IN ['-', '/'] AND numDate_6_7 > 12 => trim_date[1..4] + '0' + trim_date[9] + trim_date[6..7],
                 hasSpecialChar AND trim_date[2] IN ['-', '/'] => trim_date[6..9] + '0' + trim_date[1] + trim_date[3..4],
                 hasSpecialChar AND trim_date[1..2] IN ['19','20'] AND trim_date[3..4] NOT IN ['-', '/'] AND trim_date[5] IN ['-', '/'] AND trim_date[7] IN ['-', '/'] AND numDate_8_9 > 12 => trim_date[1..4] + '0' + trim_date[6] + trim_date[8..9],
                 hasSpecialChar AND trim_date[1..2] IN ['19','20'] AND trim_date[3..4] NOT IN ['-', '/'] AND trim_date[5] IN ['-', '/'] AND trim_date[7] IN ['-', '/'] => trim_date[1..4] + '0' + trim_date[6] + trim_date[8..9],
                 hasSpecialChar AND numDate_1_2 > 12 AND trim_date[3] IN ['-', '/'] AND trim_date[5] IN ['-', '/'] => trim_date[6..9] + '0' + trim_date[4] + trim_date[1..2],
                 hasSpecialChar AND trim_date[3] IN ['-', '/'] AND trim_date[5] IN ['-', '/'] => trim_date[6..9] + '0' + trim_date[4] + trim_date[1..2],
                 ''),
        8 => MAP(hasSpecialChar AND trim_date[3] IN ['-','/'] AND trim_date[7] IN ['1','0'] AND numDate_1_2 <= 12 => '20' + trim_date[7..8] + trim_date[1..2] + trim_date[4..5],
                 hasSpecialChar AND trim_date[3] IN ['-','/'] AND trim_date[7] IN ['1','0'] AND numDate_1_2 > 12 => '20' + trim_date[7..8] + trim_date[4..5] + trim_date[1..2],
                 hasSpecialChar AND trim_date[3] IN ['-','/'] AND numDate_7_8 > 30 AND numDate_1_2 <= 12 => '19' + trim_date[7..8] + trim_date[1..2] + trim_date[4..5],
                 hasSpecialChar AND trim_date[3] IN ['-','/'] AND numDate_7_8 > 30 AND numDate_1_2 > 12 => '19' + trim_date[7..8] + trim_date[4..5] + trim_date[1..2],
                 hasSpecialChar = FALSE AND trim_date[1..2] IN ['19','20'] AND numDate_5_6 <= 12 => trim_date,
                 hasSpecialChar = FALSE AND trim_date[1..2] IN ['19','20'] AND numDate_5_6 > 12 AND trim_date[5..6] NOT IN ['19','20'] => trim_date[1..4] + trim_date[7..8] + trim_date[5..6],
                 hasSpecialChar = FALSE AND trim_date[1..2] IN ['19','20'] AND numDate_3_4 <= 12 AND trim_date[5..6] IN ['19','20'] => trim_date[5..8] + trim_date[3..4] + trim_date[1..2],
                 hasSpecialChar = FALSE AND trim_date[5..6] IN ['19','20'] AND numDate_1_2 <= 12 => trim_date[5..8] + trim_date[1..2] + trim_date[3..4],
                 hasSpecialChar = FALSE AND trim_date[5..6] IN ['19','20'] AND numDate_1_2 > 12 => trim_date[5..8] + trim_date[3..4] + trim_date[1..2],
                 ''),
        7 => MAP(hasSpecialChar = FALSE AND trim_date[4..5] IN ['19','20'] => trim_date[4..7] + '0' + trim_date[1..3],
                 hasSpecialChar AND numDate_6_7 > 30 AND trim_date[3] IN ['-','/'] AND numDate_1_2 > 12 => '19' + trim_date[6..7] + '0' + trim_date[4] + trim_date[1..2],
                 hasSpecialChar AND numDate_6_7 > 30 AND trim_date[3] IN ['-','/'] AND numDate_1_2 <= 12 => '19' + trim_date[6..7] + trim_date[1..2] + '0' + trim_date[4],
                 hasSpecialChar AND numDate_6_7 < 30 AND trim_date[3] IN ['-','/'] AND numDate_1_2 > 12 => '20' + trim_date[6..7] + '0' + trim_date[4] + trim_date[1..2],
                 hasSpecialChar AND numDate_6_7 < 30 AND trim_date[3] IN ['-','/'] AND numDate_1_2 <= 12 => '20' + trim_date[6..7] + trim_date[1..2] + '0' + trim_date[4],
                 hasSpecialChar AND numDate_6_7 > 30 AND trim_date[2] IN ['-','/'] AND numDate_3_4 > 12 => '19' + trim_date[6..7] + '0' + trim_date[1] + trim_date[3..4],
                 hasSpecialChar AND numDate_6_7 > 30 AND trim_date[2] IN ['-','/'] AND numDate_3_4 <= 12 => '19' + trim_date[6..7] + trim_date[3..4] + '0' + trim_date[1],
                 hasSpecialChar AND numDate_6_7 < 30 AND trim_date[2] IN ['-','/'] AND numDate_3_4 > 12 => '20' + trim_date[6..7] + '0' + trim_date[1] + trim_date[3..4],
                 hasSpecialChar AND numDate_6_7 < 30 AND trim_date[2] IN ['-','/'] AND numDate_3_4 <= 12 => '20' + trim_date[6..7] + trim_date[3..4] + '0' + trim_date[1],
                 ''),
        6 => MAP(trim_date[3..4] IN ['19','20'] AND trim_date[1..2] NOT IN ['19','20'] => trim_date[3..6] + '0' + trim_date[1] + '0' + trim_date[2],
                 trim_date[1..2] IN ['19','20'] AND trim_date[3..4] NOT IN ['19','20'] => trim_date[1..4] + '0' + trim_date[5] + '0' + trim_date[6],
                 numDate_1_2 > 50 AND trim_date[3] = '0' AND trim_date[5] = '0' => '19' + trim_date[1..6],
                 trim_date[5] IN ['1','0','2'] AND numDate_1_2 <= 12 => '20' + trim_date[5..6] + trim_date[1..4],
                 trim_date[5] IN ['1','0','2'] AND numDate_1_2 > 12 => '20' + trim_date[5..6] + trim_date[3..4] + trim_date[1..2],
                 trim_date[5] NOT IN ['1','0','2'] AND numDate_1_2 <= 12 => '19' + trim_date[5..6] + trim_date[1..4],
                 trim_date[5] NOT IN ['1','0','2'] AND numDate_1_2 > 12 => '19' + trim_date[5..6] + trim_date[3..4] + trim_date[1..2],
                 '') ,

        ''),
    '');
  END;
	
  EXPORT BOOLEAN IsActiveDate(UNSIGNED4 TodaysDate, UNSIGNED4 startDt, UNSIGNED4 terminationDt) := FUNCTION
    B1 := TodaysDate BETWEEN startDt AND terminationDt;
   RETURN B1;
  END; 

END;
