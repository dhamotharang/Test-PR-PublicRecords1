IMPORT FLAccidents_ecrash, eCrash_Analytics;

EXPORT BuildReports(STRING inAgencyId, STRING InAgencyType, STRING8 inBeginDate, STRING8 inEndDate, STRING InSortSeq) := MODULE

	SHARED dsByAgency := LIMIT(FLAccidents_ecrash.Key_eCrash_ByAgencyID(KEYED(AgencyID = inAgencyId AND accident_date BETWEEN inBeginDate AND inEndDate)),eCrash_Analytics.Constants.MaxReadCnt);
	SHARED dsByDOW		:= LIMIT(FLAccidents_ecrash.Key_eCrash_ByDOW(KEYED(AgencyID = inAgencyId AND accident_date BETWEEN inBeginDate AND inEndDate)),eCrash_Analytics.Constants.MaxReadCnt);
	SHARED dsByHOD		:= LIMIT(FLAccidents_ecrash.Key_eCrash_ByHOD(KEYED(AgencyID = inAgencyId AND accident_date BETWEEN inBeginDate AND inEndDate)),eCrash_Analytics.Constants.MaxReadCnt);
	SHARED dsByMOY		:= LIMIT(FLAccidents_ecrash.Key_eCrash_ByMOY(KEYED(AgencyID = inAgencyId AND accident_date BETWEEN inBeginDate AND inEndDate)),eCrash_Analytics.Constants.MaxReadCnt);
	SHARED dsByCT			:= LIMIT(FLAccidents_ecrash.Key_eCrash_ByCollisionType(KEYED(AgencyID = inAgencyId AND accident_date BETWEEN inBeginDate AND inEndDate)),eCrash_Analytics.Constants.MaxReadCnt);
	SHARED dsByInter	:= LIMIT(FLAccidents_ecrash.Key_eCrash_ByInter(KEYED(AgencyID = inAgencyId AND accident_date BETWEEN inBeginDate AND inEndDate)),eCrash_Analytics.Constants.MaxReadCnt);

//at agency level, I'll slim the record, then do a rollup to count all the accidents at that agency level, and finally put that 1 record we
//end up with into the standard output layout that all the reports will use.
//Agency Level Accident Count
  SHARED Layouts.Layout_AgencyLvl AgencyLvlSlim({dsByAgency} L):=TRANSFORM
	  SELF.AgencyID 		:= L.AgencyID;
		SELF.AccidentCnt 	:= L.AccidentCnt;
		SELF.InjuryCnt   	:= L.InjuryCnt;
		SELF.FatalCnt			:= L.FatalCnt;
	END;
	
	SHARED dsAgencyLvl := PROJECT(dsByAgency, AgencyLvlSlim(LEFT)); 
	
  SHARED {dsAgencyLvl} RollAgencyLvl({dsAgencyLvl} L, {dsAgencyLvl} R):=TRANSFORM
	  SELF.agencyID 		:= L.agencyID;
		SELF.AccidentCnt 	:= L.AccidentCnt + R.AccidentCnt;
		SELF.InjuryCnt		:= L.InjuryCnt + R.InjuryCnt;
		SELF.FatalCnt			:= L.FatalCnt + R.FatalCnt;
  END;
	
	SHARED dsAgencyLvlRolled := ROLLUP(dsAgencyLvl,
																		 LEFT.AgencyID=RIGHT.AgencyID,
																		 RollAgencyLvl(LEFT,RIGHT));
											 
// Agency Level Accident Count
	SHARED eCrash_Analytics.Layouts.Layout_Response ACAgencyLvl({dsAgencyLvlRolled} L):= TRANSFORM
	  SELF.AgencyID			:= L.AgencyID;
		SELF.AccidentCnt	:= L.AccidentCnt;
		SELF := [];
	END;
	
	EXPORT RPT1ACAgencyLvl := PROJECT(dsAgencyLvlRolled, ACAgencyLvl(LEFT));   //returns only 1 record
	
