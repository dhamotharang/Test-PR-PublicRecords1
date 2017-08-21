IMPORT Business_Header, ut,mdr;

Layout_outf := AMIDIR.Layout_AMIDIR_Base_BIP;

export fAMIDIR_As_Business_Contact(dataset(Layout_outf) pAMIDIR)
 :=
  function

	Cleaned_AMIDIR_Base := pAMIDIR;

	Business_Header.Layout_Business_Contact_Full_New Translate_RA_To_BCF(Cleaned_AMIDIR_Base l, unsigned1 c) := transform
	  self.bdid             := (unsigned6)l.bdid;
		self.did              := (unsigned6)l.did;
		self.source           := MDR.sourceTools.src_AMIDIR;
		self.vl_id            := l.key;
	  self.vendor_id        := l.Key;
	  self.dt_first_seen    := (unsigned4)l.Date_First_Seen;
	  self.dt_last_seen     := (unsigned4)l.Date_Last_Seen;
	  self.title            := choose(c,
										l.Physician_Name_Clean_title,
																		l.Office_Manager_Name_Clean_title);
	  self.fname            := choose(c,
										l.Physician_Name_Clean_fname,
																		l.Office_Manager_Name_Clean_fname);
	  self.mname            := choose(c,
										l.Physician_Name_Clean_mname,
																		l.Office_Manager_Name_Clean_mname);
	  self.lname            := choose(c,
										l.Physician_Name_Clean_lname,
																		l.Office_Manager_Name_Clean_lname);
	  self.name_suffix      := choose(c,
										l.Physician_Name_Clean_name_suffix,
																		l.Office_Manager_Name_Clean_name_suffix);
	  self.name_score       := choose(c,
										Business_Header.CleanName(l.Physician_Name_Clean_fname,
																								  l.Physician_Name_Clean_mname,
																															l.Physician_Name_Clean_lname,
																															l.Physician_Name_Clean_name_suffix)[142],
									  Business_Header.CleanName(l.Office_Manager_Name_Clean_fname,
																								  l.Office_Manager_Name_Clean_mname,
																															l.Office_Manager_Name_Clean_lname,
																															l.Office_Manager_Name_Clean_name_suffix)[142]);
	  self.email_address        := '';
	  self.prim_range           := l.Business_Address_Clean_prim_range;
	  self.predir               := l.Business_Address_Clean_predir;
	  self.prim_name            := l.Business_Address_Clean_prim_name;
	  self.addr_suffix          := l.Business_Address_Clean_addr_suffix;
	  self.postdir              := l.Business_Address_Clean_postdir;
	  self.unit_desig           := l.Business_Address_Clean_unit_desig;
	  self.sec_range            := l.Business_Address_Clean_sec_range;
	  self.city                 := l.Business_Address_Clean_v_city_name;
	  self.state                := l.Business_Address_Clean_st; 
	  self.zip                  := (unsigned3)l.Business_Address_Clean_zip;
	  self.zip4                 := (unsigned2)l.Business_Address_Clean_zip4; 
	  self.county               := '';
	  self.msa                  := '';
	  self.geo_lat              := '';
	  self.geo_long             := '';
	  self.phone                := 0;
	  self.ssn                  := (unsigned4)l.ssn;
	  self.company_title        := choose(c,
											'Physician',
																			'Office Manager');
	  self.company_name         := l.Business_Name;
	  self.company_source_group := l.Key;
	  self.company_prim_range   := l.Business_Address_Clean_prim_range;
	  self.company_predir       := l.Business_Address_Clean_predir;
	  self.company_prim_name    := l.Business_Address_Clean_prim_name;
	  self.company_addr_suffix  := l.Business_Address_Clean_addr_suffix;
	  self.company_postdir      := l.Business_Address_Clean_postdir;
	  self.company_unit_desig   := l.Business_Address_Clean_unit_desig;
	  self.company_sec_range    := l.Business_Address_Clean_sec_range;
	  self.company_city         := l.Business_Address_Clean_v_city_name;
	  self.company_state        := l.Business_Address_Clean_st;
	  self.company_zip          := (unsigned3)l.Business_Address_Clean_zip;
	  self.company_zip4         := (unsigned2)l.Business_Address_Clean_zip4;
	  self.company_phone        := (unsigned6)l.Business_Phone;
	  self.company_fein         := 0;
	  self.record_type          := 'C';
	  //self                      := l;
	end;

	Cleaned_AMIDIR_Contact_Ra_Norm := normalize(Cleaned_AMIDIR_Base,
												2,
																							Translate_RA_To_BCF(left, counter));

	Cleaned_AMIDIR_Contact_Ra_Init := Cleaned_AMIDIR_Contact_Ra_Norm(lname <> '', company_name <> '');
	
	Cleaned_AMIDIR_Contact_Ra_Init_Filtered	:=	Cleaned_AMIDIR_Contact_Ra_Init((integer)name_score < 3,
																			   Business_Header.CheckPersonName(fname,mname,lname,name_suffix));

	return Cleaned_AMIDIR_Contact_Ra_Init_Filtered;
  end
 ;
