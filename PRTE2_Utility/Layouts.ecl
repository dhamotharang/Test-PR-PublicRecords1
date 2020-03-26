import UtilFile, Address, AID;

EXPORT Layouts := module

	export incoming := record
			string15  id;
			string10  exchange_serial_number;
			string8   date_added_to_exchange;
			string8   connect_date;
			string8   date_first_seen;
			string8   record_date;
			string10  util_type;
			string25  orig_lname;
			string20  orig_fname;
			string20  orig_mname;
			string5   orig_name_suffix;
			string1   addr_type;
			string1   addr_dual;
			string50  address_street;
			string100 address_street_Name;
			string5   address_street_Type;
			string2   address_street_direction;
			string10  address_apartment;
			string20  address_city;
			string2   address_state;
			string10  address_zip;
			string9   ssn;
			string10  work_phone;
			string10  phone;
			string8   dob;
			string2   drivers_license_state_code;
			string22  drivers_license;
	    string10 	cust_num;
			string10	bug_num;
		  string8	  link_dob;
      string9   link_ssn;
      string9   link_fein;
      string9   link_inc_date;
      string100 company_name;
      string50  orig_addr1;
      string50  orig_add2;
      string20  orig_city;
      string2   orig_st;
      string10  orig_zip;

			end;

	export base := record
		UtilFile.Layout_Utility_Bus_Base;
		string10 cust_num;
		string10 bug_num;
	end;	
	
	export slimrec := record
			UtilFile.Layout_Utility_In - [csa_indicator];
	end;
			

	export misc := record
		data16 		hval;
		unsigned4 startDate;
		unsigned4 endDate;
		string2 	state;
	end;

	
	export did_out := record
		utilfile.Layout_DID_Out;
	end;	

	export autokey :=	RECORD
		utilfile.Layout_DID_Out;
		integer zero := 0;
		string	blank;
	END;

	export as_header := record
		base - [cust_num, bug_num];
	end;	
end;