// Agency Level Injury Count Report
	SHARED eCrash_Analytics.Layouts.Layout_Response ICAgencyLvl({dsAgencyLvlRolled} L):= TRANSFORM
		SELF.AgencyID			:= L.AgencyID;
		SELF.InjuryCnt		:= L.InjuryCnt + L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT2ICAgencyLvl := PROJECT(dsAgencyLvlRolled, ICAgencyLvl(LEFT));

// Agency Level Fatal Count Report
	SHARED eCrash_Analytics.Layouts.Layout_Response FCAgencyLvl({dsAgencyLvlRolled} L):= TRANSFORM
		SELF.AgencyID			:= L.AgencyID;
		SELF.FatalCnt			:= L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT3FCAgencyLvl := PROJECT(dsAgencyLvlRolled, FCAgencyLvl(LEFT));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
											 
// Report At Agency/Precinct Level	
	SHARED Layout_ByAgencyByPrecinct := RECORD
	  dsByAgency.AgencyID;
		dsByAgency.Precinct;
		INTEGER Accidentcnt := SUM(GROUP, dsByAgency.Accidentcnt);
		INTEGER InjuryCnt		:= SUM(GROUP, dsByAgency.InjuryCnt);
		INTEGER FatalCnt		:= SUM(GROUP, dsByAgency.FatalCnt);
	END;
	
	SHARED AgencyPrecinctTbl := TABLE(dsByAgency(Precinct > ''), Layout_ByAgencyByPrecinct, AgencyID, Precinct);

// Agency/Precinct Level Accident Count Report	
	SHARED eCrash_Analytics.Layouts.Layout_Response ACAgencyPrecinctLvl({AgencyPrecinctTbl} L):= TRANSFORM
		SELF.AgencyID		  := L.AgencyID;
		SELF.Command			:= L.Precinct;
		SELF.ACCIDENTCNT	:= L.Accidentcnt;
		SELF := [];
	END;
	
	EXPORT RPT1ACPrecinctLvl := SORT(PROJECT(AgencyPrecinctTbl, ACAgencyPrecinctLvl(LEFT)),Command);

// Agency/Precinct Level Injury Count Report	
	SHARED eCrash_Analytics.Layouts.Layout_Response ICAgencyPrecinctLvl({AgencyPrecinctTbl} L):=TRANSFORM
		SELF.AgencyID		  := L.AgencyID;
		SELF.Command			:= L.Precinct;
		SELF.INJURYCNT		:= L.Injurycnt + L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT2ICPrecinctLvl := SORT(PROJECT(AgencyPrecinctTbl, ICAgencyPrecinctLvl(LEFT)),Command);

// Agency/Precinct Level Fatal Count Report
	SHARED eCrash_Analytics.Layouts.Layout_Response FCAgencyPrecinctLvl({AgencyPrecinctTbl} L):=TRANSFORM
		SELF.AgencyID		  := L.AgencyID;
		SELF.Command			:= L.Precinct;
		SELF.FatalCnt		  := L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT3FCPrecinctLvl := SORT(PROJECT(AgencyPrecinctTbl, FCAgencyPrecinctLvl(LEFT)),Command);

// Report At Agency/Beat Level	
	SHARED Layout_ByAgencyByBeat := RECORD
	  dsByAgency.AgencyID;
		dsByAgency.Beat;
		INTEGER Accidentcnt := SUM(GROUP, dsByAgency.Accidentcnt);
		INTEGER InjuryCnt		:= SUM(GROUP, dsByAgency.InjuryCnt);
		INTEGER FatalCnt		:= SUM(GROUP, dsByAgency.FatalCnt);
	END;
	
	SHARED AgencyBeatTbl := TABLE(dsByAgency(Beat > ''), Layout_ByAgencyByBeat, AgencyID, Beat);

