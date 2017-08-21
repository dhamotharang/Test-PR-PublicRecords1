Import Aid, address;

Export Layout := Module

Export Dea_In := Record
			String9	Dea_Registration_Number;
			String1	Business_activity_code;
			String16	Drug_Schedules;
			String8	Expiration_Date;
			String40	Address1; //Name
			String40	Address2; //AdditionalCompanyInfo
			String40	Address3;
			String40	Address4; 
			String33	Address5;//City
			String2	State;
			String5	Zip_Code; 
			String1	Bus_Activity_Sub_Code;
			String1	Exp_of_Payment_Indicator;
			String8	Activity;
			String2	CrLf;
End;

Export  AID_prep := RECORD
			String8 date_first_reported;
			String8 date_last_reported;
			Dea_In;
			address.Layout_Clean_Name.title,
			address.Layout_Clean_Name.fname,
			address.Layout_Clean_Name.mname,
			address.Layout_Clean_Name.lname,
			address.Layout_Clean_Name.name_suffix,	
			Boolean	is_company_flag;
			String40	cname;
			Unsigned8 Nid;
			String77	Append_Prep_Address_Situs;
			String54	Append_Prep_Address_Last_Situs;
			AID.Common.xAID	AID;
END;

Export DEA_In_PreProcessed := record
			String8 date_first_reported;
			String8 date_last_reported;
			Dea_In;
			String10	prim_range;
			String2	predir;
			String28	prim_name;
			String4	addr_suffix;
			String2	postdir;
			String10	unit_desig;
			String8	sec_range;
			String25	p_city_name;
			String25	v_city_name;
			String2	st;
			String5	zip;
			String4	zip4;
			String4	cart;
			String1	cr_sort_sz;
			String4	lot;
			String1	lot_order;
			String2	dbpc;
			String1	chk_digit;
			String2	rec_type;
			String5	county;
			String10	geo_lat;
			String11	geo_long;
			String4	msa;
			String7	geo_blk;
			String1	geo_match;
			String4	err_stat;
			String182	cln_address;
			Unsigned8 rawaid;
			Unsigned8 nid;
			address.Layout_Clean_Name.title,
			address.Layout_Clean_Name.fname,
			address.Layout_Clean_Name.mname,
			address.Layout_Clean_Name.lname,
			address.Layout_Clean_Name.name_suffix,
			String3  name_score;
			Integer1  filler;
			boolean	is_company_flag;
			String40	cname;
End;

End;