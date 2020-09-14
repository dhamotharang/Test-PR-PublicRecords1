import		address, BIPV2;
EXPORT Layout_Header_Out := RECORD
	Cortera.Layout_Header - First_Seen; //Excluding for keys
	// ***
		unsigned4	processDate;
		string8		version;
		unsigned8 persistent_record_id := 0;
  unsigned4 dt_first_seen;   // Date record first seen at Seisint
  unsigned4 dt_last_seen;    // Date record last (most recently seen) at Seisint
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
	boolean current;
		string10		clean_phone;
		string10		clean_fax;

		unsigned8		rawaid := 0;
		address.Layout_Clean182.prim_range
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
		,address.Layout_Clean182.county
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat;
		
	unsigned6		bdid := 0;
	unsigned1		bdid_score := 0;
	BIPV2.IDlayouts.l_xlink_ids;	


END;