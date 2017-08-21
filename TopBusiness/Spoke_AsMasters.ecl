import Spoke,MDR;

export Spoke_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := Spoke.Files(,true).Base.QA;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(rawfields.company_name != '');
		
		extract := normalize(filtered,
			if(left.clean_company_address.v_city_name != left.clean_company_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Spoke,
				self.source_docid := (string)hash64(
					left.rawfields.first_name,
					left.rawfields.last_name,
					left.rawfields.job_title,
					left.rawfields.company_name,
					left.rawfields.company_street_address,
					left.rawfields.company_city,
					left.rawfields.company_state,
					left.rawfields.company_postal_code,
					left.rawfields.company_phone_number,
					left.rawfields.company_annual_revenue,
					left.rawfields.company_business_description),
				self.source_party := '',
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
				self.zip4 := left.clean_company_address.zip4,
				self.county_fips := left.clean_company_address.fips_county,
				self.msa := left.clean_company_address.msa,
				self.phone := left.clean_phones.company_phone_number,
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
	
		filtered := base(clean_contact_name.lname != '');
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_Spoke,
				self.source_docid := (string)hash64(
					left.rawfields.first_name,
					left.rawfields.last_name,
					left.rawfields.job_title,
					left.rawfields.company_name,
					left.rawfields.company_street_address,
					left.rawfields.company_city,
					left.rawfields.company_state,
					left.rawfields.company_postal_code,
					left.rawfields.company_phone_number,
					left.rawfields.company_annual_revenue,
					left.rawfields.company_business_description),
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.ssn := '',
				self.did := left.did,
				self.score := left.did_score,
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
				self.position_title := left.rawfields.job_title,
				self.position_type := 'C';
				self.email := '',
				self.phone := ''			
				));
		
		return extract;
	
	end;

	export dataset(Layout_Abstract.Unlinked) As_Abstract_Master := function
	
		filtered := base(rawfields.company_business_description != '');
		
		extract := project(filtered,
			transform(Layout_Abstract.Unlinked,
				self.source := MDR.sourceTools.src_Spoke,
				self.source_docid := (string)hash64(
					left.rawfields.first_name,
					left.rawfields.last_name,
					left.rawfields.job_title,
					left.rawfields.company_name,
					left.rawfields.company_street_address,
					left.rawfields.company_city,
					left.rawfields.company_state,
					left.rawfields.company_postal_code,
					left.rawfields.company_phone_number,
					left.rawfields.company_annual_revenue,
					left.rawfields.company_business_description),
				self.source_party := '',
			  // The company_business_description field does have industry info in it, but it 
				// also at times contains other non-industry related information about the company.
				// So it was decided to put that type of info in the business_description 
				// field on the layout_abstract instead of on the layout_industry.
				self.business_description := stringlib.StringToUpperCase(left.rawfields.company_business_description),
      ));
		
		return extract;
	
	end;

	export dataset(Layout_Finance.Unlinked) As_Finance_Master := function
	
		filtered := base(rawfields.company_annual_revenue != '');
		
		extract := project(filtered,
			transform(Layout_Finance.Unlinked,
				self.source := MDR.sourceTools.src_Spoke,
				self.source_docid := (string)hash64(
					left.rawfields.first_name,
					left.rawfields.last_name,
					left.rawfields.job_title,
					left.rawfields.company_name,
					left.rawfields.company_street_address,
					left.rawfields.company_city,
					left.rawfields.company_state,
					left.rawfields.company_postal_code,
					left.rawfields.company_phone_number,
					left.rawfields.company_annual_revenue,
					left.rawfields.company_business_description),
				self.source_party := '',
				self.revenue := (unsigned)left.rawfields.company_annual_revenue,
				self.annualsalesrevisiondate := if(left.clean_dates.validation_date = 0,'',intformat(left.clean_dates.validation_date,8,1)),
				self := []));
		
		return extract;
	
	end;
		
end;