// Agency/Precinct Level Accident Count Report	
	SHARED eCrash_Analytics.Layouts.Layout_Response ACAgencyBeatLvl({AgencyBeatTbl} L):= TRANSFORM
		SELF.AgencyID		  := L.AgencyID;
		SELF.Command			:= L.Beat;
		SELF.ACCIDENTCNT	:= L.Accidentcnt;
		SELF := [];
	END;
	
	EXPORT RPT1ACBeatLvl := SORT(PROJECT(AgencyBeatTbl, ACAgencyBeatLvl(LEFT)),Command);

// Agency/Beat Level Injury Count Report	
	SHARED eCrash_Analytics.Layouts.Layout_Response ICAgencyBeatLvl({AgencyBeatTbl} L):=TRANSFORM
		SELF.AgencyID		  := L.AgencyID;
		SELF.Command			:= L.Beat;
		SELF.INJURYCNT		:= L.Injurycnt + L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT2ICBeatLvl := SORT(PROJECT(AgencyBeatTbl, ICAgencyBeatLvl(LEFT)),Command);

// Agency/Precinct Level Fatal Count Report
	SHARED eCrash_Analytics.Layouts.Layout_Response FCAgencyBeatLvl({AgencyBeatTbl} L):=TRANSFORM
		SELF.AgencyID		  := L.AgencyID;
		SELF.Command			:= L.Beat;
		SELF.FatalCnt		  := L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT3FCBeatLvl := SORT(PROJECT(AgencyBeatTbl, FCAgencyBeatLvl(LEFT)),Command);
	
// Report of Accidents By Day Of Week
	SHARED Layout_ByDOW := RECORD
	  dsByDOW.AgencyID;
		dsByDOW.DayOfWeek;
		INTEGER Accidentcnt := SUM(GROUP, dsByDOW.Accidentcnt);
		INTEGER InjuryCnt		:= SUM(GROUP, dsByDOW.InjuryCnt);
		INTEGER FatalCnt		:= SUM(GROUP, dsByDOW.FatalCnt);
	END;
	
	SHARED DOWTbl := TABLE(dsByDOW, Layout_ByDOW, AgencyID, DayOfWeek);

// Agency/Precinct Level Accident Count Report	
	SHARED eCrash_Analytics.Layouts.Layout_Response ACDOWLvl({DOWTbl} L):= TRANSFORM
		SELF.AgencyID		  := L.AgencyID;
		SELF.DayOfWeek		:= L.DayOfWeek; 
		SELF.ACCIDENTCNT	:= L.Accidentcnt;
		SELF := [];
	END;
	
	EXPORT RPT4ACDOW := SORT(PROJECT(DOWTbl, ACDOWLvl(LEFT)),Command);

// Agency/Precinct Level Injury Count Report	
	SHARED eCrash_Analytics.Layouts.Layout_Response ICDOWLvl({DOWTbl} L):=TRANSFORM
		SELF.AgencyID		  := L.AgencyID;
		SELF.DayOfWeek		:= L.DayOfWeek;
		SELF.INJURYCNT		:= L.Injurycnt + L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT5ICDOW := SORT(PROJECT(DOWTbl, ICDOWLvl(LEFT)),Command);

// Agency/Precinct Level Fatal Count Report
	SHARED eCrash_Analytics.Layouts.Layout_Response FCDOWLvl({DOWTbl} L):=TRANSFORM
		SELF.AgencyID		  := L.AgencyID;
		SELF.DayOfWeek		:= L.DayOfWeek; 
		SELF.FatalCnt		  := L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT6FCDOW := SORT(PROJECT(DOWTbl, FCDOWLvl(LEFT)),Command);

