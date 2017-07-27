import DEA,MDR;

export DEA_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := DEA.File_DEA_Modified;
	
	shared filtered := base(is_company_flag);
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
		
		extract := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_DEA,
				self.source_docid := left.dea_registration_number,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.date_first_reported,
				self.date_last_seen := (unsigned4)left.date_last_reported,
				self.company_name := left.cname,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.prim_range,
				self.predir := left.predir,
				self.prim_name := left.prim_name,
				self.addr_suffix := left.addr_suffix,
				self.postdir := left.postdir,
				self.unit_desig := left.unit_desig,
				self.sec_range := left.sec_range,
				self.city_name := choose(counter,
					left.p_city_name,
					left.v_city_name),
				self.state := left.st,
				self.zip := left.zip,
				self.county_fips := left.county[3..5],
				self.msa := left.msa,
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
	
	export dataset(Layout_License.Unlinked) As_License_Master := function
		
		extract := project(filtered,
			transform(Layout_License.Unlinked,
				self.source            := MDR.sourceTools.src_DEA,
				self.source_docid      := left.dea_registration_number,
				self.source_party      := '',
				self.license_state     := '',
				self.license_board     := 'US DEA',
				self.license_number    := left.dea_registration_number;
				self.license_type      := left.drug_schedules;
				self.license_status    := '',
				self.issue_date        := '';
				self.last_renewal_date := '';
				self.expiration_date   := left.expiration_date;
				self.company_name      := left.cname;
				));		
		return extract;
	end;	

	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source            := MDR.sourceTools.src_DEA,
				self.source_docid      := left.dea_registration_number,
				self.source_party      := '',
				self.date_first_seen   := (unsigned4)left.date_first_reported,
				self.date_last_seen    := (unsigned4)left.date_last_reported,
				self.name_prefix       := left.title,
				self.name_first        := left.fname,
				self.name_middle       := left.mname,
				self.name_last         := left.lname,
				self.name_suffix       := left.name_suffix,
				self.position_title    := 'DEA License Contact',
				self := []));
		
		return extract(name_last != '');
	
	end;
	
end;
