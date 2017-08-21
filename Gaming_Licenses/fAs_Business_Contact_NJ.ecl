import Business_Header, ut,address;

export fAs_Business_Contact_NJ(dataset(layouts.base.nj) pInputBase) :=
function

	layout_BH_contact 	:= Business_Header.Layout_Business_Contact_Full_New;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to Business Contact Layout
	//////////////////////////////////////////////////////////////////////////////////////////////
	layout_BH_contact tbusiness_contact(layouts.base.nj l) :=
	transform
	    		
	  self.vl_id			      := l.rawfields.RegistrationNumber;
		self.vendor_id			  := l.rawfields.RegistrationNumber;
		self.dt_first_seen		  := l.dt_first_seen;
		self.dt_last_seen		  := l.dt_last_seen;
		self.source               := Source_Codes.NJ;
		self.record_type          := l.record_type;
		self.from_hdr             := 'N';
		self.glb                  := false;
		self.dppa			      := false;
		self.company_title        := '';
		self.company_department   := '';
		self.title                := l.clean_name.title;
		self.fname                := l.clean_name.fname;
		self.mname				  := l.clean_name.mname;
		self.lname                := l.clean_name.lname;
		self.name_suffix          := l.clean_name.name_suffix;
		self.name_score           := Business_Header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
		self.prim_range           := L.Clean_address.prim_range;                   
		self.predir				  := L.Clean_address.predir;
		self.prim_name            := L.Clean_address.prim_name;
		self.addr_suffix          := L.Clean_address.addr_suffix;
		self.postdir              := L.Clean_address.postdir;
		self.unit_desig           := L.Clean_address.unit_desig;
		self.sec_range			  := L.Clean_address.sec_range;
		self.city                 := L.Clean_address.v_city_name;
		self.state                := L.Clean_address.st;
		self.zip                  := (UNSIGNED3)L.Clean_address.zip;
		self.zip4                 := (UNSIGNED2)L.Clean_address.zip4;
		self.county				  := L.Clean_address.fips_county;
		self.msa                  := L.Clean_address.msa;
		self.geo_lat              := L.Clean_address.geo_lat;
		self.geo_long             := L.Clean_address.geo_long;
		//self.phone                := (unsigned6)l.clean_phone; 
		self.email_address				:= '';
		self.ssn                  := 0;
		self.company_source_group := self.vendor_id;
		self.company_name         := l.rawfields.name;
		
		self.company_prim_range   := L.Clean_address.prim_range;
		self.company_predir		  := L.Clean_address.predir;
		self.company_prim_name    := L.Clean_address.prim_name;
		self.company_addr_suffix  := L.Clean_address.addr_suffix;
		self.company_postdir      := L.Clean_address.postdir;
		self.company_unit_desig   := L.Clean_address.unit_desig;
		self.company_sec_range	  := L.Clean_address.sec_range;
		self.company_city         := L.Clean_address.v_city_name;
		self.company_state        := L.Clean_address.st;
		self.company_zip          := (UNSIGNED3)L.Clean_address.zip;
		self.company_zip4         := (UNSIGNED2)L.Clean_address.zip4;
		//self.company_phone				:= self.phone;
		self.company_fein					:= 0;
		self := [];
	end;

	asbc := project( pInputBase(rawfields.name != ''),tbusiness_contact(LEFT));

	return	asbc( (integer)name_score < 2		//changed(lowered from 3) for this dataset after looking at the data
				 ,Business_Header.CheckPersonName(fname, mname, lname, name_suffix)
				 ,company_name				!= ''
				 ,ut.IsCompany(company_name)
				 ,prim_name					!= ''
				 ,company_prim_name	!= ''
				 ); 


end;