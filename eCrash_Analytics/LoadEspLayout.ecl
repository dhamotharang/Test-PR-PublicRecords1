IMPORT iesp, eCrash_Analytics, lib_stringlib;

EXPORT LoadEspLayout(DATASET(eCrash_Analytics.Layouts.Layout_Response) ResultsIn, STRING RptNbr, STRING InAgencyID, INTEGER TotalResults, DATASET(eCrash_Analytics.Layouts.Layout_Response) GT) := MODULE
 
	SHARED iesp.adminanalytics.t_AnalyticsRecord xRecords({ResultsIn} L) := TRANSFORM
		SELF.Agency																:= IF(L.AgencyId = '', InAgencyID, L.AgencyID);
		SELF.Command															:= L.Command;
		SELF.TimePeriod.DayOfWeek								  := L.DayName;
		SELF.TimePeriod.HourOfDay									:= L.HourOfDay;
		SELF.TimePeriod.MonthOfYear               := L.MonthOfYear;
		SELF.Intersection													:= L.Intersection;
		SELF.AccidentCount												:= L.AccidentCnt;
		SELF.FatalCount														:= L.FatalCnt;
		SELF.InjuryCount													:= L.InjuryCnt;
		SELF.PropertyDamageCount 									:= L.PropDmgCnt;
		SELF.UnknownSeverity											:= 0;
    SELF.SeverityCount.Fatal									:= L.FatalCnt;
		SELF.SeverityCount.Injury									:= L.InjuryCnt;
		SELF.SeverityCount.PropertyDamage					:= L.PropDmgCnt;
		SELF.TourCount.First											:= L.Tour1;
		SELF.TourCount.Second											:= L.Tour2;
		SELF.TourCount.Third											:= L.Tour3;
		SELF.TourCount.Unknown										:= L.TourUnk;
		SELF.DayCount.Monday											:= L.Monday;
		SELF.DayCount.Tuesday											:= L.Tuesday;
		SELF.DayCount.Wednesday										:= L.Wednesday;
		SELF.DayCount.Thursday										:= L.Thursday;
		SELF.DayCount.Friday											:= L.Friday;
		SELF.DayCount.Saturday										:= L.Saturday;
		SELF.DayCount.Sunday											:= L.Sunday;
		SELF.DayCount.Unknown											:= L.DOWUnk;
		SELF.CollisionTypeCount.FrontRear 				:= L.CT_FrontRear;
		SELF.CollisionTypeCount.FrontFront 				:= L.CT_FrontFront;
		SELF.CollisionTypeCount.Angle 						:= L.CT_Angle;
		SELF.CollisionTypeCount.SideSwipeSame			:= L.CT_SideSwipeSame;
		SELF.CollisionTypeCount.SideSwipeOpposite	:= L.CT_SideSwipeOpposite;
		SELF.CollisionTypeCount.RearSide					:= L.CT_RearSide;
		SELF.CollisionTypeCount.RearRear					:= L.CT_RearRear;
		SELF.CollisionTypeCount.Other 						:= L.CT_Other;
		SELF.CollisionTypeCount.Unknown						:= L.CT_Unknown;
		SELF.AccidentTypeCount.Vehicle						:= L.AT_Vehicle;				
		SELF.AccidentTypeCount.Pedestrian					:= L.AT_Pedestrian;				
		SELF.AccidentTypeCount.Bicycle						:= L.AT_Bicycle;				
		SELF.AccidentTypeCount.Motorcycle					:= L.AT_Motorcycle;				
		SELF.AccidentTypeCount.Animal							:= L.AT_Animal;				
		SELF.AccidentTypeCount.Train							:= L.AT_Train;
		SELF.AccidentTypeCount.Unknown						:= L.AT_Unknown;
		SELF := L;
		SELF := [];	
	END;
	
	SHARED dsRptRecs := PROJECT(ResultsIn, xRecords(LEFT));
	
	EXPORT iesp.adminanalytics.t_AdminAnalyticsReportResponse LoadFinalLayout := TRANSFORM
		SELF.TotalCount 																						:= TotalResults;
		SELF.ReturnCount 																						:= 0;
		SELF.ReportNumber 																					:= RptNbr;
		SELF.TotalCounts.TotalAccidentCount 												:= GT[1].AccidentCnt;
		SELF.TotalCounts.TotalSeverityCount.Fatal 									:= GT[1].FatalCnt;
		SELF.TotalCounts.TotalSeverityCount.Injury 									:= GT[1].InjuryCnt;
		SELF.TotalCounts.TotalSeverityCount.PropertyDamage 					:= GT[1].PropDmgCnt;
		SELF.TotalCounts.TotalTourCount.First 											:= GT[1].TOUR1;
		SELF.TotalCounts.TotalTourCount.Second 											:= GT[1].TOUR2;
		SELF.TotalCounts.TotalTourCount.Third 											:= GT[1].TOUR3;
		SELF.TotalCounts.TotalTourCount.Unknown 										:= GT[1].TOURUnk;
		SELF.TotalCounts.TotalDayCount.Monday												:= GT[1].Monday;
		SELF.TotalCounts.TotalDayCount.Tuesday											:= GT[1].Tuesday;
		SELF.TotalCounts.TotalDayCount.Wednesday										:= GT[1].Wednesday;
		SELF.TotalCounts.TotalDayCount.Thursday											:= GT[1].Thursday;
		SELF.TotalCounts.TotalDayCount.Friday												:= GT[1].Friday;	
		SELF.TotalCounts.TotalDayCount.Saturday											:= GT[1].Saturday;
		SELF.TotalCounts.TotalDayCount.Sunday												:= GT[1].Sunday;
		SELF.TotalCounts.TotalDayCount.Unknown											:= GT[1].DOWUnk;
		SELF.TotalCounts.TotalCollisionTypeCount.FrontRear					:= GT[1].CT_FrontRear;
		SELF.TotalCounts.TotalCollisionTypeCount.FrontFront					:= GT[1].CT_FrontFront;
		SELF.TotalCounts.TotalCollisionTypeCount.Angle							:= GT[1].CT_Angle;
		SELF.TotalCounts.TotalCollisionTypeCount.SideSwipeSame			:= GT[1].CT_SideSwipeSame;
		SELF.TotalCounts.TotalCollisionTypeCount.SideSwipeOpposite	:= GT[1].CT_SideSwipeOpposite;
		SELF.TotalCounts.TotalCollisionTypeCount.RearSide						:= GT[1].CT_RearSide;
		SELF.TotalCounts.TotalCollisionTypeCount.RearRear						:= GT[1].CT_RearRear;
		SELF.TotalCounts.TotalCollisionTypeCount.Other							:= GT[1].CT_Other;
		SELF.TotalCounts.TotalCollisionTypeCount.Unknown						:= GT[1].CT_Unknown;
		SELF.TotalCounts.TotalAccidentTypeCount.Vehicle							:= GT[1].AT_Vehicle;							
		SELF.TotalCounts.TotalAccidentTypeCount.Pedestrian					:= GT[1].AT_Pedestrian;
		SELF.TotalCounts.TotalAccidentTypeCount.Bicycle							:= GT[1].AT_Bicycle;	
		SELF.TotalCounts.TotalAccidentTypeCount.Motorcycle					:= GT[1].AT_Motorcycle;
		SELF.TotalCounts.TotalAccidentTypeCount.Animal							:= GT[1].AT_Animal;
		SELF.TotalCounts.TotalAccidentTypeCount.Train								:= GT[1].AT_Train;	
		SELF.TotalCounts.TotalAccidentTypeCount.Unknown							:= GT[1].AT_Unknown;
		SELF.Records			:= dsRptRecs;
	END;


END; //Module