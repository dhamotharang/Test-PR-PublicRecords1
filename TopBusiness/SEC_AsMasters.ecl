import govdata,MDR;

export SEC_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := govdata.File_SEC_Broker_Dealer_BDID;
	
	shared filtered := base(cik_number != '' and (unsigned)is_company_flag != 0);
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
		
		extract := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_SEC_Broker_Dealer,
				self.source_docid := left.cik_number,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_first_reported,
				self.date_last_seen := (unsigned4)left.dt_last_reported,
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
				self.county_fips := left.county,
				self.msa := left.msa,
				self.phone := '',
				self.fein := left.irs_taxpayer_id,
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
				self.source            := MDR.sourceTools.src_SEC_Broker_Dealer,
				self.source_docid      := left.cik_number,
				self.source_party      := '',
				self.license_state     := '',
				self.license_board     := 'US Securities & Exchange Commission',
				self.license_number    := left.cik_number;
				self.license_type      := 'Securities Broker/Dealer';
				self.license_status    := '',
				self.issue_date        := '';
				self.last_renewal_date := '';
				self.expiration_date   := '';
				self.company_name      := left.cname;
				));		
		return extract;
	end;	

end;
