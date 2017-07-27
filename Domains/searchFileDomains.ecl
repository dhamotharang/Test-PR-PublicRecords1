import domains, ut, address;

   f := Domains.File_Whois_Base; 

  Layout_Searchfile := RECORD (domains.layout_whois_base)
	  unsigned6 internetservices_id;
		string30 admin_fname;
		string30 admin_mname;
		string50 admin_lname;
		string30 tech_fname;
		string30 tech_mname;
		string50 tech_lname;
		string30 registrant_fname;
		string30 registrant_mname;
		string50 registrant_lname;
		STRING10 registrant_prim_range;
		STRING2  registrant_predir;
		STRING28 registrant_prim_name;
		STRING4  registrant_suffix;
		STRING2  registrant_postdir;
		STRING10 registrant_unit_desig;
		STRING8  registrant_sec_range;
		STRING25 registrant_p_city_name;
		STRING25 registrant_v_city_name;
		STRING2  registrant_state;
		STRING5  registrant_zip;
	END;
	
 
	
	layout_searchFile xform(Layout_Whois_Base l) := transform
	
		RegistrantName := Address.CleanNameFields(Address.CleanPerson73(l.registrant_name));
		TechName := Address.CleanNameFields(Address.CleanPerson73(l.tech_name));
		AdminName := Address.CleanNameFields(Address.CleanPerson73(l.admin_name));
			  // admin and tech address fields already parsed in the data no need to run through cleaner
				// no so with registrantAddr
    unsigned1 region := address.Components.Country.US;				
		RegistrantAddr := Address.GetCleanAddress(l.registrant_address1, 
	                                               l.registrant_address2, region).results;
																								 																								
	  self.tech_fname             := TechName.fname,
		self.tech_mname             := TechName.mname,
		self.tech_lname             := TechName.lname,
		self.admin_fname            := AdminName.fname,
		self.admin_mname            := AdminName.mname,
		self.admin_lname            := AdminName.lname,
    self.registrant_fname       := Stringlib.StringToUpperCase(registrantName.fname),
		self.registrant_mname       := Stringlib.StringToUpperCase(registrantName.mname),
		self.registrant_lname       := Stringlib.StringToUpperCase(registrantName.lname),
		self.registrant_prim_range  := Stringlib.StringToUpperCase(registrantAddr.prim_range),
		self.registrant_predir      := Stringlib.StringToUpperCase(registrantAddr.predir),
		self.registrant_prim_name   := Stringlib.StringToUpperCase(registrantAddr.prim_name),
		self.registrant_suffix      := Stringlib.StringToUpperCase(registrantAddr.suffix),
		self.registrant_postdir     := Stringlib.StringToUpperCase(registrantAddr.postdir),
		self.registrant_unit_desig  := Stringlib.StringToUpperCase(registrantAddr.unit_desig),
		self.registrant_sec_range   := Stringlib.StringToUpperCase(registrantAddr.sec_range),
		self.registrant_p_city_name := Stringlib.StringToUpperCase(registrantAddr.p_city),
		self.registrant_v_city_name := Stringlib.StringToUpperCase(registrantAddr.v_city),
		self.registrant_state       := Stringlib.StringToUpperCase(registrantAddr.state),
		self.registrant_zip         := Stringlib.StringToUpperCase(registrantAddr.zip),
		self.internetservices_id := 0;
	  self := l;		
	end;
	
	f_final := project(f, xform(left));
	
ut.MAC_Sequence_Records_NewRec(f_final,Layout_Searchfile,internetservices_id,outf);

export searchfileDomains := outf : PERSIST('persist::internetservices_searchfile');