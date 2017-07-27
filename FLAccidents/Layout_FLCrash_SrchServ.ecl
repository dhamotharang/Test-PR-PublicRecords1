import BIPV2;

export Layout_FLCrash_SrchServ := record
  BIPV2.IDlayouts.l_xlink_ids;      	//Added for BIP project	
	string12  did,
	string9   accident_nbr,
	string8   accident_date, 
	string5   title,
	string20  fname,
	string20  mname,
	string20  lname,
	string5   name_suffix,
	string12  b_did,
	string25  cname,
	string10  prim_range,
	string2   predir,
	string28  prim_name,
	string4   addr_suffix,
	string2   postdir,
	string10  unit_desig,
	string8   sec_range,
	string25  v_city_name,
	string2   st,
	string5   zip,
	string4   zip4,
  string20  record_type,
	string15  driver_license_nbr,
	string2   dlnbr_st,
	string22  vin,
	string8   tag_nbr,
	string2   tagnbr_st,
	string150 orig_full_name; 
end;