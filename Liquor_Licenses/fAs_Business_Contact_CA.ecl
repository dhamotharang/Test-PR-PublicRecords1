import Business_Header, ut,address;

export fAs_Business_Contact_CA(dataset(layouts.base.ca) pInputBase) :=
function

	layout_BH_contact 	:= Business_Header.Layout_Business_Contact_Full_New;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to Business Contact Layout
	//////////////////////////////////////////////////////////////////////////////////////////////
	layout_BH_contact tbusiness_contact(layouts.base.ca l, unsigned2 cnt) :=
	transform
	  self.vl_id						    := trim(l.rawfields.FILE_NUMBER,left,right);
		self.vendor_id						:= trim(l.rawfields.FILE_NUMBER,left,right);
		self.dt_first_seen				:= l.dt_first_seen;
		self.dt_last_seen					:= l.dt_last_seen;
		self.source               := Source_Codes.CA;
		self.record_type          := 'C';
		self.from_hdr             := 'N';
		self.glb                  := false;
		self.dppa									:= false;
		self.company_title        := '';
		self.company_department   := '';
		self.title                := l.clean_primary_name.title      	;
		self.fname                := l.clean_primary_name.fname      	;
		self.mname								:= l.clean_primary_name.mname				;
		self.lname                := l.clean_primary_name.lname      	;
		self.name_suffix          := l.clean_primary_name.name_suffix	;
		self.name_score           := Business_Header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
		self.prim_range           := if(cnt between 1 and 2,L.Clean_location_address.prim_range			,L.Clean_mailing_address.prim_range				);                   
		self.predir								:= if(cnt between 1 and 2,L.Clean_location_address.predir					,L.Clean_mailing_address.predir						);
		self.prim_name            := if(cnt between 1 and 2,L.Clean_location_address.prim_name			,L.Clean_mailing_address.prim_name				);
		self.addr_suffix          := if(cnt between 1 and 2,L.Clean_location_address.addr_suffix		,L.Clean_mailing_address.addr_suffix			);
		self.postdir              := if(cnt between 1 and 2,L.Clean_location_address.postdir				,L.Clean_mailing_address.postdir					);
		self.unit_desig           := if(cnt between 1 and 2,L.Clean_location_address.unit_desig			,L.Clean_mailing_address.unit_desig				);
		self.sec_range						:= if(cnt between 1 and 2,L.Clean_location_address.sec_range			,L.Clean_mailing_address.sec_range				);
		self.city                 := if(cnt between 1 and 2,L.Clean_location_address.v_city_name		,L.Clean_mailing_address.v_city_name			);
		self.state                := if(cnt between 1 and 2,L.Clean_location_address.st							,L.Clean_mailing_address.st								);
		self.zip                  := if(cnt between 1 and 2,(UNSIGNED3)L.Clean_location_address.zip	,(UNSIGNED3)L.Clean_mailing_address.zip		);
		self.zip4                 := if(cnt between 1 and 2,(UNSIGNED2)L.Clean_location_address.zip4,(UNSIGNED2)L.Clean_mailing_address.zip4	);
		self.county								:= if(cnt between 1 and 2,L.Clean_location_address.fips_county		,L.Clean_mailing_address.fips_county			);
		self.msa                  := if(cnt between 1 and 2,L.Clean_location_address.msa						,L.Clean_mailing_address.msa							);
		self.geo_lat              := if(cnt between 1 and 2,L.Clean_location_address.geo_lat				,L.Clean_mailing_address.geo_lat					);
		self.geo_long             := if(cnt between 1 and 2,L.Clean_location_address.geo_long				,L.Clean_mailing_address.geo_long					);
		self.phone                := 0; 
		self.email_address				:= '';
		self.ssn                  := 0;
		self.company_source_group := self.vendor_id;
		self.company_name         := l.rawfields.DBA_NAME;
		self.company_prim_range   := if(cnt % 2 = 0,L.Clean_mailing_address.prim_range			,L.Clean_location_address.prim_range			);
		self.company_predir				:= if(cnt % 2 = 0,L.Clean_mailing_address.predir					,L.Clean_location_address.predir					);
		self.company_prim_name    := if(cnt % 2 = 0,L.Clean_mailing_address.prim_name				,L.Clean_location_address.prim_name				);
		self.company_addr_suffix  := if(cnt % 2 = 0,L.Clean_mailing_address.addr_suffix			,L.Clean_location_address.addr_suffix			);
		self.company_postdir      := if(cnt % 2 = 0,L.Clean_mailing_address.postdir					,L.Clean_location_address.postdir					);
		self.company_unit_desig   := if(cnt % 2 = 0,L.Clean_mailing_address.unit_desig			,L.Clean_location_address.unit_desig			);
		self.company_sec_range		:= if(cnt % 2 = 0,L.Clean_mailing_address.sec_range				,L.Clean_location_address.sec_range				);
		self.company_city         := if(cnt % 2 = 0,L.Clean_mailing_address.v_city_name			,L.Clean_location_address.v_city_name			);
		self.company_state        := if(cnt % 2 = 0,L.Clean_mailing_address.st							,L.Clean_location_address.st							);
		self.company_zip          := if(cnt % 2 = 0,(UNSIGNED3)L.Clean_mailing_address.zip	,(UNSIGNED3)L.Clean_location_address.zip	);
		self.company_zip4         := if(cnt % 2 = 0,(UNSIGNED2)L.Clean_mailing_address.zip4	,(UNSIGNED2)L.Clean_location_address.zip4	);
		self.company_phone				:= 0;
		self.company_fein					:= 0;
	end;

	asbc := normalize(pInputBase, 4, tbusiness_contact(LEFT,counter));

	return	asbc((integer)name_score < 3
							,Business_Header.CheckPersonName(fname, mname, lname, name_suffix)
							,company_name != ''
					);

end;