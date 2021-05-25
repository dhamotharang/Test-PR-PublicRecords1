export Layouts_DL_MI_In := module

	export Layout_MI_Update := record
		string1  Code;
   	string13 Customer_DLN_PID;
   	string50 Last_Name;
   	string50 First_Name;
   	string50 Middle_Name;
   	string6  Name_Suffix;
   	string36 Street_Address;
   	string19 City;
   	string2  State;
   	string5  Zipcode;
   	string8  Date_of_Birth;
   	string1  Gender;
   	string2  County;
   	string1  DLN_PID_Indicator;
   	string36 Mailing_Street_address;
   	string19 Mailing_City;
   	string2  Mailing_State;
   	string5  Mailing_Zipcode;
		string5  blob;
	end;
	
	export Layout_MI_Cleaned := record
		string8   process_date;
		Layout_MI_Update;
		string5   clean_name_prefix;
		string20  clean_fname;
		string20  clean_mname;
		string20  clean_lname;
		string5   clean_name_suffix;
		string3   clean_name_score;
	end;
	
	export Layout_MI_Cleaned_Ext := record
	  Layout_MI_Cleaned;
		string1 addr_type;
	end;

end;