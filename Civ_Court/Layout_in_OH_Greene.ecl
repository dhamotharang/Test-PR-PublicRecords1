IMPORT Civ_Court, ut;

EXPORT Layout_in_OH_Greene := MODULE;

	EXPORT raw_in := RECORD
		string	line;
	END;
	
	EXPORT case_in	:= RECORD
		string	case_num;
		string	case_name;
		string	file_date;
		string	charge;
		string	docket;
		string	pl_def;
		string	attorney;
		string	aka_name;
		string	party_name1;
		string	party_name2;
		string	address1;
		string	address2;
		string  address3;
		string  line;
	END;
	
END;