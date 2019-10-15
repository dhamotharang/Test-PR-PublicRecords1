import BIPV2;

EXPORT layouts := module

export xlink := record
	unsigned6 rid;
	string5 src;
  string5 sub_src:='';
	string src_rcid := '';

	string200 company_name;
	string50 company_prim_range;
	string50 company_prim_name;
	string50 company_zip;
	string50 company_sec_range;
	string50 company_city;
	string50 company_state;
	string50 company_phone;
	string50 company_fein;

	string100 email_address;									
	string25 fname;	
	string25 mname;	
	string25 lname;	

	BIPV2.IDlayouts.l_xlink_ids;
	unsigned6 bdid_input;
	unsigned6 bdid;
	unsigned3 BDID_score;
end;

export xlink6:={xlink AND NOT [sub_src]};
export xlink5:={xlink6 AND NOT [src_rcid]};


end;