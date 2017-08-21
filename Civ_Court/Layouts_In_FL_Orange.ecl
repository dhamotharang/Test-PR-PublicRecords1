IMPORT Civ_Court, ut;

EXPORT Layouts_In_FL_Orange := MODULE

	EXPORT Raw_In	:= RECORD //Variable length
		string 	rec_type;
		string 	court;
		string 	case_no;
	//Multiple record types and fields so using generic field names for initial input file
		string	field1;
		string	field2;
		string	field3;
		string	field4;
		string	field5;
		string	field6	:= '';
		string	field7	:= '';
		string	field8	:= '';
		string	field9	:= '';
		string	field10	:= '';
		string	field11	:= '';
		string	field12	:= '';
	END;
	
	EXPORT Raw_In_1	:= RECORD
		string 	rec_type; //rec_type = '1'
		string 	court;
		string 	case_no;
		string 	name;
		string 	case_type;
		string 	party_number;
		string 	party_type;
		string 	count_no;
		string 	judge_name;
		string 	filing_date;
		string 	case_type_desc;
		string 	case_status_desc;
		string 	case_status_date;
		string 	disposition_desc;
		string 	disposition_date;
	END;
	
	EXPORT Raw_In_3	:= RECORD
		string 	rec_type;  //rec_type = '3'
		string 	court;
		string 	case_no;
		string 	event_date;
		string 	event_code;
		string 	event_code_desc;
		string 	event_action;
		string 	event_action_date;
		string	event_duration;
	END;
	
	EXPORT Raw_Full	:= RECORD
		string 	court;
		string 	case_no;
		string 	name;
		string 	case_type;
		string 	party_number;
		string 	party_type;
		string 	count_no;
		string 	judge_name;
		string 	filing_date;
		string 	case_type_desc;
		string 	case_status_desc;
		string 	case_status_date;
		string 	disposition_desc;
		string 	disposition_date;
		string 	event_date;
		string 	event_code;
		string 	event_code_desc;
		string 	event_action;
		string 	event_action_date;
		string	event_duration;
	END;
	
		EXPORT Raw_Weekly	:= RECORD
		string 	UniformCaseNumber;
		string 	CaseStyle;
		string 	CaseNumber;
		string 	CaseTypeDesc;
		string 	CaseStatus;
		string 	CaseStatusDate;
		string 	CaseFileDate;
		string 	Judge;
		string 	PartyType;
		string 	PartyName;
		string 	DOB;
		string 	Race;
		string 	Gender;
		string 	Address;
		string 	LeadAttorney;
		string 	DispositionDesc;
		string 	DispositionDate;
	END;

END;
