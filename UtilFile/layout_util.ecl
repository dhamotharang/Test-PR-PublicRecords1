import address, AID;

export layout_util := module

export daily_in := record

   string10 Exchange_Serial_Number;
   string8  Date_added_to_exchange;
   string8  Service_Connect_date;
   string10 Service_Type;
   string25 Last_Name;
   string15 First_Name;
   string15 Middle_Name;
   string3  Name_Suffix;
   string159 S_address;
   string159 B_address;
   string9  Social_Security_Number;
   string10 Work_Phone;
   string10 Service_Phone;
   string2  Drivers_License_State_code;
   string22 Drivers_License;
   string3  Filler;
   string1  CSA_UCA_Indicator;
   string1  lf;
end;

export temp := record
   string15 	id;
   string10 	Exchange_Serial_Number;
   string8 	Date_added_to_exchange;
   string8 	Service_Connect_date;
   string10 	Service_Type;
   string25 	Last_Name;
   string15 	First_Name;
   string15 	Middle_Name;
   string3 	Name_Suffix;
   string1	addr_type;
   string1	addr_dual;
   string159  address;
   string9 	Social_Security_Number;
   string10 	Work_Phone;
   string10 	Service_Phone;
   string2 	Drivers_License_State_code;
   string22 	Drivers_License;
   string1 CSA_UCA_Indicator;
end;

export preclean := record

   string15 	id;
   string10 	Exchange_Serial_Number;
   string8 	Date_added_to_exchange;
   string8 	Connect_date;
   string10 	Util_Type;
   string25 	Last_Name;
   string15 	First_Name;
   string15 	Middle_Name;
   string3 	Name_Suffix;
   string1	addr_type;
   string1	addr_dual;
   string10   Address_Street;
   string100  Address_Street_Name;
   string5 	Address_Street_Type;
   string2 	Address_Street_direction;
   string10 	Address_Apartment;
   string20 	Address_City;
   string2 	Address_State;
   string10 	Address_Zip;
   string9 	Social_Security_Number;
   string10 	Work_Phone;
   string10 	Phone;
   string2 	Drivers_License_State_code;
   string22 	Drivers_License;
   string1 CSA_UCA_Indicator;
   string73  name_clean;
   string1 name_flag;
   string address1;
   string address2;
   	AID.Common.xAID							Append_RawAID;        
   
   end;
export base := record
	utilfile.Layout_Utility_In;
	string1 name_flag;
	AID.Common.xAID							Append_RawAID;        
	unsigned8 nid:=0;
  unsigned2  name_ind:=0;  // name indicator bitmap

end;

export OLD_Layout_Utility_In := record
	string15        id;
	string10        exchange_serial_number;
	string8         date_added_to_exchange;
	string8         connect_date;
	string8         date_first_seen;
	string8         record_date;
	string10        util_type;
	string25        orig_lname;
	string20        orig_fname;
	string20        orig_mname;
	string5         orig_name_suffix;
	string1         addr_type;
	string1         addr_dual;
	string10        address_street;
	string100       address_street_Name;
	string5         address_street_Type;
	string2         address_street_direction;
	string10        address_apartment;
	string20        address_city;
	string2         address_state;
	string10        address_zip;
	string9         ssn;
	string10        work_phone;
	string10        phone;
	string8         dob;
	string2         drivers_license_state_code;
	string22        drivers_license;
	//string1		csa_indicator := '';
	address.Layout_Clean182;
	string12        did;
	string5         title;
	string20        fname;
	string20        mname;
	string20        lname;
	string5         name_suffix;
	string3         name_score;
	AID.Common.xAID							Append_RawAID;        
    unsigned8 nid:=0;
    unsigned2  name_ind:=0;  // name indicator bitmap

end;

export daily_in_new := record

   string10   CSD_Reference_Number;
   string8    Date_First_Verified;
   string8    Date_Last_Verified;
   string10   Addr_Type;
   string25   Consumer_Last_Name;
   string15   First_Name;
   string15   Middle_Name;
   string3    Name_Suffix;
   string10   Svc_addr_street;
	 string100  Svc_addr_street_Name;
	 string5    Svc_addr_street_Type;
	 string2    Svc_addr_street_direction;
	 string10   Svc_addr_apartment;
	 string20   Svc_addr_city;
	 string2    Svc_addr_state;
	 string10   Svc_addr_zip;
	 string10   Bus_addr_street;
	 string100  Bus_addr_street_Name;
	 string5    Bus_addr_street_Type;
	 string2    Bus_addr_street_direction;
	 string10   Bus_addr_apartment;
	 string20   Bus_addr_city;
	 string2    Bus_addr_state;
	 string10   Bus_addr_zip;
	 string9    ssn;
	 string10   wrk_phone;
	 string10   svc_phone;
	 string2    DLN_state_code;
	 string22   drivers_license;
  // string3	  filler;
	// string1		csa_uca_indicator;
	 string1		lf;
end;

end;