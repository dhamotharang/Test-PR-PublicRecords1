import FBNv2,MDR;

export FBN_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared company_base := FBNv2.File_FBN_Business_Base_AID;
	
	shared contact_base := FBNv2.File_FBN_Contact_Base_AID;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered_company := company_base(tmsid != '' and rmsid != '' and bus_name != '');
		
		// the filter condition makes sure we don't get a blank address unless we need it to get the record at all
		extract_1 := project(filtered_company((prim_name != '' and zip5 != '') or mail_prim_name = '' or mail_zip5 = ''),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.fFBNV2(left.tmsid),
				self.source_docid := left.tmsid + '//' + left.rmsid,
				self.source_party := 'COMP',
				self.date_first_seen := left.dt_first_seen,
				self.date_last_seen := left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.bus_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.BUSINESS,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.rawaid,
				self.prim_range := left.prim_range,
				self.predir := left.predir,
				self.prim_name := left.prim_name,
				self.addr_suffix := left.addr_suffix,
				self.postdir := left.postdir,
				self.unit_desig := left.unit_desig,
				self.sec_range := left.sec_range,
				self.city_name := left.v_city_name,
				self.state := left.st,
				self.zip := left.zip5,
				self.county_fips := left.fips_county,
				self.msa := '',
				self.phone := left.bus_phone_num,
				self.fein := if(left.orig_fein = 0,'',intformat(left.orig_fein,9,1)),
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		extract_2 := project(filtered_company(mail_zip5 != '' and mail_prim_name != ''),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.fFBNV2(left.tmsid),
				self.source_docid := left.tmsid + '//' + left.rmsid,
				self.source_party := 'COMP',
				self.date_first_seen := left.dt_first_seen,
				self.date_last_seen := left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.bus_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.MAILING,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.mail_rawaid,
				self.prim_range := left.mail_prim_range,
				self.predir := left.mail_predir,
				self.prim_name := left.mail_prim_name,
				self.addr_suffix := left.mail_addr_suffix,
				self.postdir := left.mail_postdir,
				self.unit_desig := left.mail_unit_desig,
				self.sec_range := left.mail_sec_range,
				self.city_name := left.mail_v_city_name,
				self.state := left.mail_st,
				self.zip := left.mail_zip5,
				self.county_fips := left.mail_fips_county,
				self.msa := '',
				self.phone := left.bus_phone_num,
				self.fein := if(left.orig_fein = 0,'',intformat(left.orig_fein,9,1)),
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		filtered_contact := contact_base(tmsid != '' and rmsid != '' and contact_name != '' and lname = '');
		
		extract_3 := project(filtered_contact,
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.fFBNV2(left.tmsid),
				self.source_docid := left.tmsid + '//' + left.rmsid,
				self.source_party := 'CONT' + hash64(left.contact_name),
				self.date_first_seen := left.dt_first_seen,
				self.date_last_seen := left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.contact_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.rawaid,
				self.prim_range := left.prim_range,
				self.predir := left.predir,
				self.prim_name := left.prim_name,
				self.addr_suffix := left.addr_suffix,
				self.postdir := left.postdir,
				self.unit_desig := left.unit_desig,
				self.sec_range := left.sec_range,
				self.city_name := left.v_city_name,
				self.state := left.st,
				self.zip := left.zip5,
				self.county_fips := left.fips_county,
				self.msa := '',
				self.phone := left.contact_phone,
				self.fein := if(left.contact_fei_num = 0,'',intformat(left.contact_fei_num,9,1)),
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := left.contact_charter_num));
		
		return extract_1 + extract_2 + extract_3;
	
	end;

	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		filtered_contact := contact_base(tmsid != '' and rmsid != '' and contact_name != '' and lname != '');
		
		extract := project(filtered_contact,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.fFBNV2(left.tmsid),
				self.source_docid := left.tmsid + '//' + left.rmsid,
				self.source_party := 'COMP',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.ssn := left.ssn,
				self.name_prefix := left.title,
				self.name_first := left.fname,
				self.name_middle := left.mname,
				self.name_last := left.lname,
				self.name_suffix := left.name_suffix,
				self.prim_range := left.prim_range,
				self.predir := left.predir,
				self.prim_name := left.prim_name,
				self.addr_suffix := left.addr_suffix,
				self.postdir := left.postdir,
				self.unit_desig := left.unit_desig,
				self.sec_range := left.sec_range,
				self.city_name := left.v_city_name,
				self.state := left.st,
				self.zip := left.zip5,
				self.zip4 := left.zip4,
				self.position_title := '',
				self.position_type := 'C';
				self.phone := left.contact_phone,
				self.email := '',			
				));
		
		return extract;
	
	end;
	
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	
		filtered := company_base(tmsid != '' and rmsid != '' and 
		                         (sic_code != '' or bus_type_desc !=''));
		
		extract := project(filtered,
			transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.fFBNV2(left.tmsid),
				self.source_docid := left.tmsid + '//' + left.rmsid,
				self.source_party := 'COMP', // ???
				self.siccode              := left.sic_code,
				self.NAICS                := '';
			  // Even though the field used below is labeled as "bus_type_desc", the field has
				// industry type info in it instead of an actual description of the company/business.
			  // So it was decided to put that type of info in industry_description field on the 
				// layout_industry instead of in the business_description on the layout_abstract.
				self.industry_description := left.bus_type_desc,
      ));
		
		return extract;
	
	end;

  // Is this really needed just for this 1 FBN data field	???
	export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := function
	
		filtered := company_base(tmsid != '' and rmsid != '' and bus_name != '');
		
		extract := project(filtered,
			transform(Layout_Incorporation.Unlinked,
				self.source := MDR.sourceTools.fFBNV2(left.tmsid),
				self.source_docid := left.tmsid + '//' + left.rmsid,
				self.source_party := 'COMP',
		      self.corp_state_origin         := '';
          self.corp_legal_name           := '';
				  self.corp_orig_sos_charter_nbr := '';
          self.corp_orig_bus_type_desc   := '';
          self.latest_filing_date        := '';
			    self.corp_status_desc          := left.bus_status;
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
		
		return extract;
	
	end;

end;
