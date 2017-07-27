import header,address,AID;
export Layout := module

	export base := RECORD
		unsigned4 file_date_min:=0
		,unsigned4 file_date_max:=0
		,header.layout_eq_src
		,string35 current_occupation_employer:=''
		,string35 former_occupation_employer:=''
		,string35 former2_occupation_employer:=''
		,string35 other_occupation_employer:=''
		,string35 other_former_occupation_employer:=''
		,string15 orig_fname
		,string15 orig_mname
		,string25 orig_lname
		,string2 orig_suffix
		,string57 orig_addr
		,string57 addr_std
		,string30 temp_addr2
		,string20 orig_city
		,string2 orig_state
		,string5 orig_zip

		,unsigned6 did:=0
		,unsigned6 rid:=0
		,string1   rec_tp
		,unsigned4 dt_first_seen:=0
		,unsigned4 dt_last_seen:=0
		,unsigned4 dt_vendor_last_reported:=0
		,unsigned4 dt_vendor_first_reported:=0
		,string10  clean_phone:=''
		,string9   clean_ssn:=''
		,integer4  clean_dob:=0
		,qstring18 vendor_id
		,string1 jflag3
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
		,unsigned8 uid := 0
		,AID.Common.xAID	RawAID:=0
	END;

	export raw_rf:=record
			string8 file_date;
			string8 file_date_max:='';
			string8 file_date_min:='';
			string15 first_name;
			string15 middle_initial;
			string25 last_name;
			string2  suffix;
			string15 former_first_name;
			string15 former_middle_initial;
			string25 former_last_name;
			string2  former_suffix;
			string15 former_first_name2:='';
			string15 former_middle_initial2:='';
			string25 former_last_name2:='';
			string2  former_suffix2:='';
			string15 aka_first_name;
			string15 aka_middle_initial;
			string25 aka_last_name;
			string2  aka_suffix;
			string57 current_address;
			string20 current_city;
			string2  current_state;
			string5  current_zip;
			string6  current_address_date_reported;
			string57 former1_address;
			string20 former1_city;
			string2  former1_state;
			string5  former1_zip;
			string6  former1_address_date_reported;
			string57 former2_address;
			string20 former2_city;
			string2  former2_state;
			string5  former2_zip;
			string6  former2_address_date_reported;
			string9  ssn;
			string18  cid;
			string1  ssn_confirmed:='';
			string8  birthdate:='';
			string10 phone:='';
			string35 current_occupation_employer:='';
			string35 former_occupation_employer:='';
			string35 former2_occupation_employer:='';
			string35 other_occupation_employer:='';
			string35 other_former_occupation_employer:='';
			string6 min_ar1:='';
			string6 max_ar1:='';
			string6 min_ar2:='';
			string6 max_ar2:='';
			string6 min_ar3:='';
			string6 max_ar3:='';
		end;

	export current_raw := RECORD
		ebcdic string15 first_name;
		ebcdic string15 middle_initial;
		ebcdic string25 last_name;
		ebcdic string2  suffix;
		ebcdic string15 former_first_name;
		ebcdic string15 former_middle_initial;
		ebcdic string25 former_last_name;
		ebcdic string2  former_suffix;
		ebcdic string15 former_first_name2;
		ebcdic string15 former_middle_initial2;
		ebcdic string25 former_last_name2;
		ebcdic string2  former_suffix2;
		ebcdic string15 aka_first_name;
		ebcdic string15 aka_middle_initial;
		ebcdic string25 aka_last_name;
		ebcdic string2  aka_suffix;
		ebcdic string57 current_address;
		ebcdic string20 current_city;
		ebcdic string2  current_state;
		ebcdic string5  current_zip;
		ebcdic string6  current_address_date_reported;
		ebcdic string57 former1_address;
		ebcdic string20 former1_city;
		ebcdic string2  former1_state;
		ebcdic string5  former1_zip;
		ebcdic string6  former1_address_date_reported;
		ebcdic string57 former2_address;
		ebcdic string20 former2_city;
		ebcdic string2  former2_state;
		ebcdic string5  former2_zip;
		ebcdic string6  former2_address_date_reported;
		ebcdic string6  blank1;
		ebcdic string9  ssn;
		ebcdic string9  cid;
		ebcdic string1  ssn_confirmed;
		ebcdic string1  blank2;
		ebcdic string43 blank3; 
	END;

	export old_raw := record
		ebcdic string15 first_name
		,ebcdic string1 middle_initial
		,ebcdic string25 last_name
		,ebcdic string2 suffix
		,ebcdic string15 former_first_name
		,ebcdic string1 former_middle_initial
		,ebcdic string25 former_last_name
		,ebcdic string2 former_suffix
		,ebcdic string15 aka_first_name
		,ebcdic string1 aka_middle_initial
		,ebcdic string25 aka_last_name
		,ebcdic string2 aka_suffix
		,ebcdic string57 current_address
		,ebcdic string20 current_city
		,ebcdic string2 current_state
		,ebcdic string5 current_zip
		,ebcdic string6 current_address_date_reported
		,ebcdic string57 former1_address
		,ebcdic string20 former1_city
		,ebcdic string2 former1_state
		,ebcdic string5 former1_zip
		,ebcdic string6 former1_address_date_reported
		,ebcdic string57 former2_address
		,ebcdic string20 former2_city
		,ebcdic string2 former2_state
		,ebcdic string5 former2_zip
		,ebcdic string6 former2_address_date_reported
		,ebcdic string6 birthdate
		,ebcdic string9 ssn
		,ebcdic string9 cid
		,ebcdic string10 phone
		,ebcdic string35 current_occupation_employer
		,ebcdic string35 former_occupation_employer
		,ebcdic string35 former2_occupation_employer
		,ebcdic string35 other_occupation_employer
		,ebcdic string35 other_former_occupation_employer
	end;

end;