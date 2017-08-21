import DNB_dmi,MDR;

export DNB_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := dnb_dmi.files(,dnb_dmi._Dataset().IsDataland).base.companies.qa;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(rawfields.duns_number != '' and rawfields.business_name != '');
		
		extract_1 := normalize(filtered,
			if(left.clean_address.v_city_name != left.clean_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet,
				self.source_docid := left.rawfields.duns_number,
				self.source_party := 'C' + hash32(left.rawfields.business_name),
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.rawfields.business_name),
				self.company_name_type := Constants.Company_Name_Types.LEGAL,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.rawaid,
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
				self.phone := left.rawfields.telephone_number,
				self.fein := '',
				self.url := '',
				self.duns := left.rawfields.duns_number,
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.rawfields.state_of_incorporation_abbr,
				self.incorp_number := ''));
		
		extract_2 := normalize(filtered(rawfields.trade_style != ''),
			if(left.clean_address.v_city_name != left.clean_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet,
				self.source_docid := left.rawfields.duns_number,
				self.source_party := 'C' + hash32(left.rawfields.trade_style),
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.rawfields.trade_style),
				self.company_name_type := Constants.Company_Name_Types.FICTITIOUS,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.rawaid,
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
				self.phone := left.rawfields.telephone_number,
				self.fein := '',
				self.url := '',
				self.duns := left.rawfields.duns_number,
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.rawfields.state_of_incorporation_abbr,
				self.incorp_number := ''));
		
		extract_3 := normalize(filtered(rawfields.headquarters_duns_number != ''),
			if(left.clean_address.v_city_name != left.clean_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet,
				self.source_docid := left.rawfields.headquarters_duns_number,
				self.source_party := 'C' + hash32(left.rawfields.business_name),
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.rawfields.business_name),
				self.company_name_type := Constants.Company_Name_Types.LEGAL,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.rawaid,
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
				self.phone := left.rawfields.telephone_number,
				self.fein := '',
				self.url := '',
				self.duns := left.rawfields.headquarters_duns_number,
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.rawfields.state_of_incorporation_abbr,
				self.incorp_number := ''));
		
		extract_4 := normalize(filtered(rawfields.headquarters_duns_number != '' and rawfields.trade_style != ''),
			if(left.clean_address.v_city_name != left.clean_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet,
				self.source_docid := left.rawfields.headquarters_duns_number,
				self.source_party := 'C' + hash32(left.rawfields.trade_style),
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.rawfields.trade_style),
				self.company_name_type := Constants.Company_Name_Types.FICTITIOUS,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.rawaid,
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
				self.phone := left.rawfields.telephone_number,
				self.fein := '',
				self.url := '',
				self.duns := left.rawfields.headquarters_duns_number,
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.rawfields.state_of_incorporation_abbr,
				self.incorp_number := ''));
		
		return extract_1 + extract_2 + extract_3 + extract_4;
	
	end;
	
	export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := function
	
		filtered := base(rawfields.duns_number != '' and rawfields.business_name != '');
		
		extract := normalize(filtered,
			12,
			transform(Layout_Relationship.Unlinked,
				self.source_1 := MDR.sourceTools.src_Dunn_Bradstreet,
				self.source_docid_1 := choose(counter,
					left.rawfields.duns_number,
					left.rawfields.duns_number,
					left.rawfields.duns_number,
					left.rawfields.duns_number,
					left.rawfields.duns_number,
					left.rawfields.duns_number,
					left.rawfields.headquarters_duns_number,
					left.rawfields.headquarters_duns_number,
					left.rawfields.headquarters_duns_number,
					left.rawfields.headquarters_duns_number,
					left.rawfields.headquarters_duns_number,
					left.rawfields.headquarters_duns_number),
				self.source_party_1 := choose(counter,
					'C' + hash32(left.rawfields.business_name),
					'C' + hash32(left.rawfields.business_name),
					'C' + hash32(left.rawfields.business_name),
					'C' + hash32(left.rawfields.trade_style),
					'C' + hash32(left.rawfields.trade_style),
					'C' + hash32(left.rawfields.trade_style),
					'C' + hash32(left.rawfields.business_name),
					'C' + hash32(left.rawfields.business_name),
					'C' + hash32(left.rawfields.business_name),
					'C' + hash32(left.rawfields.trade_style),
					'C' + hash32(left.rawfields.trade_style),
					'C' + hash32(left.rawfields.trade_style)),
				self.role_1 := choose(counter,
					'Child',
					'Child',
					'Customer',
					'Child',
					'Child',
					'Customer',
					'Child',
					'Child',
					'Customer',
					'Child',
					'Child',
					'Customer'),
				self.source_2 := MDR.sourceTools.src_Dunn_Bradstreet,
				self.source_docid_2 := choose(counter,
					left.rawfields.parent_duns_number,
					left.rawfields.ultimate_duns_number,
					left.rawfields.bank_duns_number,
					left.rawfields.parent_duns_number,
					left.rawfields.ultimate_duns_number,
					left.rawfields.bank_duns_number,
					left.rawfields.parent_duns_number,
					left.rawfields.ultimate_duns_number,
					left.rawfields.bank_duns_number,
					left.rawfields.parent_duns_number,
					left.rawfields.ultimate_duns_number,
					left.rawfields.bank_duns_number),
				self.source_party_2 := choose(counter,
					'C' + hash32(left.rawfields.parent_company_name),
					'C' + hash32(left.rawfields.ultimate_company_name),
					'C' + hash32(left.rawfields.bank_name),
					'C' + hash32(left.rawfields.parent_company_name),
					'C' + hash32(left.rawfields.ultimate_company_name),
					'C' + hash32(left.rawfields.bank_name),
					'C' + hash32(left.rawfields.parent_company_name),
					'C' + hash32(left.rawfields.ultimate_company_name),
					'C' + hash32(left.rawfields.bank_name),
					'C' + hash32(left.rawfields.parent_company_name),
					'C' + hash32(left.rawfields.ultimate_company_name),
					'C' + hash32(left.rawfields.bank_name)),
				self.role_2 := choose(counter,
					'Parent',
					'Ultimate Parent',
					'Bank',
					'Parent',
					'Ultimate Parent',
					'Bank',
					'Parent',
					'Ultimate Parent',
					'Bank',
					'Parent',
					'Ultimate Parent',
					'Bank')))(source_docid_2 != '');
		
		return extract;
	
	end;
	
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	
		filtered := base(rawfields.duns_number != '');
		
		extract := normalize(filtered,
			62,
			transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet,
				self.source_docid := left.rawfields.duns_number,
				self.source_party := choose(((counter - 1) div 31) + 1,
					'C' + hash32(left.rawfields.business_name),
					'C' + hash32(left.rawfields.trade_style)),
				self.siccode := choose(((counter - 1) % 31) + 1,
					'',
					left.rawfields.sic1,left.rawfields.sic1a,left.rawfields.sic1b,left.rawfields.sic1c,left.rawfields.sic1d,
					left.rawfields.sic2,left.rawfields.sic2a,left.rawfields.sic2b,left.rawfields.sic2c,left.rawfields.sic2d,
					left.rawfields.sic3,left.rawfields.sic3a,left.rawfields.sic3b,left.rawfields.sic3c,left.rawfields.sic3d,
					left.rawfields.sic4,left.rawfields.sic4a,left.rawfields.sic4b,left.rawfields.sic4c,left.rawfields.sic4d,
					left.rawfields.sic5,left.rawfields.sic5a,left.rawfields.sic5b,left.rawfields.sic5c,left.rawfields.sic5d,
					left.rawfields.sic6,left.rawfields.sic6a,left.rawfields.sic6b,left.rawfields.sic6c,left.rawfields.sic6d),
				self.NAICS                := '';
			  // Even though the field used below is labeled as "line_of_business_description", 
				// the field has industry type info in it instead of an actual description of the 
				// company/business.  
			  // So it was decided to put that type of info in industry_description field on the 
				// layout_industry instead of in the business_description on the layout_abstract.
				self.industry_description := if(((counter - 1) % 31) + 1 = 1,left.rawfields.line_of_business_description,'');
			));
		
		return extract(siccode != '' or industry_description != '');
	
	end;

	export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := function
	
		filtered := base(rawfields.duns_number != '' and
			(rawfields.date_of_incorporation != '' or rawfields.state_of_incorporation_abbr != ''));
		
		extract := normalize(filtered,
			2,
			transform(Layout_Incorporation.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet,
				self.source_docid := left.rawfields.duns_number,
				self.source_party := choose(counter,
					'C' + hash32(left.rawfields.business_name),
					'C' + hash32(left.rawfields.trade_style)),
					self.corp_structure            := '';
					self.corp_foreign_state        := left.rawfields.state_of_incorporation_abbr;
		      self.corp_state_origin         := '';
          self.corp_legal_name           := '';
				  self.corp_orig_sos_charter_nbr := '';
          self.corp_orig_bus_type_desc   := '';
          self.latest_filing_date        := left.rawfields.date_of_incorporation; //???
			    self.corp_status_desc          := '';
				  self.corp_status_date          := '';
		      self.corp_foreign_domestic_ind := '';
		      self.corp_for_profit_ind       := '';
				  self.corp_term_exist_exp       := '';
          self.start_date                := left.rawfields.year_started + '0000'; // Used when calculating YearsInBusiness ???
				  self.dt_vendor_last_reported   := ''; 
          self.corp_key                  := '';
          self.record_type               := '';
				  self.event_filing_date         := '';
		      self.event_filing_desc         := '';
      ));
		
		return extract;
	
	end;
	
	export dataset(Layout_Finance.Unlinked) As_Finance_Master := function
	
		filtered := base(rawfields.duns_number != '' and rawfields.annual_sales_revision_date != '' and (integer)rawfields.annual_sales_volume != 0);
		
		extract := project(filtered,
			transform(Layout_Finance.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet,
				self.source_docid := left.rawfields.duns_number,
				self.source_party := choose(counter,
					'C' + hash32(left.rawfields.business_name),
					'C' + hash32(left.rawfields.trade_style)),
				self.FiscalYearEnding := (unsigned4)left.rawfields.annual_sales_revision_date,																 
				self.sales := (integer) left.rawfields.annual_sales_volume,
				self := [])); 
					
		return extract;
	
	end;	

end;