// Report Accident Counts by Hour of Day	
	SHARED Layout_ByHOD := RECORD
	  dsByHOD.AgencyID;
		dsByHOD.HourOfDay;
		INTEGER Accidentcnt := SUM(GROUP, dsByHOD.Accidentcnt);
		INTEGER InjuryCnt		:= SUM(GROUP, dsByHOD.InjuryCnt);
		INTEGER FatalCnt		:= SUM(GROUP, dsByHOD.FatalCnt);
	END;
	
	SHARED HODTbl := TABLE(dsByHOD, Layout_ByHOD, AgencyID, HourOfDay);
	
	SHARED eCrash_Analytics.Layouts.Layout_Response ACHODLvl({HODTbl} L):= TRANSFORM
		SELF.AgencyID		   	:= L.AgencyID;
		SELF.HourOfDay 			:= (INTEGER) L.HourOfDay;
		SELF.ACCIDENTCNT	 	:= L.Accidentcnt;
		SELF := [];
	END;
	
	EXPORT RPT7ACHOD := SORT(PROJECT(HODTbl, ACHODLvl(LEFT)),HourOfDay);

// Report of Injury Counts by Hour Of Day	
	SHARED eCrash_Analytics.Layouts.Layout_Response ICHODLvl({HODTbl} L):=TRANSFORM
		SELF.AgencyID		  	:= L.AgencyID;
		SELF.HourOfDay 			:= (INTEGER) L.HourOfDay;
		SELF.INJURYCNT			:= L.Injurycnt + L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT8ICHOD := SORT(PROJECT(HODTbl, ICHODLvl(LEFT)),HourOfDay);

// Report of Fatal Counts by Hour of Day
	SHARED eCrash_Analytics.Layouts.Layout_Response FCHODLvl({HODTbl} L):=TRANSFORM
		SELF.AgencyID		  	:= L.AgencyID;
		SELF.HourOfDay 			:= (INTEGER) L.HourOfDay;
		SELF.FatalCnt		  	:= L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT9FCHOD := SORT(PROJECT(HODTbl, FCHODLvl(LEFT)),HourOfDay);

// Report Accident Counts by Month of Year	
	SHARED Layout_ByMOY := RECORD
	  dsByMOY.AgencyID;
		dsByMOY.MonthOfYear;
		INTEGER Accidentcnt := SUM(GROUP, dsByMOY.Accidentcnt);
		INTEGER InjuryCnt		:= SUM(GROUP, dsByMOY.InjuryCnt);
		INTEGER FatalCnt		:= SUM(GROUP, dsByMOY.FatalCnt);
	END;
	
	SHARED MOYTbl := TABLE(dsByMOY, Layout_ByMOY, AgencyID, MonthOfYear);
	
	SHARED eCrash_Analytics.Layouts.Layout_Response ACMOYLvl({MOYTbl} L):= TRANSFORM
		SELF.AgencyID		   	:= L.AgencyID;
		SELF.MonthOfYear 		:= (INTEGER) L.MonthOfYear;
		SELF.ACCIDENTCNT	 	:= L.Accidentcnt;
		SELF := [];
	END;
	
	EXPORT RPT10ACMOY := SORT(PROJECT(MOYTbl, ACMOYLvl(LEFT)),MonthOfYear);

// Report Injury Counts by Month of Year	
	SHARED eCrash_Analytics.Layouts.Layout_Response ICMOYLvl({MOYTbl} L):=TRANSFORM
		SELF.AgencyID		  	:= L.AgencyID;
		SELF.MonthOfYear 		:= (INTEGER) L.MonthOfYear;
		SELF.INJURYCNT			:= L.Injurycnt + L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT11ICMOY := SORT(PROJECT(MOYTbl, ICMOYLvl(LEFT)),MonthOfYear);

