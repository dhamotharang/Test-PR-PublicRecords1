IMPORT eCrash_Analytics, lib_stringlib, STD, ut;
EXPORT Functions := MODULE
 
	EXPORT SortData(DATASET(eCrash_Analytics.Layouts.Layout_Response) InData, STRING SortParm, STRING2 RptNbr) := FUNCTION
	
	  DefaultSort	 := MAP(RptNbr BETWEEN '1' AND '3'   => SORT(Indata,COMMAND),
		                    RptNbr BETWEEN '4' AND '6'   => SORT(Indata,DAYOFWEEK),
												RptNbr BETWEEN '7' AND '9'   => SORT(Indata,HOUROFDAY),
												RptNbr BETWEEN '10' AND '12' => SORT(Indata,MONTHOFYEAR),
												RptNbr = '13'							   => SORT(Indata,-ACCIDENTCNT),
												RptNbr BETWEEN '14' AND '18' => SORT(Indata,-ACCIDENTCNT,INTERSECTION),
												Indata);
												
		SpecificSort := CASE(TRIM(stringlib.StringToUpperCase(SortParm),LEFT,RIGHT),
													eCrash_Analytics.Constants.SrtAscCommand 											=> SORT(InData,COMMAND),
													eCrash_Analytics.Constants.SrtDscCommand 											=> SORT(InData,-COMMAND),
													eCrash_Analytics.Constants.SrtAscAccidentCntAscInter 				  => SORT(InData,ACCIDENTCNT,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscAccidentCntAscInter					=> SORT(InData,-ACCIDENTCNT,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscFatalCntAscInter  				    => SORT(InData,FATALCNT,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscFatalCntAscInter  				    => SORT(InData,-FATALCNT,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscInjuryCntAscInter						=> SORT(InData,INJURYCNT,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscInjuryCntAscInter						=> SORT(InData,-INJURYCNT,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscPropDmgCntAscInter  					=> SORT(InData,PROPDMGCNT,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscPropDmgCntAscInter  					=> SORT(InData,-PROPDMGCNT,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscVehicleAscInter 							=> SORT(InData,AT_VEHICLE,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscVehicleAscInter 							=> SORT(InData,-AT_VEHICLE,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscPedAscInter									=> SORT(InData,AT_PEDESTRIAN,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscPedAscInter									=> SORT(InData,-AT_PEDESTRIAN,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscBicycleAscInter							=> SORT(InData,AT_BICYCLE,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscBicycleAscInter							=> SORT(InData,-AT_BICYCLE,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscMotorAscInter 								=> SORT(InData,AT_MOTORCYCLE,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscMotorAscInter 								=> SORT(InData,-AT_MOTORCYCLE,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscAnimalAscInter 							=> SORT(InData,AT_ANIMAL,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscAnimalAscInter								=> SORT(InData,-AT_ANIMAL,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscTrainAscInter 							  => SORT(InData,AT_TRAIN,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscTrainAscInter 								=> SORT(InData,-AT_TRAIN,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscTour11AscInter								=> SORT(InData,TOUR1,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscTour1AscInter								=> SORT(InData,-TOUR1,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscTour2AscInter								=> SORT(InData,TOUR2,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscTour2AscInter								=> SORT(InData,-TOUR2,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscTour3AscInter								=> SORT(InData,TOUR3,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscTour3AscInter								=> SORT(InData,-TOUR3,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscFrontRearAscInter 						=> SORT(InData,CT_FRONTREAR,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscFrontRearAscInter						=> SORT(InData,-CT_FRONTREAR,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscFrontFrontAscInter						=> SORT(InData,CT_FRONTFRONT,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscFrontFrontAscInter						=> SORT(InData,-CT_FRONTFRONT,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscAngleAscInter								=> SORT(InData,CT_ANGLE,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscAngleAscInter								=> SORT(InData,-CT_ANGLE,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscSideSwipeSameAscInter				=> SORT(InData,CT_SIDESWIPESAME,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscSideSwipeSameAscInter 				=> SORT(InData,-CT_SIDESWIPESAME,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscSideSwipeOppositeAscInter 		=> SORT(InData,CT_SIDESWIPEOPPOSITE,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscSideSwipeOppositeAscInter 		=> SORT(InData,-CT_SIDESWIPEOPPOSITE,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscRearsideAscInter							=> SORT(InData,CT_REARSIDE,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscRearsideAscInter							=> SORT(InData,-CT_REARSIDE,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscRearRearAscInter							=> SORT(InData,CT_REARREAR,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscRearRearAscInter							=> SORT(InData,-CT_REARREAR,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscOtherAscInter								=> SORT(InData,CT_OTHER,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscOtherAscInter								=> SORT(InData,-CT_OTHER,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscUnknownAscInter							=> SORT(InData,CT_UNKNOWN,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscUnknownAscInter							=> SORT(InData,-CT_UNKNOWN,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscMondayAscInter								=> SORT(InData,MONDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscMondayAscInter								=> SORT(InData,-MONDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscTuesdayAscInter							=> SORT(InData,TUESDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscTuesdayAscInter							=> SORT(InData,-TUESDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscWednesdayAscInter						=> SORT(InData,WEDNESDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscWednesdayAscInter						=> SORT(InData,-WEDNESDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscThursdayAscInter							=> SORT(InData,THURSDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscThursdayAscInter							=> SORT(InData,-THURSDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscFridayAscInter								=> SORT(InData,FRIDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscFridayAscInter								=> SORT(InData,-FRIDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscSaturdayAscInter							=> SORT(InData,SATURDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscSaturdayAscInter							=> SORT(InData,-SATURDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtAscSundayAscInter								=> SORT(InData,SUNDAY,INTERSECTION),
													eCrash_Analytics.Constants.SrtDscSundayAscInter								=> SORT(InData,-SUNDAY,INTERSECTION),
																																													 Indata);
			
			SortedDataSet := IF(SortParm = '', DefaultSort, SpecificSort);
			
			RETURN SortedDataSet;
		END;

// we will add a record counter after the search is all done so when we need to page, we can do it with a counter.		
   	EXPORT AddCounter(DATASET(eCrash_Analytics.Layouts.Layout_Response) InData) := FUNCTION
         {inData} AddCntr({InData} L, INTEGER Cntr) := TRANSFORM
            SELF.RecCntr := Cntr;            
						SELF:=L;
				 END;
				 dsWithCntr := PROJECT(InData, AddCntr(LEFT, COUNTER));
         RETURN dsWithCntr;
		END;

		EXPORT InsertEmpties(STRING inRptNbr, DATASET(eCrash_Analytics.Layouts.Layout_Response) dsReport) := FUNCTION
				dsBackFilledDOW := SORT(JOIN(dsReport, Constants.File_DOW,
																		LEFT.DayOfWeek = RIGHT.DayOfWeek,
																		TRANSFORM({dsReport}, SELF.DayOfWeek:=RIGHT.DayOfWeek, SELF.DayName:=RIGHT.DayName,SELF:=LEFT, SELF:=[]), FULL OUTER), DayOfWeek);
				dsBackFilledHOD := SORT(JOIN(dsReport, Constants.File_HOD,
				 														LEFT.HourOfDay = RIGHT.HourOfDay,
																		TRANSFORM({dsReport}, SELF.HourOfDay:=RIGHT.HourOfDay, SELF:=LEFT, SELF := []), FULL OUTER), HourOfDay);
				dsBackFilledMOY := SORT(JOIN(dsReport, Constants.File_MOY,
																		LEFT.MonthOfYear = RIGHT.MonthOfYear,
																		TRANSFORM({dsReport}, SELF.MonthOfYear:=RIGHT.MonthOfYear,SELF:=LEFT, SELF := []), FULL OUTER), MonthOfYear);
				dsBackfilled := MAP(InRptNbr IN ['4','5','6'] 	  => dsBackFilledDOW,
														InRptNbr IN ['7','8','9'] 		=> dsBackFilledHOD,
														InRptNbr IN ['10','11','12'] 	=> dsBackFilledMOY,
														dsReport);
				RETURN dsBackFilled;
		END;	
		
		EXPORT ComputeGrandTotals(DATASET(eCrash_Analytics.Layouts.Layout_Response) InData) := FUNCTION
		
		    {InData} RollAgencyLvl({Indata} L, {Indata} R):=TRANSFORM
				    	SELF.AccidentCnt 					:= L.AccidentCnt + R.AccidentCnt;    
							SELF.FatalCnt							:= L.FatalCnt + R.FatalCnt;
							SELF.InjuryCnt						:= L.InjuryCnt + R.InjuryCnt;     
							SELF.PropDmgCnt						:= L.PropDmgCnt + R.PropDmgCnt;
							SELF.TOUR1								:= L.TOUR1 + R.TOUR1; 
							SELF.TOUR2								:= L.TOUR2 + R.TOUR2;
							SELF.TOUR3								:= L.TOUR3 + R.TOUR3;
							SELF.TOURUnk      				:= L.TOURUnk + R.TOURUnk;
							SELF.MONDAY								:= L.MONDAY + R.MONDAY;          
							SELF.TUESDAY							:= L.TUESDAY + R.TUESDAY;
							SELF.WEDNESDAY						:= L.WEDNESDAY + R.WEDNESDAY;
							SELF.THURSDAY							:= L.THURSDAY + R.THURSDAY;
							SELF.FRIDAY								:= L.FRIDAY + R.FRIDAY;
							SELF.SATURDAY							:= L.SATURDAY + R.SATURDAY;
							SELF.SUNDAY								:= L.SUNDAY	+ R.SUNDAY;
							SELF.DOWUnk								:= L.DOWUnk + R.DOWUnk;
							SELF.CT_FRONTREAR					:= L.CT_FRONTREAR + R.CT_FRONTREAR;              
							SELF.CT_FRONTFRONT				:= L.CT_FRONTFRONT + R.CT_FRONTFRONT;
							SELF.CT_ANGLE							:= L.CT_ANGLE + R.CT_ANGLE;
							SELF.CT_SIDESWIPESAME			:= L.CT_SIDESWIPESAME + R.CT_SIDESWIPESAME;
							SELF.CT_SIDESWIPEOPPOSITE	:= L.CT_SIDESWIPEOPPOSITE + R.CT_SIDESWIPEOPPOSITE;
							SELF.CT_REARSIDE					:= L.CT_REARSIDE + R.CT_REARSIDE;
							SELF.CT_REARREAR					:= L.CT_REARREAR + R.CT_REARREAR;
							SELF.CT_OTHER							:= L.CT_OTHER + R.CT_OTHER;
							SELF.CT_UNKNOWN						:= L.CT_UNKNOWN + R.CT_UNKNOWN;
							SELF.AT_VEHICLE						:= L.AT_VEHICLE + R.AT_VEHICLE;            
							SELF.AT_PEDESTRIAN				:= L.AT_PEDESTRIAN + R.AT_PEDESTRIAN;
							SELF.AT_BICYCLE						:= L.AT_BICYCLE + R.AT_BICYCLE;
							SELF.AT_MOTORCYCLE				:= L.AT_MOTORCYCLE + R.AT_MOTORCYCLE;
							SELF.AT_ANIMAL						:= L.AT_ANIMAL + R.AT_ANIMAL;
							SELF.AT_TRAIN							:= L.AT_TRAIN + R.AT_TRAIN;
							SELF.AT_UNKNOWN						:= L.AT_UNKNOWN + R.AT_UNKNOWN;
							SELF := L;
						  SELF := [];
				END;
	
				GrandTotals := ROLLUP(Indata,RollAgencyLvl(LEFT,RIGHT),TRUE);

		    RETURN GrandTotals;
		END;
		
END;