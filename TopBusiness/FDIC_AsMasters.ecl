import govdata,MDR;

export FDIC_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := govdata.File_FDIC_Base_AID;
	
	shared filtered := base(cert != '');
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
		
		extract := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_FDIC,
				self.source_docid := left.cert,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.company_name := left.name,
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
				self.zip := left.zip5,
				self.county_fips := left.fipscounty,
				self.msa := left.msa_code,
				self.phone := '',
				self.fein := '',
				self.url := left.webaddr,
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));		
		
		return extract;
		
	end;
	
	export dataset(Layout_License.Unlinked) As_License_Master := function
		
		extract := project(filtered,
			transform(Layout_License.Unlinked,
				self.source            := MDR.sourceTools.src_FDIC,
				self.source_docid      := left.cert,
				self.source_party      := '',
				self.license_state     := '',
				self.license_board     := 'FDIC',
				self.license_number    := left.cert;
				self.license_type      := 'FDIC Insured Institution',
				self.license_status    := map(
					left.active = '1' => 'Active',
					left.active = '0' => 'Lapsed',
					''),
				self.issue_date        := left.insdate[1..4] + left.insdate[6..7] + left.insdate[9..10];
				self.last_renewal_date := left.effdate[1..4] + left.effdate[6..7] + left.effdate[9..10];
				self.expiration_date   := if(left.endefymd[1..4] = '9999','',left.endefymd[1..4] + left.endefymd[6..7] + left.endefymd[9..10]);
				self.company_name      := left.name;
				));		
		return extract;
	end;	

	export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := function
		
		extract := project(filtered,
			transform(Layout_Relationship.Unlinked,
				self.source_1            := MDR.sourceTools.src_FDIC,
				self.source_docid_1      := left.cert,
				self.source_party_1      := '',
				self.role_1              := 'Bank Predecessor',
				self.source_2            := MDR.sourceTools.src_FDIC,
				self.source_docid_2      := left.newcert,
				self.source_party_2      := '',
				self.role_2              := 'Bank Successor'
				));		
		return extract;
	end;	
	
end;
