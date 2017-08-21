import calBus, MDR;

export Calbus_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := CALBUS.File_Calbus_Base;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
	  // NOTE: As of a data stats run in December 2010, approximately only 37% of the 
		// firm_name fields contain data and approximatley 92% of the owner_name fields 
		// contain a company name.  
		// The only way to know if the owner_name field contains a business name instead of a 
		// person name is to check to see if the parsed owner_lname(last name) field is empty.
		filtered := base(firm_name != '' or (owner_name !='' and owner_lname = '')); 

		// Which addresses go with which names?
		//  On 06/10/11, Rosemary Murphy looked at various base file records and thinks that:
		//  1) when firm_name is populated and the business_address and mailing_address 
		//     are the same, then there is really no way to tell which name goes with which 
		//     address without further manual investigation.
		//  2) When firm_name is populated and the business_address is different from the 
		//     mailing_address; then the business_address goes with the firm_name and 
		//     the mailing_address goes with the owner_name.

		// Extract the Business Address
		//extract_business := normalize(filtered, // ???
		extract_business := normalize(filtered(firm_name !=''),
			if(left.business_v_city_name != left.business_p_city_name,2,1),
					transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Calbus,
				self.source_docid := left.account_number,
				self.source_party := if(left.firm_name !='', // and addresses_different, ???
				                        'FIRM',
				                        'OWNER'),
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen  := (unsigned4)left.dt_last_seen,
				/* use this ---v instead of just always using firm_name ???
				bus_addr_hash  := hash64(left.BUSINESS_STREET, left.BUSINESS_CITY, left.BUSINESS_STATE, left.BUSINESS_ZIP_5, left.BUSINESS_ZIP_PLUS_4);
        mail_addr_hash := hash64(left.MAILING_STREET, left.MAILING_CITY, left.MAILING_STATE, left.MAILING_ZIP_5, left.MAILING_ZIP_PLUS_4);
				addresses_different := if(bus_addr_hash = mail_addr_hash,true,false);
				*/
				self.company_name := if(left.firm_name !='', // and addresses_different, ???
				                        stringlib.StringToUpperCase(left.firm_name),
				                        stringlib.StringToUpperCase(left.owner_name)),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.BUSINESS,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.raw_aid,
				self.prim_range := left.Business_prim_range,
				self.predir := left.Business_predir,
				self.prim_name := left.Business_prim_name,
				self.addr_suffix := left.Business_addr_suffix,
				self.postdir := left.Business_postdir,
				self.unit_desig := left.Business_unit_desig,
				self.sec_range := left.Business_sec_range,
				self.city_name := choose(counter,
					left.Business_p_city_name,
					left.Business_v_city_name),
				self.state := left.Business_st,
				self.zip := left.Business_zip5,
				self.zip4 := left.Business_zip4,
				self.county_fips := left.Business_fips_county,
				self.msa := '',
				self.phone := '',
				self.fein := '',
				self.url := '',
				self.duns := '', 
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));

		//  Extract the Mailing Address
	  extract_mailing :=  normalize(filtered,		
		    if(left.mailing_v_city_name != left.mailing_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Calbus,
				self.source_docid := left.account_number,
				self.source_party := 'OWNER',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.owner_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.MAILING,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.mail_raw_aid,
				self.prim_range := left.mailing_prim_range,
				self.predir := left.mailing_predir,
				self.prim_name := left.mailing_prim_name,
				self.addr_suffix := left.mailing_addr_suffix,
				self.postdir := left.mailing_postdir,
				self.unit_desig := left.mailing_unit_desig,
				self.sec_range := left.mailing_sec_range,
				self.city_name := choose(counter,
					left.mailing_p_city_name,
					left.mailing_v_city_name),
				self.state := left.mailing_st,
				self.zip := left.mailing_zip5,
				self.zip4 := left.mailing_zip4,
				self.county_fips := left.mailing_fips_county,
				self.msa := '',
				self.phone := '', 
				self.fein := '',
				self.url := '',
				self.duns := '', 
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '', 
				self.incorp_number := ''));
		
		return extract_business + extract_mailing;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function

    filtered := base(owner_lname !=''); 

	  extract := project(filtered,
		  transform(Layout_contacts.Unlinked,		
			  self.source        := MDR.sourceTools.src_Calbus,
				self.source_docid  := left.account_number,
				self.source_party  := 'OWNER',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.ssn           := '';
				self.did           := left.did,
				self.score         := left.did_score,
				self.name_prefix   := left.owner_title;
		    self.name_first    := left.owner_fname;
		    self.name_middle   := left.owner_mname;
		    self.name_last     := left.owner_lname;
		    self.name_suffix   := left.owner_name_suffix;
				self.prim_range := left.mailing_prim_range,
				self.predir := left.mailing_predir,
				self.prim_name := left.mailing_prim_name,
				self.addr_suffix := left.mailing_addr_suffix,
				self.postdir := left.mailing_postdir,
				self.unit_desig := left.mailing_unit_desig,
				self.sec_range := left.mailing_sec_range,
				self.city_name := left.mailing_p_city_name,
				self.state := left.mailing_st,
				self.zip := left.mailing_zip5,,
				self.zip4 := left.mailing_zip4,
				self.position_title := Constants.Contact_Name_Types.OWNER,
				self.position_type := 'C';
		    self.phone         := '',
		    self.email         := ''			
			));
			
		return extract;

	end;

	export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := function

	    filtered := base(process_date != '' OR ownership_code_desc != '');

			extract := project(filtered,
			  transform(Layout_Incorporation.unlinked,
				  self.source            := MDR.sourceTools.src_Calbus,
					self.source_docid      := left.account_number,
					self.source_party      := 'OWNER',
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
          self.start_date                := left.start_date; // Used when calculating YearsInBusiness ???
				  self.dt_vendor_last_reported   := ''; 
          self.corp_key                  := '';
          self.record_type               := '';
				  self.event_filing_date         := '';
		      self.event_filing_desc         := '';
					));

			return extract;

	end;

	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	
		filtered := base(naics_code != '' or industry_code_desc !='');
		
		extract := project(filtered,
			transform(Layout_Industry.Unlinked,
				self.source       := MDR.sourceTools.src_Calbus,
				self.source_docid := left.account_number,
				self.source_party := 'OWNER',
				self.SicCode              := '';
				self.NAICS                := left.NAICS_CODE,
				self.industry_description := left.Industry_code_desc;
				));
		
		return extract;
	
	end;	

end;
