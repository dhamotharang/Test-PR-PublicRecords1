import Gaming_Licenses,MDR;

export GamingLicenses_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
		
		extract := normalize(Gaming_Licenses.Files().Base.NJ.QA(clean_name.lname = '' and rawfields.registrationnumber != ''),if(left.clean_address.v_city_name != left.clean_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_NJ_Gaming_Licenses,
				self.source_docid := left.rawfields.registrationnumber,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := left.rawfields.name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
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
	
	export dataset(Layout_License.Unlinked) As_License_Master := function
		
		extract := project(Gaming_Licenses.Files().Base.NJ.QA(clean_name.lname = '' and rawfields.registrationnumber != ''),
			transform(Layout_License.Unlinked,
				self.source            := MDR.sourceTools.src_NJ_Gaming_Licenses,
				self.source_docid      := left.rawfields.registrationnumber,
				self.source_party      := '',
				self.license_state     := 'NJ',
				self.license_board     := 'Gaming',
				self.license_number    := left.rawfields.registrationnumber;
				self.license_type      := left.rawfields.professionid;
				self.license_status    := left.rawfields.status,
				self.issue_date        := if(left.clean_dates.issuedate = 0,'',(string)left.clean_dates.issuedate),
				self.last_renewal_date := if(left.clean_dates.datelastrenewal = 0,'',(string)left.clean_dates.datelastrenewal);
				self.expiration_date   := if(left.clean_dates.expireddate = 0,'',(string)left.clean_dates.expireddate);
				self.company_name      := left.rawfields.name;
				));		
		return extract;
	end;	

end;
