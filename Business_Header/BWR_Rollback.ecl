import ut,business_header_ss;

//have keys on them
  ut.mac_SF_Move('BASE::Business_Contacts','R',_a,3,true)
	ut.mac_SF_Move('BASE::People_At_Work_Stats','R',_b,3,true)
	ut.mac_SF_Move('BASE::business_header.Best','R',_c,3,true)
	ut.mac_SF_Move('BASE::business_header.CompanyName','R',_d,3,true)
	ut.mac_SF_Move('BASE::business_header.CompanyName_Address','R',_e,3,true)
	ut.mac_SF_Move('BASE::business_header.CompanyName_Phone','R',_f,3,true)
	ut.mac_SF_Move('BASE::business_header.CompanyName_FEIN','R',_g,3,true)
	ut.mac_SF_Move('BASE::Business_Header','R',_h,3,true)
	ut.mac_SF_Move('BASE::Business_Relatives','R',_i,3,true)
	ut.mac_SF_Move('BASE::Business_Relatives_Group','R',_j,3,true)
	ut.mac_SF_Move('BASE::bh_co_name_words','R',_k,3,true)
	ut.mac_SF_Move('BASE::bh_bdid.city.zip.fein.phone','R',_l,3,true)

//have no keys
	ut.mac_SF_Move('BASE::Business_Header_Stat','R',_m,3,false)
	
rollfiles := sequential(
	_a,_b,_c,_d,_e,_f,_g,_h,_i,_j,_k,_l,_m);
	

//keys themselves
business_header_ss.mac_AcceptSK('R',rollkeys,true,false)
	

sequential(
	rollfiles,
	rollkeys);


