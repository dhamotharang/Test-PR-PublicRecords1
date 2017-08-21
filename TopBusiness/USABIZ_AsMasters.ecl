import InfoUSA,MDR;

export USABIZ_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := InfoUSA.File_ABIUS_Company_Base_AID(abi_number != '' and company_name != '');
		
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base;
		
		extract_1 := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ,
				self.source_docid := left.abi_number +
					if(left.abi_number = 'business',(string)hash64(left.company_name,left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range,left.v_city_name,left.p_city_name,left.st,left.z5,left.phone),''),
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
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
				self.zip := if((unsigned)left.z5 = 0,'',intformat((unsigned)left.z5,5,1)),
				self.zip4 := if((unsigned)left.zip4 = 0,'',intformat((unsigned)left.zip4,4,1)),
				self.county_fips := left.county[3..5],
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
				self.source := MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ,
				self.source_docid := left.abi_number +
					if(left.abi_number = 'business',(string)hash64(left.company_name,left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range,left.v_city_name,left.p_city_name,left.st,left.z5,left.phone),''),
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
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
				self.zip := if((unsigned)left.z5 = 0,'',intformat((unsigned)left.z5,5,1)),
				self.zip4 := if((unsigned)left.zip4 = 0,'',intformat((unsigned)left.zip4,4,1)),
				self.county_fips := left.county[3..5],
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
				self.source := MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ,
				self.source_docid := left.abi_number +
					if(left.abi_number = 'business',(string)hash64(left.company_name,left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range,left.v_city_name,left.p_city_name,left.st,left.z5,left.phone),''),
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
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
				self.phone := '',				
				));
		
		return extract;
		
	end;

	export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := function

	    filtered := base(year_started != '');

			extract := project(filtered,
			  transform(Layout_Incorporation.unlinked,
				  self.source       := MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ,
				  self.source_docid := left.abi_number +
					  if(left.abi_number = 'business',(string)hash64(left.company_name,left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range,left.v_city_name,left.p_city_name,left.st,left.z5,left.phone),''),
				  self.source_party := '',
							      self.corp_state_origin         := '';
          self.corp_legal_name           := '';
				  self.corp_orig_sos_charter_nbr := '';
          self.corp_orig_bus_type_desc   := '';
          self.latest_filing_date        := '';
			    self.corp_status_desc          := '';
				  self.corp_status_date          := '';
		      self.corp_foreign_domestic_ind := '';
					self.corp_foreign_state        := '';
					self.corp_structure            := '';
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
	   
		filtered := base(primary_sic != '');
		
		extract := normalize(filtered,
			map(
				left.secondary_sic_1 = '' => 1,
				left.secondary_sic_2 = '' => 2,
				left.secondary_sic_3 = '' => 3,
				left.secondary_sic_4 = '' => 4,
				/* otherwise */              5),
		  transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ,
				self.source_docid := left.abi_number +
					if(left.abi_number = 'business',(string)hash64(left.company_name,left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range,left.v_city_name,left.p_city_name,left.st,left.z5,left.phone),''),
				self.source_party := '',
				self.SicCode := choose(counter,
					left.primary_sic,
					left.secondary_sic_1,
					left.secondary_sic_2,
					left.secondary_sic_3,
					left.secondary_sic_4);
				self.NAICS                := '';
				self.industry_description := '';
				// NOTE: the base file industry_desc field doesn't really have industry info in it. 
				// It contains other non-industry related information about the company.
			  // However Tim Bernhard decided he did not want that data output on either the 
				// layout_industry or in the business_description field on the layout_abstract.
			));
				
		return extract;
		
	end;
			
end;
