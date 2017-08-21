import DCA,MDR;

export DCA_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := DCA.File_DCA_Base;
			
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(process_date != '' and root != '' and sub != '' and name != '');
		
		extract_1 := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_DCA,
				self.source_docid := left.root + '-' + left.sub,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.company_name := stringlib.StringToUpperCase(left.name),
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
				self.zip := left.z5,
				self.zip4 := left.zip4,
				self.county_fips := left.county[3..5],
				self.msa := left.msa,
				self.phone := left.phone,
				self.fein := '',
				self.url := left.url,
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.incorp,
				self.incorp_number := ''));

		extract_2 := normalize(filtered(fax != ''),if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_DCA,
				self.source_docid := left.root + '-' + left.sub,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.company_name := stringlib.StringToUpperCase(left.name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.FAX,
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
				self.zip := left.z5,
				self.zip4 := left.zip4,
				self.county_fips := left.county[3..5],
				self.msa := left.msa,
				self.phone := left.fax,
				self.fein := '',
				self.url := left.url,
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.incorp,
				self.incorp_number := ''));
		
		return extract_1 + extract_2;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
		
		filtered := base(process_date != '' and root != '' and sub != '' and exec1_lname != '');
		
		extract := normalize(filtered,10,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_DCA,
				self.source_docid := left.root + '-' + left.sub,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.process_date,
				self.date_last_seen := (unsigned4)left.process_date,
				self.ssn := '',
				self.did := 0,
				self.score := 0,
				self.name_prefix := choose(counter,
					left.exec1_title,
					left.exec2_title,
					left.exec3_title,
					left.exec4_title,
					left.exec5_title,
					left.exec6_title,
					left.exec7_title,
					left.exec8_title,
					left.exec9_title,
					left.exec10_title),
				self.name_first := choose(counter,
					left.exec1_fname,
					left.exec2_fname,
					left.exec3_fname,
					left.exec4_fname,
					left.exec5_fname,
					left.exec6_fname,
					left.exec7_fname,
					left.exec8_fname,
					left.exec9_fname,
					left.exec10_fname),
				self.name_middle := choose(counter,
					left.exec1_mname,
					left.exec2_mname,
					left.exec3_mname,
					left.exec4_mname,
					left.exec5_mname,
					left.exec6_mname,
					left.exec7_mname,
					left.exec8_mname,
					left.exec9_mname,
					left.exec10_mname),
				self.name_last := choose(counter,
					left.exec1_lname,
					left.exec2_lname,
					left.exec3_lname,
					left.exec4_lname,
					left.exec5_lname,
					left.exec6_lname,
					left.exec7_lname,
					left.exec8_lname,
					left.exec9_lname,
					left.exec10_lname),
				self.name_suffix := choose(counter,
					left.exec1_name_suffix,
					left.exec2_name_suffix,
					left.exec3_name_suffix,
					left.exec4_name_suffix,
					left.exec5_name_suffix,
					left.exec6_name_suffix,
					left.exec7_name_suffix,
					left.exec8_name_suffix,
					left.exec9_name_suffix,
					left.exec10_name_suffix),
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
				self.position_title := stringlib.StringToUpperCase(choose(counter,
					left.title_1,
					left.title_2,
					left.title_3,
					left.title_4,
					left.title_5,
					left.title_6,
					left.title_7,
					left.title_8,
					left.title_9,
					left.title_10)),
				self.email := '',
				self.phone := '',
				self.position_type := 'C';
				))(name_last != '');
		
		return extract;
		
	end;
	
	export dataset(Layout_URLs.Unlinked) As_URL_Master := function
	
		filtered := base(process_date != '' and root != '' and sub != '' and url != '');
		
		extract := project(filtered,
			transform(Layout_URLs.Unlinked,
				self.source := MDR.sourceTools.src_DCA,
				self.source_docid := left.root + '-' + left.sub,
				self.source_party := '',
				self.url := left.url));
		
		return extract;
	
	end;
	
	export dataset(Layout_Finance.Unlinked) As_Finance_Master := function
	
		filtered := base(process_date != '' and root != '' and sub != '' and fye != '' and
		 (sales != '' OR (assets != '' and liabilities != '')));
		
		extract := project(filtered,
			transform(Layout_Finance.Unlinked,
				self.source := MDR.sourceTools.src_DCA,
				self.source_docid := left.root + '-' + left.sub,
				self.exchange := left.exchange1,
				self.ticker := left.ticker_symbol,
				self.FiscalYearEnding := (unsigned4) if (length(left.fye) = 6, 
				  if ((integer) left.fye[5..6] < 50,
					   '20' + left.fye[5..6] + left.fye[1..2] + left.fye[3..4],
					   '19' + left.fye[5..6] + left.fye[1..2] + left.fye[3..4]),
					left.fye); // e.g. FYE = 123109  OR do we just leave it as strictly what
										 // was on the rec and not attempt to format it?																				 
				self.sales := (integer) left.sales,
				self.profitsLoss := (integer) left.earnings;
				self.TotalAssets := (integer) left.assets,
				self.TotalLiabilities := (integer) left.liabilities,
				tmp_networth :=  (integer) left.assets - (integer) left.liabilities;
				self.networth := tmp_networth;
				self.totalLiabilitiesToNetWorth := (real) ((integer) left.liabilities / tmp_networth);
				self := [])); 
					
		return extract;
	
	end;
	
	export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := function
	
		filtered := base(process_date != '' and root != '' and sub != '' and
			(parent_number != '' or jv1_ != '' or jv2_ != ''));
		
		extract := normalize(filtered,
			3,
			transform(Layout_Relationship.Unlinked,
			self.source_1 := MDR.sourceTools.src_DCA,
			self.source_docid_1 := left.root + '-' + left.sub,
			self.source_party_1 := '',
			self.role_1 := left.type_orig,
			self.source_2 := MDR.sourceTools.src_DCA,
			self.source_docid_2 := choose(counter,
				left.parent_number,
				left.jv1_,
				left.jv2_),
			self.source_party_2 := '',
			self.role_2 := 'Parent'));
		
		return extract(source_docid_2 != '');
	
	end;

	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	
		filtered := base(process_date != '' and root != '' and sub != '' and Sic1 != '');

		extract := normalize(filtered,
			map(
				left.Sic2  = '' => 1,
				left.Sic3  = '' => 2,
				left.Sic4  = '' => 3,
				left.Sic5  = '' => 4,
				left.Sic6  = '' => 5,
				left.Sic7  = '' => 6,
				left.Sic8  = '' => 7,
				left.Sic9  = '' => 8,
				left.Sic10 = '' => 9,
				/* otherwise */   10),
			transform(Layout_Industry.Unlinked,
			  self.source       := MDR.sourceTools.src_DCA,
			  self.source_docid := left.root + '-' + left.sub,
				self.source_party := '',
				self.SicCode      := choose(counter,  
					left.Sic1, 
					left.Sic2,
					left.Sic3,
					left.Sic4,
					left.Sic5,
					left.Sic6,
					left.Sic7,
					left.Sic8,
					left.Sic9,
					left.Sic10),
				self.NAICS                := '';
				self.industry_description := '';
				));
		
		return extract;
	
	end;	

	export dataset(Layout_Abstract.Unlinked) As_Abstract_Master := function

	    filtered := base(process_date != '' and root != '' and sub != '' and bus_desc != '');

			extract := project(filtered,
			  transform(Layout_Abstract.unlinked,
			    self.source       := MDR.sourceTools.src_DCA,
			    self.source_docid := left.root + '-' + left.sub,
			    self.source_party := '',
			    // The bus_desc field does have industry info in it, but it also at times
				  // contains other non-industry related information about the company.
				  // So it was decided to put that type of info in the business_description 
					// field on the layout_abstract instead of the layout_industry.
          self.business_description := left.bus_desc;
					));

			return extract;

	end;

end;
