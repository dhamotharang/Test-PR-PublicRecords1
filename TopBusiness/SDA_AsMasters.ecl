import SDA_SDAA,MDR;

export SDA_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := SDA_SDAA.File_SDA_Base;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(vendor_id != '' and company_name != '');
		
		extract := project(filtered,
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_SDA,
				self.source_docid := left.vendor_id,
				self.source_party := 'C' + hash64(left.company_name),
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.company_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.company_rawaid,
				self.prim_range := left.company_prim_range,
				self.predir := left.company_predir,
				self.prim_name := left.company_prim_name,
				self.addr_suffix := left.company_addr_suffix,
				self.postdir := left.company_postdir,
				self.unit_desig := left.company_unit_desig,
				self.sec_range := left.company_sec_range,
				self.city_name := left.company_city,
				self.state := left.company_state,
				self.zip := if(left.company_zip = 0,'',intformat(left.company_zip,5,1)),
				self.zip4 := if(left.company_zip4 = 0,'',intformat(left.company_zip4,4,1)),
				self.county_fips := '',
				self.msa := left.msa,
				self.phone := if(left.company_phone = 0,'',intformat(left.company_phone,10,1)),
				self.fein := if(left.company_fein = 0,'',intformat(left.company_fein,9,1)),
				self.url := if(stringlib.StringFind(left.email_address,'@',1) > 0,left.email_address[stringlib.StringFind(left.email_address,'@',1) + 1..],''),
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		filtered := base(vendor_id != '' and lname != '');
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_SDA,
				self.source_docid := left.vendor_id,
				self.source_party := 'C' + hash64(left.company_name),
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.ssn := if(left.ssn = 0,'',intformat(left.ssn,9,1)),
				self.did := left.did,
				self.score := left.contact_score,
				self.name_prefix := left.title,
				self.name_first := left.fname,
				self.name_middle := left.mname,
				self.name_last := left.lname,
				self.name_suffix := left.name_suffix,
				self.prim_range := left.prim_range,
				self.predir := left.predir,
				self.prim_name := left.prim_name,
				self.addr_suffix := left.addr_suffix,
				self.postdir := left.postdir,
				self.unit_desig := left.unit_desig,
				self.sec_range := left.sec_range,
				self.city_name := left.city,
				self.state := left.state,
				self.zip := if(left.zip = 0,'',intformat(left.zip,5,1)),
				self.zip4 := if(left.zip4 = 0,'',intformat(left.zip4,4,1)),
				self.position_title := left.company_title,
				self.position_type := 'C';
				self.phone := if(left.phone = 0,'',intformat(left.phone,10,1)),
				self.email := left.email_address,			
			));
		
		return extract;
	
	end;

	export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := function
	
		filtered := base(vendor_id != '' and company_name != '');
		deduped := dedup(filtered,vendor_id,company_name,all);
		joinedup := join(deduped,deduped,
			left.vendor_id = right.vendor_id and
			left.company_name != right.company_name,
			transform(Layout_Relationship.Unlinked,
				self.source_1 := MDR.sourceTools.src_SDA,
				self.source_docid_1 := left.vendor_id,
				self.source_party_1 := 'C' + hash64(left.company_name),
				self.role_1 := 'BUSINESS RELATIVE',
				self.source_2 := MDR.sourceTools.src_SDA,
				self.source_docid_2 := right.vendor_id,
				self.source_party_2 := 'C' + hash64(right.company_name),
				self.role_2 := 'BUSINESS RELATIVE'));
		
		return joinedup;
	
	end;
	
end;
