IMPORT eCrash_Analytics, FLAccidents_Ecrash,iesp;
EXPORT Layouts := MODULE

EXPORT Layout_byCommand := RECORD
  string11 agency_id;
	string10 crash_date;
  string30 precinct;
  string20 beat;
END;

EXPORT Layout_Inquiry := RECORD
  STRING  AGENCYID;       // called Jurisdiction_nbr in the HPPC keys.
	STRING1 AGENCY_TYPE;  // NONE=AGENCY LEVEL (see AGENCY), 1 = BEAT, 2 = PRECINCT
	STRING8 START_DATE;   // YYYYMMDD
	STRING8 END_DATE;     // YYYYMMDD
	INTEGER DAYOFFSET;    // number of days to offset from current date if start date/end date not provided.
	STRING  SORTSEQ;      // pipe delimited list of fields for sort sequence ex. FIELD1|-FIELD2
END;

EXPORT Layout_AgencyLvl := RECORD
	STRING AgencyID;
	INTEGER AccidentCnt;
	INTEGER InjuryCnt;
	INTEGER FatalCnt;
END;

EXPORT Layout_ByTours := RECORD
	STRING AgencyID;
	STRING Intersection;
	INTEGER Accidentcnt;
	INTEGER TOUR1;
	INTEGER TOUR2;
	INTEGER TOUR3;
	INTEGER TOURUnk;
END;

EXPORT Layout_ByDOWDays := RECORD
	STRING AgencyID;
	STRING Intersection;
	INTEGER Accidentcnt;
	INTEGER MONDAY;
	INTEGER TUESDAY;
	INTEGER WEDNESDAY;
	INTEGER THURSDAY;
	INTEGER FRIDAY;
	INTEGER SATURDAY;
	INTEGER SUNDAY;
	INTEGER DOWUnk;
END;


EXPORT Layout_Response := RECORD
  INTEGER RecCntr;
	STRING  AGENCYID;          //called Jurisdiction_nbr in the HPCC keys
	STRING  COMMAND;         //This will be the beat or precinct
	INTEGER DayOfWeek;
	STRING  DayName;
	INTEGER HourOfDay;
	INTEGER MonthOfYear;
	STRING  MonthName;
	STRING  INTERSECTION;    //combination of accident street & cross street
	INTEGER AccidentCnt;    
	INTEGER FatalCnt;       //only fatals
	INTEGER InjuryCnt;      //Injury count includes all fatal and non fatals
	INTEGER PropDmgCnt; //count of accidents having property damage
	INTEGER TOUR1;           // count of accidents occuring during a particular work shift1 etc..
	INTEGER TOUR2;
	INTEGER TOUR3;
	INTEGER TOURUnk;
	INTEGER MONDAY;          //number of accident occuring on a Monday etc.....
	INTEGER TUESDAY;
	INTEGER WEDNESDAY;
	INTEGER THURSDAY;
	INTEGER FRIDAY;
	INTEGER SATURDAY;
	INTEGER SUNDAY;
	INTEGER DOWUnk;
	INTEGER CT_FRONTREAR;              //number of accidents having a front collision type etc....
	INTEGER CT_FRONTFRONT;
	INTEGER CT_ANGLE;
	INTEGER CT_SIDESWIPESAME;
	INTEGER CT_SIDESWIPEOPPOSITE;
	INTEGER CT_REARSIDE;
	INTEGER CT_REARREAR;
	INTEGER CT_OTHER;
	INTEGER CT_UNKNOWN;
	INTEGER AT_VEHICLE;            //number of accidents having an accident type of vehicle etc....
	INTEGER AT_PEDESTRIAN;
	INTEGER AT_BICYCLE;
	INTEGER AT_MOTORCYCLE;
	INTEGER AT_ANIMAL;
	INTEGER AT_TRAIN;
	INTEGER AT_UNKNOWN;
END;

EXPORT Record_DOW := RECORD
  INTEGER DayOfWeek;
	STRING DayName;
END;

EXPORT Record_HOD := RECORD
  INTEGER HourOfDay;
END;

EXPORT Record_MOY := RECORD
  INTEGER MonthOfYear;
END;


END; //Layouts