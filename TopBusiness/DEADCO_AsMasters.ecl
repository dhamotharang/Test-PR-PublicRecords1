import InfoUSA,MDR;

export DEADCO_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := InfoUSA.File_Deadco_base_AID(abi_number != '' and company_name != '');
		
	export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := function
	
		extract_sub := normalize(base(subsidiary_parent_num != ''),2,
			transform(Layout_Relationship.Unlinked,
				self.source_1 := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,
				self.source_docid_1 := left.abi_number,
				self.source_party_1 := '',
				self.role_1 := 'SUBSIDIARY',
				self.source_2 := choose(counter,MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,'IA'),
				self.source_docid_2 := left.subsidiary_parent_num,
				self.source_party_2 := '',
				self.role_2 := 'SUBSIDIARY PARENT'));
				
		extract_ult := normalize(base(ultimate_parent_num != ''),2,
			transform(Layout_Relationship.Unlinked,
				self.source_1 := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,
				self.source_docid_1 := left.abi_number,
				self.source_party_1 := '',
				self.role_1 := 'SUBSIDIARY',
				self.source_2 := choose(counter,MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,'IA'),
				self.source_docid_2 := left.ultimate_parent_num,
				self.source_party_2 := '',
				self.role_2 := 'ULTIMATE PARENT'));
			
		return extract_sub + extract_ult;
	
	end;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base;
		
		extract_1 := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,
				self.source_docid := left.abi_number,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := left.company_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.append_rawaid,
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
				self.zip := left.zip5,
				self.zip4 := left.zip4,
				self.county_fips := left.ace_fips_county,
				self.msa := left.msa,
				self.phone := left.phone,
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		extract_2 := normalize(filtered(fax != ''),if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,
				self.source_docid := left.abi_number,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := left.company_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.FAX,
				self.aid := left.append_rawaid,
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
				self.zip := left.zip5,
				self.zip4 := left.zip4,
				self.county_fips := left.ace_fips_county,
				self.msa := left.msa,
				self.phone := left.fax,
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
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,
				self.source_docid := left.abi_number,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
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
				self.position_title := '',
				self.position_type := 'C';
				self.email := '',
				self.phone := ''			
				));
		
		return extract;
		
	end;

	export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := function

	    filtered := base(year_started != '');

			extract := project(filtered,
			  transform(Layout_Incorporation.unlinked,
				  self.source       := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,
				  self.source_docid := left.abi_number,
					self.source_party      := '',
 		      self.corp_state_origin         := '';
          self.corp_legal_name           := '';
				  self.corp_orig_sos_charter_nbr := '';
          self.corp_orig_bus_type_desc   := '';
          self.latest_filing_date        := '';
			    self.corp_status_desc          := 'INACTIVE'; // Used when calculating YearsInBusiness ???
				  self.corp_status_date          := '';
		      self.corp_foreign_domestic_ind := '';
					self.corp_foreign_state        := '';
					self.corp_structure            := '';
		      self.corp_for_profit_ind       := '';
				  self.corp_term_exist_exp       := '';
					self.start_date                := left.year_started + '0000';   // Used when calculating YearsInBusiness ???
					self.dt_vendor_last_reported   := left.dt_vendor_last_reported; // Used when calculating YearsInBusiness ???
          self.corp_key                  := '';
          self.record_type               := '';
				  self.event_filing_date         := '';
		      self.event_filing_desc         := '';
					));

			return extract;

	end;
	
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	   
		filtered := base(primary_sic != '');
		
		extract := normalize(filtered,
			map(
				left.secondary_sic_1 = '' => 1,
				left.secondary_sic_2 = '' => 2,
				left.secondary_sic_3 = '' => 3,
				left.secondary_sic_4 = '' => 4,
				/* otherwise */              5),
		  transform(Layout_Industry.Unlinked,
			  self.source       := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,
				self.source_docid := left.abi_number,
				self.source_party := '',
				self.SicCode      := choose(counter,  
					left.primary_sic,
					left.secondary_sic_1,
					left.secondary_sic_2,
					left.secondary_sic_3,
					left.secondary_sic_4);
				self.NAICS                := '';
				self.industry_description := ''; 
				));
				
		return extract;

	end;

	export dataset(Layout_Abstract.Unlinked) As_Abstract_Master := function

		filtered := base(industry_desc !='');
		
			extract := project(filtered,
			  transform(Layout_Abstract.unlinked,
			    self.source := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES,
				  self.source_docid := left.abi_number,
			    self.source_party := '',
				  // The industry_desc field does have industry info in it, but it also at times
				  // contains other non-industry related information about the company.
				  // So it was decided to put that type of info in the business_description field on
					// the layout_abstract instead of the industry_description on the layout_industry.
          self.business_description := left.industry_desc;
				));

			return extract;

	end;
	
end;
