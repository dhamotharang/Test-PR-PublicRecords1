IMPORT Civ_Court, ut;

EXPORT Layouts_In_WA := MODULE

	EXPORT Civil	:= RECORD
		string3	dist_mncp_court_code;
		string2 case_type;
		string9 case_number;
		string3	filler1;
		string2 case_disposition_code;
		string10 case_disposition_date;
		string10 filing_date;
		string3 case_cause_number;
		string128	case_title;
		string1	cr;
	END;
	
	EXPORT	Jud_Rec	:= RECORD
		string3		dist_mncp_court_code;
		string2 	case_type;
		string9 	case_number;
		string3		filler1;
		string2		judgement_type_code;
		string10	judgement_date;
		string2		judgement_disposition_code;
		string10	judgement_disposition_date;
		string3 	filler2;
		string1 	cr;
	END;
	
	EXPORT Par_Rec	:= RECORD
		string3	dist_mncp_court_code;
		string2 case_type;
		string9 case_number;
		string3	filler1;
		string3	participant_type_code;
		string64	participant_name;
		string1	judgement_rule_code;
		string1	cr;
	END;
	
	EXPORT Civ_Par	:= RECORD
		Par_Rec and not [filler1, cr];
		string3	c_dist_mncp_court_code;
		string2 c_case_type;
		string9 c_case_number;
		string2 case_disposition_code;
		string10 case_disposition_date;
		string10 filing_date;
		string3 case_cause_number;
		string128	case_title;
	END;
	
	EXPORT Civ_Jud	:= RECORD
		Jud_Rec and not [filler1, filler2, cr];
		string3	c_dist_mncp_court_code;
		string2 c_case_type;
		string9 c_case_number;
		string2 case_disposition_code;
		string10 case_disposition_date;
		string10 filing_date;
		string3 case_cause_number;
		string128	case_title;
	END;
	
	EXPORT cause_code_lkp	:= RECORD
		string2		code_type;
		string3		code; 
		string45	code_desc;
		string1		lf;
	END;
	
	EXPORT case_disp_lkp	:= RECORD
		string2		code;
		string30	code_desc;
		string1		lf;
	END;
	
	EXPORT court_code_lkp	:= RECORD
		string3		code;
		string40	code_desc;
		string1		lf;
	END;
	
	EXPORT judgement_disp_lkp	:= RECORD
		string2		code;
		string25	code_desc;
		string1		lf;
	END;
	
	EXPORT judgement_type_lkp	:= RECORD
		string2		code;
		string25	code_desc;
		string1		lf;
	END;
	
	EXPORT participant_type_lkp	:= RECORD
		string3		code;
		string20	code_desc;
		string1		lf;
	END;	
	
	EXPORT sealed_rec := record 	//VC - DF-23245
    string3   CourtID;
    string9   CaseNumber;
    string3   LawEnforcementCode;
    string2   CaseType;
    string128 CaseTitle;
    string10  FileDate;
    string10  DispositionDate;
    string2   DispositionCode;
    string1   filler;
end;

END;