// Report Fatal Counts by Month of Year
	SHARED eCrash_Analytics.Layouts.Layout_Response FCMOYLvl({MOYTbl} L):=TRANSFORM
		SELF.AgencyID		  	:= L.AgencyID;
		SELF.MonthOfYear 		:= (INTEGER) L.MonthOfYear;
		SELF.FatalCnt		  	:= L.FatalCnt;
		SELF := [];
	END;
	
	EXPORT RPT12FCMOY := SORT(PROJECT(MOYTbl, FCMOYLvl(LEFT)),MonthOfYear);
	
	// Report Accident Counts by Collision Type	
	SHARED Layout_ByCT := RECORD
	  dsByCT.AgencyID;
		INTEGER Accidentcnt 					:= SUM(GROUP, dsByCT.Accidentcnt);
	  INTEGER CTFrontRear						:= SUM(GROUP, dsByCT.CTFrontRear);
		INTEGER CTFrontFront					:= SUM(GROUP, dsByCT.CTFrontFront);			
		INTEGER CTAngle						  	:= SUM(GROUP, dsByCT.CTAngle);					
		INTEGER CTSideSwipeSame		  	:= SUM(GROUP, dsByCT.CTSideSwipeSame);		
		INTEGER CTSideSwipeOpposite  	:= SUM(GROUP, dsByCT.CTSideSwipeOpposite);
		INTEGER CTRearSide					  := SUM(GROUP, dsByCT.CTRearSide);					
		INTEGER CTRearRear					  := SUM(GROUP, dsByCT.CTRearRear);					
		INTEGER CTOther						  	:= SUM(GROUP, dsByCT.CTOther);						
		INTEGER CTUnknown					  	:= SUM(GROUP, dsByCT.CTUnknown);					
	END;
	
	SHARED CTTbl := TABLE(dsByCT, Layout_ByCT, AgencyID);
	
		// Report accident counts by collision type
	SHARED eCrash_Analytics.Layouts.Layout_Response CTLvl({CTTbl} L):=TRANSFORM
		SELF.AgencyID		  						:= L.AgencyID;
    SELF.AccidentCnt							:= L.AccidentCnt;    
		SELF.CT_FRONTREAR							:= L.CTFrontRear;              
		SELF.CT_FRONTFRONT						:= L.CTFrontFront;
		SELF.CT_ANGLE									:= L.CTAngle;
		SELF.CT_SIDESWIPESAME					:= L.CTSideSwipeSame;
		SELF.CT_SIDESWIPEOPPOSITE			:= L.CTSideSwipeOpposite;
		SELF.CT_REARSIDE							:= L.CTRearSide;
		SELF.CT_REARREAR							:= L.CTRearRear;
		SELF.CT_OTHER									:= L.CTOther;
		SELF.CT_UNKNOWN								:= L.CTUnknown;
		SELF := [];
	END;
	
	EXPORT RPT13ACCollisionType := SORT(PROJECT(CTTbl, CTLvl(LEFT)),AccidentCnt);

	// Report Accident Counts by Severity Type	by Intersection
	SHARED Layout_BySeverityByInter := RECORD
	  dsByInter.AgencyID;
		dsByInter.Intersection;
		INTEGER Accidentcnt 	:= SUM(GROUP,dsByInter.Accidentcnt);
		INTEGER FatalCnt			:= SUM(GROUP,dsByInter.FatalCnt);       
	  INTEGER InjuryCnt			:= SUM(GROUP,dsByInter.InjuryCnt);       
	  INTEGER PropDmgCnt		:= SUM(GROUP,dsByInter.PropDmgCnt);  
  END;	
	
	SHARED SeverityByInterTbl := TABLE(dsByInter, Layout_BySeverityByInter, AgencyID, Intersection);
	
	// Report accident counts by severity by inter
	SHARED eCrash_Analytics.Layouts.Layout_Response SeverityByInterLvl({SeverityByInterTbl} L):=TRANSFORM
		SELF.AgencyID		  						:= L.AgencyID;
		SELF.Intersection							:= L.Intersection;
		SELF.AccidentCnt							:= L.AccidentCnt;    
	  SELF.FatalCnt                 := L.FatalCnt;
	  SELF.InjuryCnt								:= L.InjuryCnt;
	  SELF.PropDmgCnt               := L.PropDmgCnt;
		SELF := [];
	END;
	
	EXPORT RPT14ACBySeverityByInter := SORT(PROJECT(SeverityByInterTbl, SeverityByInterLvl(LEFT)),Intersection);

	// Report Accident Counts by Accident Type	by Intersection
	SHARED Layout_ByATByInter := RECORD
	  dsByInter.AgencyID;
		dsByInter.Intersection;
		INTEGER Accidentcnt 	:= SUM(GROUP, dsByInter.Accidentcnt);
		INTEGER ATVehicle			:= SUM(GROUP, dsByInter.ATVehicle);
		INTEGER ATPedestrian 	:= SUM(GROUP, dsByInter.ATPedestrian);
		INTEGER ATBicycle			:= SUM(GROUP, dsByInter.ATBicycle);
		INTEGER ATMotorcycle	:= SUM(GROUP, dsByInter.ATMotorcycle);			
		INTEGER ATAnimal			:= SUM(GROUP, dsByInter.ATAnimal);					
		INTEGER ATTrain		  	:= SUM(GROUP, dsByInter.ATTrain);		
		INTEGER ATUnknown  		:= SUM(GROUP, dsByInter.ATUnknown);
  END;	
	
	SHARED ATByInterTbl := TABLE(dsByInter, Layout_ByATByInter, AgencyID, Intersection);
	
	// Report accident counts by accident type by inter
	SHARED eCrash_Analytics.Layouts.Layout_Response ATByInterLvl({ATByInterTbl} L):=TRANSFORM
		SELF.AgencyID		  	:= L.AgencyID;
		SELF.Intersection		:= L.Intersection;
		SELF.AccidentCnt		:= L.AccidentCnt;    
	  SELF.AT_Vehicle			:= L.ATVehicle;
	  SELF.AT_Pedestrian	:= L.ATPedestrian;
	  SELF.AT_Bicycle     := L.ATBicycle;
	  SELF.AT_Motorcycle  := L.ATMotorcycle;
		SELF.AT_Animal			:= L.ATAnimal;
		SELF.AT_Train				:= L.ATTrain;
		SELF.AT_Unknown			:= L.ATUnknown;
		SELF := [];
	END;
	
	EXPORT RPT15ACByATByInter := SORT(PROJECT(ATByInterTbl, ATByInterLvl(LEFT)),Intersection);

	// Report Accident Counts by Tour	by Intersection
	SHARED Layout_ByTourByInter := RECORD
	  dsByInter.AgencyID;
		dsByInter.Intersection;
		dsByInter.Tour;
		INTEGER Accidentcnt 	:= SUM(GROUP,dsByInter.Accidentcnt);
  END;	
	
	SHARED TourByInterTbl := TABLE(dsByInter, Layout_ByTourByInter, AgencyID, Intersection, Tour);
	
