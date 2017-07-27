import Zoom,MDR;

export Zoom_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := Zoom.Files().Base.QA;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(rawfields.zoomid != '' and rawfields.company_name != '');
		
		extract_1 := normalize(filtered,
			if(left.clean_company_address.v_city_name != left.clean_company_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Zoom,
				self.source_docid := trim(left.rawfields.zoomid),
				self.source_party := 'P' + hash64(left.rawfields.zoom_company_id,left.rawfields.company_name),
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.rawfields.company_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.raw_aid,
				self.prim_range := left.clean_company_address.prim_range,
				self.predir := left.clean_company_address.predir,
				self.prim_name := left.clean_company_address.prim_name,
				self.addr_suffix := left.clean_company_address.addr_suffix,
				self.postdir := left.clean_company_address.postdir,
				self.unit_desig := left.clean_company_address.unit_desig,
				self.sec_range := left.clean_company_address.sec_range,
				self.city_name := choose(counter,
					left.clean_company_address.p_city_name,
					left.clean_company_address.v_city_name),
				self.state := left.clean_company_address.st,
				self.zip := left.clean_company_address.zip,
				self.county_fips := left.clean_company_address.fips_county,
				self.msa := left.clean_company_address.msa,
				self.phone := left.clean_phones.company_phone,
				self.fein := '',
				self.url := left.rawfields.company_domain_name,
				self.duns := '',
				self.experian := '',
				self.zoom := left.rawfields.zoom_company_id,
				self.incorp_state := '',
				self.incorp_number := ''));
		
		extract_2 := normalize(filtered,
			if(left.clean_company_address.v_city_name != left.clean_company_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Zoom,
				self.source_docid := trim(left.rawfields.zoomid),
				self.source_party := 'P' + hash64(left.rawfields.zoom_company_id,left.rawfields.company_name),
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.rawfields.company_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.raw_aid,
				self.prim_range := left.clean_company_address.prim_range,
				self.predir := left.clean_company_address.predir,
				self.prim_name := left.clean_company_address.prim_name,
				self.addr_suffix := left.clean_company_address.addr_suffix,
				self.postdir := left.clean_company_address.postdir,
				self.unit_desig := left.clean_company_address.unit_desig,
				self.sec_range := left.clean_company_address.sec_range,
				self.city_name := choose(counter,
					left.clean_company_address.p_city_name,
					left.clean_company_address.v_city_name),
				self.state := left.clean_company_address.st,
				self.zip := left.clean_company_address.zip,
				self.county_fips := left.clean_company_address.fips_county,
				self.msa := left.clean_company_address.msa,
				self.phone := left.clean_phones.company_phone,
				self.fein := '',
				self.url := if(stringlib.StringFind(left.rawfields.email_address,'@',1) > 0,left.rawfields.email_address[stringlib.StringFind(left.rawfields.email_address,'@',1) + 1..],''),
				self.duns := '',
				self.experian := '',
				self.zoom := left.rawfields.zoom_company_id,
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract_1 + extract_2;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		filtered := base(rawfields.zoomid != '' and clean_contact_name.lname != '');
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_Zoom,
				self.source_docid := left.rawfields.zoomid,
				self.source_party := 'P' + hash64(left.rawfields.zoom_company_id,left.rawfields.company_name),
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.ssn := '',
				self.name_prefix := left.clean_contact_name.title,
				self.name_first := left.clean_contact_name.fname,
				self.name_middle := left.clean_contact_name.mname,
				self.name_last := left.clean_contact_name.lname,
				self.name_suffix := left.clean_contact_name.name_suffix,
				self.prim_range := '',
				self.predir := '',
				self.prim_name := '',
				self.addr_suffix := '',
				self.postdir := '',
				self.unit_desig := '',
				self.sec_range := '',
				self.city_name := '',
				self.state := '',
				self.zip := '',
				self.zip4 := '',
				self.position_title := stringlib.StringToUpperCase(left.rawfields.job_title),
				self.position_type := 'C';
				self.email := left.rawfields.email_address,
				self.phone := left.clean_phones.phone,
			
				));
		
		return extract;
	
	end;
		
	export dataset(Layout_URLs.Unlinked) As_URL_Master := function
	
		filtered := base(rawfields.zoomid != '' and rawfields.company_domain_name != '');
		
		extract := project(filtered,
			transform(Layout_URLs.Unlinked,
				self.source := MDR.sourceTools.src_Zoom,
				self.source_docid := left.rawfields.zoomid,
				self.source_party := 'P' + hash64(left.rawfields.zoom_company_id,left.rawfields.company_name),
				self.url := left.rawfields.company_domain_name));
		
		return extract;
	
	end;
	
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function

		filtered := base(rawfields.zoomid != '' and rawfields.industry_label != '');
		
		extract := normalize(filtered,if(left.rawfields.secondary_industry_label != '',2,1),
			transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_Zoom,
				self.source_docid := left.rawfields.zoomid,
				self.source_party := 'P' + hash64(left.rawfields.zoom_company_id,left.rawfields.company_name),
				self.siccode              := '';
				self.NAICS                := '';
        self.industry_description := choose(counter,left.rawfields.industry_label,left.rawfields.secondary_industry_label),
			));
		
		return extract;
	
	end;
	
end;
