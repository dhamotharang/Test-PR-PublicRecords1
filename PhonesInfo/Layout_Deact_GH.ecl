﻿EXPORT Layout_Deact_GH := module

//History
	export History := record
		string2 		action_code;
		string14		timestamp;
		string10		phone;
		string10 	phone_swap;
		string255 filename;
	end;
	
//Base	
	export Temp := record
		unsigned  groupid			:= 0;
		unsigned8	vendor_first_reported_dt;
		unsigned8	vendor_last_reported_dt;
		string2 		action_code;
		string14		timestamp;
		string10		phone;
		string10  phone_swap;
		string255 filename;
		string60 	carrier_name;
		string 			filedate;
		unsigned8	swap_start_dt		:= 0;
		unsigned8	swap_end_dt			:= 0;
		string2			deact_code;
		unsigned8	deact_start_dt 	:= 0;
		unsigned8	deact_end_dt		:= 0;
		unsigned8	react_start_dt	:= 0;
		unsigned8	react_end_dt		:= 0;
		string2			is_react				:= '';
		string2			is_deact				:= '';
		unsigned8 porting_dt; 
		string 			pk_carrier_name;
		integer 		days_apart;
	end;

//Base Temp	
	export Temp2 := record
		Temp;
		integer did;
		integer bdid;
		integer addID;
	end;

end;