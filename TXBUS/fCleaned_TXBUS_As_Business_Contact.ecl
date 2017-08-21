IMPORT Business_Header, ut,mdr;

export fCleaned_TXBUS_As_Business_Contact(dataset(Layouts_Txbus.Layout_Base) pTXBUS)
 :=
  function

	Layout_Cleaned_TXBUS_Base := Layouts_Txbus.Layout_Base;

	Cleaned_TXBUS_Base := pTXBUS;

	Business_Header.Layout_Business_Contact_Full_New Translate_RA_To_BCF(Layout_Cleaned_TXBUS_Base l, unsigned1 c) := transform
	  self.source           := MDR.sourceTools.src_TXBUS;
		self.vl_id            := L.Taxpayer_Number;
	  self.vendor_id        := L.Taxpayer_Number; 
	  self.dt_first_seen    := (unsigned6) l.dt_first_seen;
	  self.dt_last_seen     := (unsigned6) l.dt_last_seen;
	  self.title            := l.Taxpayer_title;
	  self.fname            := l.Taxpayer_fname;
    self.mname            := l.Taxpayer_mname;
    self.lname            := l.Taxpayer_lname;
	  self.name_suffix      := l.Taxpayer_name_suffix;
	  self.name_score       := l.Taxpayer_name_score;
		
	  self.prim_range       := choose(c,l.Taxpayer_prim_range,  l.Outlet_prim_range);
	  self.predir           := choose(c,l.Taxpayer_predir, 	    l.Outlet_predir);
	  self.prim_name        := choose(c,l.Taxpayer_prim_name,   l.Outlet_prim_name);
	  self.addr_suffix      := choose(c,l.Taxpayer_addr_suffix, l.Outlet_addr_suffix);
	  self.postdir          := choose(c,l.Taxpayer_postdir,     l.Outlet_postdir);
	  self.unit_desig       := choose(c,l.Taxpayer_unit_desig,  l.Outlet_unit_desig);
	  self.sec_range        := choose(c,l.Taxpayer_sec_range, 	l.Outlet_sec_range);
	  self.city             := choose(c,l.Taxpayer_v_city_name, l.Outlet_v_city_name);
	  self.state            := choose(c,l.Taxpayer_st,		    l.Outlet_st);
	  self.zip              := (unsigned3)choose(c,l.Taxpayer_zip5, l.Outlet_zip5);
	  self.zip4             := (unsigned3)choose(c,l.Taxpayer_zip4, l.Outlet_zip4);
	  self.county           := choose(c,l.Taxpayer_fips_county,	l.Outlet_fips_county);
	  self.geo_lat          := choose(c,l.Taxpayer_geo_lat,	l.Outlet_geo_lat);
	  self.geo_long         := choose(c,l.Taxpayer_geo_long,l.Outlet_geo_long);
	  self.phone            := (unsigned6)choose(c,l.Taxpayer_Phone,l.Outlet_Phone);
	  self.ssn              := 0;
	  self.company_title        := l.Taxpayer_org_type_desc;
	  self.company_name         := choose(c,l.Taxpayer_Name,l.Outlet_Name);
	  self.company_source_group := L.Taxpayer_Number;
	  self.company_prim_range   := choose(c,l.Taxpayer_prim_range,l.Outlet_prim_range);
	  self.company_predir       := choose(c,l.Taxpayer_predir, 	    l.Outlet_predir);
	  self.company_prim_name    := choose(c,l.Taxpayer_prim_name,   l.Outlet_prim_name);
	  self.company_addr_suffix  := choose(c,l.Taxpayer_addr_suffix, l.Outlet_addr_suffix);
	  self.company_postdir      := choose(c,l.Taxpayer_postdir,     l.Outlet_postdir);
	  self.company_unit_desig   := choose(c,l.Taxpayer_unit_desig,  l.Outlet_unit_desig);
	  self.company_sec_range    := choose(c,l.Taxpayer_sec_range, 	l.Outlet_sec_range);
	  self.company_city         := choose(c,l.Taxpayer_v_city_name, l.Outlet_v_city_name);
	  self.company_state        := choose(c,l.Taxpayer_st,		    l.Outlet_st);
	  self.company_zip          := (unsigned3)choose(c,l.Taxpayer_zip5, l.Outlet_zip5);
	  self.company_zip4         := (unsigned3)choose(c,l.Taxpayer_zip4, l.Outlet_zip4);
	  self.company_phone        := (unsigned6)choose(c,l.Taxpayer_Phone,l.Outlet_Phone);
	  self.company_fein         := 0;
	  self.record_type          := 'C';
		self.from_hdr							:= 'N';
	  self                      := l;
	  self                      := [];
	end;


	Cleaned_TXBUS_Contact_Ra_Norm := normalize(Cleaned_TXBUS_Base,
											   2,Translate_RA_To_BCF(left, counter));

	Cleaned_TXBUS_Contact_Ra_Init := Cleaned_TXBUS_Contact_Ra_Norm(lname <> '', company_name <> '');

	Cleaned_TXBUS_Contact_Ra_Init_Filtered	:=	Cleaned_TXBUS_Contact_Ra_Init((integer)name_score < 3,
																					  Business_Header.CheckPersonName(fname, mname,lname,name_suffix)
																					 );

	return Cleaned_TXBUS_Contact_Ra_Init_Filtered; 
	
 end;
