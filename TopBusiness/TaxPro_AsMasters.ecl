import TaxPro,MDR;

export TaxPro_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := TaxPro.File_Base;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(tmsid != '' and company != '');
		
		extract := normalize(filtered,
			if(left.addr.v_city_name != left.addr.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Tax_Practitioner,
				self.source_docid := left.tmsid,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.company),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.addr.prim_range,
				self.predir := left.addr.predir,
				self.prim_name := left.addr.prim_name,
				self.addr_suffix := left.addr.addr_suffix,
				self.postdir := left.addr.postdir,
				self.unit_desig := left.addr.unit_desig,
				self.sec_range := left.addr.sec_range,
				self.city_name := choose(counter,
					left.addr.p_city_name,
					left.addr.v_city_name),
				self.state := left.addr.st,
				self.zip := left.addr.zip5,
				self.county_fips := left.addr.fips_county,
				self.msa := '',
				self.phone := '',
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		filtered := base(tmsid != '' and name.lname != '');
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_Tax_Practitioner,
				self.source_docid := left.tmsid,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.ssn := left.ssn,
				self.name_prefix := left.name.title,
				self.name_first := left.name.fname,
				self.name_middle := left.name.mname,
				self.name_last := left.name.lname,
				self.name_suffix := left.name.name_suffix,
				self.prim_range := left.addr.prim_range,
				self.predir := left.addr.predir,
				self.prim_name := left.addr.prim_name,
				self.addr_suffix := left.addr.addr_suffix,
				self.postdir := left.addr.postdir,
				self.unit_desig := left.addr.unit_desig,
				self.sec_range := left.addr.sec_range,
				self.city_name := choose(counter,
					left.addr.p_city_name,
					left.addr.v_city_name),
				self.state := left.addr.st,
				self.zip := left.addr.zip5,
				self.zip4 := left.addr.zip4,
				self.position_title := left.occupation,
				self.position_type := 'C';
				self.email := '',
				self.phone := '',		
				));
		
		return extract;
	
	end;
		
end;
