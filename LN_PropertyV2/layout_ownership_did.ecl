import AID;

l_hist := record
	unsigned4	dt_seen;	// YYYYMMDD
	string12	ln_fares_id;
	unsigned6	owner_did;
end;

export layout_ownership_did := record
	// rolled info
	unsigned6				did;
	boolean					current;
	unsigned4				dt_first_seen;	// YYYYMMDD
	unsigned4				dt_last_seen;		// YYYYMMDD
	dataset(l_hist)	hist	{maxcount(LN_PropertyV2.Constants.maxRecsByOwnership)};
	
	// current owner info
	string20	fname;
	string20	lname;
	
	// tax appraiser info
	string5		fips_code;
	string45	unformatted_apn;
	string2		orig_state;
	string30	orig_county;
	string250	legal_brief_description;
	
	// address info
	AID.Common.xAID	rawaid;
	AID.Common.xAID	aceaid;
	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		suffix;
	string2		postdir;
	string10	unit_desig;
	string8		sec_range;
	string25	p_city_name;
	string25	v_city_name;
	string2		st;
	string5		zip;
	string4		zip4;
	string4		cart;
	string1		cr_sort_sz;
	string4		lot;
	string1		lot_order;
	string2		dbpc;
	string1		chk_digit;
	string2		rec_type;
	string5		county;
	string10	geo_lat;
	string11	geo_long;
	string4		msa;
	string7		geo_blk;
	string1		geo_match;
end;