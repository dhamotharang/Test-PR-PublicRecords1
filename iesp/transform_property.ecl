import LN_PropertyV2, LN_PropertyV2_Services, doxie, risk_indicators, address, identifier2, codes;
					  
export transform_property := MODULE	

	shared string FormatName (LN_PropertyV2_Services.layouts.parties.entity L) :=
		if (trim (L.title) != '', trim (L.title), '') +
		if (trim (L.fname) != '', ' ' + trim (L.fname), '') +
		if (trim (L.mname) != '', ' ' + trim (L.mname), '') + 
		if (trim (L.lname) != '', ' ' + trim (L.lname), '') +
		if (trim (L.name_suffix) != '', ' ' + trim (L.name_suffix), '');
	;
 
	// inject unsigned date-field for sorting
	shared deed_ext := record (iesp.propdeed.t_DeedReportRecord)
		boolean IsSubjectOwned;
		unsigned4 srt_date;
	end;

	
	// inject unsigned date-field (and "ownership") for sorting
	shared assess_ext := record (iesp.propassess.t_AssessReportRecord)
		boolean IsSubjectOwned;
		unsigned4 srt_date;
		
		string mortgage_loan_type_code;
		string garage_type_code;
		string roof_type_code;
		string air_conditioning_code;
		string exterior_walls_code;
		string heating_code;
		string standardized_land_use_code;
		string foundation_code;
		string land_usage_code;
	end;

	shared iesp.share.t_Address make__t_address( LN_PropertyV2_Services.layouts.parties.pparty le ) := TRANSFORM
		self.StreetNumber        := le.prim_range;
		self.StreetPreDirection  := le.predir;
		self.StreetName          := le.prim_name;
		self.StreetSuffix        := le.suffix;
		self.StreetPostDirection := le.postdir;
		self.UnitDesignation     := le.unit_desig;
		self.UnitNumber          := le.sec_range;
		self.StreetAddress1      := '';
		self.StreetAddress2      := '';
		self.City                := le.v_city_name;
		self.State               := le.st;
		self.Zip5                := le.zip;
		self.Zip4                := le.zip4;
		self.County              := le.county_name;
		self.PostalCode          := '';
		self.StateCityZip        := '';
	END;


	shared iesp.share.t_StringArrayItem make_array( LN_PropertyV2_Services.layouts.parties.orig le ) := TRANSFORM
		self.value := le.orig_name;
	END;


	export working_layout := record
		identifier2.layout_Identifier2;
		
		deed_ext deed;
		assess_ext assess;
		
		LN_PropertyV2.key_Property_did().ln_fares_id;
		unsigned  fares_did;
		boolean   IsSubjectOwned;
		unsigned4 srt_date;
		unsigned4 dt_vendor_last_reported;
		
		boolean   IsAddressMatch;
		// boolean   IsExactAddressMatch;
		boolean   IsDIDMatch;
		boolean   IsOwner;
		boolean   isCurrentDeedOwner;
		boolean   isCurrentAssessorOwner;
		string1 vendor_source_flag;
		unsigned3 dt_last_seen;
		set of string ln_fares_ids;
	end;

	shared clean( in_addr, in_unit_num, in_csz, out_section ) := MACRO

		#uniquename( clean182 )
		%clean182% := Address.CleanAddress182( in_addr + ' ' + in_unit_num, in_csz );
		#uniquename( cleaned )
		%cleaned% := Address.CleanFields( %clean182% );
		out_section.StreetNumber        := %cleaned%.prim_range;
		out_section.StreetPreDirection  := %cleaned%.predir;
		out_section.StreetName          := %cleaned%.prim_name;
		out_section.StreetSuffix        := %cleaned%.addr_suffix;
		out_section.StreetPostDirection := %cleaned%.postdir;
		out_section.UnitDesignation     := %cleaned%.unit_desig;
		out_section.UnitNumber          := %cleaned%.sec_range;
		out_section.StreetAddress1      := in_addr;
		out_section.StreetAddress2      := in_unit_num;
		out_section.City                := %cleaned%.v_city_name;
		out_section.State               := %cleaned%.st;
		out_section.Zip5                := %cleaned%.zip;
		out_section.Zip4                := %cleaned%.zip4;
		out_section.County              := %cleaned%.county;
		out_section.PostalCode          := '';
		out_section.StateCityZip        := '';
	ENDMACRO;


	export deed_assess := module
		export working_layout format_deed_all (working_layout L, recordof(LN_PropertyV2.key_deed_fid()) R) := TRANSFORM
			self.deed.DataSource             :=  R.vendor_source_flag;
			self.deed.SourcePropertyRecordId :=  R.ln_fares_id;

			mt := trim(stringlib.stringtouppercase(R.first_td_loan_type_code));
			fares := R.ln_fares_id[1] = 'R';	// R means Fares
			fidelity := R.ln_fares_id[1] in ['O','D'];
			
			deedMortgageType := risk_indicators.iid_constants.mortgage_type(fidelity, fares, mt);

			self.deed.MortgageLoanType       := deedMortgageType;
			self.deed.MortgageDeedType       := ''; // R.fares_mortgage_deed_type_desc; -- ?
			self.deed.MortgageDeedSubtype    := '';
			self.deed.LenderName             := R.lender_name;
			self.deed.TitleCompanyName       := R.title_company_name;
			self.deed.BuildingSquareFeet     := '';// only in assessment records
			
			// weird, but... to cut leading zeroes
			int_book                    := (integer) R.recorder_book_number;
			self.deed.Book                   := if (int_book = 0, '', (string) int_book);
			int_page                    := (integer) R.recorder_page_number;
			self.deed.Page                   := if (int_page = 0, '', (string) int_page);
			self.deed.AlternateParcelNumber  := R.apnt_or_pin_number;
			self.deed.DocumentNumber         := R.document_number;
			self.deed.InterestRate           := R.first_td_interest_rate;
			self.deed.InterestRateType       := R.type_financing;// R.type_financing_desc;

			self.deed.RecordType             := 'deed';
			self.deed.ParcelNumber           := ''; // R.fares_iris_apn; -- ?
			self.deed.ParcelId               := StringLib.StringSubstituteOut(R.apnt_or_pin_number, '-', '');
			self.deed.SalePrice              := iesp.ECL2ESP.FormatDollarAmount (R.sales_price);
			self.deed.MortgageTerm           := R.loan_term_years + if (R.type_financing != '', ' ' + R.type_financing, '');
			self.deed.MortgageAmount         := iesp.ECL2ESP.FormatDollarAmount (R.first_td_loan_amount);

			self.deed.DocumentType           := R.document_type_code; // document_type_desc; -- ?
			self.deed.TransactionType        := ''; // R.fares_transaction_type_desc; -- ?

			self.deed.Owner1Name             := R.name1;
			self.deed.Owner2Name             := R.name2;
			self.deed.SellerName             := R.seller1;
			self.deed.LandUsage              := R.property_use_code; // property_use_desc; -- ?
			unsigned4 sale_date              := (unsigned4) if (R.contract_date != '', R.contract_date, R.recording_date);
			self.deed.SaleDate               := iesp.ECL2ESP.toDate (sale_date);
			self.deed.RecordingDate          := iesp.ECL2ESP.toDate ((unsigned4) R.recording_date);


			clean( R.seller_mailing_full_street_address, R.seller_mailing_address_unit_number, R.seller_mailing_address_citystatezip, self.deed.SellerAddress );
			clean( R.property_full_street_address, R.property_address_unit_number, R.property_address_citystatezip, self.deed.PropertyAddress );
			clean( R.mailing_street, R.mailing_unit_number, R.mailing_csz, self.deed.OwnerAddress );

			self.deed.BriefDescription       := R.legal_brief_description;

			self.deed.sellers := [];
			self.deed.owners  := [];
			self.deed.srt_date               := sale_date;
      
      //*** Check if the input name matches the name on the deed record - either name1 or name2 *** 
      //first try a straight string find of the first and last name in either of the name fields on the deed record
      stringFoundName1  := Stringlib.StringFind(R.name1, trim(L.fname), 1) > 0 and Stringlib.StringFind(R.name1, trim(L.lname), 1) > 0;
      stringFoundName2  := Stringlib.StringFind(R.name2, trim(L.fname), 1) > 0 and Stringlib.StringFind(R.name2, trim(L.lname), 1) > 0;
 
      //next try parsing the name1 field from the deed record and then scoring the first and last name to the parsed names
      cleaned_name1 := Stringlib.StringToUppercase(Address.CleanPersonLFM73(R.name1));
      string30 fname1_clean := cleaned_name1[6..25];
      string30 lname1_clean := cleaned_name1[46..65];
      firstmatch1_score := Risk_Indicators.FnameScore(L.fname,fname1_clean);
      lastmatch1_score  := Risk_Indicators.LnameScore(L.lname,lname1_clean);
      fuzzyMatchName1   := risk_indicators.iid_constants.g(firstmatch1_score) and risk_indicators.iid_constants.g(lastmatch1_score);

      //finally try parsing the name2 field from the deed record and then scoring the first and last name to the parsed names
      cleaned_name2 := Stringlib.StringToUppercase(Address.CleanPersonLFM73(R.name2));
      string30 fname2_clean := cleaned_name2[6..25];
      string30 lname2_clean := cleaned_name2[46..65];
      firstmatch2_score := Risk_Indicators.FnameScore(L.fname,fname2_clean);
      lastmatch2_score  := Risk_Indicators.LnameScore(L.lname,lname2_clean);
      fuzzyMatchName2   := risk_indicators.iid_constants.g(firstmatch2_score) and risk_indicators.iid_constants.g(lastmatch2_score);

			nameMatch   := L.fname <> '' and L.lname <> '' and (stringFoundName1 or stringFoundName2 or fuzzyMatchName1 or fuzzyMatchName2);

			DIDMatch    := l.fares_did != 0 and l.fares_did in [l.did,l.did2,l.did3];
			isOwner     := DIDMatch or nameMatch;
			self.deed.IsSubjectOwned         := isOwner;

      //move owner names from the deed record to the Owners2 section of the layout so we can compare the deed owner names to the assessment owner names later when they are joined together
      deedName1 := project(Risk_Indicators.iid_constants.ds_Record, 
                                 transform(iesp.property.t_Property2Name, 
                                           self.First  := fname1_clean,
                                           self.Last   := lname1_clean,
                                           self        := []));
      deedName2 := project(Risk_Indicators.iid_constants.ds_Record, 
                                 transform(iesp.property.t_Property2Name, 
                                           self.First  := fname2_clean,
                                           self.Last   := lname2_clean,
                                           self        := []));
      self.deed.Owners2.Names   := deedName1 + deedName2;
      
			self := L;
		END;

		export working_layout format_assess_all (working_layout L, recordof(LN_PropertyV2.key_assessor_fid()) R) := TRANSFORM
			self.vendor_source_flag             := R.vendor_source_flag; // copied along to allow codes.mac_getpropertycode to play nicely
			self.assess.DataSource              := R.vendor_source_flag;
			self.assess.SourcePropertyRecordId  := R.ln_fares_id;

			self.assess.SubdivisionName         := R.legal_subdivision_name;
			self.assess.YearBuilt               := (integer) R.year_built;
			self.assess.LotNumber               := R.legal_lot_number;
			self.assess.LandValue               := '';
			self.assess.ImprovementValue        := '';
			self.assess.TotalValue              := '';

			self.assess.MarketLandValue         := iesp.ECL2ESP.FormatDollarAmount (R.market_land_value);
			self.assess.MarketImprovementValue  := iesp.ECL2ESP.FormatDollarAmount (R.market_improvement_value);
			self.assess.TotalMarketValue        := iesp.ECL2ESP.FormatDollarAmount (R.market_total_value);
			liv_sq_feet                         := 0; // ?? was: (integer) R.fares_living_square_feet;
			self.assess.LivingSize              := ''; // ?? was: if (liv_sq_feet > 0, iesp.ECL2ESP.InsertPlaceHolders (R.fares_living_square_feet), '');
			self.assess.LandSize                := R.land_square_footage;
			self.assess.NumberStories           := (integer) R.no_of_stories;
			self.assess.NumberBedrooms          := (integer) R.no_of_bedrooms;
			self.assess.NumberFullBaths         := (integer) R.no_of_baths;
			self.assess.NumberHalfBaths         := (integer) R.no_of_partial_baths;
			self.assess.LegalDescription        := R.legal_brief_description;

			// weird, but... to cut leading zeroes
			int_book                     := (integer) R.recorder_book_number;
			self.assess.Book                    := if (int_book = 0, '', (string) int_book);
			int_page                     := (integer) R.recorder_page_number;
			self.assess.Page                    := if (int_page = 0, '', (string) int_page);
			self.assess.HomesteadExemption      := if (R.homestead_homeowner_exemption = 'Y', 'YES', '');
			self.assess.PriorSaleDate           := iesp.ECL2ESP.toDate ((unsigned4) R.prior_recording_date);
			self.assess.LoanAmount              := iesp.ECL2ESP.FormatDollarAmount (R.mortgage_loan_amount);
			self.assess.RecordType              := 'assessor'; 
			self.assess.ParcelNumber            := R.apna_or_pin_number; // same as below, don't ahve formatted value here...
			self.assess.ParcelId                := R.apna_or_pin_number;
			self.assess.SalePrice               := iesp.ECL2ESP.FormatDollarAmount (R.sales_price);
			self.assess.TaxYear                 := (integer) R.tax_year;
			self.assess.TaxAmount               := iesp.ECL2ESP.FormatDollarAmount (R.tax_amount);
			self.assess.AssessedValue           := iesp.ECL2ESP.FormatDollarAmount (R.assessed_total_value);

			
			self.assess.SaleDate                := iesp.ECL2ESP.toDate ((unsigned4) R.sale_date);
			self.assess.RecordingDate           := iesp.ECL2ESP.toDate ((unsigned4) R.recording_date);

			clean( R.property_full_street_address, R.property_unit_number, R.property_city_state_zip, self.assess.PropertyAddress );

			self.assess.Owner1Name             := R.assessee_name;
			self.assess.Owner2Name             := R.second_assessee_name;

      //*** Check if the input name matches the name on the assessor record - either name1 or name2 *** 
      //first try a straight string find of the first and last name in either of the name fields on the assessor record
      stringFoundName1  := Stringlib.StringFind(R.assessee_name, trim(L.fname), 1) > 0 and Stringlib.StringFind(R.assessee_name, trim(L.lname), 1) > 0;
      stringFoundName2  := Stringlib.StringFind(R.second_assessee_name, trim(L.fname), 1) > 0 and Stringlib.StringFind(R.second_assessee_name, trim(L.lname), 1) > 0;
 
      //next try parsing the name1 field from the assessor record and then scoring the first and last name to the parsed names
      cleaned_name1 := Stringlib.StringToUppercase(Address.CleanPersonLFM73(R.assessee_name));
      string30 fname1_clean := cleaned_name1[6..25];
      string30 lname1_clean := cleaned_name1[46..65];
      firstmatch1_score := Risk_Indicators.FnameScore(L.fname,fname1_clean);
      lastmatch1_score  := Risk_Indicators.LnameScore(L.lname,lname1_clean);
      fuzzyMatchName1   := risk_indicators.iid_constants.g(firstmatch1_score) and risk_indicators.iid_constants.g(lastmatch1_score);

      //finally try parsing the name2 field from the assessor record and then scoring the first and last name to the parsed names
      cleaned_name2 := Stringlib.StringToUppercase(Address.CleanPersonLFM73(R.second_assessee_name));
      string30 fname2_clean := cleaned_name2[6..25];
      string30 lname2_clean := cleaned_name2[46..65];
      firstmatch2_score := Risk_Indicators.FnameScore(L.fname,fname2_clean);
      lastmatch2_score  := Risk_Indicators.LnameScore(L.lname,lname2_clean);
      fuzzyMatchName2   := risk_indicators.iid_constants.g(firstmatch2_score) and risk_indicators.iid_constants.g(lastmatch2_score);

			nameMatch   := L.fname <> '' and L.lname <> '' and (stringFoundName1 or stringFoundName2 or fuzzyMatchName1 or fuzzyMatchName2);  //if the name was found using any of the searches above
      
			DIDmatch    := L.fares_did != 0 and L.fares_did in [l.did,l.did2,l.did3];
			isOwner     := DIDMatch or nameMatch;
			self.assess.IsSubjectOwned          := IsOwner;
			self.assess.srt_date                := (unsigned4) if (R.sale_date != '', R.sale_date, R.recording_date);

      //move owner names from the assess record to the Owners2 section of the layout so we can compare the assessment owner names to the deed owner names later when they are joined together
      assessName1 := project(Risk_Indicators.iid_constants.ds_Record, 
                                 transform(iesp.property.t_Property2Name, 
                                           self.First  := fname1_clean,
                                           self.Last   := lname1_clean,
                                           self        := []));
      assessName2 := project(Risk_Indicators.iid_constants.ds_Record, 
                                 transform(iesp.property.t_Property2Name, 
                                           self.First  := fname2_clean,
                                           self.Last   := lname2_clean,
                                           self        := []));
      self.assess.Owners2.Names   := assessName1 + assessName2;
			
			// codes
			self.assess.mortgage_loan_type_code      := R.mortgage_loan_type_code; // was: mortgage_loan_type_desc;
			self.assess.garage_type_code             := R.garage_type_code; // was: garage_type_desc;
			self.assess.roof_type_code               := R.roof_type_code; // was: roof_type_desc;
			self.assess.air_conditioning_code        := R.air_conditioning_code; // was: air_conditioning_desc;
			self.assess.exterior_walls_code          := R.exterior_walls_code; // was: exterior_walls_desc;
			self.assess.heating_code                 := R.heating_code; // was: heating_desc;
			self.assess.standardized_land_use_code   := R.standardized_land_use_code; // was: standardized_land_use_desc;
			self.assess.foundation_code              := R.foundation_code; // was: foundation_desc;


			
			self := L;
		END;

		export add_assess_codes( dataset(working_layout) wl ) := FUNCTION
			// Mac_GetPropertyCode(in_prop,out_prop,key, Fares_file_name,Fares_field_name, prop_code,prop_field_new)
			//                        in  out   key                  key:file     key:field                     code source (from 'left')          description destination
			Codes.Mac_GetPropertyCode(wl,  wl1, Codes.Key_Codes_V3, 'FARES_2580', 'MORTGAGE_LOAN_TYPE_CODE',    assess.mortgage_loan_type_code   , assess.MortgageLoanType );
			Codes.Mac_GetPropertyCode(wl1, wl2, Codes.Key_Codes_V3, 'FARES_2580', 'GARAGE',                     assess.garage_type_code          , assess.GarageDescription);
			Codes.Mac_GetPropertyCode(wl2, wl3, Codes.Key_Codes_V3, 'FARES_2580', 'ROOF_TYPE',                  assess.roof_type_code            , assess.RoofDescription  );
			Codes.Mac_GetPropertyCode(wl3, wl4, Codes.Key_Codes_V3, 'FARES_2580', 'AIR_CONDITIONING',           assess.air_conditioning_code     , assess.ACDescription    );
			Codes.Mac_GetPropertyCode(wl4, wl5, Codes.Key_Codes_V3, 'FARES_2580', 'EXTERIOR_WALLS',             assess.exterior_walls_code       , assess.ExteriorWalls    );
			Codes.Mac_GetPropertyCode(wl5, wl6, Codes.Key_Codes_V3, 'FARES_2580', 'HEATING',                    assess.heating_code              , assess.Heating          );
			Codes.Mac_GetPropertyCode(wl6, wl7, Codes.Key_Codes_V3, 'FARES_2580', 'FOUNDATION',                 assess.foundation_code           , assess.Foundation       );
			Codes.Mac_GetPropertyCode(wl7, wl8, Codes.Key_Codes_V3, 'FARES_2580', 'LAND_USE',                   assess.land_usage_code           , assess.LandUsage        );

			return wl8;
		END;
	

	end;	
END;    