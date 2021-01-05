EXPORT Layout_PrepEcrashAnalyticKeys := MODULE

EXPORT interim := RECORD 
 Layout_eCrash.Consolidation; 
 STRING orig_case_identifier; 
 STRING orig_state_report_number; 
END; 

EXPORT accidents_by_AgencyID_slim := RECORD
  STRING11 AgencyID;
	STRING10 accident_date;
  STRING30 precinct;
  STRING20 beat;
	STRING   report_code;
	STRING   vehicle_incident_id;
	INTEGER  AccidentCnt;
	INTEGER  InjuryCnt;
	INTEGER  FatalCnt;
	INTEGER  InjuryUnkCnt;
END;

EXPORT accidents_by_CT_slim := RECORD
  STRING11 AgencyID;
	STRING8  accident_date;
	STRING   report_code;
	STRING   vehicle_incident_id;
	STRING   vehicle_unit_number;
	STRING   Report_Collision_Type;
END;

EXPORT accidents_by_CT_slim2 := RECORD
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

EXPORT accidents_by_dow_slim := RECORD
  STRING11 AgencyID;
	STRING8  accident_date;
  INTEGER  DayOfWeek;
	STRING   report_code;
	STRING   vehicle_incident_id;
	INTEGER  AccidentCnt;
	INTEGER  InjuryCnt;
	INTEGER  FatalCnt;
	INTEGER  InjuryUnkCnt;
END;

EXPORT accidents_by_hod_slim := RECORD
  STRING11 AgencyID;
	STRING8  accident_date;
	INTEGER  HourOfDay; //HH:MM:SS
	STRING   report_code;
	STRING   vehicle_incident_id;
	INTEGER  AccidentCnt;
	INTEGER  InjuryCnt;
	INTEGER  FatalCnt;
	INTEGER  InjuryUnkCnt;
END;

EXPORT accidents_by_slim := RECORD
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

EXPORT accidents_by_slim2 := RECORD
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

EXPORT accidents_by_moy_slim := RECORD
  STRING11 AgencyID;
	STRING8  accident_date;
  STRING2  MonthOfYear;
	STRING   report_code;
	STRING   vehicle_incident_id;
	INTEGER  AccidentCnt;
	INTEGER  InjuryCnt;
	INTEGER  FatalCnt;
	INTEGER  InjuryUnkCnt;
END;

END;