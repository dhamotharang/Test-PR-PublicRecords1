import InfoUSA,MDR;

export IDEXEC_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := InfoUSA.File_IDEXEC_Base(idexec_key != '' and firm_name != '');
		
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base;
		
		extract := normalize(filtered,if(left.firm_address_clean_v_city_name != left.firm_address_clean_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.SourceTools.src_INFOUSA_IDEXEC,
				self.source_docid := left.idexec_key,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.company_name := stringlib.StringToUpperCase(left.firm_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.prim_range := left.firm_address_clean_prim_range,
				self.predir := left.firm_address_clean_predir,
				self.prim_name := left.firm_address_clean_prim_name,
				self.addr_suffix := left.firm_address_clean_addr_suffix,
				self.postdir := left.firm_address_clean_postdir,
				self.unit_desig := left.firm_address_clean_unit_desig,
				self.sec_range := left.firm_address_clean_sec_range,
				self.city_name := choose(counter,
					left.firm_address_clean_p_city_name,
					left.firm_address_clean_v_city_name),
				self.state := left.firm_address_clean_st,
				self.zip := left.firm_address_clean_zip,
				self.zip4 := left.firm_address_clean_zip4,
				self.county_fips := left.firm_address_clean_fipscounty,
				self.msa := left.firm_address_clean_msa,
				self.aid := left.raw_aid,
				self.phone := stringlib.StringFilter(left.loc_telephone,'0123456789'),
				self.fein := '',
				self.url := left.web_address,
				self.duns := left.duns_nbr,
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
		
		filtered := base(exec_clean_lname != '');
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.SourceTools.src_INFOUSA_IDEXEC,
				self.source_docid := left.idexec_key,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.name_prefix := left.exec_clean_title,
				self.name_first := left.exec_clean_fname,
				self.name_middle := left.exec_clean_mname,
				self.name_last := left.exec_clean_lname,
				self.name_suffix := left.exec_clean_name_suffix,
				self.position_title := stringlib.StringToUpperCase(left.exec_title),
				self.position_type := 'C',
				self := []));
		
		return extract;
		
	end;

	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	   
		filtered := base(industries_1 != ''); //???
		
		extract := normalize(filtered,4,
			transform(Layout_Industry.Unlinked,
				self.source := MDR.SourceTools.src_INFOUSA_IDEXEC,
				self.source_docid := left.idexec_key,
				self.source_party := '',
				self.SicCode := '',
				self.NAICS := '';
				self.industry_description := choose(counter,
					left.industries_1[7..],
					left.industries_2[7..],
					left.industries_3[7..],
					left.industries_4[7..])))(industry_description != '');
				
		return extract;

	end;
	
	export dataset(Layout_Finance.Unlinked) As_Finance_Master := function
	
		filtered := base(ticker != '');
		
		extract := project(filtered,
			transform(Layout_Finance.Unlinked,
				self.source := MDR.SourceTools.src_INFOUSA_IDEXEC,
				self.source_docid := left.idexec_key,
				self.source_party := '',
				self.exchange := left.exchange_code_1,
				self.ticker := left.ticker,
				self := []));
		
		return extract;
	
	end;
			
end;
