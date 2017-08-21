import DNB_FEINV2,MDR;

export DNBFEIN_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := DNB_FEINV2.File_DNB_Fein_base_main_new;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(tmsid != '' and orig_company_name != '');
		
		extract_1 := normalize(filtered,
			if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet_FEIN,
				self.source_docid := left.tmsid,
				self.source_party := if((unsigned)left.confidence_code >= 5,'STANDARD','REPORTED'),
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.orig_company_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.raw_aid,
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
				self.zip4 := left.zip4,
				self.county_fips := left.county[3..5],
				self.msa := left.msa,
				self.phone := '',
				self.fein := left.fein,
				self.url := '',
				self.duns := left.case_duns_number,
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		extract_2 := project(filtered(trade_style != ''),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet_FEIN,
				self.source_docid := left.tmsid,
				self.source_party := 'STANDARD',
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.trade_style),
				self.company_name_type := Constants.Company_Name_Types.FICTITIOUS,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
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
				self.county_fips := '',
				self.msa := '',
				self.phone := left.telephone_number,
				self.fein := left.fein,
				self.url := '',
				self.duns := left.case_duns_number,
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		extract_3 := project(filtered(company_name != ''),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet_FEIN,
				self.source_docid := left.tmsid,
				self.source_party := 'STANDARD',
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.company_name),
				self.company_name_type := Constants.Company_Name_Types.LEGAL,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
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
				self.county_fips := '',
				self.msa := '',
				self.phone := left.telephone_number,
				self.fein := left.fein,
				self.url := '',
				self.duns := left.case_duns_number,
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		// return extract_1;
		return extract_1 + extract_2 + extract_3;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		filtered := base(tmsid != '' and lname != '');
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet_FEIN,
				self.source_docid := left.tmsid,
				self.source_party := 'STANDARD',
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
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
				self.position_title := left.top_contact_title,
				self.position_type := 'C';
				self.email := '',
				self.phone := ''			
				));
		
		return extract;
	
	end;
		
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	
		filtered := base(tmsid != '' and sic_code != '');
		
		extract := project(filtered,
			transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_Dunn_Bradstreet_FEIN,
				self.source_docid := left.tmsid,
				self.source_party := 'STANDARD',
				self.siccode := left.sic_code,
				self.NAICS                := '';
				self.industry_description := '';
			));
		
		return extract;
	
	end;
	
end;
