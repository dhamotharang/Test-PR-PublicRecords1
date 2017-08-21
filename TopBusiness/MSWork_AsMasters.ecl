import govdata,MDR;

export MSWork_AsMasters := module(Interface_AsMasters.Unlinked.Base)

	shared base := govdata.File_MS_Workers_Comp_BDID;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(employer_name != '');
		
		extract_employer := normalize(filtered,
			if(left.emp_v_city_name != left.emp_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_MS_Worker_Comp,
				self.source_docid := left.mwee_no, // ??
				self.source_party := 'EMP',
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.employer_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.emp_prim_range,
				self.predir := left.emp_predir,
				self.prim_name := left.emp_prim_name,
				self.addr_suffix := left.emp_addr_suffix,
				self.postdir := left.emp_postdir,
				self.unit_desig := left.emp_unit_desig,
				self.sec_range := left.emp_sec_range,
				self.city_name := choose(counter,
					left.emp_p_city_name,
					left.emp_v_city_name),
				self.state := left.emp_st,
				self.zip := left.emp_zip5,
				self.zip4 := left.emp_zip4,
				self.county_fips := left.emp_fipscounty,
				self.msa := left.emp_msa,
				self.phone := '', //left.telephone_number,
				self.fein := left.employer_fein,
				self.url := '',
				self.duns := '', //left.duns_number,
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '', //left.state_of_incorporation_abbr,
				self.incorp_number := ''));
  
	  extract_carrier :=  project(filtered(carrier_name != ''),		
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_MS_Worker_Comp,
				self.source_docid := left.mwee_no, // ??
				self.source_party := 'CARR',
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := stringlib.StringToUpperCase(left.carrier_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
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
				self.phone := '', 
				self.fein := '',
				self.url := '',
				self.duns := '', 
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '', 
				self.incorp_number := ''));
		
		return extract_employer + extract_carrier;
	
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	   filtered := base(firm_name != ''); // what to filter on??
	  extract := project(filtered,
		  transform(Layout_contacts.Unlinked,		
			  self.source := 'CB',
				self.source_docid := left.account_number, // ??		
				self.name_prefix   := '';
		    self.name_first    := left.owner_fname;
		    self.name_middle   := left.owner_mname;
		    self.name_last     := left.owner_lname;
		    self.name_suffix   := left.owner_name_suffix;
				self.prim_range := left.claimant_prim_range,
				self.predir := left.claimant_predir,
				self.prim_name := left.claimant_prim_name,
				self.addr_suffix := left.claimant_addr_suffix,
				self.postdir := left.claimant_postdir,
				self.unit_desig := left.claimant_unit_desig,
				self.sec_range := left.claimant_sec_range,
				self.city_name := left.claimant_city,
				self.state := left.claimant_state,
				self.zip := if(left.claimant_zip = 0,'',intformat(left.claimant_zip,5,1)),
				self.zip4 := if(left.claimant_zip4 = 0,'',intformat(left.claimant_zip4,4,1)),
				// is this really 
		    self.position_title := stringlib.StringToUpperCase(left.FIRM_NAME);
				self.position_type := 'C';
				self.email := '',			
			));			
		return extract;
	end;
	
	export dataset(Layout_TradeLines.Unlinked) As_TradeLine_Master := dataset([],Layout_TradeLines.Unlinked);	
	export dataset(Layout_URLs.Unlinked) As_URL_Master := dataset([],Layout_URLs.Unlinked);	
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	
		filtered := base(process_date != '' OR naics_code != '');
		
		extract := project(filtered,
			transform(Layout_Industry.Unlinked,
				self.source := 'CB',
				self.source_docid := left.account_number, // ??							
        self.SicCode := ''; // not sure about this field left.INDUSTRY_CODE; ??
				self.SicCodeDescription := ''; //left.Industry_code_desc;
				self.naics := (integer8) left.NAICS_CODE,
				self.yearsinbusiness := ((integer8) ut.GetDate[1..4]) - 
				                        (integer8)(left.start_date[1..4]); 
				self.yearsatlocation := 0));
		
		return extract;
	
	end;	
	export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := function
	    filtered := base(process_date != '' OR ownership_code_desc != '');
			extract := project(filtered,
			  transform(Layout_Incorporation.unlinked,
				  self.source         := 'CB',
					self.source_docid   := left.account_number, // ??					
					self.legalStructure := left.ownership_code_desc;
					self := [];
					));
			return extract;
	end;
	
	export dataset(Layout_Finance.Unlinked) As_Finance_Master := dataset([],Layout_Finance.Unlinked);
   
		//////////
	// export Layout_Common := record
      // string8   Process_date;
	  // string8   dt_first_seen;
	  // string8   dt_last_seen;
	  
       // string3	DISTRICT_BRANCH;
       // string13	ACCOUNT_NUMBER;
       // string3	DISTRICT;
       // string4	TAX_CODE_FULL;
       // string50	FIRM_NAME;
       // string50	OWNER_NAME;
       // string40	BUSINESS_STREET;
       // string30	BUSINESS_CITY;
       // string2	BUSINESS_STATE;
       // string5	BUSINESS_ZIP_5;
       // string4	BUSINESS_ZIP_PLUS_4;
       // string7	BUSINESS_FOREIGN_ZIP;
       // string35	BUSINESS_COUNTRY_NAME;
       // string40	MAILING_STREET;
       // string30	MAILING_CITY;
       // string2	MAILING_STATE;
       // string5	MAILING_ZIP_5;
       // string4	MAILING_ZIP_PLUS_4;
       // string7	MAILING_FOREIGN_ZIP;
       // string35	MAILING_COUNTRY_NAME;
       // string8	START_DATE;
       // string5	INDUSTRY_CODE;
	   // string6  NAICS_CODE;
       // string2	COUNTY_CODE;
       // string3	CITY_CODE;
       // string1	OWNERSHIP_CODE;
	
	  // string45  Tax_code_full_desc;
	  // string100 Industry_code_desc;
	  // string40  County_code_desc;
	  // string40  Ownership_code_desc;
      // string10 	Business_prim_range;      //Business clean address
      // string2   Business_predir;
      // string28 	Business_prim_name;
      // string4   Business_addr_suffix;
      // string2   Business_postdir;
      // string10 	Business_unit_desig;
      // string8   Business_sec_range;
      // string25 	Business_p_city_name;
      // string25 	Business_v_city_name;
      // string2   Business_st;
      // string5   Business_zip5;
      // string4   Business_zip4;
      // string4   Business_cart;
      // string1   Business_cr_sort_sz;
      // string4   Business_lot;
      // string1   Business_lot_order;
      // string2   Business_dpbc;
      // string1   Business_chk_digit;
      // string2   Business_addr_rec_type;
      // string2   Business_fips_state;
      // string3   Business_fips_county;
      // string10 	Business_geo_lat;
      // string11 	Business_geo_long;
      // string4   Business_cbsa;
      // string7   Business_geo_blk;
      // string1   Business_geo_match;
      // string4   Business_err_stat;
	  // string10 	Mailing_prim_range;       //Mailing clean address
      // string2   Mailing_predir;
      // string28 	Mailing_prim_name;
      // string4   Mailing_addr_suffix;
      // string2   Mailing_postdir;
      // string10 	Mailing_unit_desig;
      // string8   Mailing_sec_range;
      // string25 	Mailing_p_city_name;
      // string25 	Mailing_v_city_name;
      // string2   Mailing_st;
      // string5   Mailing_zip5;
      // string4   Mailing_zip4;
      // string4   Mailing_cart;
      // string1   Mailing_cr_sort_sz;
      // string4   Mailing_lot;
      // string1   Mailing_lot_order;
      // string2   Mailing_dpbc;
      // string1   Mailing_chk_digit;
      // string2   Mailing_addr_rec_type;
      // string2   Mailing_fips_state;
      // string3   Mailing_fips_county;
      // string10 	Mailing_geo_lat;
      // string11 	Mailing_geo_long;
      // string4   Mailing_cbsa;
      // string7   Mailing_geo_blk;
      // string1   Mailing_geo_match;
      // string4   Mailing_err_stat;
	  // string5   Owner_title;
	  // string20  Owner_fname;
	  // string20  Owner_mname;
	  // string20  Owner_lname;
	  // string5   Owner_name_suffix;
	  // string3   Owner_name_score; 
  // end;
	
	///////// 
end;