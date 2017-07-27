import FCC,MDR;

export FCC_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := FCC.File_FCC_base;
	
	shared filtered := base(clean_licensees_name != '' and fcc_seq != 0);
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
		
		extract_licensee := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_FCC_Radio_Licenses,
				self.source_docid := (string)left.fcc_seq,
				self.source_party := 'LICENSEE',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.company_name := left.clean_licensees_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
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
				self.zip := left.zip5,
				self.county_fips := left.fips_county,
				self.msa := '',
				self.phone := left.licensees_phone,
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));		
		
		extract_dba := normalize(filtered(clean_dba_name != ''),if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_FCC_Radio_Licenses,
				self.source_docid := (string)left.fcc_seq,
				self.source_party := 'LICENSEE',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.company_name := left.clean_dba_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
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
				self.zip := left.zip5,
				self.county_fips := left.fips_county,
				self.msa := '',
				self.phone := left.licensees_phone,
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));		
		
		extract_firm_1 := normalize(filtered(clean_firm_name != ''),if(left.firm.v_city_name != left.firm.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_FCC_Radio_Licenses,
				self.source_docid := (string)left.fcc_seq,
				self.source_party := 'FIRM',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.company_name := left.clean_firm_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.PHONE,
				self.aid := 0,
				self.prim_range := left.firm.prim_range,
				self.predir := left.firm.predir,
				self.prim_name := left.firm.prim_name,
				self.addr_suffix := left.firm.addr_suffix,
				self.postdir := left.firm.postdir,
				self.unit_desig := left.firm.unit_desig,
				self.sec_range := left.firm.sec_range,
				self.city_name := choose(counter,
					left.firm.p_city_name,
					left.firm.v_city_name),
				self.state := left.firm.st,
				self.zip := left.firm.zip5,
				self.county_fips := left.firm.fips_county,
				self.msa := '',
				self.phone := left.contact_firms_phone_number,
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));		
				
		extract_firm_2 := normalize(filtered(clean_firm_name != '' and contact_firms_fax_number != contact_firms_phone_number),if(left.firm.v_city_name != left.firm.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_FCC_Radio_Licenses,
				self.source_docid := (string)left.fcc_seq,
				self.source_party := 'FIRM',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.company_name := left.clean_firm_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.FAX,
				self.aid := 0,
				self.prim_range := left.firm.prim_range,
				self.predir := left.firm.predir,
				self.prim_name := left.firm.prim_name,
				self.addr_suffix := left.firm.addr_suffix,
				self.postdir := left.firm.postdir,
				self.unit_desig := left.firm.unit_desig,
				self.sec_range := left.firm.sec_range,
				self.city_name := choose(counter,
					left.firm.p_city_name,
					left.firm.v_city_name),
				self.state := left.firm.st,
				self.zip := left.firm.zip5,
				self.county_fips := left.firm.fips_county,
				self.msa := '',
				self.phone := left.contact_firms_fax_number,
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));		
				
		return extract_licensee + extract_firm_1 + extract_firm_2 + extract_dba;	
		
	end;
	
	export dataset(Layout_License.Unlinked) As_License_Master := function
		
		extract := project(filtered,
			transform(Layout_License.Unlinked,
				self.source            := MDR.sourceTools.src_FCC_Radio_Licenses,
				self.source_docid      := (string)left.fcc_seq,
				self.source_party      := 'LICENSEE',
				self.license_state     := '',
				self.license_board     := 'Federal Communications Commission',
				self.license_number    := left.callsign_of_license;
				self.license_type      := left.license_type;
				self.license_status    := map(
					left.pending_or_granted = 'P' => 'Pending',
					left.pending_or_granted = 'G' => 'Granted',
					left.pending_or_granted),
				self.issue_date        := left.date_license_issued;
				self.last_renewal_date := left.date_of_last_change;
				self.expiration_date   := left.date_license_expires;
				self.company_name      := left.licensees_name;
				));		
		return extract;
	end;	

	export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := function
		
		extract := project(filtered,
			transform(Layout_Relationship.Unlinked,
				self.source_1            := MDR.sourceTools.src_FCC_Radio_Licenses,
				self.source_docid_1      := (string)left.fcc_seq,
				self.source_party_1      := 'LICENSEE',
				self.role_1              := 'FCC Licensee',
				self.source_2            := MDR.sourceTools.src_FCC_Radio_Licenses,
				self.source_docid_2      := (string)left.fcc_seq,
				self.source_party_2      := 'FIRM',
				self.role_2              := 'FCC Application Preparer'
				));		
		return extract;
	end;	
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source            := MDR.sourceTools.src_FCC_Radio_Licenses,
				self.source_docid      := (string)left.fcc_seq,
				self.source_party      := 'LICENSEE',
				self.date_first_seen   := (unsigned4)left.process_date,
				self.date_last_seen    := (unsigned4)left.process_date,
				self.name_prefix       := left.attention_title,
				self.name_first        := left.attention_fname,
				self.name_middle       := left.attention_mname,
				self.name_last         := left.attention_lname,
				self.name_suffix       := left.attention_name_suffix,
				self.position_title    := 'FCC License Contact',
				self := []));
		
		return extract;
	
	end;
	
end;
