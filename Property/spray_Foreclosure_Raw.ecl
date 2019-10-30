IMPORT lib_fileservices, _control, Property, STD;

#WORKUNIT('name','Foreclosure - Spray Raw');

EXPORT spray_Foreclosure_Raw(
	STRING  pVersion,
	STRING  pHostname,
	STRING  version_date_in,
	STRING  pGroup,
	STRING  pFile,
	INTEGER pRecordSize = 2762
) := FUNCTION
	TempInFile := Property.thor_cluster + 'in::foreclosure::'+ pVersion +'::temp'; 	

	sprayForeclosureRaw := IF(
		STD.File.FileExists(TempInFile),
		OUTPUT('Foreclosure file sprayed in previous run'),
		STD.File.SprayFixed(
			pHostname,	
			pFile,
			pRecordSize,
			pGroup,
			TempInFile,,,,,
			true
		)
	);

	Foreclosure_in_temp := DATASET(
		TempInFile,
		Layout_Foreclosure_Raw_In,
		FLAT
	);

	//Format Raw Input by removing extraneous zeros
	Layout_Foreclosure_Raw_In tForeclosureRawInFormat(Layout_Foreclosure_Raw_In pInput) := TRANSFORM
		SELF.second_defendant_borrower_owner_last_name := StringLib.StringFindReplace(TRIM(pInput.second_defendant_borrower_owner_last_name,LEFT,RIGHT), '&', '');
		SELF.document_nbr                 := REGEXREPLACE('^0+', pInput.document_nbr, '');
		SELF.title_company_code           := REGEXREPLACE('^0+', pInput.title_company_code, '');
		SELF.title_company_name           := REGEXREPLACE('^0+', pInput.title_company_name, '');
		SELF.date_of_default              := REGEXREPLACE('^0+', pInput.date_of_default, '');
		SELF.amount_of_default            := REGEXREPLACE('^0+', pInput.amount_of_default, '');
		SELF.filing_date                  := REGEXREPLACE('^0+', pInput.filing_date, '');
		SELF.plaintiff_1                  := REGEXREPLACE(';\\+', pInput.plaintiff_1, '');
		SELF.plaintiff_2                  := REGEXREPLACE(';\\+', pInput.plaintiff_2, '');
		SELF.final_judgment_amount        := REGEXREPLACE('^0+', pInput.final_judgment_amount, '');
		SELF.auction_date                 := REGEXREPLACE('^0+', pInput.auction_date, '');
		SELF.auction_time                 := REGEXREPLACE('^0+', pInput.auction_time, '');
		SELF.sales_price                  := REGEXREPLACE('^0+', pInput.sales_price, '');
		SELF.situs_house_number_prefix_1  := REGEXREPLACE('^0+', pInput.situs_house_number_prefix_1, '');
		SELF.situs_house_number_1         := REGEXREPLACE('^0+', pInput.situs_house_number_1, '');
		SELF.situs_house_number_suffix_1  := REGEXREPLACE('^0+', pInput.situs_house_number_suffix_1, '');
		SELF.situs_street_name_1          := REGEXREPLACE('^0+', pInput.situs_street_name_1, '');
		SELF.apartment_unit               := REGEXREPLACE('^0+', pInput.apartment_unit, '');
		SELF.full_site_address_unparsed_1 := REGEXREPLACE('^0+', pInput.full_site_address_unparsed_1, '');
		SELF.original_loan_amount         := REGEXREPLACE('^0+', pInput.original_loan_amount, '');
		SELF.transfer_value               := REGEXREPLACE('^0+', pInput.transfer_value, '');
		SELF.situs_house_number_prefix_2  := REGEXREPLACE('^0+', pInput.situs_house_number_prefix_2, '');
		SELF.situs_house_number_2         := REGEXREPLACE('^0+', pInput.situs_house_number_2, '');
		SELF.situs_house_number_suffix_2  := REGEXREPLACE('^0+', pInput.situs_house_number_suffix_2, '');
		SELF.situs_street_name_2          := REGEXREPLACE('^0+', pInput.situs_street_name_2, '');
		SELF.apartment_unit_2             := REGEXREPLACE('^0+', pInput.apartment_unit_2, '');
		SELF.full_site_address_unparsed_2 := REGEXREPLACE('^0+', pInput.full_site_address_unparsed_2, '');
		SELF.property_indicator           := REGEXREPLACE('^0+', pInput.property_indicator, '');
		SELF.number_of_units              := REGEXREPLACE('^0+', pInput.number_of_units, '');
		SELF.living_area_square_feet      := REGEXREPLACE('^0+', pInput.living_area_square_feet, '');
		SELF.number_of_bedrooms           := REGEXREPLACE('^0+', pInput.number_of_bedrooms, '');
		SELF.number_of_bathrooms          := REGEXREPLACE('^0+', REGEXREPLACE('0+$', pInput.number_of_bathrooms, ''), '');
		SELF.number_of_garages            := REGEXREPLACE('^0+', pInput.number_of_garages, '');
		SELF.year_built                   := REGEXREPLACE('^0+', pInput.year_built, '');
		SELF.current_land_value           := REGEXREPLACE('^0+', pInput.current_land_value, '');
		SELF.current_improvement_value    := REGEXREPLACE('^0+', pInput.current_improvement_value, '');
		SELF.section                      := REGEXREPLACE('^0+', pInput.section, '');
		SELF.map_book                     := REGEXREPLACE('^0+', pInput.map_book, '');
		SELF.map_page                     := REGEXREPLACE('^0+', pInput.map_page, '');
		SELF.last_full_sale_transfer_date := REGEXREPLACE('^0+', pInput.last_full_sale_transfer_date, '');
		SELF.document_year                := REGEXREPLACE('^0+', pInput.document_year, '');
		SELF.tax_year                     := REGEXREPLACE('^0+', pInput.tax_year, '');
		SELF                              := pInput;
	END;

	rsForeclosureRawFormatted := PROJECT(
		Foreclosure_in_temp,
		tForeclosureRawInFormat(LEFT)
	);

	//Lookup and populate full descriptions of codes

	Layout_Foreclosure_Raw_In_Codes := RECORD
		Layout_Foreclosure_Raw_In;
		STRING40 deed_desc;
		STRING40 document_desc;
		STRING40 et_al_desc;
		STRING40 property_desc;
		STRING40 use_desc;
	END;

	//Deed Description
	Layout_Foreclosure_Raw_In_Codes tForeclosureLookupDeedDesc (Layout_Foreclosure_Raw_In pInput, File_Foreclosure_Codes pLkp) := TRANSFORM
		SELF.deed_desc     := pLkp.code_desc;
		SELF.document_desc := '';
		SELF.et_al_desc    := '';
		SELF.property_desc := '';
		SELF.use_desc      := '';
		SELF               := pInput;
	END;

	rsForeclosureRawFormattedCoded1 := JOIN(
		rsForeclosureRawFormatted,
		File_Foreclosure_Codes,
		RIGHT.code_type = 'deed' AND LEFT.deed_category = RIGHT.code,
		tForeclosureLookupDeedDesc(LEFT, RIGHT),
		LEFT OUTER,
		lookup
	);

	//Document Description
	Layout_Foreclosure_Raw_In_Codes tForeclosureLookupDocumentDesc (Layout_Foreclosure_Raw_In_Codes pInput, File_Foreclosure_Codes pLkp) := TRANSFORM
		SELF.document_desc := pLkp.code_desc;
		SELF               := pInput;
	END;

	rsForeclosureRawFormattedCoded2 := JOIN(
		rsForeclosureRawFormattedCoded1,
		File_Foreclosure_Codes,
		RIGHT.code_type = 'document' AND LEFT.document_type = RIGHT.code,
		tForeclosureLookupDocumentDesc(LEFT, RIGHT),
		LEFT OUTER,
		lookup
	);

	//Et Al Description
	Layout_Foreclosure_Raw_In_Codes tForeclosureLookupEtAlDesc (Layout_Foreclosure_Raw_In_Codes pInput, File_Foreclosure_Codes pLkp) := TRANSFORM
		SELF.et_al_desc := pLkp.code_desc;
		SELF	        := pInput;
	end;

	rsForeclosureRawFormattedCoded3 := JOIN(
		rsForeclosureRawFormattedCoded2,
		File_Foreclosure_Codes,
		RIGHT.code_type = 'etal' AND LEFT.defendant_borrower_owner_et_al_indicator = RIGHT.code,
		tForeclosureLookupEtAlDesc(LEFT, RIGHT),
		LEFT OUTER,
		lookup
	);

	//Property Description
	Layout_Foreclosure_Raw_In_Codes tForeclosureLookupPropertyDesc (Layout_Foreclosure_Raw_In_Codes pInput, File_Foreclosure_Codes pLkp) := TRANSFORM
		SELF.property_desc := pLkp.code_desc;
		SELF               := pInput;
	END;

	rsForeclosureRawFormattedCoded4 :=	JOIN(rsForeclosureRawFormattedCoded3, File_Foreclosure_Codes,
		RIGHT.code_type	=	'property' AND LEFT.property_indicator = RIGHT.code,
		tForeclosureLookupPropertyDesc(LEFT, RIGHT),
		LEFT OUTER,
		lookup
	);

	//Land Use Description
	Layout_Foreclosure_Raw_In_Codes tForeclosureLookupUseDesc (Layout_Foreclosure_Raw_In_Codes pInput, File_Foreclosure_Codes pLkp) := TRANSFORM
		SELF.use_desc := pLkp.code_desc;
		SELF          := pInput;
	END;

	rsForeclosureRawFormattedCoded := JOIN(
		rsForeclosureRawFormattedCoded4,
		File_Foreclosure_Codes,
		RIGHT.code_type = 'land_use' AND LEFT.use_code = RIGHT.code,
		tForeclosureLookupUseDesc(LEFT, RIGHT),
		LEFT OUTER,
		lookup
	);

	Layout_Foreclosure_Raw_In_ID := RECORD
		STRING70 foreclosure_id;
		STRING8  process_date;
		Layout_Foreclosure_Raw_In_Codes;
	END;

	Layout_Foreclosure_Raw_In_ID tForeclosureAddID(Layout_Foreclosure_Raw_In_Codes pInput, seqNum) := TRANSFORM
		SELF.foreclosure_id := IF(
			pInput.parcel_number_unmatched_id <> '',
			IF(
				TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT) <> '',
				StringLib.StringFindReplace(
					TRIM(pInput.parcel_number_unmatched_id,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT),
					' ',
					''
				),
				StringLib.StringFindReplace(
					TRIM(pInput.parcel_number_unmatched_id,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_company_name,LEFT,RIGHT),
					' ',
					''
				)
			),
			IF(
				TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT) <> '',
				StringLib.StringFindReplace(
					'FC' + INTFORMAT(seqNum, 8, 1) + TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT),
					' ',
					''
				),
				StringLib.StringFindReplace(
					'FC' + INTFORMAT(seqNum, 8, 1) + TRIM(pInput.first_defendant_borrower_company_name,LEFT,RIGHT),
					' ',
					''
				)
			)
		);
		SELF.process_date := version_date_in;
		SELF              := pInput;
	END;

	rsForeclosureRawFormattedID := PROJECT(rsForeclosureRawFormattedCoded, tForeclosureAddID(LEFT,COUNTER));

	FormatRaw := IF(
		STD.File.FileExists(Property.thor_cluster + 'in::foreclosure::using::fares_update'+ pVersion),
		OUTPUT('Foreclosure file transformed in previous run'),
		OUTPUT(rsForeclosureRawFormattedID, , Property.thor_cluster + 'in::foreclosure::using::fares_update'+ pVersion, COMPRESSED)
	);

	delTemp := IF(
		STD.File.FileExists(TempInFile),
		STD.File.DeleteLogicalFile(TempInFile),
		OUTPUT('Foreclosure Temp file deleted in previous run')
	);

	NewFile      := Property.thor_cluster + 'in::foreclosure::using::fares_update'+ pVersion;
	inFile       := Property.thor_cluster + 'in::foreclosure::using::fares_update';
	usedInFile   := Property.thor_cluster + 'in::foreclosure::used::fares_update';
	DeleteInFile := Property.thor_cluster + 'in::foreclosure::delete::fares_update';
		
	addToSuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile(DeleteInFile, usedInFile, , TRUE),
		STD.File.ClearSuperFile(usedInFile),
		STD.File.AddSuperFile(usedInFile, inFile, , TRUE),
		STD.File.ClearSuperFile(inFile),
		STD.File.AddSuperFile(inFile, NewFile),
		STD.File.FinishSuperFileTransaction(),
		IF(STD.File.GetSuperFileSubCount(DeleteInFile) > 0,STD.File.ClearSuperFile(DeleteInFile, TRUE))
	);

	RETURN SEQUENTIAL(
		sprayForeclosureRaw,
		FormatRaw,
		addToSuper,
		delTemp,
	);

END;
