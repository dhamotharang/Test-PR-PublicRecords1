
IMPORT LN_PropertyV2_Services, ut;

EXPORT Transforms := MODULE

	SHARED STRING DISPLAY_NOTHING := '';
	
	SHARED BOOLEAN FirstListedOwnerIsAPerson( DATASET(LN_PropertyV2_Services.layouts.parties.pparty) party ) :=
		FUNCTION
			RETURN LENGTH(TRIM(party.entity[1].lname)) > 0;
		END;
	
	SHARED STRING fn_DisplayFullName( DATASET(LN_PropertyV2_Services.layouts.parties.pparty) party) :=
		FUNCTION
			RETURN ut.fn_FormatFullName(party.entity[1].lname, party.entity[1].fname, party.entity[1].mname);
		END;
		
	SHARED STRING fn_DisplayCompanyName( DATASET(LN_PropertyV2_Services.layouts.parties.pparty) party) :=
		FUNCTION
			RETURN party.entity[1].cname;
		END;		

	SHARED STRING fn_DisplayFullAddress( DATASET(LN_PropertyV2_Services.layouts.parties.pparty) party, BOOLEAN addCityStateZip = TRUE) :=
		FUNCTION
			StreetAddress :=   TRIM(party[1].prim_range) + ' ' 
			                 + TRIM(party[1].predir) + ' ' 
						           + TRIM(party[1].prim_name) + ' ' 
						           + TRIM(party[1].suffix) + ' ' 
						           + TRIM(party[1].postdir) + ' ' 
						           + TRIM(party[1].unit_desig) + ' ' 
						           + TRIM(party[1].sec_range) + ' ';
											
			CityStateZip :=    TRIM(party[1].p_city_name) + IF( LENGTH( TRIM(party[1].st) + TRIM(party[1].zip) + TRIM(party[1].zip4) ) > 0, ', ', DISPLAY_NOTHING)
			                 + TRIM(party[1].st) + ' '
											 + TRIM(party[1].zip) + IF( LENGTH(TRIM(party[1].zip4)) > 0, '-', DISPLAY_NOTHING)
											 + TRIM(party[1].zip4);
											 
			RETURN IF( addCityStateZip, StreetAddress + CityStateZip, StreetAddress );
		END;
		
	EXPORT STRING fn_DisplayPropertyCharacteristics(LN_PropertyV2_Services.layouts.assess.result.tmp assessment, STRING land_lot_size) :=
		FUNCTION
			
			RETURN IF( LENGTH(TRIM(assessment.year_built)) > 0,             'Year Built: '              + TRIM(assessment.year_built)             + '; ', DISPLAY_NOTHING )
			     + IF( LENGTH(TRIM(assessment.no_of_buildings)) > 0,        'Number of Buildings: '     + TRIM(assessment.no_of_buildings)        + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.no_of_stories)) > 0,          'Number of Stories: '       + TRIM(assessment.no_of_stories)          + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.style_desc)) > 0,             'Style: '                   + TRIM(assessment.style_desc)             + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.no_of_units)) > 0,            'Number of Units: '         + TRIM(assessment.no_of_units)            + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.no_of_bedrooms)) > 0,         'Number of Bedrooms: '      + TRIM(assessment.no_of_bedrooms)         + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.air_conditioning_desc)) > 0,  'Air Conditioning: '        + TRIM(assessment.air_conditioning_desc)  + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.heating_desc)) > 0,           'Heating: '                 + TRIM(assessment.heating_desc)           + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.no_of_baths)) > 0,            'Number of Baths: '         + TRIM(assessment.no_of_baths)            + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.type_construction_desc)) > 0, 'Construction: '            + TRIM(assessment.type_construction_desc) + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.no_of_partial_baths)) > 0,    'Number of Partial Baths: ' + TRIM(assessment.no_of_partial_baths)    + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.basement_desc)) > 0,          'Basement: '                + TRIM(assessment.basement_desc)          + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.no_of_rooms)) > 0,            'Total Rooms: '             + TRIM(assessment.no_of_rooms)            + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.exterior_walls_desc)) > 0,    'Exterior Walls: '          + TRIM(assessment.exterior_walls_desc)    + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.fireplace_indicator)) > 0,    'Fireplace: '               + TRIM(assessment.fireplace_indicator)    + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.foundation_desc)) > 0,        'Foundation: '              + TRIM(assessment.foundation_desc)        + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.garage_type_desc)) > 0,       'Garage Type: '             + TRIM(assessment.garage_type_desc)       + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.parking_no_of_cars)) > 0,     'Number of Cars: '          + TRIM(assessment.parking_no_of_cars)     + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.roof_type_desc)) > 0,         'Roof: '                    + TRIM(assessment.roof_type_desc)         + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.elevator)) > 0,               'Elevator: '                + TRIM(assessment.elevator)               + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.pool_desc)) > 0,              'Pool: '                    + TRIM(assessment.pool_desc)              + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(land_lot_size)) > 0,                     'Lot Size: '                + TRIM(land_lot_size)                     + '; ', DISPLAY_NOTHING )
					 + IF( LENGTH(TRIM(assessment.building_area)) > 0,          'Building Area: '           + TRIM(assessment.building_area)          + '; ', DISPLAY_NOTHING );
		END;
		
	EXPORT Layouts.rec_Blackbaud_out xfm_to_output_format(LN_PropertyV2_Services.layouts.combined.tmp l) :=
		TRANSFORM
			SELF.Match_Code                        := l.assessments[1].standardized_land_use_code;
			SELF.OwnerName                         := IF( FirstListedOwnerIsAPerson(l.parties(party_type = 'O')),
			                                              fn_DisplayFullName(l.parties(party_type = 'O')),
																										fn_DisplayCompanyName(l.parties(party_type = 'O'))
																									 );
			SELF.OwnerFirst                        := l.parties(party_type = 'O').entity[1].fname;
			SELF.OwnerLast                         := l.parties(party_type = 'O').entity[1].lname;
			SELF.OwnerMi                           := l.parties(party_type = 'O').entity[1].mname[1];
			SELF.OwnerSuffix                       := l.parties(party_type = 'O').entity[1].name_suffix;
			SELF.OwnerSpouse                       := IF( FirstListedOwnerIsAPerson(l.parties(party_type = 'O')),
			                                              ut.fn_FormatFullName(l.parties(party_type = 'O').entity[2].lname, 
			                                                                   l.parties(party_type = 'O').entity[2].fname),
																										DISPLAY_NOTHING
																									 );
			SELF.OwnerSpouseMi                     := IF( FirstListedOwnerIsAPerson(l.parties(party_type = 'O')),
			                                              l.parties(party_type = 'O').entity[2].mname,
																										DISPLAY_NOTHING
																									 );
			SELF.PropAddress                       := fn_DisplayFullAddress(l.parties(party_type = 'P'), FALSE); // l.assessments[1].property_full_street_address;
			SELF.PropCity                          := l.parties(party_type = 'P')[1].p_city_name;
			SELF.PropState                         := l.parties(party_type = 'P')[1].st;
			SELF.PropZip                           := l.parties(party_type = 'P')[1].zip;
			SELF.Assessed_Land_Value               := l.assessments[1].assessed_land_value;
			SELF.Assessed_Improvement_Value        := l.assessments[1].assessed_improvement_value;
			SELF.Assessment_Year                   := l.assessments[1].assessed_value_year;
			SELF.Assessors_Parcel_Number           := l.deeds[1].apnt_or_pin_number;
			SELF.Book_Page                         := IF( LENGTH(TRIM(l.deeds[1].recorder_book_number)) > 0 AND LENGTH(TRIM(l.deeds[1].recorder_page_number)) > 0,
			                                              l.deeds[1].recorder_book_number + ', ' + l.deeds[1].recorder_page_number,
																									  l.deeds[1].recorder_book_number + l.deeds[1].recorder_page_number
																								   );
			SELF.Borrower                          := fn_DisplayFullName(l.parties(party_type = 'B'));
			SELF.Buyer_Mailing_Address             := fn_DisplayFullAddress(l.parties(party_type = 'O' AND party_type_name = 'Buyer'), TRUE);
			SELF.Buyer                             := fn_DisplayFullName(l.parties(party_type = 'O' AND party_type_name = 'Buyer')); 
			SELF.Deed_Type                         := l.deeds[1].document_type_desc;
			SELF.Document_Number                   := l.deeds[1].document_number;
			SELF.Due_Date                          := l.deeds[1].first_td_due_date;
			SELF.Estimated_Roll_Certification_Date := l.assessments[1].certification_date;
			SELF.Land_Use                          := l.deeds[1].property_use_desc;
			SELF.Legal_Description                 := l.deeds[1].legal_brief_description;
			SELF.Lender_Type                       := l.deeds[1].first_td_lender_type_desc;
			SELF.Lender                            := l.deeds[1].lender_name;
			SELF.Loan_Amount                       := l.deeds[1].first_td_loan_amount;
			SELF.Loan_Type                         := l.deeds[1].first_td_loan_type_code;
			SELF.Lot_Size                          := l.deeds[1].land_lot_size;
			SELF.Mailing_Address                   := fn_DisplayFullAddress(l.parties(party_type = 'P'), TRUE);
			SELF.Market_Improvement_Value          := l.assessments[1].market_improvement_value;
			SELF.Market_Land_Value                 := l.assessments[1].market_land_value;
			SELF.Market_Value_Year                 := l.assessments[1].market_value_year;
			SELF.Mortgage_Record_For	             := 'No Boca data';
			SELF.Mortgage_Type                     := l.assessments[1].mortgage_loan_type_desc;
			SELF.MSA                               := l.parties(party_type = 'P')[1].msa;
			SELF.Owner                             := fn_DisplayFullName(l.parties(party_type = 'O')); 
			SELF.Property_Address                  := fn_DisplayFullAddress(l.parties(party_type = 'P'), TRUE);
			SELF.Property_Characteristics		       := fn_DisplayPropertyCharacteristics(l.assessments[1], l.deeds[1].land_lot_size);
			SELF.Property_Record_For		           := 'No Boca data';
			SELF.Property_Transfer_Record_For		   := 'No Boca data';
			SELF.Property_Use                      := l.deeds[1].property_use_desc;
			SELF.Recorded_Date		                 := 'No Boca data';
			SELF.Recording_Date                    := l.deeds[1].recording_date; // OR assessments.recording_date ???
			SELF.Sale_Date                         := l.assessments[1].sale_date;
			SELF.Sale_Price                        := l.deeds[1].sales_price;
			SELF.Seller_Mailing_Address            := fn_DisplayFullAddress(l.parties(party_type = 'S'), TRUE);
			SELF.Seller                            := fn_DisplayFullName(l.parties(party_type = 'S')); 
			SELF.Tape_Produced_By_County	         := l.assessments[1].tape_cut_date;
			SELF.Tax_Amount                        := l.assessments[1].tax_amount;
			SELF.Tax_Rate_Code                     := l.assessments[1].tax_rate_code_area;
			SELF.Term                              := l.deeds[1].first_td_due_date;
			SELF.Title_Company                     := l.deeds[1].title_company_name;
			SELF.Total_Assessed_Value              := l.assessments[1].assessed_total_value;
			SELF.Total_Market_Value                := l.assessments[1].market_total_value;
			SELF.Type_of_Mortgage                  := l.assessments[1].mortgage_loan_type_desc;
			SELF.Year_Built                        := l.assessments[1].year_built;
			SELF.Stories                           := l.assessments[1].no_of_stories;
			SELF.Units                             := l.assessments[1].no_of_units;
			SELF.Bedrooms                          := l.assessments[1].no_of_bedrooms;
			SELF.Baths                             := l.assessments[1].no_of_baths;
			SELF.Partial_Baths                     := l.assessments[1].no_of_partial_baths;
			SELF.Total_Rooms                       := l.assessments[1].no_of_rooms;
			SELF.Fireplace                         := l.assessments[1].fireplace_indicator;   // OR assessments.fireplace_number
			SELF.Garage_Type                       := l.assessments[1].garage_type_desc;
			SELF.Garage_Size                       := l.assessments[1].parking_no_of_cars;
			SELF.Pool_Spa                          := l.assessments[1].pool_desc;             // OR assessments.pool_code OR assessments.fares_pool_indicator
			SELF.No_of_Buildings                   := l.assessments[1].no_of_buildings;
			SELF.Style                             := l.assessments[1].style_desc;
			SELF.Air_Conditioning                  := l.assessments[1].air_conditioning_desc; // OR assessments.air_conditioning_type_desc
			SELF.Heating                           := l.assessments[1].heating_desc;          // OR assessments.heating_fuel_type_desc
			SELF.Construction                      := l.assessments[1].type_construction_desc;
			SELF.Basement                          := l.assessments[1].basement_desc;
			SELF.Exterior_Walls                    := l.assessments[1].exterior_walls_desc;
			SELF.Foundation                        := l.assessments[1].foundation_desc;
			SELF.Roof                              := l.assessments[1].roof_type_desc;        // OR assessments.roof_cover_desc
			SELF.Elevator                          := l.assessments[1].elevator;
			SELF.Property_Lot_Size                 := l.deeds[1].land_lot_size;
			SELF.Building_Area                     := l.assessments[1].building_area;			
			SELF                                   := l;
		END;
		
END;
