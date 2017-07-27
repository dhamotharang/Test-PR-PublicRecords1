import TXBus, ut, MDR;

export TxBus_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := TxBus.File_TxBus_Base;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(Outlet_Name != '');
		
		extract_outlet := normalize(filtered(taxpayer_fname = ''),
			if(left.outlet_v_city_name != left.outlet_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_TXBUS,
				self.source_docid := left.taxPayer_number  + '//' + left.outlet_number,
				self.source_party := 'OUTLET',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.outlet_name),
				self.company_name_type := Constants.Company_Name_Types.FICTITIOUS,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.mail_raw_aid,
				self.prim_range := left.outlet_prim_range,
				self.predir := left.outlet_predir,
				self.prim_name := left.outlet_prim_name,
				self.addr_suffix := left.outlet_addr_suffix,
				self.postdir := left.outlet_postdir,
				self.unit_desig := left.outlet_unit_desig,
				self.sec_range := left.outlet_sec_range,
				self.city_name := choose(counter,
					left.outlet_p_city_name,
					left.outlet_v_city_name),
				self.state := left.outlet_st,
				self.zip := left.outlet_zip5,
				self.county_fips := left.outlet_fips_county,
				self.msa := '',
				self.phone := left.outlet_Phone, //left.telephone_number,
				self.fein := '',
				self.url := '',
				self.duns := '', 
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '', 
				self.incorp_number := ''));
  
	  extract_taxpayer :=  normalize(filtered,		
		    if(left.taxpayer_v_city_name != left.taxpayer_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_TXBUS,
				self.source_docid := left.taxPayer_number  + '//' + left.outlet_number,
				self.source_party := 'TAXPAYER',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.taxpayer_name),
				self.company_name_type := Constants.Company_Name_Types.LEGAL,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.raw_aid,
				self.prim_range := left.taxpayer_prim_range,
				self.predir := left.taxpayer_predir,
				self.prim_name := left.taxpayer_prim_name,
				self.addr_suffix := left.taxpayer_addr_suffix,
				self.postdir := left.taxpayer_postdir,
				self.unit_desig := left.taxpayer_unit_desig,
				self.sec_range := left.taxpayer_sec_range,
				self.city_name := choose(counter,
					left.taxpayer_p_city_name,
					left.taxpayer_v_city_name),
				self.state := left.taxpayer_st,
				self.zip := left.taxpayer_zip5,
				self.county_fips := left.taxpayer_fips_county,
				self.msa := '',
				self.phone := left.Taxpayer_Phone, 
				self.fein := '',
				self.url := '',
				self.duns := '', 
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '', 
				self.incorp_number := ''));
		
		return extract_outlet + extract_taxpayer;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	   filtered := base(taxPayer_fname != ''); // what to filter on??
	  extract := project(filtered,
		  transform(Layout_contacts.Unlinked,		
				self.source := MDR.sourceTools.src_TXBUS,
				self.source_docid := left.taxPayer_number  + '//' + left.outlet_number,
				self.source_party := 'TAXPAYER',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.ssn           := '',
				self.name_prefix   := left.taxPayer_title;
		    self.name_first    := left.taxPayer_fname;
		    self.name_middle   := left.taxPayer_mname;
		    self.name_last     := left.taxPayer_lname;
		    self.name_suffix   := left.taxPayer_name_suffix;
				self.prim_range := left.taxPayer_prim_range,
				self.predir := left.taxPayer_predir,
				self.prim_name := left.taxPayer_prim_name,
				self.addr_suffix := left.taxPayer_addr_suffix,
				self.postdir := left.taxPayer_postdir,
				self.unit_desig := left.taxPayer_unit_desig,
				self.sec_range := left.taxPayer_sec_range,
				self.city_name := left.taxPayer_p_city_name,
				self.state := left.taxPayer_st,
				self.zip := left.taxPayer_zip5,
				self.zip4 := left.taxPayer_zip4,
		    self.position_title := '',
				self.position_type := 'C',
				self.phone         := '',
				self.email         := ''));			
		return extract;
	end;
	
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	
		filtered := base(outlet_naics_code != '');
		
		extract := project(filtered,
			transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_TXBUS,
				self.source_docid := left.taxPayer_number  + '//' + left.outlet_number,
				self.source_party := 'OUTLET',
        self.SicCode := ''; 
				self.industry_description := ''; 
				self.naics := left.Outlet_NAICS_Code;
			));

		return extract;
	
	end;	
	
	export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := function
	
		extract_outlet := project(base(Outlet_Permit_Issue_Date !=''),
			transform(Layout_Incorporation.Unlinked,
				self.source := MDR.sourceTools.src_TXBUS,
				self.source_docid := left.taxPayer_number  + '//' + left.outlet_number,
				self.source_party := 'OUTLET',
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
				// v--- Used when calculating YearsInBusiness ???
        self.start_date                := left.Outlet_Permit_Issue_Date; //OR Outlet_First_Sales_Date; ???
				self.dt_vendor_last_reported   := ''; 
        self.corp_key                  := '';
        self.record_type               := '';
				self.event_filing_date         := '';
		    self.event_filing_desc         := '';
    ));

    // Is this extract really needed just for this 1 field ???				
		extract_taxpayer := project(base(taxpayer_org_type_desc != ''),
			transform(Layout_Incorporation.Unlinked,
				self.source := MDR.sourceTools.src_TXBUS,
				self.source_docid := left.taxPayer_number  + '//' + left.outlet_number,
				self.source_party := 'TAXPAYER',
	      self.corp_state_origin         := '';
        self.corp_legal_name           := '';
				self.corp_orig_sos_charter_nbr := '';
        self.corp_orig_bus_type_desc   := left.taxpayer_org_type_desc;
        self.latest_filing_date        := '';
			  self.corp_status_desc          := '';
				self.corp_status_date          := '';
		    self.corp_foreign_domestic_ind := '';
				self.corp_foreign_state        := '';
				self.corp_structure            := '';
		    self.corp_for_profit_ind       := '';
				self.corp_term_exist_exp       := '';
        self.start_date                := '';
				self.dt_vendor_last_reported   := ''; 
        self.corp_key                  := '';
        self.record_type               := '';
				self.event_filing_date         := '';
		    self.event_filing_desc         := '';
    ));
				
		return extract_outlet + 
		       extract_taxpayer; // remove ???
	
	end;
   
end;