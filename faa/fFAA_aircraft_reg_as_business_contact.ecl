import business_header,mdr;

rLayout_Plus
 :=
  record
	faa.layout_aircraft_registration_out;
	unsigned8 __fpos { virtual (fileposition)};
  end
 ;

export fFAA_aircraft_reg_as_business_contact(dataset(rLayout_Plus) pFAA_Aircraft_Reg)
 :=
  function

	df := pFAA_Aircraft_Reg;

	Business_Header.Layout_Business_Contact_Full_New into_contact(df L) := transform
		self.zip := (integer)L.zip;
		self.dt_first_seen := (integer)L.date_first_seen;
		self.dt_last_seen := (integer)L.date_last_Seen;
		self.source := MDR.sourceTools.src_Aircrafts;
		self.record_type := L.current_flag;
		self.vl_id := '';
		// there is no obvious choice for what to use for vendor_id....i'm trying to hit something
		// reasonably unique.  Same thing is also used in faa_aircraft_reg_as_business_header
		self.vendor_id := L.name[1..6] + L.zip_code[1..5] + l.type_registrant + L.n_number;
		self.company_title := '';
		self.name_score := Business_Header.CleanName(L.fname, L.mname, L.lname, L.name_suffix)[142];  
		self.zip4 := (integer)l.z4;
		self.phone := 0;
		self.email_address := '';
		self.city := L.v_city_name;
		self.state := L.st;
		self.company_name := stringlib.stringtouppercase(L.compname);
		self.company_prim_range := L.prim_range;
		self.company_predir := l.predir;
		self.company_prim_name := L.prim_name;
		self.company_addr_suffix := L.addr_suffix;
		self.company_postdir := L.postdir;
		self.company_unit_desig := L.unit_desig;
		self.company_sec_range := L.sec_range;
		self.company_city := L.v_city_name;
		self.company_state := L.st;
		self.company_zip := (integer)L.zip;
		self.company_zip4 := (integer)L.z4;
		self.company_phone := 0;
		self := L;
	end;

	o1 := project(df,into_contact(LEFT));

	o1_filtered	:=	o1((integer)name_score < 3);
	
	return o1;

  end
 ;
 