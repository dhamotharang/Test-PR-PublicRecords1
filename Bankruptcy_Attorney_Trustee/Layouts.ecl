import address, bipv2;
export Layouts := module

export layout_attorneys_in := record
	string FullName;
	string Firm;
	string Email;
	string Address;
	string Country;
	string City;
	string State;
	string Zipcode;
	string Phone;
	string Fax;
	string LastUpdated;
end;

export layout_trustees_in := record
	string FullName;
	string Firm;
	string EMail;
	string Phone;
	string Address;
	string City;
	string State;
	string ZipCode;
	string LastUpdated;
end;

export layout_addr := record
	string Address;
	string City;
	string State;
	string Zipcode;
end;

export layout_addr_clean := record
	layout_addr;
	string182 cleanaddress;
end;

export layout_name := record
	string100 name;
	string73 cleanname := '';
end;


export layout_company_name := record
	string100 co_name;
	string73 co_cleanname := '';
end;

export layout_attorneys_out := record
	 BIPV2.IDlayouts.l_xlink_ids;	
	 unsigned6	did       :=0;
	 unsigned1	did_score :=0;
	 unsigned6	Bdid	  := 0;
	 unsigned1	bdid_score:= 0;
	 layout_attorneys_in;
	 string10 clean_phone:='';
	 string8  date_first_seen := '';
	 string8  date_last_seen := '';
	 string8  date_vendor_first_reported := '';
	 string8  date_vendor_last_reported := '';
	 address.Layout_Clean_Name.title;
	 address.Layout_Clean_Name.fname;
	 address.Layout_Clean_Name.mname;
	 address.Layout_Clean_Name.lname;
	 address.Layout_Clean_Name.name_suffix;
	 address.Layout_Clean_Name.name_score;
	 string120 company_name;
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
	 string2		fips_county:='';
	 string3		county:='';
	 address.Layout_Clean182.geo_lat;
	 address.Layout_Clean182.geo_long;
	 address.Layout_Clean182.msa;
	 address.Layout_Clean182.geo_blk;
	 address.Layout_Clean182.geo_match;
	 address.Layout_Clean182.err_stat;	
	 string1 active_flag;
end;



export layout_trustees_out := record
	 BIPV2.IDlayouts.l_xlink_ids;	
	 unsigned6	did       :=0;
	 unsigned	did_score :=0;
	 unsigned6	Bdid	  := 0;
	 unsigned1	bdid_score:= 0;
	 layout_trustees_in;
	 string10 clean_phone:='';
	 string8  date_first_seen := '';
	 string8  date_last_seen := '';
	 string8  date_vendor_first_reported := '';
	 string8  date_vendor_last_reported := '';
	 address.Layout_Clean_Name.title;
	 address.Layout_Clean_Name.fname;
	 address.Layout_Clean_Name.mname;
	 address.Layout_Clean_Name.lname;
	 address.Layout_Clean_Name.name_suffix;
	 address.Layout_Clean_Name.name_score;
	 string120 company_name;
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
	 string2		fips_county:='';
	 string3		county:='';
	 address.Layout_Clean182.geo_lat;
	 address.Layout_Clean182.geo_long;
	 address.Layout_Clean182.msa;
	 address.Layout_Clean182.geo_blk;
	 address.Layout_Clean182.geo_match;
	 address.Layout_Clean182.err_stat;	
	 string1 active_flag;
end;
end;