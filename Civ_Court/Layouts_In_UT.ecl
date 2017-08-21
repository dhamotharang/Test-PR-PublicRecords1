IMPORT Civ_Court, ut;

EXPORT Layouts_In_UT := MODULE

	EXPORT Filings	:= RECORD
		string	case_type;
		string	case_num;
		string	locn_descr;
		string	filing_date; //  m/d/yyyy
		string	party_code;
		string	last_name;
		string	first_name;
	END;
	
	EXPORT Judgements	:= RECORD
		string	locn_code;
		string	locn_descr;
		string	case_type; 	//filter out type: FS,IF,MD,MO,PC,PN,TC,TN
		string	case_num;
		string	jdmt_filing_date;	// m/d/yyyy
		string	disp_date;		// m/d/yyyy
		string	jdmt_code;
		string	last_name;
		string	first_name;
		string	party_code;
	END;
	
	EXPORT Disposition := RECORD
		string	locn_code;
		string	locn_descr;
		string	case_type;	//filter out type: FS,IF,MD,MO,PC,PN,TC,TN
		string	case_num;
		string	disp_code;
		string	disp_date;	// m/d/yyyy
		string	last_name;
		string	first_name;
		string	party_code;
	END;
	
	EXPORT Case_all	:= RECORD
		string	case_type;
		string	case_num;
		string	locn_code;
		string	locn_descr;
		string	filing_date;
		string	party_code;
		string	last_name;
		string	first_name;
		string	disp_code;
		string	disp_date;
		string	jdmt_code;
		string	jdmt_filing_date;
	END;

	EXPORT code_lkp	:= RECORD
		string	code;
		string	code_desc;
	END;
	
END;



