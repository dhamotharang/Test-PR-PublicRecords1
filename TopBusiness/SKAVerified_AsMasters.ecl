import BusData,MDR;

export SKAVerified_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := BusData.File_SKA_Verified_Base((unsigned)id != 0 and (unsigned)persid != 0 and company_name != '');
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base;
		
		extract_1 := normalize(filtered,
			if(left.mail_v_city_name != left.mail_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_SKA,
				self.source_docid := left.id + '//' + left.persid,
				self.source_party := '',
				self.date_first_seen := (unsigned4)0,
				self.date_last_seen := (unsigned4)0,
				self.company_name := stringlib.StringToUpperCase(left.company_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.MAILING,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.mail_prim_range,
				self.predir := left.mail_predir,
				self.prim_name := left.mail_prim_name,
				self.addr_suffix := left.mail_addr_suffix,
				self.postdir := left.mail_postdir,
				self.unit_desig := left.mail_unit_desig,
				self.sec_range := left.mail_sec_range,
				self.city_name := choose(counter,
					left.mail_p_city_name,
					left.mail_v_city_name),
				self.state := left.mail_st,
				self.zip := left.mail_zip,
				self.zip4 := left.mail_zip4,
				self.county_fips := left.mail_county,
				self.msa := left.mail_msa,
				self.phone := left.phone,
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		extract_2 := normalize(filtered,
			if(left.alt_v_city_name != left.alt_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_SKA,
				self.source_docid := left.id + '//' + left.persid,
				self.source_party := '',
				self.date_first_seen := (unsigned4)0,
				self.date_last_seen := (unsigned4)0,
				self.company_name := stringlib.StringToUpperCase(left.company_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.alt_prim_range,
				self.predir := left.alt_predir,
				self.prim_name := left.alt_prim_name,
				self.addr_suffix := left.alt_addr_suffix,
				self.postdir := left.alt_postdir,
				self.unit_desig := left.alt_unit_desig,
				self.sec_range := left.alt_sec_range,
				self.city_name := choose(counter,
					left.alt_p_city_name,
					left.alt_v_city_name),
				self.state := left.alt_st,
				self.zip := left.alt_zip,
				self.zip4 := left.alt_zip4,
				self.county_fips := left.alt_county,
				self.msa := left.alt_msa,
				self.phone := left.phone,
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract_1 + extract_2;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		filtered := base(lname != '');
		
		extract := normalize(filtered,if(left.key_title != left.company_title,2,1),
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_SKA,
				self.source_docid := left.id + '//' + left.persid,
				self.source_party := '',
				self.date_first_seen := 0,
				self.date_last_seen := 0,
				self.ssn := '',
				self.did := 0,
				self.score := 0,
				self.name_prefix := left.title,
				self.name_first := left.fname,
				self.name_middle := left.mname,
				self.name_last := left.lname,
				self.name_suffix := left.name_suffix,
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
				self.position_title := stringlib.StringToUpperCase(choose(counter,
					left.company_title,
					left.key_title)),
				self.position_type := 'C';
				self.email := '',
				self.phone := '',			
				));
		
		return extract;
	
	end;
		
end;
