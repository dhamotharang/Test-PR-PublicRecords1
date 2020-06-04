EXPORT Layout_Comp_Code := module
	
	EXPORT CompCode_temp := record
		string8 dt_first_reported;
		string8 dt_last_reported;
		string8 dt_start;						//Date/Time Entered in Table
		string8 dt_end;
		string 	spid;
		string 	cc;									//Country Code
		string 	name;								//Operator Full Name
		string  operator_fullname;
		string 	country;						//ISO2
		string  code;								//Data Type: B = Both; R = Range; P = Port						
		string 	ocn;
		integer groupid;
		boolean is_current;
		unsigned4 global_sid;				//CCPA Requirement
		unsigned8 record_sid;				//CCPA Requirement
	end;
	
END;