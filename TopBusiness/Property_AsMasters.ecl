import LN_PropertyV2, iesp, MDR, census_data;
export Property_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	base0 := LN_PropertyV2.file_search_building;
	shared base :=
		join(
			base0,
			census_data.file_fips2county,
			left.county[3..5] = right.county_fips and
			left.st = right.state_code,
			transform({recordof(base0);string18 county_name;},
				self.county_name := right.county_name,
				self := left),
			left outer,
			lookup) : persist('~thor40_241_7::persist::brm::propertybase');

	shared assessment_file := LN_PropertyV2.File_Assessment; 
	// LN_PropertyV2.file_assessment_building 
	// contains other fields needed. 
	shared deed_file := ln_propertyV2.File_Deed; // LN_PropertyV2.file_deed_building
	shared filtered := base(cname != '') : independent; 
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		
		// also have a field named nameasIs which seems to be more expanded and longer than cname	(company name field)	
		// Source_code[1] ='O' -- Owner
		// Vendor source_flag  = F, O, D, S (Fares, Dayton, OKCity, Supplemental)
		//
		// rec_type is returned from address cleaner:
		
		// F Firm.
		// G General delivery.
		// H High-rise apartment or office building.
		// M Military.
		// P Post office box.
		// R Rural route or highway contract.
		// S Street (usually, one side of one city block).
		// Blank Unassigned.
		// tonymkirk: 
		// The second character may be a D or blank. The D stands for default; it means that
		// ACE detected, from the ZIP+4 directory, that a finer level of ZIP+4 assignment would
		// be possible if further input information were available.
		
		//requirement notes:
		   
			     //Current and prior subsections
					 
					 //1.Current subsec : properties in which input bid is current owner or a buyer (past or present)
					 //2. Prior subsec : input bid has sold property (at any time)
					 
					 // properties grouped by state in each current/prior subsection
					 // within a state:  Within a state, the properties will be ordered reverse-chronologically, 
					 // so the most newly acquired properties are first, and the oldest or longest held property is last. 			                                       		
		
		  // only get addresses for linking build that are owner
		
		// Not going to take the OO ("owner" name with "owner" address) when a "CO" ("care/of" name with "owner" address)
		// exists because it appears that the address is actually that of the care/of.  So, I'll take the "CO" in those cases
		// but only take the owner name (via the property address record)
		// Also... ignoring CP (care/of name with property address) records, because there isn't a direct connection.
		jointoremoveco := join(
			filtered(source_code != 'CP'),
			filtered(source_code = 'CO'),
			left.ln_fares_id = right.ln_fares_id and
			left.source_code = 'OO',
			transform(recordof(filtered),
				self.prim_range := if(right.ln_fares_id != '','',left.prim_range),
				self.predir := if(right.ln_fares_id != '','',left.predir),
				self.prim_name := if(right.ln_fares_id != '','',left.prim_name),
				self.suffix := if(right.ln_fares_id != '','',left.suffix),
				self.postdir := if(right.ln_fares_id != '','',left.postdir),
				self.unit_desig := if(right.ln_fares_id != '','',left.unit_desig),
				self.sec_range := if(right. ln_fares_id != '','',left.sec_range),
				self.p_city_name := if(right.ln_fares_id != '','',left.p_city_name),
				self.v_city_name := if(right.ln_fares_id != '','',left.v_city_name),
				self.st := if(right.ln_fares_id != '','',left.st),
				self.zip := if(right.ln_fares_id != '','',left.zip),
				self.msa := if(right.ln_fares_id != '','',left.msa),
				self := left),
			left outer);
		
		notaxdept := jointoremoveco(
			not(
				source_code[1] = 'C' and (
					stringlib.stringfind(nameasis,'TAX DEPT',1) > 0 or
					stringlib.stringfind(nameasis,'TAX DEPARTMENT',1) > 0 or
					stringlib.stringfind(cname,'TAX DEPT',1) > 0 or
					stringlib.stringfind(cname,'TAX DEPARTMENT',1) > 0)));
		extract := normalize(notaxdept,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
			  isAPropertyRec := left.source_code[2] = 'P';
				self.source := MDR.sourceTools.fProperty(left.ln_fares_id),
				self.source_docid := left.ln_fares_id;
        self.source_party := left.source_code[1] + hash64(if(left.nameasis != '',left.nameasis,left.cname)),
				self.date_first_seen := (unsigned4)left.dt_first_seen * 100,
				self.date_last_seen := (unsigned4)left.dt_last_seen * 100,
				self.company_name := if(left.nameasis != '',left.nameasis,left.cname),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := if(isAPropertyRec,Constants.Address_Types.PROPERTY,Constants.Address_Types.UNKNOWN),
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.prim_range;
				self.predir := left.predir;
				self.prim_name := left.prim_name;
				self.addr_suffix := left.suffix;
				self.postdir := left.postdir;
				self.unit_desig := left.unit_desig;
				self.sec_range := left.sec_range;
				self.city_name := choose(counter,
					left.p_city_name,
					left.v_city_name),
				self.state := left.st,
				self.zip := left.zip,
				self.zip4 := left.zip4,
				self.county_fips := left.county[3..5],
				self.msa := left.msa,
				self.phone := left.phone_number;
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
			return dedup(dedup(extract,record,all,local),record,all);
		end;
		
		export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
		
			extract_coowners := join(
				distribute(base(lname != ''),hash64(ln_fares_id)),
				distribute(filtered(ln_fares_id[2] = 'D'),hash64(ln_fares_id)),
				left.ln_fares_id = right.ln_fares_id,
				transform(Layout_Contacts.Unlinked,
					self.source := MDR.sourceTools.fProperty(right.ln_fares_id),
					self.source_docid := right.ln_fares_id;					
					self.source_party := right.source_code[1] + hash64(if(right.nameasis != '',right.nameasis,right.cname)),
					self.date_first_seen := (unsigned4)right.dt_first_seen * 100,
					self.date_last_seen := (unsigned4)right.dt_last_seen * 100,
					self.ssn := '',
					self.did := left.did,
					self.score := 0,
					self.name_prefix := left.title,
					self.name_first := left.fname,
					self.name_middle := left.mname,
					self.name_last := left.lname,
					self.name_suffix := left.name_suffix,
					self.addr_suffix := left.suffix,
					self.city_name := left.p_city_name,
					self.state := left.st,
					self.position_title := map(
						left.source_code[1] = 'S' and right.source_code[1] = 'S' => 'PROPERTY CO-SELLER',
						left.source_code[1] = 'S' and right.source_code[1] = 'O' => 'PROPERTY SELLER',
						left.source_code[1] = 'O' and right.source_code[1] = 'S' => 'PROPERTY BUYER',
						left.source_code[1] = 'O' and right.source_code[1] = 'O' => 'PROPERTY CO-OWNER',
						skip),
					self.position_type := 'O',
					self.phone := left.phone_number,
					self.email := '',
					self := left),
				local);
			
			return dedup(dedup(extract_coowners,record,all,local),record,all);
			
		end;
		
		export dataset(Layout_Property.Main.Unlinked) As_Property_Master := function
				     
			extract_assessment:=  join(
				distribute(assessment_file,hash64(ln_fares_id)),
				distribute(filtered (source_code[2] = 'P'),hash64(ln_fares_id)),
			  left.ln_fares_id = right.ln_Fares_id, // Vendor source_flag  = F, O, D, S (Fares, Dayton, OKCity, Supplemental),
			  transform(Layout_Property.Main.Unlinked,
					self.source := MDR.sourceTools.fProperty(left.ln_fares_id),
					 self.source_docid := left.ln_fares_id;					
					 self.event_id     := left.ln_fares_id;
					 self.vendor       := left.vendor_source_flag;
					 self.county_code  := left.fips_code;
					self.apn    := left.fares_unformatted_apn, // set to default change later								
					self.legal_description := left.legal_brief_description,
					 self.property_address := iesp.ECL2ESP.SetAddress(
							right.prim_name,right.prim_range,right.predir,right.postdir,
							right.suffix,right.unit_desig,right.sec_range,right.v_city_name,
							if(right.st = '',left.state_code,right.st),right.zip,
							right.zip4,if(right.county_name = '',left.county_name,right.county_name),
							'','','','')),
				left outer,
				local);
	
			extract_deed:=  join(
				distribute(deed_file,hash64(ln_fares_id)),
				distribute(filtered (source_code[2] = 'P'),hash64(ln_fares_id)),
			  left.ln_fares_id = right.ln_Fares_id, // Vendor source_flag  = F, O, D, S (Fares, Dayton, OKCity, Supplemental),
			  transform(Layout_Property.Main.Unlinked,
					self.source := MDR.sourceTools.fProperty(left.ln_fares_id),
					 self.source_docid := left.ln_fares_id;					
					 self.event_id     := left.ln_fares_id;
					 self.vendor       := left.vendor_source_flag;
					 self.county_code  := left.fips_code,
					self.apn    := left.fares_unformatted_apn, // set to default change later								
					self.legal_description := left.legal_brief_description,
					 self.property_address := iesp.ECL2ESP.SetAddress(
							right.prim_name,right.prim_range,right.predir,right.postdir,
							right.suffix,right.unit_desig,right.sec_range,right.v_city_name,
							if(right.st = '',left.state,right.st),right.zip,
							right.zip4,if(right.county_name = '',left.county_name,right.county_name),
							'','','','')),
				left outer,
				local);
	
	     return dedup(dedup(extract_assessment + extract_deed,record,all,local),record,all);
	  end;
		
		export dataset(Layout_Property.Party.Unlinked) As_Property_Master_Party := function
	  
		extract := project(base, //(source_code[1] ='O' or source_code[1] = 'B' or source_code[1] = 'S'),
			transform(Layout_Property.Party.Unlinked,
				self.source := MDR.sourceTools.fProperty(left.ln_fares_id),
				self.source_docid := left.ln_fares_id;
        self.source_party := left.source_code[1] + hash64(if(left.nameasis != '',left.nameasis,left.cname)),
				isAPropertyRec := left.source_code[2] = 'P';
				self.event_id  := left.ln_fares_id,			
				self.vendor := left.vendor_source_flag, // similar to ln_fares_id[1] = R, O, D but vendor_source_flag 
				                                       // also includes S as well so using this field.
																							 //LN_PropertyV2.Key_Prop_Ownership_V4
				self.party_type   := left.source_code[1],
				self.party_type_address := left.source_code[2],
				// self.current_record := project(assessment_file(ln_fares_id != ''),transform({string1 current_record;},
				                               // self := left)).current_record[1];
				self.salesPrice  := 0; //left.sale TODO : 2356099946 total recs in assessor only 
				                                       //  918061566 recs have a sales price
				self.owner_date   := left.dt_last_seen * 100;
				self.sales_date   := left.dt_last_seen * 100; // TODO need to update this
				self.company_name := if(left.nameasis != '',left.nameasis,left.cname),
				self.name_last    := left.lname,
				self.name_first   := left.fname,
				self.name_middle  := left.mname,
				self.name_suffix  := left.name_suffix,
				self.name_title   := left.title,
				self.prim_range   := if (isAPropertyRec, '', left.prim_range),
				self.predir       := if (isAPropertyRec, '', left.predir),
				self.prim_name    := if (isAPropertyRec, '', left.prim_name),
				self.addr_suffix  := if (isAPropertyRec, '', left.suffix),
				self.postdir      := if (isAPropertyRec, '', left.postdir),
				self.unit_desig   := if (isAPropertyRec, '', left.unit_desig),
				self.sec_range    := if (isAPropertyRec, '', left.sec_range),
				self.city_name    := if (isAPropertyRec, '',left.v_city_name),
				self.state        := if (isAPropertyRec, '', left.st),
				self.zip          := if (isAPropertyRec, '', left.zip),				
				self.zip4         := if (isAPropertyRec, '', left.zip4),
				self.county_name  := if (isAPropertyRec, '', left.county_name),
			));				
		return extract;						       								
	end;
			
			export dataset(Layout_Property.Assessment.Unlinked) As_Property_Master_Assessment := function
				extract := project(assessment_file(ln_fares_id != '' and ln_fares_id[2] = 'A'), // needed for join later.
				transform(Layout_Property.Assessment.Unlinked,
			    self.event_id              := left.ln_fares_id,
					self.vendor                := left.vendor_source_flag,
					self.current_record        := left.current_record,
					self.document_type         := left.document_type,
					self.isForeclosedNOD       := false,
					self.assessed_land_value   := left.assessed_land_value,
					self.assessed_improvement_value := left.assessed_improvement_value,
					self.assessed_total_value  := left.assessed_total_value,
					self.market_land_value     := left.market_land_value,
					self.market_improvement_value := left.market_improvement_value,
		      self.market_total_value    := left.market_total_value,				
					self.sales_price           := left.sales_price,
					self.assessment_date       := left.assessed_value_year + '0000';  // to pad out since only year is listed				
					self.county                := left.county_name,
					self.tax_year              := left.tax_year,
					self.TransactionType       := left.Document_Type));					
					// TODO : probably more fields may be needed here as well
					return dedup(dedup(extract,record,all,local),record,all);
			end;
			 
			export dataset(Layout_Property.Deed.Unlinked) As_Property_Master_Deed := function
				extract := project(deed_file(ln_fares_id != '' and ln_fares_id[2] = 'D'), // needed for join later.
				transform(Layout_Property.Deed.Unlinked,
			    self.event_id              := left.ln_fares_id,
					self.vendor                := left.vendor_source_flag,
					self.current_record        := left.current_record,
					self.document_type_code    := left.document_type_code,
					self.recording_date       :=   left.recording_date;
					self.contract_date        :=   left.contract_date; // TODO need to update this
					self.document_number      := left.document_number,
					self.book_number          := left.recorder_book_number,
					self.page_number          := left.recorder_page_number,
					self.sales_price          := left.sales_price,
					self.LoanAmount           :=  left.first_td_loan_amount;
					self.LoanAmountSecMort    :=  left.second_td_loan_amount;
					self.LoanDate             :=  if (left.contract_date <> '', left.contract_date, left.recording_date);
					self.LoanDueDate          := left.first_td_due_date;
					self.LoanInterestRate     := left.first_td_interest_rate;
					self.loan_type_code       := left.first_td_loan_type_code;
	        self.Lender_Name           :=	left.lender_name;
					self.first_td_loan_amount  := left.first_td_loan_amount;
		      self.second_td_loan_amount := left.second_td_loan_amount;
		      self.buyer_or_borrower_ind := left.buyer_or_borrower_ind; //new - 'O' for buyer, 'B' for borrower
		      self.county_name           := left.county_name;
					self.title_company_name    := left.title_company_name;
					));
					// TODO : probably more fields may be needed here as well
					return dedup(dedup(extract,record,all,local),record,all);
			end;
	
		// export dataset(Layout_Relationship.Unlinked) As_Relationship_Master := function
		
			// tempjoin := join(
				// dedup(distribute(filtered(source_code[1] = 'C'),hash64(ln_fares_id)),ln_fares_id,if(nameasis != '',nameasis,cname),all),
				// dedup(distribute(filtered(source_code[1] = 'O'),hash64(ln_fares_id)),ln_fares_id,if(nameasis != '',nameasis,cname),all),
				// left.ln_fares_id = right.ln_fares_id,
				// transform(Layout_Relationship.Unlinked,
					// self.source_1 := MDR.sourceTools.fProperty(left.ln_fares_id),
					// self.source_docid_1 := left.ln_fares_id;
					// self.source_party_1 := left.source_code[1] + hash64(if(left.nameasis != '',left.nameasis,left.cname)),
					// self.role_1 := 'PROPERTY INTERMEDIARY',
					// self.source_2 := MDR.sourceTools.fProperty(right.ln_fares_id),
					// self.source_docid_2 := right.ln_fares_id;
					// self.source_party_2 := right.source_code[1] + hash64(if(right.nameasis != '',right.nameasis,right.cname)),
					// self.role_2 := 'PROPERTY_OWNER'),
				// local);
			
			// return tempjoin;
		
		// end;
		
	end;