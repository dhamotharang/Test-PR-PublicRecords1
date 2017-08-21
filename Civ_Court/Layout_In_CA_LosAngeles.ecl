IMPORT Civ_Court, ut;

EXPORT Layout_In_CA_LosAngeles := RECORD
	string2	 blank1;
	string2 	month_of_filing;
	string2 	blank2;
	string2 	day_of_filing;
	string2 	blank3;
	string4	 year_of_filing;
	string1 	blank4;
	string1 	case_status; //C = Corrections, M = Amendments, T = Transfers
	string1 	blank5;
	string2 	party_type; //2 dashes = PLAINTIFF, blank = DEFENDENT
	string45 	party_name1;  //currently just contains a period
	string40 	party_name2;
	string1 	branch_code_id;
	string3 	blank6;
	string1 	dist_prfx;
	string2 	case_type;
	string6 	case_number;
	string1 	blank7;
	string1 	suffix; //G = Glendale, B = Burbank
	string13 	blank8;
	string4	indx_type;
	string2 CR;
END;