// first, put the accident count in the proper tour catagory.
  SHARED Layouts.Layout_ByTours tours({TourByInterTbl} L):= TRANSFORM
    SELF.AgencyID 		:= L.AgencyID;
		SELF.Intersection := L.Intersection;
		SELF.Accidentcnt	:= L.Accidentcnt;
		SELF.TOUR1				:= IF(L.TOUR = 1, L.AccidentCnt,0);
		SELF.TOUR2				:= IF(L.TOUR = 2, L.AccidentCnt,0);
		SELF.TOUR3				:= IF(L.TOUR = 3, L.AccidentCnt,0);
		SELF.TOURUnk			:= IF(L.TOUR = 4, L.AccidentCnt,0);
	END;
	
	SHARED dsTours := PROJECT(TourByInterTbl, tours(LEFT));

//rollup by intersection adding up all the accident counts for the tour.	
  SHARED {dsTours} RollTourInter({dsTours} L, {dsTours} R):=TRANSFORM
		SELF.agencyID 		 							:= L.agencyID;
		SELF.Intersection 							:= L.Intersection;
		SELF.Accidentcnt								:= L.Accidentcnt + R.Accidentcnt;
		SELF.TOUR1											:= L.TOUR1 + R.TOUR1;
		SELF.TOUR2											:= L.TOUR2 + R.TOUR2;
		SELF.TOUR3											:= L.TOUR3 + R.TOUR3;
		SELF.TOURUnk										:= L.TOURUnk + R.TOURUnk;
	END;
	
	SHARED dsToursRolled := ROLLUP(dsTours,
																 LEFT.intersection = RIGHT.intersection,
																 RollTourInter(LEFT,RIGHT)); 

	// Put in interim layout
	SHARED eCrash_Analytics.Layouts.Layout_Response TourByInterLvl({dsToursRolled} L):=TRANSFORM
		SELF.AgencyID		  	:= L.AgencyID;
		SELF.Intersection		:= L.Intersection;
		SELF.Accidentcnt		:= L.Accidentcnt;
		SELF.TOUR1					:= L.TOUR1;
		SELF.TOUR2					:= L.TOUR2;
		SELF.TOUR3					:= L.TOUR3;
		SELF.TOURUnk				:= L.TOURUnk;
		SELF := [];
	END;
	
	EXPORT RPT16ACByTourByInter := SORT(PROJECT(dsToursRolled, TourByInterLvl(LEFT)),Intersection);

	// Report Accident Counts by Collision Type	by Intersection
	SHARED Layout_ByCTByInter := RECORD
	  dsByInter.AgencyID;
		dsByInter.Intersection;
		INTEGER Accidentcnt 					:= SUM(GROUP, dsByInter.Accidentcnt);
	  INTEGER CTFrontRear						:= SUM(GROUP, dsByInter.CTFrontRear);
		INTEGER CTFrontFront					:= SUM(GROUP, dsByInter.CTFrontFront);			
		INTEGER CTAngle						  	:= SUM(GROUP, dsByInter.CTAngle);					
		INTEGER CTSideSwipeSame		  	:= SUM(GROUP, dsByInter.CTSideSwipeSame);		
		INTEGER CTSideSwipeOpposite  	:= SUM(GROUP, dsByInter.CTSideSwipeOpposite);
		INTEGER CTRearSide					  := SUM(GROUP, dsByInter.CTRearSide);					
		INTEGER CTRearRear					  := SUM(GROUP, dsByInter.CTRearRear);					
		INTEGER CTOther						  	:= SUM(GROUP, dsByInter.CTOther);						
		INTEGER CTUnknown					  	:= SUM(GROUP, dsByInter.CTUnknown);					
	END;
	
	SHARED CTByInterTbl := TABLE(dsByInter, Layout_ByCTByInter, AgencyID, Intersection);
	
	// Report Fatal Counts by Month of Year
	SHARED eCrash_Analytics.Layouts.Layout_Response CTByInterLvl({CTByInterTbl} L):=TRANSFORM
		SELF.AgencyID		  						:= L.AgencyID;
		SELF.Intersection							:= L.Intersection;
    SELF.AccidentCnt							:= L.AccidentCnt;    
		SELF.CT_FRONTREAR							:= L.CTFrontRear;              
		SELF.CT_FRONTFRONT						:= L.CTFrontFront;
		SELF.CT_ANGLE									:= L.CTAngle;
		SELF.CT_SIDESWIPESAME					:= L.CTSideSwipeSame;
		SELF.CT_SIDESWIPEOPPOSITE			:= L.CTSideSwipeOpposite;
		SELF.CT_REARSIDE							:= L.CTRearSide;
		SELF.CT_REARREAR							:= L.CTRearRear;
		SELF.CT_OTHER									:= L.CTOther;
		SELF.CT_UNKNOWN								:= L.CTUnknown;
		SELF := [];
	END;
	
	EXPORT RPT17ACByCTByInter := SORT(PROJECT(CTByInterTbl, CTByInterLvl(LEFT)),Intersection);

	// Report Accident Counts by Day Of Week	by Intersection
	SHARED Layout_ByDOWByInter := RECORD
	  dsByInter.AgencyID;
		dsByInter.Intersection;
		dsByInter.DayOfWeek;
		INTEGER Accidentcnt 	:= SUM(GROUP,dsByInter.Accidentcnt);
  END;	
	
	SHARED DOWByInterTbl := TABLE(dsByInter, Layout_ByDOWByInter, AgencyID, Intersection, DayOfWeek);
	
