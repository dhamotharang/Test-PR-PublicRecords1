import address, AID, BIPV2;

export Layouts := module

	export Raw_OIG_Layout:=record,maxlength(99999)
		string20 		LASTNAME;
		string15		FIRSTNAME;	
		string15		MIDNAME;
		string30		BUSNAME; 	
		string20		GENERAL; 	
		string20		SPECIALTY;	
		string6			UPIN1;
		string10    NPI;
		string8			DOB; 	
		string30		ADDRESS1; 	
		string20		CITY;	
		string2			STATE;	
		string5			ZIP5;	
		string9			SANCTYPE;	
		string8			SANCDATE;	
		string8			REINDATE;
		string8 	  WAIVERDATE;
		string2 		WVRSTATE;
	end;	

 	export Temp	:=	record
		Raw_OIG_Layout;
		string100 Append_Prep_Address1;
		string50	Append_Prep_AddressLast;
		AID.Common.xAID		Append_RawAID;
		AID.Common.xAID		ace_aid	;
  end;
	
	export Base := record
		Temp;
		string2    Addr_Type;
		string8    dt_vendor_first_reported;
		string8    dt_vendor_last_reported;
		string8    dt_first_seen;
		string8    dt_last_seen;
		string250  SANCDESC;
		unsigned6  did 	:= 0;
		unsigned6  bdid := 0;
		string9	   ssn 	:='';
		BIPV2.IDlayouts.l_xlink_IDs;
	end;
	
	export	KeyBuild := record
			Base;
			string5 		title;
			string20 		fname;
			string20 		mname;
			string20 		lname;
			string5 		name_suffix;
			string2   	ace_fips_st;
			string3			fips_county;
			string10 		prim_range;      
			string2   	predir;
			string28 		prim_name;
			string4   	addr_suffix;
			string2   	postdir;
			string10 		unit_desig;
			string8   	sec_range;
			string25 		p_city_name;
			string25 		v_city_name;
			string2   	st;
			string5   	zip;
			string4   	zip4;
			string4   	cart;
			string1   	cr_sort_sz;
			string4   	lot;
			string1   	lot_order;
			string2   	dpbc;
			string1   	chk_digit;
			string2   	addr_rec_type;
			string2   	fips_state;
			string2   	rec_type;
			string5 		county;
			string10 		geo_lat;
			string11 		geo_long;
			string4   	cbsa;
			string4   	msa;
			string7   	geo_blk	;
			string1   	geo_match;
			string4   	err_stat;
	end;  	
	
  export KeyBuild_main := record  // Bug 135721
			KeyBuild-NPI-WAIVERDATE-WVRSTATE;
	end;
	
end;