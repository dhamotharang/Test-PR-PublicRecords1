import irs5500,MDR;

export IRS5500_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := irs5500.File_IRS5500_Base_AID;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(ein != '' and plan_number != '' and document_locator_number != '' and sponsor_dfe_name != '');
		
		extract := project(filtered,
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_IRS_5500,
				self.source_docid := trim(left.ein) + '//' + trim(left.plan_number) + '//' + trim(left.document_locator_number),
				self.source_party := 'SPONSOR',
				self.date_first_seen := (unsigned4)left.form_plan_year_begin_date,
				self.date_last_seen := (unsigned4)left.form_tax_prd,
				self.company_name := stringlib.StringToUpperCase(left.sponsor_dfe_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.raw_aid,
				self.prim_range := left.spons_prim_range,
				self.predir := left.spons_predir,
				self.prim_name := left.spons_prim_name,
				self.addr_suffix := left.spons_addr_suffix,
				self.postdir := left.spons_postdir,
				self.unit_desig := left.spons_unit_desig,
				self.sec_range := left.spons_sec_range,
				self.city_name := left.spons_p_city_name,
				self.state := left.spons_st,
				self.zip := left.spons_zip5,
				self.zip4 := left.spons_zip4,
				self.county_fips := left.spons_county[3..5],
				self.msa := left.spons_msa,
				self.phone := left.spon_dfe_phone_num,
				self.fein := left.ein,
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		filtered := base(ein != '' and plan_number != '' and document_locator_number != '' and sponsor_dfe_name != '' and spons_sign_lname != '');
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_IRS_5500,
				self.source_docid := trim(left.ein) + '//' + trim(left.plan_number) + '//' + trim(left.document_locator_number),
				self.source_party := 'SPONSOR',
				self.date_first_seen := (unsigned4)left.form_plan_year_begin_date,
				self.date_last_seen := (unsigned4)left.form_tax_prd,
				self.ssn := '',
				self.did := 0,
				self.score := 0,
				self.name_prefix := left.spons_sign_title,
				self.name_first := left.spons_sign_fname,
				self.name_middle := left.spons_sign_mname,
				self.name_last := left.spons_sign_lname,
				self.name_suffix := left.spons_sign_suffix,
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
				self.position_title := 'IRS FORM 5500 SIGNATORY',
				self.position_type := 'C',
				self.email := '',
				self.phone := ''
				));
		
		return extract;
	
	end;
		
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	
		filtered := base(ein != '' and plan_number != '' and document_locator_number != '' and sponsor_dfe_name != '' and business_code != '');
		
		extract := project(filtered,
			transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_IRS_5500,
				self.source_docid := trim(left.ein) + '//' + trim(left.plan_number) + '//' + trim(left.document_locator_number),
				self.source_party := 'SPONSOR',
				self.siccode := left.business_code,
				self.industry_description := '',
				self.naics := ''));
				
		return extract;
	
	end;

end;
