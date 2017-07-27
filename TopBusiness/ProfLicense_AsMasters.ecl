import Prof_LicenseV2,MDR;

export ProfLicense_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := Prof_LicenseV2.File_ProfLic_Base;
	
	shared filtered := base(company_name != '' and lname = '' and prolic_seq_id != 0);
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
		
		extract := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Professional_License,
				self.source_docid := (string)left.prolic_seq_id,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := left.company_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.prim_range,
				self.predir := left.predir,
				self.prim_name := left.prim_name,
				self.addr_suffix := left.suffix,
				self.postdir := left.postdir,
				self.unit_desig := left.unit_desig,
				self.sec_range := left.sec_range,
				self.city_name := choose(counter,
					left.p_city_name,
					left.v_city_name),
				self.state := left.st,
				self.zip := left.zip,
				self.county_fips := left.county,
				self.msa := left.msa,
				self.phone := left.phone,
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
				self.source            := MDR.sourceTools.src_Professional_License,
				self.source_docid      := (string)left.prolic_seq_id,
				self.source_party      := '',
				self.license_state     := left.source_st;
				self.license_board     := left.profession_or_board;
				self.license_number    := left.license_number;
				self.license_type      := left.license_type;
				self.license_status    := left.status;
				self.issue_date        := left.issue_date;
				self.last_renewal_date := left.last_renewal_date;
				self.expiration_date   := left.expiration_date;
				self.company_name      := left.company_name;
				));		
		return extract;
		end;	
end;