// first, put the accident count in the proper DayOfWeek catagory.
  SHARED eCrash_Analytics.Layouts.Layout_ByDOWDays DOW({DOWByInterTbl} L):= TRANSFORM
    SELF.AgencyID 		:= L.AgencyID;
		SELF.Intersection := L.Intersection;
		SELF.Accidentcnt	:= L.Accidentcnt;
		SELF.MONDAY				:= IF(L.DayOfWeek = 1, L.AccidentCnt,0);
		SELF.TUESDAY			:= IF(L.DayOfWeek = 2, L.AccidentCnt,0);
		SELF.WEDNESDAY		:= IF(L.DayOfWeek = 3, L.AccidentCnt,0);
		SELF.THURSDAY			:= IF(L.DayOfWeek = 4, L.AccidentCnt,0);
		SELF.FRIDAY				:= IF(L.DayOfWeek = 5, L.AccidentCnt,0);
		SELF.SATURDAY			:= IF(L.DayOfWeek = 6, L.AccidentCnt,0);
		SELF.SUNDAY				:= IF(L.DayOfWeek = 7, L.AccidentCnt,0);
		SELF.DOWUnk				:= IF(L.DayOfWeek = 8, L.AccidentCnt,0);
	END;
	
	SHARED dsDOW := PROJECT(DOWByInterTbl, DOW(LEFT));

	//rollup by intersection adding up all the accident counts for the DayOfWeek.	
	SHARED {dsDOW} RollDOWInter({dsDOW} L, {dsDOW} R):=TRANSFORM
		SELF.agencyID 		:= L.agencyID;
		SELF.Intersection := L.Intersection;
		SELF.AccidentCnt	:= L.Accidentcnt + R.Accidentcnt;
		SELF.MONDAY				:= L.MONDAY + R.MONDAY;
		SELF.TUESDAY			:= L.TUESDAY + R.TUESDAY;
		SELF.WEDNESDAY		:= L.WEDNESDAY + R.WEDNESDAY;
		SELF.THURSDAY			:= L.THURSDAY + R.THURSDAY;
		SELF.FRIDAY				:= L.FRIDAY + R.FRIDAY;
		SELF.SATURDAY			:= L.SATURDAY + R.SATURDAY;
		SELF.SUNDAY				:= L.SUNDAY + R.SUNDAY;
		SELF.DOWUnk				:= L.DOWUnk + R.DOWUnk;
	END;
	
	SHARED dsDOWRolled := ROLLUP(dsDOW,
															LEFT.intersection = RIGHT.intersection,
															RollDOWInter(LEFT,RIGHT)); 

	// Report accident counts by DayOfWeek by inter
	SHARED eCrash_Analytics.Layouts.Layout_Response DOWByInterLvl({dsDOWRolled} L):=TRANSFORM
		SELF.AgencyID		  	:= L.AgencyID;
		SELF.Intersection		:= L.Intersection;
		SELF.Accidentcnt		:= L.AccidentCnt;
		SELF.MONDAY					:= L.MONDAY;
		SELF.TUESDAY				:= L.TUESDAY;
		SELF.WEDNESDAY			:= L.WEDNESDAY;
		SELF.THURSDAY				:= L.THURSDAY;
		SELF.FRIDAY					:= L.FRIDAY;
		SELF.SATURDAY				:= L.SATURDAY;
		SELF.SUNDAY					:= L.SUNDAY;
		SELF.DOWUnk					:= L.DOWUnk;
		SELF := [];
	END;
	
	EXPORT RPT18ACByDOWByInter := SORT(PROJECT(dsDOWRolled, DOWByInterLvl(LEFT)),Intersection);
	
END;