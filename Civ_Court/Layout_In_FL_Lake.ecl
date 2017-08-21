IMPORT Civ_Court, ut;

EXPORT Layout_In_FL_Lake := RECORD
   string	case_num;
   string	date_of_eviction; //mm/dd/yyy
   string	pord;  //party type
   string	first_name;
   string	middle_initial;
   string	last_name;
   string	corporate_name;
   string	address;
   string	city;
   string	state;
   string	zip;
END;