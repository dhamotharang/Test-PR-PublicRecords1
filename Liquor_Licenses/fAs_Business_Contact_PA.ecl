import Business_Header, ut,address;

export fAs_Business_Contact_PA(dataset(layouts.base.pa) pInputBase) :=
function

	layout_BH_contact 	:= Business_Header.Layout_Business_Contact_Full_New;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to Business Contact Layout
	//////////////////////////////////////////////////////////////////////////////////////////////
	layout_BH_contact tbusiness_contact(layouts.base.pa l, unsigned4 cnt) :=
	transform

		title						:= choose(cnt, l.clean_person_name1.title				,l.clean_person_name2.title				,l.clean_person_name3.title				);
		fname						:= choose(cnt, l.clean_person_name1.fname				,l.clean_person_name2.fname				,l.clean_person_name3.fname 			);
		mname						:= choose(cnt, l.clean_person_name1.mname				,l.clean_person_name2.mname				,l.clean_person_name3.mname				);
		lname						:= choose(cnt, l.clean_person_name1.lname      	,l.clean_person_name2.lname				,l.clean_person_name3.lname				);
		name_suffix			:= choose(cnt, l.clean_person_name1.name_suffix	,l.clean_person_name2.name_suffix	,l.clean_person_name3.name_suffix	);

		company_name :=		if(l.clean_person_name1.lname = '',trim(l.rawfields.Licensee_NAME_1,left,right), '') + ' '
										+ if(l.clean_person_name2.lname = '',trim(l.rawfields.Licensee_NAME_2,left,right), '') + ' '
										+ if(l.clean_person_name3.lname = '',trim(l.rawfields.Licensee_NAME_3,left,right), '')
										;
	
		self.vl_id						    := trim(l.rawfields.License_Identification_Number,left,right)	;
		self.vendor_id						:= trim(l.rawfields.License_Identification_Number,left,right)	;
		self.dt_first_seen				:= l.dt_first_seen								;
		self.dt_last_seen					:= l.dt_last_seen									;
		self.source               := Source_Codes.pa								;
		self.record_type          := 'C'														;
		self.from_hdr             := 'N'														;
		self.glb                  := false													;
		self.dppa									:= false													;
		self.company_title        := ''															;
		self.company_department   := ''															;
		self.title                := title      										;
		self.fname                := fname      										;
		self.mname								:= mname													;
		self.lname                := lname      										;
		self.name_suffix          := name_suffix										;
		self.name_score           := Business_Header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
		self.prim_range           := L.Clean_Address.prim_range			;                   
		self.predir								:= L.Clean_Address.predir					;
		self.prim_name            := L.Clean_Address.prim_name			;
		self.addr_suffix          := L.Clean_Address.addr_suffix		;
		self.postdir              := L.Clean_Address.postdir				;
		self.unit_desig           := L.Clean_Address.unit_desig			;
		self.sec_range						:= L.Clean_Address.sec_range			;
		self.city                 := L.Clean_Address.v_city_name		;
		self.state                := L.Clean_Address.st							;
		self.zip                  := (UNSIGNED3)L.Clean_Address.zip	;
		self.zip4                 := (UNSIGNED2)L.Clean_Address.zip4;
		self.county								:= L.Clean_Address.fips_county		;
		self.msa                  := L.Clean_Address.msa						;
		self.geo_lat              := L.Clean_Address.geo_lat				;
		self.geo_long             := L.Clean_Address.geo_long				;
		self.phone                := 0															; 
		self.email_address				:= ''															;
		self.ssn                  := 0															;
		self.company_source_group := self.vendor_id									;
		self.company_name         := trim(company_name,left,right)	;									
		self.company_prim_range   := L.Clean_Address.prim_range			;
		self.company_predir				:= L.Clean_Address.predir					;
		self.company_prim_name    := L.Clean_Address.prim_name			;
		self.company_addr_suffix  := L.Clean_Address.addr_suffix		;
		self.company_postdir      := L.Clean_Address.postdir				;
		self.company_unit_desig   := L.Clean_Address.unit_desig			;
		self.company_sec_range		:= L.Clean_Address.sec_range			;
		self.company_city         := L.Clean_Address.v_city_name		;
		self.company_state        := L.Clean_Address.st							;
		self.company_zip          := (UNSIGNED3)L.Clean_Address.zip	;
		self.company_zip4         := (UNSIGNED2)L.Clean_Address.zip4;
		self.company_phone				:= 0															;
		self.company_fein					:= 0															;
	end;

	asbc := normalize(pInputBase, 3,tbusiness_contact(LEFT,counter));

	return	asbc((integer)name_score < 3
							,Business_Header.CheckPersonName(fname, mname, lname, name_suffix)
							,company_name != ''
					);

end;