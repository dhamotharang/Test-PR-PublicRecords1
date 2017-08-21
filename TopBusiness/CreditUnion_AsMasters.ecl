import Credit_Unions,MDR;

export CreditUnion_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := Credit_Unions.Files(,true).Base.QA;
	
	shared filtered := base(rawfields.charter != '');
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
		
		extract := normalize(filtered,if(left.clean_address.v_city_name != left.clean_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Credit_Unions,
				self.source_docid := left.rawfields.charter,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_vendor_first_reported,
				self.date_last_seen := (unsigned4)left.dt_vendor_last_reported,
				self.company_name := left.rawfields.cu_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.raw_aid,
				self.prim_range := left.clean_address.prim_range,
				self.predir := left.clean_address.predir,
				self.prim_name := left.clean_address.prim_name,
				self.addr_suffix := left.clean_address.addr_suffix,
				self.postdir := left.clean_address.postdir,
				self.unit_desig := left.clean_address.unit_desig,
				self.sec_range := left.clean_address.sec_range,
				self.city_name := choose(counter,
					left.clean_address.p_city_name,
					left.clean_address.v_city_name),
				self.state := left.clean_address.st,
				self.zip := left.clean_address.zip,
				self.zip4 := left.clean_address.zip4,
				self.county_fips := left.clean_address.fips_county,
				self.msa := left.clean_address.msa,
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
	
		extract := project(filtered(clean_contact_name.lname != ''),
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_Credit_Unions,
				self.source_docid := left.rawfields.charter,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_vendor_first_reported,
				self.date_last_seen := (unsigned4)left.dt_vendor_last_reported,
				self.name_prefix := left.clean_contact_name.title,
				self.name_first := left.clean_contact_name.fname,
				self.name_middle := left.clean_contact_name.mname,
				self.name_last := left.clean_contact_name.lname,
				self.name_suffix := left.clean_contact_name.name_suffix,
				self.did := left.did,
				self.score := left.did_score,
				self := []));
		
		return extract;
	
	end;
	
end;
