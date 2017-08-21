import header,address,AID;
export Layouts := MODULE

	export load := RECORD
		string2	   Record_Type;
		string20   First_Name;
		string20   Middle_Name;
		string32   Last_Name;
		string3    Name_Prefix;
		string3    Name_Suffix_;
		string12   Perm_ID;
		string9	   SSN;
		string32   AKA1;
		string32   AKA2;
		string32   AKA3;
		string1	   New_Subject_Flag;
		string1	   Name_Change_Flag;
		string1	   Address_Change_Flag;
		string1	   SSN_Change_Flag;
		string1	   File_Since_Date_Change_Flag;
		string1	   Deceased_Indicator_Flag;
		string1	   DOB_Change_Flag;
		string1	   Phone_Change_Flag;
		string27   Filler2;
		string1    Gender;
		string1    MFDU_indicator;
		string8	   File_Since_Date;
		string10   House_Number;
		string2	   Street_Direction;
		string28   Street_Name;
		string4	   Street_Type;
		string2	   Street_Post_Direction;
		string4	   Unit_Type;
		string10   Unit_Number;
		string28   Cty;
		string2	   State;
		string5	   Zip_Code;
		string4	   Zp4;
		string1	   Address_Standardization_Indicator;
		string8	   Date_Address_Reported;
		string15   Party_ID;
		string1	   Deceased_Indicator;
		string8	   Date_of_Birth;
		string1	   Date_of_Birth_Estimated_Ind;
		string10   phone;
		string15   Filler3;
		string1   cr;
	END;

	export update := RECORD
		load;
	END;

	export delete := RECORD
		load;
	END;

	export base := RECORD
		load-cr;
		String75  Prepped_name:='';
		String60  Prepped_addr1:='';
		String35  Prepped_addr2:='';
		string2   Prepped_rec_type:='';
		boolean   IsUpdating:=false;
		boolean   IsCurrent:=false;
		unsigned6 did:=0;
		unsigned  did_score:=0;
		unsigned4 dt_first_seen:=0;
		unsigned4 dt_last_seen:=0;
		unsigned4 dt_vendor_last_reported:=0;
		unsigned4 dt_vendor_first_reported:=0;
		string10  clean_phone:='';
		string9   clean_ssn:='';
		integer4  clean_dob:=0
		,address.Layout_Clean_Name.title
		,address.Layout_Clean_Name.fname
		,address.Layout_Clean_Name.mname
		,address.Layout_Clean_Name.lname
		,address.Layout_Clean_Name.name_suffix
		,address.Layout_Clean_Name.name_score

		,address.Layout_Clean182.prim_range
		,address.Layout_Clean182.predir
		,address.Layout_Clean182.prim_name
		,address.Layout_Clean182.addr_suffix
		,address.Layout_Clean182.postdir
		,address.Layout_Clean182.unit_desig
		,address.Layout_Clean182.sec_range
		,address.Layout_Clean182.p_city_name
		,address.Layout_Clean182.v_city_name
		,address.Layout_Clean182.st
		,address.Layout_Clean182.zip
		,address.Layout_Clean182.zip4
		,address.Layout_Clean182.cart
		,address.Layout_Clean182.cr_sort_sz
		,address.Layout_Clean182.lot
		,address.Layout_Clean182.lot_order
		,address.Layout_Clean182.dbpc
		,address.Layout_Clean182.chk_digit
		,address.Layout_Clean182.rec_type
		,string2		fips_county:=''
		,string3		county:=''
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat

		,AID.Common.xAID	RawAID:=0;
		 boolean   IsDelete := false;

	END;

END;