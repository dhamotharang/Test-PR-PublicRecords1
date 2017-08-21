IMPORT Civ_Court;

EXPORT Layout_In_FL_Alachua := MODULE

	EXPORT	lte := RECORD
		string3	county_code;
		string50 	case_number;
		string8 	file_date;
		string100 cause_of_action;
		string50	party_descr;
		string50 	first_name;
		string50 	middle_name;
		string50	last_name;
		string50 	company_name;
		string10	alias_type;
		string50 	alias_firstname;
		string50 	alias_middlename;
		string50 	alias_lastname;
		string50 	alias_company;
		string50 	addr_line1;
		string50	addr_line2;
		string50	addr_line3;
		string50 	city;
		string10	state;
		string10	zipcode;
		string20	phone1;
		string20	phone2;
		string2		cr;
	END;
	
	EXPORT nlj	:= RECORD
		string	Case_Number;
		string	Party_Code;
		string	Party_Last_Name;
		string	Party_First_Name;
		string	Party_Middle_Name; 
		string	Party_Company_Name;
		string	Attorney_Last_Name;
		string	Attorney_First_Name;
		string	Attorney_Middle_Name;
		string	Attorney_Company_Name;
		string	Docket_Date;
		string	Docket_Text;
	END;
	
	EXPORT civil	:= RECORD
		string	filing_action;
		string	filing_date;
		string	case_number;
		string	party_description;
		string	last_name_1;
		string	first_name_1;
		string	company_name_1;
		string	date_of_birth_1;
		string	vs_or_adv;
		string	last_name_2;
		string	first_name_2;
		string	company_name_2;
	END;
	
END;

