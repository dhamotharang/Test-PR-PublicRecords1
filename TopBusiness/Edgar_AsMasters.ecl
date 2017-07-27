import Edgar,MDR;

export Edgar_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared company_base := Edgar.File_Edgar_Company_Base(companyname != '' and accnumber != '');
	shared contact_base := Edgar.File_Edgar_Contacts_Base(lname != '' and accession != '');
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := company_base;
		
		extract_1 := normalize(filtered,if(left.bus_v_city_name != left.bus_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Edgar,
				self.source_docid := left.accnumber,
				self.source_party := '',
				self.date_first_seen := (unsigned4)(if(left.accnumber[12..13] <= '20','20','19') + left.accnumber[12..13] + '0000'),
				self.date_last_seen := (unsigned4)(if(left.accnumber[12..13] <= '20','20','19') + left.accnumber[12..13] + '0000'),
				self.company_name := stringlib.StringToUpperCase(left.companyname),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.BUSINESS,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.bus_prim_range,
				self.predir := left.bus_predir,
				self.prim_name := left.bus_prim_name,
				self.addr_suffix := left.bus_addr_suffix,
				self.postdir := left.bus_postdir,
				self.unit_desig := left.bus_unit_desig,
				self.sec_range := left.bus_sec_range,
				self.city_name := choose(counter,
					left.bus_p_city_name,
					left.bus_v_city_name),
				self.state := left.bus_st,
				self.zip := left.bus_zip,
				self.county_fips := left.bus_county[3..5],
				self.msa := left.bus_msa,
				self.phone := left.bus_phone10,
				self.fein := left.taxid,
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.incstate,
				self.incorp_number := ''));

		extract_2 := normalize(filtered,if(left.mail_v_city_name != left.mail_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Edgar,
				self.source_docid := left.accnumber,
				self.source_party := '',
				self.date_first_seen := (unsigned4)(if(left.accnumber[12..13] <= '20','20','19') + left.accnumber[12..13] + '0000'),
				self.date_last_seen := (unsigned4)(if(left.accnumber[12..13] <= '20','20','19') + left.accnumber[12..13] + '0000'),
				self.company_name := stringlib.StringToUpperCase(left.companyname),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.MAILING,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.mail_prim_range,
				self.predir := left.mail_predir,
				self.prim_name := left.mail_prim_name,
				self.addr_suffix := left.mail_addr_suffix,
				self.postdir := left.mail_postdir,
				self.unit_desig := left.mail_unit_desig,
				self.sec_range := left.mail_sec_range,
				self.city_name := choose(counter,
					left.mail_p_city_name,
					left.mail_v_city_name),
				self.state := left.mail_st,
				self.zip := left.mail_zip,
				self.county_fips := left.mail_county[3..5],
				self.msa := left.mail_msa,
				self.phone := left.mail_phone10,
				self.fein := left.taxid,
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.incstate,
				self.incorp_number := ''));
		
		return extract_1 + extract_2;
	
	end;
	
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	
		filtered := company_base(siccode != '');
		
		extract := project(filtered,
			transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_Edgar,
				self.source_docid := left.accnumber,
				self.source_party := '',
				self.siccode := left.siccode,
				self := []));
		
		return extract;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		filtered := contact_base;
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_Edgar,
				self.source_docid := left.accnumber,
				self.source_party := '',
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
				self.position_title := left.position,		
				self.position_type := 'C',
				self := []));
		
		return extract;
	
	end;

end;
