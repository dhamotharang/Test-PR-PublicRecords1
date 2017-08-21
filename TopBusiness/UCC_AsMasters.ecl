import UCCv2, MDR, census_data; //address; //uccv2_services;

export UCC_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base_party := UCCv2.File_UCC_Party_Base;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base_party(process_date != '' and tmsid != '' and company_name != '' and company_name not in ['PRO SE','PRO-SE']);
		
		extract := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_UCCv2,
				self.source_docid := trim(left.tmsid,left,right),
				self.source_party := left.party_type[1] + intformat(hash32(left.orig_name,left.orig_address1,left.orig_address2,left.orig_city,left.orig_state,left.orig_zip5) % 1000000000,9,1),
				self.date_first_seen := left.dt_first_seen * 100,
				self.date_last_seen := left.dt_last_seen * 100,
				self.company_name := left.company_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.prim_range,
				self.predir := left.predir,
				self.prim_name := left.prim_name,
				self.addr_suffix := left.suffix,
				self.postdir := left.postdir,
				self.unit_desig := left.unit_desig,
				self.sec_range := left.sec_range,
				self.city_name := choose(counter,
					left.p_city_name,
					left.v_city_name),
				self.state := left.st,
				self.zip := left.zip5,
				self.zip4 := left.zip4,
				self.county_fips := left.ace_fips_county,
				self.msa := left.msa,
				self.phone := '',
				self.fein := left.fein,
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));		
		return extract;	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function

		company_filtered := base_party(tmsid != '' and company_name != '');
		person_filtered := base_party(tmsid != '' and lname != '');
		
		codebtors := join(
			company_filtered(party_type = 'D'),
			person_filtered(party_type = 'D'),
			left.tmsid = right.tmsid,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_UCCv2,
				self.source_docid := trim(left.tmsid,left,right),
				self.source_party := left.party_type[1] + intformat(hash32(left.orig_name,left.orig_address1,left.orig_address2,left.orig_city,left.orig_state,left.orig_zip5) % 1000000000,9,1),
				self.date_first_seen := left.dt_first_seen * 100,
				self.date_last_seen := left.dt_last_seen * 100,
				self.ssn := right.ssn,
				self.did := (unsigned)right.did,
				self.score := right.did_score,
				self.name_prefix := right.title,
				self.name_first := right.fname,
				self.name_middle := right.mname,
				self.name_last := right.lname,
				self.name_suffix := right.name_suffix,
				self.addr_suffix := right.suffix,
				self.city_name := right.p_city_name,
				self.zip := right.zip5,
				self.state := right.st,
				self.position_title := 'Co-Debtors',
				self.position_type := 'O',
				self.email := '',
				self.phone := '',
				self := right));
		
		return codebtors;
				
	end;
		
	export dataset(TopBusiness.Layout_UCC.Main.unlinked) As_UCC_Master := function
	  main_base := UCCV2.File_UCC_Main_Base;		             
		filtered := main_base( orig_filing_number != '');
		extract := project(filtered, transform (Layout_UCC.main.unlinked,
				self.source := MDR.sourceTools.src_UCCv2,
				self.source_docid := trim(left.tmsid,left,right),			
		    self.Filing_Jurisdiction := left.filing_jurisdiction,
  	    //self.filing_jurisdiction_name := left.filing_jurisdiction_name,
	      self.orig_filing_number := if(left.orig_filing_number != '',left.orig_filing_number,left.filing_number),
	      self.orig_filing_type := left.orig_filing_type,
	      self.orig_filing_date := left.orig_filing_date,
				self.status_type := left.status_type,
				self.expiration_date := left.expiration_date;		
				self.filing_number := left.filing_number,
				self.filing_type := StringLib.StringToUpperCase(left.filing_type),
				self.filing_date := left.filing_date,
				self.filing_status := StringLib.StringToUpperCase(left.filing_status),
				self.page := left.page,
				self.contract_type := left.contract_type,
				self.amount := left.amount,
				self.irs_serial_number := left.irs_serial_number,
				self.effective_date := left.effective_date,
				self.filing_agency := left.filing_agency,
				self.filing_agency_address := left.address,
				self.filing_agency_city := left.city,
				self.filing_agency_state := left.state,
				self.filing_agency_county := left.county,
				self.filing_agency_zip := left.zip
				));
				
				return extract;	    
	end;
	
	//export dataset(Layout_ucc.party) As_UCC_Master_Party(dataset(layout_ucc.main.unlinked) in_layout) := function
  export dataset(TopBusiness.Layout_UCC.Party) As_UCC_Master_Party:= function
		extract := join(dedup(UCCV2.File_UCC_Main_Base,filing_jurisdiction,if(orig_filing_number != '',orig_filing_number,filing_number),tmsid,all),base_party,
			left.tmsid = right.tmsid,
			transform(TopBusiness.Layout_UCC.Party,
				self.filing_jurisdiction := left.filing_jurisdiction,
	      self.orig_filing_number := if(left.orig_filing_number != '',left.orig_filing_number,left.filing_number),
				self.filing_number := left.filing_number,
				self.county_name := '',
				self := right));

		add_county_name :=
			join(
				extract,
				census_data.file_fips2county,
				left.county = right.county_fips and
				left.st = right.state_code,
				transform(TopBusiness.Layout_UCC.Party,
					self.county_name := right.county_name,
					self := left),
				left outer,
				lookup);
		
		return dedup(dedup(add_county_name,record,all,local),record,all);
	
	end;
	
	export dataset(TopBusiness.Layout_UCC.Collateral) As_UCC_Master_Collateral := function
	
		filtered := dedup(UCCV2.File_UCC_Main_Base(orig_filing_number != '' and collateral_desc != ''),filing_jurisdiction,orig_filing_number,filing_number,collateral_desc,all);
		
		filtproj := ungroup(project(group(sort(filtered,orig_filing_number),orig_filing_number),transform(
			{filtered;unsigned __collseq;},
			self.__collseq := counter,
			self := left)));
		
		extract := normalize(filtproj,((length(trim(left.collateral_desc)) - 1) div 100) + 1,
			transform(TopBusiness.Layout_UCC.Collateral,
				self.CollateralNumber := left.__collseq,
				self.CollateralSequence := counter,
				self.CollateralDescription := trim(left.collateral_desc)[((counter * 100) - 99)..(counter * 100)],
				self := left));
		
		return extract;
	
	end;

end;
