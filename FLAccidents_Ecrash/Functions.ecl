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
	
  EXPORT fSlashedMDYtoCYMD(STRING pDateIn) := FUNCTION
         outdate :=   INTFORMAT((INTEGER2)REGEXREPLACE('.*[-/].*[-/]([0-9]+)',pDateIn,'$1'),4,1) 
									  + INTFORMAT((INTEGER1)REGEXREPLACE('([0-9]+)[-/].*[-/].*',pDateIn,'$1'),2,1)
									  + INTFORMAT((INTEGER1)REGEXREPLACE('.*[-/]([0-9]+)[-/].*',pDateIn,'$1'),2,1);
   RETURN outdate;
  END;
	
	EXPORT fSlashedDMYtoCYMD(STRING pDateIn) := FUNCTION
         outdate :=   INTFORMAT((INTEGER2)REGEXREPLACE('.*[-/].*[-/]([0-9]+)',pDateIn,'$1'),4,1) 
									  + INTFORMAT((INTEGER1)REGEXREPLACE('.*[-/]([0-9]+)[-/].*',pDateIn,'$1'),2,1)
									  + INTFORMAT((INTEGER1)REGEXREPLACE('([0-9]+)[-/].*[-/].*',pDateIn,'$1'),2,1);
   RETURN outdate;
  END;

	EXPORT CleanPLDate(STRING pDate) := FUNCTION
    STRING yy := pDate[LENGTH(pDate)-1..];
	  STRING mm := pDate[4..6];
    INTEGER current_yy := (INTEGER)(stringlib.GetDateYYYYMMDD()[3..4]);
    STRING4 AdjustYear(STRING year) := MAP(LENGTH(year) <> 2 => year,
																				   (INTEGER)year <= (current_yy + 30) => (STRING4)(2000 + (INTEGER)year),
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
	 STRING Stdmmonth := ConvertMonth(stringlib.stringtouppercase( mm ));
	 STRING day := pDate[1..2];

	RETURN Stdyear+Stdmmonth+day;
 END;
	
 EXPORT dateconv( STRING10 date) := function
  RETURN  IF (TRIM(date) <> ''  , CASE ( LENGTH(TRIM(date)) , 10 =>  MAP( TRIM(date[1..2]) <= '12'  and TRIM(date) [4..5] > '12' =>  fSlashedMDYtoCYMD ( TRIM(date)),
                                                                          TRIM(date[1..2]) in [ '19','20' ] and TRIM(date)[5] in ['-', '/'] and TRIM(date)[6..7] <= '12' =>  TRIM(date[1..4]) + TRIM(date)[6..7] + TRIM(date)[9..10],
																																          TRIM(date[1..2]) in [ '19','20' ] and TRIM(date)[5] in ['-', '/'] and TRIM(date)[6..7] > '12' =>  TRIM(date[1..4]) + TRIM(date)[9..10] + TRIM(date)[6..7] ,
																																           fSlashedDMYtoCYMD ( TRIM(date))),
                                                               9 =>  MAP( REGEXFIND('[aA-zZ]', TRIM(date)) = true => CleanPLDate ( TRIM(date)) ,
																										                      REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date) [1..2] in [ '19','20' ] and TRIM(date) [3..4] not in ['-', '/'] and TRIM(date)[5] in ['-', '/'] and  TRIM( date) [7] not in ['-', '/'] and TRIM(date)[6..7] > '12' => TRIM(date) [1..4] + '0' + TRIM(date)[9] + TRIM(date)[6..7],
																															            REGEXFIND( '[-,/]',TRIM(date)) and  TRIM(date)[2] in ['-', '/'] =>  TRIM(date) [6..9] + '0' + TRIM(date)[1] + TRIM(date)[3..4],
																															            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date) [1..2] in [ '19','20' ] and TRIM(date) [3..4] not in ['-', '/'] and TRIM(date)[5] in ['-', '/'] and TRIM( date) [7] in ['-', '/'] and TRIM(date)[8..9] > '12' => TRIM(date) [1..4] + '0' + TRIM(date)[6] + TRIM(date)[8..9],
																															            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date) [1..2] in [ '19','20' ] and TRIM(date) [3..4] not in ['-', '/'] and TRIM(date)[5] in ['-', '/'] and TRIM( date) [7] in ['-', '/']  => TRIM(date) [1..4] + '0' + TRIM(date)[6] + TRIM(date)[8..9],
																															            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date) [1..2] > '12' and TRIM(date)[3] in ['-', '/'] and TRIM( date) [5] in ['-', '/'] => TRIM(date) [6..9] + '0' + TRIM( date) [4] + TRIM(date) [1..2],
																															            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[3] in ['-', '/'] and TRIM( date) [5] in ['-', '/'] => TRIM(date) [6..9] + '0' + TRIM( date) [4] + TRIM(date) [1..2],
																															            ''),
																															  
																		                           8 =>   MAP( REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[3] in ['-','/'] and TRIM(date)[7] in ['1','0']  and TRIM(date[1..2]) <= '12' => '20' + TRIM(date)[7..8] +  TRIM(date)[1..2] + TRIM(date)[4..5],
																										                       REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[3] in ['-','/']  and TRIM(date)[7] in ['1','0'] and  TRIM(date[1..2]) > '12' => '20' + TRIM(date)[7..8] + TRIM(date)[4..5]  +  TRIM(date)[1..2],
																		                                       REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[3] in ['-','/'] and TRIM(date)[7..8] > '30' and TRIM(date[1..2]) <= '12' => '19' + TRIM(date)[7..8] +  TRIM(date)[1..2] + TRIM(date)[4..5],
																																           REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[3] in ['-','/'] and TRIM(date)[7..8] > '30' and TRIM(date[1..2]) > '12' => '19' + TRIM(date)[7..8] + TRIM(date)[4..5] +  TRIM(date)[1..2],
																															             REGEXFIND( '[-,/]',TRIM(date)) = false and TRIM(date)[1..2] 	in [ '19','20' ]  and TRIM(date[5..6]) <= '12' => TRIM(date),
																																           REGEXFIND( '[-,/]',TRIM(date)) = false and TRIM(date)[1..2] 	in [ '19','20' ]  and TRIM(date[5..6]) > '12' and TRIM( date)[5..6] not in [ '19','20' ] => TRIM(date[1..4]) + TRIM(date[7..8]) + TRIM(date[5..6]),
																																           REGEXFIND( '[-,/]',TRIM(date)) = false and TRIM(date)[1..2] 	in [ '19','20' ]  and TRIM(date[3..4]) <= '12' and TRIM( date)[5..6]  in [ '19','20' ] => TRIM(date[5..8]) + TRIM(date[3..4]) + TRIM(date[1..2]),
                                                                           REGEXFIND( '[-,/]',TRIM(date)) = false and TRIM(date)[5..6] in [ '19','20' ] and TRIM(date[1..2]) <= '12'  => TRIM(date[5..8]) + TRIM(date[1..2]) + TRIM(date[3..4]),
																																           REGEXFIND( '[-,/]',TRIM(date)) = false and TRIM(date)[5..6] in [ '19','20' ] and TRIM(date[1..2]) >  '12' => TRIM(date[5..8]) + TRIM(date[3..4]) + TRIM(date[1..2]), 
                                                                           ''),
																		                             7  => MAP( REGEXFIND( '[-,/]',TRIM(date)) = false and TRIM(date)[4..5] in [ '19','20' ] => TRIM(date[4..7]) + '0' + TRIM(date[1..3]),
																										                        REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[6..7] > '30' and TRIM(date)[3] in ['-','/'] and TRIM(date)[1..2] > '12' => '19' +TRIM(date)[6..7] + '0'+ TRIM(date)[4] + TRIM(date) [1..2] ,
																																            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[6..7] > '30' and TRIM(date)[3] in ['-','/']  and TRIM(date)[1..2] <= '12' => '19' +TRIM(date)[6..7] + TRIM(date) [1..2] + '0'+ TRIM(date)[4] ,
																																            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[6..7] < '30' and TRIM(date)[3] in ['-','/'] and TRIM(date)[1..2] > '12' => '20' +TRIM(date)[6..7] + '0'+ TRIM(date)[4] + TRIM(date) [1..2], 
																																            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[6..7] < '30' and TRIM(date)[3] in ['-','/'] and TRIM(date)[1..2] <= '12' => '20' +TRIM(date)[6..7] + TRIM(date) [1..2] + '0'+ TRIM(date)[4] , 
																																            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[6..7] > '30' and TRIM(date)[2] in ['-','/'] and TRIM(date)[3..4] > '12'  => '19' +TRIM(date)[6..7] + '0'+ TRIM(date)[1] + TRIM(date) [3..4],
																																            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[6..7] > '30' and TRIM(date)[2] in ['-','/']and TRIM(date)[3..4] <= '12'  => '19' +TRIM(date)[6..7] + TRIM(date) [3..4] + '0'+ TRIM(date)[1],
																																            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[6..7] < '30' and TRIM(date)[2] in ['-','/'] and TRIM(date)[3..4] > '12'  => '20' +TRIM(date)[6..7] + '0'+ TRIM(date)[1] + TRIM(date) [3..4],
																																            REGEXFIND( '[-,/]',TRIM(date)) and TRIM(date)[6..7] < '30' and TRIM(date)[2] in ['-','/'] and TRIM(date)[3..4] <= '12'  => '20' +TRIM(date)[6..7] + TRIM(date) [3..4] + '0'+ TRIM(date)[1],
																																						''),
																		                             6 => MAP( TRIM(date)[3..4] in [ '19','20' ]  and ( TRIM(date)[1..2]  not in [ '19','20' ] )  => TRIM(date)[3..6] + '0'+ TRIM(date)[1]+ '0' + TRIM(date)[2] ,
																																           TRIM(date)[1..2] in [ '19','20' ]  and ( TRIM(date)[3..4]  not in [ '19','20' ] ) => TRIM(date)[1..4] + '0'+ TRIM(date)[5]+ '0' + TRIM(date)[6] ,	
																																           TRIM(date)[1..2] > '50' and TRIM(date)[3] = '0' and TRIM(date)[5] = '0' => '19' + TRIM(date)[1..6],
																																           TRIM(date)[5] in ['1','0','2'] and TRIM(date)[1..2] <= '12'  => '20' + TRIM(date)[5..6] + TRIM(date)[1..4],
																										                       TRIM(date)[5] in ['1','0','2'] and TRIM(date)[1..2] > '12'  => '20' + TRIM(date)[5..6] + TRIM(date)[3..4] + TRIM(date)[1..2],
																													                 TRIM(date)[5] not in ['1','0','2'] and TRIM(date)[1..2] <= '12'   =>  '19' + TRIM(date)[5..6] + TRIM(date)[1..4],
																																 	         TRIM(date)[5] not in ['1','0','2'] and TRIM(date)[1..2] > '12'   =>  '19' + TRIM(date)[5..6] + TRIM(date)[3..4] + TRIM(date)[1..2],
																																	         '') ,
																																 
																			                          ''),
						                                                '');
 END;

END;