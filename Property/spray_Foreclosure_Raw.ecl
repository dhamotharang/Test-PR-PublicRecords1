IMPORT lib_fileservices,_control, Property;

#workunit('name','Foreclosure - Spray Raw');
// spray_cluster	:=	'thor400_88';
// spray_cluster	:=	'thor200_144';

EXPORT spray_Foreclosure_Raw(string file_date_in, string version_date_in, string spray_cluster, string file) := FUNCTION
	
	sprayForeclosureRaw :=
		IF(fileservices.fileexists(cluster + 'in::foreclosure::'+ file_date_in +'::temp'),
			OUTPUT('Foreclosure file sprayed in previous run'),
			FileServices.SprayFixed(_control.IPAddress.edata12, file, 2762
			,spray_cluster, cluster + 'in::foreclosure::'+ file_date_in +'::temp'))
		;
				
	Foreclosure_in_temp	:=	dataset(cluster + 'in::foreclosure::'+ file_date_in +'::temp', Layout_Foreclosure_Raw_In, FLAT);
		
		//Format Raw Input by removing extraneous zeros
	Layout_Foreclosure_Raw_In tForeclosureRawInFormat(Layout_Foreclosure_Raw_In pInput)
		:=
			TRANSFORM																										
				self.second_defendant_borrower_owner_last_name		:=	StringLib.StringFindReplace(TRIM(pInput.second_defendant_borrower_owner_last_name,LEFT,RIGHT), '&', '');
				self.document_nbr																	:=	REGEXREPLACE('^0+', pInput.document_nbr, '');
				self.title_company_code														:=	REGEXREPLACE('^0+', pInput.title_company_code, '');
				self.title_company_name														:=	REGEXREPLACE('^0+', pInput.title_company_name, '');
				self.date_of_default															:=	REGEXREPLACE('^0+', pInput.date_of_default, '');
				self.amount_of_default														:=	REGEXREPLACE('^0+', pInput.amount_of_default, '');
				self.filing_date																	:=	REGEXREPLACE('^0+', pInput.filing_date, '');
				self.plaintiff_1																	:=	REGEXREPLACE(';\\+', pInput.plaintiff_1, '');
				self.plaintiff_2																	:=	REGEXREPLACE(';\\+', pInput.plaintiff_2, '');
				self.final_judgment_amount												:=	REGEXREPLACE('^0+', pInput.final_judgment_amount, '');
				self.auction_date																	:=	REGEXREPLACE('^0+', pInput.auction_date, '');
				self.auction_time																	:=	REGEXREPLACE('^0+', pInput.auction_time, '');
				self.sales_price																	:=	REGEXREPLACE('^0+', pInput.sales_price, '');
				self.situs_house_number_prefix_1									:=	REGEXREPLACE('^0+', pInput.situs_house_number_prefix_1, '');
				self.situs_house_number_1													:=	REGEXREPLACE('^0+', pInput.situs_house_number_1, '');
				self.situs_house_number_suffix_1									:=	REGEXREPLACE('^0+', pInput.situs_house_number_suffix_1, '');
				self.situs_street_name_1													:=	REGEXREPLACE('^0+', pInput.situs_street_name_1, '');
				self.apartment_unit																:=	REGEXREPLACE('^0+', pInput.apartment_unit, '');
				self.full_site_address_unparsed_1									:=	REGEXREPLACE('^0+', pInput.full_site_address_unparsed_1, '');
				self.original_loan_amount													:=	REGEXREPLACE('^0+', pInput.original_loan_amount, '');
				self.transfer_value																:=	REGEXREPLACE('^0+', pInput.transfer_value, '');
				self.situs_house_number_prefix_2									:=	REGEXREPLACE('^0+', pInput.situs_house_number_prefix_2, '');
				self.situs_house_number_2													:=	REGEXREPLACE('^0+', pInput.situs_house_number_2, '');
				self.situs_house_number_suffix_2									:=	REGEXREPLACE('^0+', pInput.situs_house_number_suffix_2, '');
				self.situs_street_name_2													:=	REGEXREPLACE('^0+', pInput.situs_street_name_2, '');
				self.apartment_unit_2															:=	REGEXREPLACE('^0+', pInput.apartment_unit_2, '');
				self.full_site_address_unparsed_2									:=	REGEXREPLACE('^0+', pInput.full_site_address_unparsed_2, '');
				self.property_indicator														:=	REGEXREPLACE('^0+', pInput.property_indicator, '');
				self.number_of_units															:=	REGEXREPLACE('^0+', pInput.number_of_units, '');
				self.living_area_square_feet											:=	REGEXREPLACE('^0+', pInput.living_area_square_feet, '');
				self.number_of_bedrooms														:=	REGEXREPLACE('^0+', pInput.number_of_bedrooms, '');
				self.number_of_bathrooms													:=	REGEXREPLACE('^0+', REGEXREPLACE('0+$', pInput.number_of_bathrooms, ''), '');
				self.number_of_garages														:=	REGEXREPLACE('^0+', pInput.number_of_garages, '');
				self.year_built																		:=	REGEXREPLACE('^0+', pInput.year_built, '');
				self.current_land_value														:=	REGEXREPLACE('^0+', pInput.current_land_value, '');
				self.current_improvement_value										:=	REGEXREPLACE('^0+', pInput.current_improvement_value, '');
				self.section																			:=	REGEXREPLACE('^0+', pInput.section, '');
				self.map_book																			:=	REGEXREPLACE('^0+', pInput.map_book, '');
				self.map_page																			:=	REGEXREPLACE('^0+', pInput.map_page, '');
				self.last_full_sale_transfer_date									:=	REGEXREPLACE('^0+', pInput.last_full_sale_transfer_date, '');
				self.document_year																:=	REGEXREPLACE('^0+', pInput.document_year, '');
				self.tax_year																			:=	REGEXREPLACE('^0+', pInput.tax_year, '');
				self																							:=	pInput;
			END;
			
	rsForeclosureRawFormatted				 												:=	PROJECT(Foreclosure_in_temp, tForeclosureRawInFormat(LEFT));

	//Lookup and populate full descriptions of codes

	Layout_Foreclosure_Raw_In_Codes
		:=
			RECORD
				Layout_Foreclosure_Raw_In;
				string40	deed_desc;
				string40	document_desc;
				string40	et_al_desc;
				string40	property_desc;
				string40	use_desc;
			END;

	//Deed Description
	Layout_Foreclosure_Raw_In_Codes tForeclosureLookupDeedDesc (Layout_Foreclosure_Raw_In pInput, File_Foreclosure_Codes pLkp) := transform
		self.deed_desc			:=	pLkp.code_desc;
		self.document_desc	:=	'';
		self.et_al_desc			:=	'';
		self.property_desc	:=	'';
		self.use_desc				:=	'';
		self								:=	pInput;
	end;

	rsForeclosureRawFormattedCoded1		 	:=	JOIN(rsForeclosureRawFormatted, File_Foreclosure_Codes,
																								right.code_type	=	'deed' 
																						AND left.deed_category = right.code,
																								tForeclosureLookupDeedDesc(left, right),
																								left outer,
																								lookup
																							 );

	//Document Description
	Layout_Foreclosure_Raw_In_Codes tForeclosureLookupDocumentDesc (Layout_Foreclosure_Raw_In_Codes pInput, File_Foreclosure_Codes pLkp) := transform
		self.document_desc	:=	pLkp.code_desc;
		self								:=	pInput;
	end;

	rsForeclosureRawFormattedCoded2		 	:=	JOIN(rsForeclosureRawFormattedCoded1, File_Foreclosure_Codes,
																								right.code_type	=	'document' 
																						AND left.document_type = right.code,
																								tForeclosureLookupDocumentDesc(left, right),
																								left outer,
																								lookup
																							 );

	//Et Al Description
	Layout_Foreclosure_Raw_In_Codes tForeclosureLookupEtAlDesc (Layout_Foreclosure_Raw_In_Codes pInput, File_Foreclosure_Codes pLkp) := transform
		self.et_al_desc			:=	pLkp.code_desc;
		self								:=	pInput;
	end;

	rsForeclosureRawFormattedCoded3		 	:=	JOIN(rsForeclosureRawFormattedCoded2, File_Foreclosure_Codes,
																								right.code_type	=	'etal' 
																						AND left.defendant_borrower_owner_et_al_indicator = right.code,
																								tForeclosureLookupEtAlDesc(left, right),
																								left outer,
																								lookup
																							 );

	//Property Description																						 
	Layout_Foreclosure_Raw_In_Codes tForeclosureLookupPropertyDesc (Layout_Foreclosure_Raw_In_Codes pInput, File_Foreclosure_Codes pLkp) := transform
		self.property_desc	:=	pLkp.code_desc;
		self								:=	pInput;
	end;

	rsForeclosureRawFormattedCoded4		 	:=	JOIN(rsForeclosureRawFormattedCoded3, File_Foreclosure_Codes,
																								right.code_type	=	'property' 
																						AND left.property_indicator = right.code,
																								tForeclosureLookupPropertyDesc(left, right),
																								left outer,
																								lookup
																							 );

	//Land Use Description																						 
	Layout_Foreclosure_Raw_In_Codes tForeclosureLookupUseDesc (Layout_Foreclosure_Raw_In_Codes pInput, File_Foreclosure_Codes pLkp) := transform
		self.use_desc				:=	pLkp.code_desc;
		self								:=	pInput;
	end;

	rsForeclosureRawFormattedCoded		 	:=	JOIN(rsForeclosureRawFormattedCoded4, File_Foreclosure_Codes,
																								right.code_type	=	'land_use' 
																						AND left.use_code = right.code,
																								tForeclosureLookupUseDesc(left, right),
																								left outer,
																								lookup
																							 );

	Layout_Foreclosure_Raw_In_ID
		:=
			RECORD
				string70	foreclosure_id;
				string8		process_date;
				Layout_Foreclosure_Raw_In_Codes;
			END;

																							 

	Layout_Foreclosure_Raw_In_ID tForeclosureAddID(Layout_Foreclosure_Raw_In_Codes pInput, seqNum)
		:=
			TRANSFORM																										
				self.foreclosure_id																:=	IF(pInput.parcel_number_unmatched_id <> '',
																																IF(TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT) <> '',
																																	StringLib.StringFindReplace(TRIM(pInput.parcel_number_unmatched_id,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT), ' ', ''),
																																	StringLib.StringFindReplace(TRIM(pInput.parcel_number_unmatched_id,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_company_name,LEFT,RIGHT), ' ', '')
																																	),
																																IF(TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT) <> '',
																																	StringLib.StringFindReplace('FC' + INTFORMAT(seqNum, 8, 1) + TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT), ' ', ''),
																																	StringLib.StringFindReplace('FC' + INTFORMAT(seqNum, 8, 1) + TRIM(pInput.first_defendant_borrower_company_name,LEFT,RIGHT), ' ', '')																
																																	)
																																);
				self.process_date																	:=	version_date_in;
				self																							:=	pInput;
			END;
		
	rsForeclosureRawFormattedID				 												:=	PROJECT(rsForeclosureRawFormattedCoded, tForeclosureAddID(LEFT,COUNTER));
	
	FormatRaw	:=
		IF(fileservices.fileexists(cluster + 'in::foreclosure::using::fares_update'+ file_date_in),
			OUTPUT('Foreclosure file transformed in previous run'),
			OUTPUT(rsForeclosureRawFormattedID, , cluster + 'in::foreclosure::using::fares_update'+ file_date_in, CLUSTER(spray_cluster), COMPRESSED)
			)
	;
	
	delTemp	:=
		IF(fileservices.fileexists(cluster + 'in::foreclosure::'+ file_date_in +'::temp'),
			FileServices.DeleteLogicalFile(cluster + 'in::foreclosure::'+ file_date_in +'::temp'),
			OUTPUT('Foreclosure Temp file deleted in previous run')
			)
	;

	NewFile						:=	cluster + 'in::foreclosure::using::fares_update'+ file_date_in;
	inFile						:=	cluster + 'in::foreclosure::using::fares_update';
	usedInFile				:=	cluster + 'in::foreclosure::used::fares_update';
	DeleteInFile			:=	cluster + 'in::foreclosure::delete::fares_update';
		
	addToSuper := sequential(
									
							 FileServices.StartSuperFileTransaction(),
							 FileServices.AddSuperFile(DeleteInFile, usedInFile, , TRUE),
							 FileServices.ClearSuperFile(usedInFile),
							 FileServices.AddSuperFile(usedInFile, inFile, , TRUE),
							 FileServices.ClearSuperFile(inFile),
							 FileServices.AddSuperFile(inFile, NewFile),
							 FileServices.FinishSuperFileTransaction(),
							 IF(FileServices.GetSuperFileSubCount(DeleteInFile) > 0,
							     FileServices.ClearSuperFile(DeleteInFile, TRUE)
							   )					 
							);
	
	return sequential(sprayForeclosureRaw
									, FormatRaw
									, addToSuper
									, delTemp
									);
END;