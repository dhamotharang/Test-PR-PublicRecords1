IMPORT	address;

EXPORT InternalLayouts := MODULE

	export rAddress := RECORD
		Layouts2.rAddress - recordCode;

		String60  Prepped_addr1:='';
		String45  Prepped_addr2:=''

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
			,string2		fips_state:=''
			,string3		fips_county:=''
			,address.Layout_Clean182.geo_lat
			,address.Layout_Clean182.geo_long
			,address.Layout_Clean182.msa
			,address.Layout_Clean182.geo_blk
			,address.Layout_Clean182.geo_match
			,address.Layout_Clean182.err_stat
		;
	END;

	export rClient := RECORD
		Layouts2.rClient - recordCode;
		String75  Prepped_name:=''
			,address.Layout_Clean_Name.title
			,typeof(address.Layout_Clean_Name.fname) prefname:=''
			,address.Layout_Clean_Name.fname
			,address.Layout_Clean_Name.mname
			,address.Layout_Clean_Name.lname
			,address.Layout_Clean_Name.name_suffix
		,unsigned6 did:=0
		,unsigned  did_score:=0
		,string9   clean_ssn:=''
		,string9   best_ssn:=''
		,integer4  clean_dob:=0
		,integer4  age:=0
		,integer4  best_dob:=0
		;
	END;

END;