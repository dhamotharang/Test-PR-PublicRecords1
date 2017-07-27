import Jigsaw,MDR;

export Jigsaw_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := Jigsaw.Files(,true).Base.QA;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(rawfields.companyid != '' and rawfields.contactid != '' and rawfields.companyname != '');
		
		extract_1 := normalize(filtered,
			if(left.clean_address.v_city_name != left.clean_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Jigsaw,
				self.source_docid := left.rawfields.companyid + '//' + left.rawfields.contactid,
				self.source_party := 'C' + hash32(left.rawfields.companyname),
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.rawfields.companyname),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.raw_aid,
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
				self.county_fips := left.clean_address.fips_county,
				self.msa := left.clean_address.msa,
				self.phone := left.rawfields.phone,
				self.fein := '',
				self.url := left.rawfields.companyurl,
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		extract_2 := normalize(filtered(rawfields.email != ''),
			if(left.clean_address.v_city_name != left.clean_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Jigsaw,
				self.source_docid := left.rawfields.companyid + '//' + left.rawfields.contactid,
				self.source_party := 'C' + hash32(left.rawfields.companyname),
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.rawfields.companyname),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.raw_aid,
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
				self.county_fips := left.clean_address.fips_county,
				self.msa := left.clean_address.msa,
				self.phone := left.rawfields.phone,
				self.fein := '',
				self.url := if(stringlib.StringFind(left.rawfields.email,'@',1) > 0,left.rawfields.email[stringlib.StringFind(left.rawfields.email,'@',1) + 1..],''),
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract_1 + extract_2;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		filtered := base(rawfields.companyid != '' and rawfields.contactid != '' and clean_name.lname != '');
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_Jigsaw,
				self.source_docid := left.rawfields.companyid + '//' + left.rawfields.contactid,
				self.source_party := 'C' + hash32(left.rawfields.companyname),
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.ssn := '',
				self.name_prefix := left.clean_name.title,
				self.name_first := left.clean_name.fname,
				self.name_middle := left.clean_name.mname,
				self.name_last := left.clean_name.lname,
				self.name_suffix := left.clean_name.name_suffix,
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
				self.position_title := stringlib.StringToUpperCase(left.rawfields.title),
				self.position_type := 'C';
				self.email := left.rawfields.email,
				self.phone := '',
				));
		
		return extract;
	
	end;
		
	export dataset(Layout_TradeLines.Unlinked) As_TradeLine_Master := dataset([],Layout_TradeLines.Unlinked);
	
	export dataset(Layout_URLs.Unlinked) As_URL_Master := function
	
		filtered := base(rawfields.companyid != '' and rawfields.contactid != '' and rawfields.companyurl != '');
		
		extract := project(filtered,
			transform(Layout_URLs.Unlinked,
				self.source := MDR.sourceTools.src_Jigsaw,
				self.source_docid := left.rawfields.companyid + '//' + left.rawfields.contactid,
				self.source_party := 'C' + hash32(left.rawfields.companyname),
				self.url := left.rawfields.companyurl));
		
		return extract;
	
	end;

end;
