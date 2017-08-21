IMPORT address,AID;

EXPORT layouts := MODULE

	SHARED max_size := _Dataset().max_record_size;
	
	EXPORT Input := RECORD,MAXLENGTH(max_size)
			STRING10	orig_phone;
		  string15	orig_first_name;
		  string1		orig_middle_name;
		  string20	orig_last_name;
		  string10	orig_house_number;
		  string2		orig_predirection;
		  string20	orig_street_name;
		  string4		orig_suffix;
		  string2		orig_postdirection;
		  string4		orig_unit_name;
		  string8		orig_unit_number;
		  string22	orig_city;
		  string2		orig_state;
		  string5		orig_zip;
		  string4		orig_zip_4;
		  string1		orig_zip_4_type;
		  string9		orig_latitude;
		  string11	orig_longitude;
			string4		orig_crte;
			string3		orig_dpc;
			STRING1		orig_verified := '';
			STRING1		orig_phone_activity := '';
			STRING1		orig_prepaid_flag := '';
	END;
	
	EXPORT Base := RECORD
			STRING18 		persistent_record_id;
			STRING2 		src;		
			UNSIGNED4 	dt_first_seen;
			UNSIGNED4 	dt_last_seen;
			UNSIGNED4 	dt_vendor_first_reported;
			UNSIGNED4 	dt_vendor_last_reported;
			UNSIGNED6 	did					:= 0;
			UNSIGNED2 	did_score		:= 0;
			// original fields
			Input;
			STRING60 		pre_prepped_addr1;
			
		  address.Layout_Clean_Name.title;
		  address.Layout_Clean_Name.fname;
		  address.Layout_Clean_Name.mname;
		  address.Layout_Clean_Name.lname;
		  address.Layout_Clean_Name.name_suffix;
			unsigned8 nid;
		  address.Layout_Clean182.prim_range;
		  address.Layout_Clean182.predir;
		  address.Layout_Clean182.prim_name;
		  address.Layout_Clean182.addr_suffix;
		  address.Layout_Clean182.postdir;
		  address.Layout_Clean182.unit_desig;
		  address.Layout_Clean182.sec_range;
		  address.Layout_Clean182.p_city_name;
		  address.Layout_Clean182.v_city_name;
		  address.Layout_Clean182.st;
		  address.Layout_Clean182.zip;
		  address.Layout_Clean182.zip4;
		  address.Layout_Clean182.cart;
		  address.Layout_Clean182.cr_sort_sz;
		  address.Layout_Clean182.lot;
		  address.Layout_Clean182.lot_order;
		  address.Layout_Clean182.dbpc;
		  address.Layout_Clean182.chk_digit;
		  address.Layout_Clean182.rec_type;
		  string2		fips_st:='';
		  string3		fips_county:='';
		  address.Layout_Clean182.geo_lat;
		  address.Layout_Clean182.geo_long;
		  address.Layout_Clean182.msa;
		  address.Layout_Clean182.geo_blk;
		  address.Layout_Clean182.geo_match;
		  address.Layout_Clean182.err_stat;
			AID.Common.xAID		RawAID;		
			AID.Common.xAID   ACEAID;
			string10 clean_Phone;
			boolean   IsUpdating:=false;
	END;

END;

