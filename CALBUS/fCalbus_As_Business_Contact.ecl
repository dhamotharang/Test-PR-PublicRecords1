import Business_Header, ut,mdr,address;

export fCalbus_As_Business_Contact(dataset(Layouts_Calbus.Layout_Base) pBasefile) :=
function

	f := CALBUS.File_Calbus_Base;

	Business_Header.Layout_Business_Contact_Full_New Translate_CST_To_BCF(Layouts_Calbus.Layout_Base l) := transform
		self.source               := MDR.sourceTools.src_CA_Sales_Tax;          // Source file type
		self.vl_id                := 'CA' + l.ACCOUNT_NUMBER;
		self.vendor_id            := 'CA' + l.ACCOUNT_NUMBER;
		self.dt_first_seen        := (unsigned4)L.start_date;
		self.dt_last_seen         := (unsigned4)l.dt_last_seen;
		self.ssn                  := (unsigned6)l.ssn;
		self.title                := l.Owner_title;
		self.fname                := l.Owner_fname;
		self.mname                := l.Owner_mname;
		self.lname                := l.Owner_lname;
		self.name_suffix          := l.Owner_name_suffix;
		self.name_score           := l.Owner_name_score;
		self.prim_range           := l.Business_prim_range;
		self.predir               := l.Business_predir;
		self.prim_name            := l.Business_prim_name;
		self.addr_suffix          := l.Business_addr_suffix;
		self.postdir              := l.Business_postdir;
		self.unit_desig           := l.Business_unit_desig;
		self.sec_range            := l.Business_sec_range;
		self.city                 := l.Business_v_city_name;
		self.state                := l.Business_st;
		self.zip                  := (unsigned3)l.Business_zip5;
		self.zip4                 := (unsigned2)l.Business_zip4;
		self.county               := l.Business_fips_county;
		self.msa                  := l.Business_cbsa;
		self.geo_lat              := l.Business_geo_lat;
		self.geo_long             := l.Business_geo_long;
		self.phone                := 0;
		self.email_address        := '';
		self.company_title        := 'OWNER';
		self.company_source_group := 'CA' + l.ACCOUNT_NUMBER; // Source group
		self.company_name         := l.firm_name;
		self.company_prim_range   := l.Business_prim_range;
		self.company_predir       := l.Business_predir;
		self.company_prim_name    := l.Business_prim_name;
		self.company_addr_suffix  := l.Business_addr_suffix;
		self.company_postdir      := l.Business_postdir;
		self.company_unit_desig   := l.Business_unit_desig;
		self.company_sec_range    := l.Business_sec_range;
		self.company_city         := l.Business_v_city_name;
		self.company_state        := l.Business_st;
		self.company_zip          := (unsigned3)l.Business_zip5;
		self.company_zip4         := (unsigned2)l.Business_zip4;
		self.company_phone        := 0;
		self.record_type          := 'C';          // Current/Historical indicator
		self                      := l
	end;

	return project(f(owner_name <> '', firm_name <> '',
			   Address.Business.GetNameType(Owner_fname + ' ' + Owner_mname + ' ' + Owner_lname + ' ' + Owner_name_suffix) in ['P','D'] 
				 and datalib.CompanyClean(owner_name)[41..120] = '',
			   (integer)(Business_Header.CleanName(Owner_fname, Owner_mname, Owner_lname, Owner_name_suffix)[142]) < 3),
				   Translate_CST_To_BCF(left));

end;
