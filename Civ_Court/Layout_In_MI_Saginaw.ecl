IMPORT Civ_Court, ut;

EXPORT Layout_In_MI_Saginaw := MODULE
	
	EXPORT raw_in := RECORD
		string	line;
	END;
	
	EXPORT case_in	:= RECORD
		string10	disposition_date;
		string		case_type;
		string14	case_num;
		string35	plaintiff;
		string32	defendant;
		string35	plaintiff_street;
		string32	plaintiff_csz;
		string35	def_street;
		string32	def_csz;
		string		case_title;
		string10	filed_date;
		string10	activity_date1;
		string		activity1;
		string10	activity_date2;
		string		activity2;
		string10	activity_date3;
		string		activity3;
		string10	activity_date4;
		string		activity4;
		string10	activity_date5;
		string		activity5;
		string10	activity_date6;
		string		activity6;
		string10	activity_date7;
		string		activity7;
		string10	activity_date8;
		string		activity8;
		string10	activity_date9;
		string		activity9;
		string10	activity_date10;
		string		activity10;
	END;
	
END;