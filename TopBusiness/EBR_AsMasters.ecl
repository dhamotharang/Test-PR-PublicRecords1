import EBR,MDR;

export EBR_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		base := EBR.File_0010_Header_Base_AID; // Before this date some of the data is highly suspect
		
		filtered := base(process_date != '' and file_number != '' and company_name != '');
		
		extract := normalize(filtered,if(left.clean_address.v_city_name != left.clean_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_EBR,
				self.source_docid := left.file_number + '//' + left.process_date,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := left.company_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.append_rawaid,
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
				self.county_fips := left.clean_address.county[3..5],
				self.msa := left.clean_address.msa,
				self.phone := left.phone_number,
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := left.file_number,
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
		
		base := EBR.File_5610_Demographic_Data_Base;
		
		filtered := base(process_date != '' and file_number != '' and clean_officer_name.lname != '');
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source := MDR.sourceTools.src_EBR,
				self.source_docid := left.file_number + '//' + left.process_date,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.ssn := '',
				self.name_prefix := left.clean_officer_name.title,
				self.name_first := left.clean_officer_name.fname,
				self.name_middle := left.clean_officer_name.mname,
				self.name_last := left.clean_officer_name.lname,
				self.name_suffix := left.clean_officer_name.name_suffix,
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
				self.position_title := left.officer_title,
				self.position_type := 'C';
				self.email := '',
				self.phone := ''
				));
		
		return extract;
		
	end;
	
	export dataset(Layout_TradeLines.Unlinked) As_TradeLine_Master := function
	
		base := EBR.File_2000_Trade_Base;
		
		filtered := base(process_date != '' and file_number != '' and business_category_description != '');
		
		extract := project(filtered,
			transform(Layout_TradeLines.Unlinked,
				self.source := MDR.sourceTools.src_EBR,
				self.source_docid := left.file_number + '//' + left.process_date,
				self.source_party := '',
				self.asof_date := (unsigned)left.process_date[1..6],
				self.business_category := left.business_category_description,
				self.account_balance := (unsigned)left.masked_account_balance,
				self.current_pct := (unsigned)left.current_percent,
				self.days_01_30_pct := (unsigned)left.debt_01_30_percent,
				self.days_31_60_pct := (unsigned)left.debt_31_60_percent,
				self.days_61_90_pct := (unsigned)left.debt_61_90_percent,
				self.days_91_plus_pct := (unsigned)left.debt_91_plus_percent));
		
		return extract;
	
	end;

	export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := function

	  base := EBR.File_5600_Demographic_Data_Base;
		
		filtered := base(process_date != '' and file_number != '' and yrs_in_bus_actual != '');
		
		extract := project(filtered,
			transform(Layout_Incorporation.Unlinked,
				self.source := MDR.sourceTools.src_EBR,
				self.source_docid := left.file_number + '//' + left.process_date,
				self.source_party := '',
				// self.yearsInBusiness := (integer) left.yrs_in_bus_actual;
        // OR calculate start_date from process_date - years_in_bus_actual; ???
        temp_start      := (integer)(left.process_date[1..4]) - (integer)left.yrs_in_bus_actual; 
        self.start_date := intformat(temp_start,4,1) + '0000';
				self := []));
		
		return extract;
	
	end;

	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	   
		base := EBR.File_5600_Demographic_Data_Base;
		
		filtered := base(process_date != '' and file_number != '' and sic_1_code != '');
		
		extract := normalize(filtered,
			map(
				left.sic_2_code = '' => 1,
				left.sic_3_code = '' => 2,
				left.sic_4_code = '' => 3,
				/* otherwise */         4),
		  transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_EBR,
				self.source_docid := left.file_number + '//' + left.process_date,
				self.source_party := '',
				self.SicCode := choose(counter,
					left.sic_1_code,
					left.sic_2_code,
					left.sic_3_code,
					left.sic_4_code),
				self.NAICS                := '',
				self.industry_description := '',
			));


    // Next extract industry description type data from the 0010 header recs.
		// Similar data (INDUSTRY_DESCRIPTION) is also on the 1000 executive summary recs, 
		// but the data on the 0010 record appears to be better.
		base0010 := EBR.File_0010_Header_Base;
		
		filtered0010 := base0010(process_date != '' and file_number != '' and business_desc != '');
		
		extract0010 := project(filtered0010,
		  transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_EBR,
				self.source_docid := left.file_number + '//' + left.process_date,
				self.source_party := '',
				self.SicCode              := '',
				self.NAICS                := '',
			  // Even though the field used below is labeled as "business_desc", the field has
				// industry type info in it instead of an actual description of the company/business.  
			  // So it was decided to put that type of info in industry_description field on the 
				// layout_industry instead of in the business_description on the layout_abstract.
				self.industry_description := left.business_desc,
			));

		return extract + extract0010;
		
	end;
	
	export dataset(Layout_Liens.Main.Unlinked) As_Liens_Master := function
	
		base := EBR.File_4020_Tax_Liens_Base;
		
		filtered := base(process_date != '' and file_number != '' and document_number != '');
		
		extract := project(filtered,
			transform(Layout_Liens.Main.Unlinked,
				self.source := MDR.sourceTools.src_EBR,
				self.source_docid := left.file_number + '//' + left.process_date,
				//self.source_party := '', ???
				self.filing_jurisdiction := left.filing_location,
				self.orig_filing_number := left.document_number,
				self.orig_filing_type := map(
					left.type_description = 'STAT-TX-' => 'STATE TAX LIEN',
					left.type_description = 'FED-TX-' => 'FEDERAL TAX LIEN',
					left.type_description),
				self.orig_filing_date := left.date_filed,
				self.amount := left.liability_amount,
				self := []));
		
		return extract;
	
	end;
	
	export dataset(Layout_UCC.Main.Unlinked) As_UCC_Master := function
	
		base := EBR.File_4510_UCC_Filings_Base;
		
		filtered := base(process_date != '' and file_number != '' and orig_file_number != '');
		
		extract := project(filtered,
			transform(Layout_UCC.Main.Unlinked,
				self.source := MDR.sourceTools.src_EBR,
				self.source_docid := left.file_number + '//' + left.process_date,
				//self.source_party := '', ???
				self.filing_jurisdiction := left.orig_file_state_code,
				self.orig_filing_number := left.orig_file_number,
				self.orig_filing_type := left.type_desc,
				self.orig_filing_date := '',
				self.status_type := left.action_desc,
				self.expiration_date := '',
				self.filing_number := left.document_number,
				self.filing_type := '',
				self.filing_date := left.date_filed,
				self.filing_status := '',
				self := []));
		
		return extract;
	
	end;
			
	export dataset(Layout_UCC.Party) As_UCC_Master_Party := function
	
		base := EBR.File_4510_UCC_Filings_Base;
		
		filtered := base(process_date != '' and file_number != '' and orig_file_number != '' and (secured_party != '' or assignee != ''));
		
		extract := normalize(filtered,2,
			transform(Layout_UCC.Party,
				//self.source := MDR.sourceTools.src_EBR,
				//self.source_docid := left.file_number + '//' + left.process_date,
				//self.source_party := '', ???
				self.filing_jurisdiction := left.orig_file_state_code,
				self.orig_filing_number := left.orig_file_number,
				self.filing_number := left.document_number,
				self.orig_name := choose(counter,left.secured_party,left.assignee),
				self.party_type := choose(counter,'S','A'),
				self := []))(orig_name != '');
		
		return extract;
	
	end;
			
/*
	export dataset(Layout_Finance.Unlinked) As_Finance_Master := function

		base := EBR.File_5600_Demographic_Data_Base; // ???
		
		filtered := base(process_date != '' and file_number != '' and record_type = 'C' and // only current recs ???
                     (sales_actual != '0' or sales_actual != '000000{'));  ???
		
		extract := project(filtered,
			transform(Layout_Finance.Unlinked,
				self.source := MDR.sourceTools.src_EBR,
				self.source_docid := left.file_number + '//' + left.process_date,
				self.source_party := '',
				//self.FiscalYearEnding := (unsigned4) left.???_date,
				self.sales := (integer) left.sales_actual * 1000, //per specs data is in hundreds of thousands???
        //                       ^--- convert position 7 which is an EBCDIC signed value(?)
        //              "{" & A thru I to +0 thru +9 AND "}" & J thru R to -0 thru -9 ???
				self := []));
					
		return extract;
	
	end;	
*/

end;
