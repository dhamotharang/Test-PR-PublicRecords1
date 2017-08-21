import Business_Header, ut,address;

export fAs_Business_Contact_LA(

	dataset(layouts.base.LA) pInputBase = files().base.LA.qa

) :=
function

	layout_BH_contact 	:= Business_Header.Layout_Business_Contact_Full_New;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to Business Contact Layout
	//////////////////////////////////////////////////////////////////////////////////////////////
	layout_BH_contact tbusiness_contact(layouts.base.LA l) :=
	transform

		self.vl_id						    := trim(l.rawfields.FORMATTEDCREDENTIAL,left,right);
		self.vendor_id						:= trim(l.rawfields.FORMATTEDCREDENTIAL,left,right);
		self.dt_first_seen				:= l.dt_first_seen;
		self.dt_last_seen					:= l.dt_last_seen;
		self.source               := Source_Codes.LA;
		self.record_type          := 'C';
		self.from_hdr             := 'N';
		self.glb                  := false;
		self.dppa									:= false;
		self.company_title        := 'Owner';
		self.company_department   := '';
		self.title                := l.clean_owner_name.title				;
		self.fname                := l.clean_owner_name.fname      	;
		self.mname								:= l.clean_owner_name.mname				;
		self.lname                := l.clean_owner_name.lname      	;
		self.name_suffix          := l.clean_owner_name.name_suffix	;
		self.name_score           := Business_Header.CleanName(self.fname,self.mname			,self.lname,self.name_suffix)[142];
		self.prim_range           := L.Clean_owner_address.prim_range				;                   
		self.predir								:= L.Clean_owner_address.predir						;
		self.prim_name            := L.Clean_owner_address.prim_name				;
		self.addr_suffix          := L.Clean_owner_address.addr_suffix			;
		self.postdir              := L.Clean_owner_address.postdir					;
		self.unit_desig           := L.Clean_owner_address.unit_desig				;
		self.sec_range						:= L.Clean_owner_address.sec_range				;
		self.city                 := L.Clean_owner_address.v_city_name			;
		self.state                := L.Clean_owner_address.st								;
		self.zip                  := (UNSIGNED3)L.Clean_owner_address.zip		;
		self.zip4                 := (UNSIGNED2)L.Clean_owner_address.zip4	;
		self.county								:= L.Clean_owner_address.fips_county			;
		self.msa                  := L.Clean_owner_address.msa							;
		self.geo_lat              := L.Clean_owner_address.geo_lat					;
		self.geo_long             := L.Clean_owner_address.geo_long					;
		self.phone                := 0; 
		self.email_address				:= '';
		self.ssn                  := 0;
		self.company_source_group := self.vendor_id;
		self.company_name         := l.rawfields.TradeName;
		self.company_prim_range   := L.Clean_trade_address.prim_range			;
		self.company_predir				:= L.Clean_trade_address.predir					;
		self.company_prim_name    := L.Clean_trade_address.prim_name			;
		self.company_addr_suffix  := L.Clean_trade_address.addr_suffix		;
		self.company_postdir      := L.Clean_trade_address.postdir				;
		self.company_unit_desig   := L.Clean_trade_address.unit_desig			;
		self.company_sec_range		:= L.Clean_trade_address.sec_range			;
		self.company_city         := L.Clean_trade_address.v_city_name		;
		self.company_state        := L.Clean_trade_address.st							;
		self.company_zip          := (UNSIGNED3)L.Clean_trade_address.zip	;
		self.company_zip4         := (UNSIGNED2)L.Clean_trade_address.zip4;
		self.company_phone				:= self.phone;
		self.company_fein					:= 0;
	end;

	asbc := project(pInputBase(clean_owner_name.lname != '')
										,tbusiness_contact(LEFT)
					);

	return	asbc(
							 (integer)name_score < 2		//changed(lowered from 3) for this dataset after looking at the data
							,Business_Header.CheckPersonName(fname, mname, lname, name_suffix)
							,lname							!= ''
							,company_name				!= ''
							,prim_name					!= ''
							,company_prim_name	!= ''
					);

end;