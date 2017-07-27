import business_header, ut,mdr;

rLayout_Plus
 :=
  record
	faa.layout_aircraft_registration_out;
	unsigned8 __fpos { virtual (fileposition)};
  end
 ;

export fFAA_aircraft_reg_as_business_header(dataset(rLayout_Plus) pFAA_Aircraft_Reg)
 :=
  function

	df := pFAA_Aircraft_Reg(compname != '');

	idrec := record
		df;
		unsigned4	rec_id := 0;
	end;

	df2 := table(df,idrec);

	ut.MAC_Sequence_Records(df2, rec_id, df3)

	business_header.Layout_Business_Header_New into_header(df3 L) := transform
		self.current := if (L.current_flag = 'C', true, false);
		self.zip := (integer)L.zip;
		self.source := MDR.sourceTools.src_Aircrafts;
		self.dt_first_seen := (integer)L.date_first_seen;
		self.dt_last_seen := (integer)L.date_last_seen;
		self.dt_vendor_first_reported := (integer)L.date_first_seen;
		self.dt_vendor_last_reported := (integer)L.date_last_seen;
		self.company_name := Stringlib.StringToUpperCase(L.compname);
		self.city := L.v_city_name;
		self.state := L.st;
		self.zip4 := (integer)L.z4;
		self.phone := 0;
		// there is no obvious choice for what to use for vendor_id....i'm trying to hit something
		// reasonably unique.  Same thing is also used in faa_aircraft_reg_as_business_contact
		self.vendor_id := L.name[1..6] + L.zip_code[1..5] + l.type_registrant + L.n_number;
		self.vl_id := '';
		self := L;
	end;

	o1 := project(df3,into_header(LEFT));

	return o1;
  end
 ;
