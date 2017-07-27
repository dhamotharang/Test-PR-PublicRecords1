import InfoUSA;

export IDEXEC_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	// shared base := InfoUSA.File_ABIUS_Company_Base(abi_number != '' and company_name != '');

	// shared base := InfoUSA.File_IDEXEC_Base(??? != '' and firm_name != ''); ???
		
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base;
		
		extract_1 := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := 'IA',
				self.source_docid := left.abi_number,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.company_name := left.company_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
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
				self.zip := left.z5,
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
				self.source := 'IA',
				self.source_docid := left.abi_number,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.company_name := left.company_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.FAX,
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
				self.zip := left.z5,
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
				self.source := 'IA',
				self.source_docid := left.abi_number,
				self.source_party := '',
				self.ssn := '',
				self.name_prefix := left.title,
				self.name_first := left.fname,
				self.name_middle := left.mname,
				self.name_last := left.lname,
				self.name_suffix := left.name_suffix,
				self.company_title := '',
				self.email := '',
				self.phone := ''));
		
		return extract;
		
	end;

	export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := function

	    filtered := base(year_started != '');

			extract := project(filtered,
			  transform(Layout_Incorporation.unlinked,
				  self.source := 'IA',
				  self.source_docid := left.abi_number,
				  self.source_party := '',
		      self.corp_state_origin         := '';
          self.corp_legal_name           := '';
				  self.corp_orig_sos_charter_nbr := '';
          self.corp_orig_bus_type_desc   := '';
          self.latest_filing_date        := '';
			    // What if company is no longer in business? not sure how to know???
			    self.corp_status_desc          := '';
				  self.corp_status_date          := '';
		      self.corp_foreign_domestic_ind := '';
		      self.corp_for_profit_ind       := '';
				  self.corp_term_exist_exp       := '';
          self.start_date                := left.year_started + '0000'; // Used when calculating YearsInBusiness ???
				  self.dt_vendor_last_reported   := ''; 
          self.corp_key                  := '';
          self.record_type               := '';
				  self.event_filing_date         := '';
		      self.event_filing_desc         := '';
			  ));

			return extract;

	end;
	
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	   
		filtered := base(primary_sic != '' or INDUSTRY_desc !=''); //???
		
		extract := normalize(filtered,
		/*map(
				left.secondary_sic_1 = '' => 1,
				left.secondary_sic_2 = '' => 2,
				left.secondary_sic_3 = '' => 3,
				left.secondary_sic_4 = '' => 4,
				// otherwise               5),
     */
		 5, 
		  transform(Layout_Industry.Unlinked,
			  self.source := 'IA',
				self.source_docid := left.abi_number,
				self.source_party := '',
				self.SicCode := choose(counter,
				  '',
					left.primary_sic,
					left.secondary_sic_1,
					left.secondary_sic_2,
					left.secondary_sic_3,
					left.secondary_sic_4);
       self.NAICS := '';
			 self.industry_description := if(counter=1,left.INDUSTRY_desc,''); //'';  //???
				// check contents ---^, may need put on layout_abstract instead of here ???
      ));
				
		//return extract;
		return extract(siccode != '' or industry_description != ''); //???

	end;
			
end;
