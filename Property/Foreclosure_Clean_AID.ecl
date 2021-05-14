IMPORT ut
		 , address
		 , AID
		 , DID_Add
		 , header_slimsort
		 , lib_stringlib
		 , idl_header
		 ,dx_property;
	
	rsForeclosureIn		:=	File_Foreclosure_Sprayed;
	
	//Project the incoming data into the Layout_Foreclosure_In layout
	Layout_Foreclosure_In	tProjectRawtoIn(rsForeclosureIn pInput)
		:=
			TRANSFORM
				self	:=	pInput;
				self	:=	[];
			END;

	rsRawInLayout	:=	PROJECT(rsForeclosureIn, tProjectRawtoIn(LEFT));
	
	//Project the existing base data into the Layout_Foreclosure_In layout
	Layout_Foreclosure_In	tProjectBasetoIn(dx_Property.Layout_Fares_Foreclosure_v2 pInput)
		:=
			TRANSFORM
				self	:=	pInput;
				self	:=	[];
			END;

	rsBaseInLayout	:=	PROJECT(File_Foreclosure_Base_v2(source NOT IN ['B7','I5']), tProjectBasetoIn(LEFT)); //BK data not needed as it is built seperately
	

	//Combine the Raw input with the existing base file
	rsRawPlusBase			:=	rsRawInLayout + rsBaseInLayout;
	
	Layout_Foreclosure_In_Sec 
		:=
			RECORD
				unsigned8 sequence := 0;
				Layout_Foreclosure_In;
			END;
			
	rsRawPlusBaseSecPrep := project(rsRawPlusBase, Layout_Foreclosure_In_Sec);

	ut.MAC_Sequence_Records (rsRawPlusBaseSecPrep, sequence, rsRawPlusBaseSec);
	
	
	//Distribute, Sort, and Dedup the combined Raw and Base records
	rsRawPlusBaseDist	:=	DISTRIBUTE(rsRawPlusBaseSec, HASH(state,
																												county,
																												batch_date_and_seq_nbr,
																												deed_category,
																												document_type,
																												recording_date,
																												document_year,
																												document_nbr,
																												document_book,
																												document_pages,
																												title_company_code,
																												title_company_name,
																												attorney_name,
																												attorney_phone_nbr,
																												first_defendant_borrower_owner_first_name,
																												first_defendant_borrower_owner_last_name,
																												first_defendant_borrower_company_name,
																												second_defendant_borrower_owner_first_name,
																												second_defendant_borrower_owner_last_name,
																												second_defendant_borrower_company_name,
																												third_defendant_borrower_owner_first_name,
																												third_defendant_borrower_owner_last_name,
																												third_defendant_borrower_company_name,
																												fourth_defendant_borrower_owner_first_name,
																												fourth_defendant_borrower_owner_last_name,
																												fourth_defendant_borrower_company_name,
																												defendant_borrower_owner_et_al_indicator,
																												date_of_default,
																												amount_of_default,
																												filing_date,
																												court_case_nbr,
																												lis_pendens_type,
																												plaintiff_1,
																												plaintiff_2,
																												final_judgment_amount,
																												auction_date,
																												auction_time,
																												street_address_of_auction_call,
																												city_of_auction_call,
																												state_of_auction_call,
																												opening_bid,
																												tax_year,
																												sales_price,
																												situs_address_indicator_1,
																												situs_house_number_prefix_1,
																												situs_house_number_1,
																												situs_house_number_suffix_1,
																												situs_street_name_1,
																												situs_mode_1,
																												situs_direction_1,
																												situs_quadrant_1,
																												apartment_unit,
																												property_city_1,
																												property_state_1,
																												property_address_zip_code_1,
																												carrier_code,
																												full_site_address_unparsed_1,
																												lender_beneficiary_first_name,
																												lender_beneficiary_last_name,
																												lender_beneficiary_company_name,
																												lender_beneficiary_mailing_address,
																												lender_beneficiary_city,
																												lender_beneficiary_state,
																												lender_beneficiary_zip,
																												lender_phone,
																												trustee_name,
																												trustee_mailing_address,
																												trustee_city,
																												trustee_state,
																												trustee_zip,
																												trustee_phone,
																												trustee_sale_number,
																												original_loan_date,
																												original_loan_recording_date,
																												original_loan_amount,
																												original_document_number,
																												original_recording_book,
																												original_recording_page,
																												parcel_number_parcel_id,
																												parcel_number_unmatched_id,
																												last_full_sale_transfer_date,
																												transfer_value,
																												situs_address_indicator_2,
																												situs_house_number_prefix_2,
																												situs_house_number_2,
																												situs_house_number_suffix_2,
																												situs_street_name_2,
																												situs_mode_2,
																												situs_direction_2,
																												situs_quadrant_2,
																												apartment_unit_2,
																												property_city_2,
																												property_state_2,
																												property_address_zip_code_2,
																												carrier_code_2,
																												full_site_address_unparsed_2,
																												property_indicator,
																												use_code,
																												number_of_units,
																												living_area_square_feet,
																												number_of_bedrooms,
																												number_of_bathrooms,
																												number_of_garages,
																												zoning_code,
																												lot_size,
																												year_built,
																												current_land_value,
																												current_improvement_value,
																												section,
																												township,
																												foreclosure_range,
																												lot_orig,
																												block,
																												tract_subdivision_name,
																												map_book,
																												map_page,
																												unit_nbr,
																												expanded_legal,
																												legal_2,
																												legal_3,
																												legal_4));	
	
	rsRawPlusBaseSort	:=	SORT(rsRawPlusBaseDist,			state,
																										county,
																										batch_date_and_seq_nbr,
																										deed_category,
																										deed_desc,
																										document_type,
																										document_desc,
																										recording_date,
																										document_year,
																										document_nbr,
																										document_book,
																										document_pages,
																										title_company_code,
																										title_company_name,
																										attorney_name,
																										attorney_phone_nbr,
																										first_defendant_borrower_owner_first_name,
																										first_defendant_borrower_owner_last_name,
																										first_defendant_borrower_company_name,
																										second_defendant_borrower_owner_first_name,
																										second_defendant_borrower_owner_last_name,
																										second_defendant_borrower_company_name,
																										third_defendant_borrower_owner_first_name,
																										third_defendant_borrower_owner_last_name,
																										third_defendant_borrower_company_name,
																										fourth_defendant_borrower_owner_first_name,
																										fourth_defendant_borrower_owner_last_name,
																										fourth_defendant_borrower_company_name,
																										defendant_borrower_owner_et_al_indicator,
																										et_al_desc,
																										date_of_default,
																										amount_of_default,
																										filing_date,
																										court_case_nbr,
																										lis_pendens_type,
																										plaintiff_1,
																										plaintiff_2,
																										final_judgment_amount,
																										auction_date,
																										auction_time,
																										street_address_of_auction_call,
																										city_of_auction_call,
																										state_of_auction_call,
																										opening_bid,
																										tax_year,
																										sales_price,
																										situs_address_indicator_1,
																										situs_house_number_prefix_1,
																										situs_house_number_1,
																										situs_house_number_suffix_1,
																										situs_street_name_1,
																										situs_mode_1,
																										situs_direction_1,
																										situs_quadrant_1,
																										apartment_unit,
																										property_city_1,
																										property_state_1,
																										property_address_zip_code_1,
																										carrier_code,
																										full_site_address_unparsed_1,
																										lender_beneficiary_first_name,
																										lender_beneficiary_last_name,
																										lender_beneficiary_company_name,
																										lender_beneficiary_mailing_address,
																										lender_beneficiary_city,
																										lender_beneficiary_state,
																										lender_beneficiary_zip,
																										lender_phone,
																										trustee_name,
																										trustee_mailing_address,
																										trustee_city,
																										trustee_state,
																										trustee_zip,
																										trustee_phone,
																										trustee_sale_number,
																										original_loan_date,
																										original_loan_recording_date,
																										original_loan_amount,
																										original_document_number,
																										original_recording_book,
																										original_recording_page,
																										parcel_number_parcel_id,
																										parcel_number_unmatched_id,
																										last_full_sale_transfer_date,
																										transfer_value,
																										situs_address_indicator_2,
																										situs_house_number_prefix_2,
																										situs_house_number_2,
																										situs_house_number_suffix_2,
																										situs_street_name_2,
																										situs_mode_2,
																										situs_direction_2,
																										situs_quadrant_2,
																										apartment_unit_2,
																										property_city_2,
																										property_state_2,
																										property_address_zip_code_2,
																										carrier_code_2,
																										full_site_address_unparsed_2,
																										property_indicator,
																										property_desc,
																										use_code,
																										use_desc,
																										number_of_units,
																										living_area_square_feet,
																										number_of_bedrooms,
																										number_of_bathrooms,
																										number_of_garages,
																										zoning_code,
																										lot_size,
																										year_built,
																										current_land_value,
																										current_improvement_value,
																										section,
																										township,
																										foreclosure_range,
																										lot_orig,
																										block,
																										tract_subdivision_name,
																										map_book,
																										map_page,
																										unit_nbr,
																										expanded_legal,
																										legal_2,
																										legal_3,
																										legal_4,
																										old_situs1_prim_range,
																										old_situs1_predir,
																										old_situs1_prim_name,
																										old_situs1_addr_suffix,
																										old_situs1_postdir,
																										old_situs1_unit_desig,
																										old_situs1_sec_range,
																										old_situs1_p_city_name,
																										old_situs1_v_city_name,
																										old_situs1_st,
																										old_situs1_zip,
																										old_situs1_zip4,
																										old_situs1_cart,
																										old_situs1_cr_sort_sz,
																										old_situs1_lot,
																										old_situs1_lot_order,
																										old_situs1_dpbc,
																										old_situs1_chk_digit,
																										old_situs1_record_type,
																										old_situs1_ace_fips_st,
																										old_situs1_fipscounty,
																										old_situs1_geo_lat,
																										old_situs1_geo_long,
																										old_situs1_msa,
																										old_situs1_geo_blk,
																										old_situs1_geo_match,
																										old_situs1_err_stat,
																										situs1_RawAID,
																										old_situs2_prim_range,
																										old_situs2_predir,
																										old_situs2_prim_name,
																										old_situs2_addr_suffix,
																										old_situs2_postdir,
																										old_situs2_unit_desig,
																										old_situs2_sec_range,
																										old_situs2_p_city_name,
																										old_situs2_v_city_name,
																										old_situs2_st,
																										old_situs2_zip,
																										old_situs2_zip4,
																										old_situs2_cart,
																										old_situs2_cr_sort_sz,
																										old_situs2_lot,
																										old_situs2_lot_order,
																										old_situs2_dpbc,
																										old_situs2_chk_digit,
																										old_situs2_record_type,
																										old_situs2_ace_fips_st,
																										old_situs2_fipscounty,
																										old_situs2_geo_lat,
																										old_situs2_geo_long,
																										old_situs2_msa,
																										old_situs2_geo_blk,
																										old_situs2_geo_match,
																										old_situs2_err_stat,	
																										situs2_RawAID,
																										-process_date,
																										LOCAL) : PERSIST(cluster + 'in::persist::foreclosure_base_sort');

	Layout_Foreclosure_In_Sec RollupUpdate(Layout_Foreclosure_In_Sec l, Layout_Foreclosure_In_Sec r) := 
	transform
		self.process_date 						:= (STRING)MAX((INTEGER)l.process_date,(INTEGER)r.process_date);
		SELF.source_rec_id						:= if(l.source_rec_id < r.source_rec_id, l.source_rec_id, r.source_rec_id);		
		self 													:= l;
	end;

	rsRawPlusBaseDed	:=	ROLLUP(rsRawPlusBaseSort, RollupUpdate(left,right),
																									state,
																									county,
																									batch_date_and_seq_nbr,
																									deed_category,
																									deed_desc,
																									document_type,
																									document_desc,
																									recording_date,
																									document_year,
																									document_nbr,
																									document_book,
																									document_pages,
																									title_company_code,
																									title_company_name,
																									attorney_name,
																									attorney_phone_nbr,
																									first_defendant_borrower_owner_first_name,
																									first_defendant_borrower_owner_last_name,
																									first_defendant_borrower_company_name,
																									second_defendant_borrower_owner_first_name,
																									second_defendant_borrower_owner_last_name,
																									second_defendant_borrower_company_name,
																									third_defendant_borrower_owner_first_name,
																									third_defendant_borrower_owner_last_name,
																									third_defendant_borrower_company_name,
																									fourth_defendant_borrower_owner_first_name,
																									fourth_defendant_borrower_owner_last_name,
																									fourth_defendant_borrower_company_name,
																									defendant_borrower_owner_et_al_indicator,
																									et_al_desc,
																									date_of_default,
																									amount_of_default,
																									filing_date,
																									court_case_nbr,
																									lis_pendens_type,
																									plaintiff_1,
																									plaintiff_2,
																									final_judgment_amount,
																									auction_date,
																									auction_time,
																									street_address_of_auction_call,
																									city_of_auction_call,
																									state_of_auction_call,
																									opening_bid,
																									tax_year,
																									sales_price,
																									situs_address_indicator_1,
																									situs_house_number_prefix_1,
																									situs_house_number_1,
																									situs_house_number_suffix_1,
																									situs_street_name_1,
																									situs_mode_1,
																									situs_direction_1,
																									situs_quadrant_1,
																									apartment_unit,
																									property_city_1,
																									property_state_1,
																									property_address_zip_code_1,
																									carrier_code,
																									full_site_address_unparsed_1,
																									lender_beneficiary_first_name,
																									lender_beneficiary_last_name,
																									lender_beneficiary_company_name,
																									lender_beneficiary_mailing_address,
																									lender_beneficiary_city,
																									lender_beneficiary_state,
																									lender_beneficiary_zip,
																									lender_phone,
																									trustee_name,
																									trustee_mailing_address,
																									trustee_city,
																									trustee_state,
																									trustee_zip,
																									trustee_phone,
																									trustee_sale_number,
																									original_loan_date,
																									original_loan_recording_date,
																									original_loan_amount,
																									original_document_number,
																									original_recording_book,
																									original_recording_page,
																									parcel_number_parcel_id,
																									parcel_number_unmatched_id,
																									last_full_sale_transfer_date,
																									transfer_value,
																									situs_address_indicator_2,
																									situs_house_number_prefix_2,
																									situs_house_number_2,
																									situs_house_number_suffix_2,
																									situs_street_name_2,
																									situs_mode_2,
																									situs_direction_2,
																									situs_quadrant_2,
																									apartment_unit_2,
																									property_city_2,
																									property_state_2,
																									property_address_zip_code_2,
																									carrier_code_2,
																									full_site_address_unparsed_2,
																									property_indicator,
																									property_desc,
																									use_code,
																									use_desc,
																									number_of_units,
																									living_area_square_feet,
																									number_of_bedrooms,
																									number_of_bathrooms,
																									number_of_garages,
																									zoning_code,
																									lot_size,
																									year_built,
																									current_land_value,
																									current_improvement_value,
																									section,
																									township,
																									foreclosure_range,
																									lot_orig,
																									block,
																									tract_subdivision_name,
																									map_book,
																									map_page,
																									unit_nbr,
																									expanded_legal,
																									legal_2,
																									legal_3,
																									legal_4,
																									name1_company,										
																									situs1_RawAID,
																									situs2_RawAID,
																									LOCAL) : PERSIST(cluster + 'in::persist::foreclosure_base_rollup');

	//Clean the addresses
	
	Layout_NormalizedRec 
		:=
			RECORD
				// unsigned8 sequence;
				
				string10	situs_house_number;
				string2		situs_direction;
				string30	situs_street_name;
				string5		situs_mode;
				string6		apartment_unit_cln;
				
				string40 	property_city;
				string2  	property_state;
				string9  	property_address_zip_code;
				string77	Append_Prep_Address_Situs;
				string54	Append_Prep_Address_Last_Situs;
				unsigned1	AddrCnt;
				AID.Common.xAID	situs_RawAID;
				string10 situs_prim_range;
				string2  situs_predir;
				string28 situs_prim_name;
				string4  situs_addr_suffix;
				string2  situs_postdir;
				string10 situs_unit_desig;
				string8  situs_sec_range;
				string25 situs_p_city_name;
				string25 situs_v_city_name;
				string2  situs_st;
				string5  situs_zip;
				string4  situs_zip4;
				string4  situs_cart;
				string1  situs_cr_sort_sz;
				string4  situs_lot;
				string1  situs_lot_order;
				string2  situs_dpbc;
				string1  situs_chk_digit;
				string2  situs_record_type;
				string2  situs_ace_fips_st;
				string3  situs_fipscounty;
				string10 situs_geo_lat;
				string11 situs_geo_long;
				string4  situs_msa;
				string7  situs_geo_blk;
				string1  situs_geo_match;
				string4  situs_err_stat;
				recordof(rsRawPlusBaseDed);
			END;
	
	Layout_NormalizedRec normalizeAddrLayout(rsRawPlusBaseDed nInput, unsigned1 AddrCnt) := TRANSFORM
		self.AddrCnt										:= CHOOSE(AddrCnt, 1, 2);
		
		self.situs_house_number					:= CHOOSE(AddrCnt, nInput.situs_house_number_1, nInput.situs_house_number_2);
		self.situs_direction						:= CHOOSE(AddrCnt, nInput.situs_direction_1, nInput.situs_direction_2);
		self.situs_street_name					:= CHOOSE(AddrCnt, nInput.situs_street_name_1, nInput.situs_street_name_2);
		self.situs_mode									:= CHOOSE(AddrCnt, nInput.situs_mode_1, nInput.situs_mode_2);
		self.apartment_unit_cln					:= CHOOSE(AddrCnt, nInput.apartment_unit, nInput.apartment_unit_2);
		
		self.property_city 							:= CHOOSE(AddrCnt, nInput.property_city_1, nInput.property_city_2);
		self.property_state							:= CHOOSE(AddrCnt, nInput.property_state_1, nInput.property_state_2);
		self.property_address_zip_code	:= CHOOSE(AddrCnt, nInput.property_address_zip_code_1, nInput.property_address_zip_code_2);
		self														:= nInput;
		self														:= [];
	END;
	
	rsRawPlusBaseNorm := normalize(rsRawPlusBaseDed, 2, normalizeAddrLayout(LEFT, COUNTER));
	
	//Format raw address before passing it to AID macro
	STRING	fRawFixCommon(STRING pStringIn)
	 :=
		FUNCTION
			STRING	lNoPeriod						:=	REGEXREPLACE('([^0-9])\\.',pStringIn,'\\1 ');
			STRING	lCleanSpaces				:=	lib_StringLib.StringLib.StringCleanSpaces(lNoPeriod);
			STRING	lNoSpaceBeforeComma	:=	lib_StringLib.StringLib.StringFindReplace(lCleanSpaces,' ,',',');
			STRING	lUpperCase					:=	lib_StringLib.StringLib.StringToUpperCase(lNoSpaceBeforeComma);
			RETURN	lUpperCase;
		END
	 ;

	STRING	fRawFixLine1(STRING pStringIn)
	 :=
		FUNCTION
			STRING	lFixedCommon				:=	fRawFixCommon(pStringIn);
			STRING	lFixReversedPOBox		:=	REGEXREPLACE('^([0-9]+) (PO BOX)$',lFixedCommon,'\\2 \\1');		// Must be in form of "1234 PO BOX" only, with no extraneous chars
			RETURN	lFixReversedPOBox;
		END
	 ;

	STRING	fRawFixLineLast(STRING pStringIn)
	 :=
		FUNCTION
			STRING	lFixedCommon				:=	fRawFixCommon(pStringIn);
			STRING	lSplitStateAndZip		:=	REGEXREPLACE('(^| )([A-Z]{2})([0-9]{5})(-?[0-9]{4})?$',lFixedCommon,'\\1\\2 \\3\\4');
			STRING	lDropZip4						:=	REGEXREPLACE('(^| )([0-9]{5})-?[0-9]{4}$',lSplitStateAndZip,'\\1\\2');
			RETURN	lDropZip4;
		END
	 ;
	
	Layout_NormalizedRec	tPreAddrClean(Layout_NormalizedRec pInput)
		:=
			TRANSFORM
				self.situs_RawAID										:=	IF(pInput.situs_RawAID <> 0, pInput.situs_RawAID, 0);
				self.Append_Prep_Address_Situs			:=	fRawFixLine1(REGEXREPLACE('^0+', pInput.situs_house_number, '') + ' ' + 
																														 pInput.situs_direction + ' ' + 
																														 REGEXREPLACE('^0+', pInput.situs_street_name, '') + ' ' + 
																														 REGEXREPLACE('^0+', pInput.situs_mode, '') + ' ' + 
																														 REGEXREPLACE('^0+', pInput.apartment_unit_cln, ''));
				self.Append_Prep_Address_Last_Situs	:=	fRawFixLineLast(pInput.property_city
																							+	IF(pInput.property_city <> '',', ','') + pInput.property_state
																							+	' ' + pInput.property_address_zip_code);
				self																:=	pInput;
			END;
			
	rsRawPreClean := PROJECT(rsRawPlusBaseNorm ,tPreAddrClean(LEFT));
	
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	
	//Only clean non-blank addresses
	rsRawPreCleanNonBlank	:=	rsRawPreClean(TRIM(Append_Prep_Address_Situs) <> '');
	
	AID.MacAppendFromRaw_2Line(rsRawPreCleanNonBlank,
		Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, situs_RawAID,
		rsCleanSitus,
		lAIDFlags
		);		
		
	Layout_NormalizedRec	tAppendCleanSitus(rsCleanSitus pInput)
		:=
			TRANSFORM
				self.situs_RawAID				:=	pInput.AIDWork_RawAID;
				self.situs_prim_range		:=	pInput.aidwork_acecache.prim_range;
				self.situs_predir				:=	pInput.aidwork_acecache.predir;
				self.situs_prim_name		:=	pInput.aidwork_acecache.prim_name;
				self.situs_addr_suffix	:=	pInput.aidwork_acecache.addr_suffix;
				self.situs_postdir			:=	pInput.aidwork_acecache.postdir;
				self.situs_unit_desig		:=	pInput.aidwork_acecache.unit_desig;
				self.situs_sec_range		:=	pInput.aidwork_acecache.sec_range;
				self.situs_p_city_name	:=	pInput.aidwork_acecache.p_city_name;
				self.situs_v_city_name	:=	pInput.aidwork_acecache.v_city_name;
				self.situs_st						:=	pInput.aidwork_acecache.st;
				self.situs_zip					:=	pInput.aidwork_acecache.zip5;
				self.situs_zip4					:=	pInput.aidwork_acecache.zip4;
				self.situs_cart					:=	pInput.aidwork_acecache.cart;
				self.situs_cr_sort_sz		:=	pInput.aidwork_acecache.cr_sort_sz;
				self.situs_lot					:=	pInput.aidwork_acecache.lot;
				self.situs_lot_order		:=	pInput.aidwork_acecache.lot_order;
				self.situs_dpbc					:=	pInput.aidwork_acecache.dbpc;
				self.situs_chk_digit		:=	pInput.aidwork_acecache.chk_digit;
				self.situs_record_type	:=	pInput.aidwork_acecache.rec_type;
				self.situs_ace_fips_st	:=  pInput.aidwork_acecache.county[1..2];
				self.situs_fipscounty		:=	pInput.aidwork_acecache.county[3..5];
				self.situs_geo_lat			:=	pInput.aidwork_acecache.geo_lat;
				self.situs_geo_long			:=	pInput.aidwork_acecache.geo_long;
				self.situs_msa					:=	pInput.aidwork_acecache.msa;
				self.situs_geo_blk			:=	pInput.aidwork_acecache.geo_blk;
				self.situs_geo_match		:=	pInput.aidwork_acecache.geo_match;
				self.situs_err_stat			:=	pInput.aidwork_acecache.err_stat;
				self										:=	pInput;
			END;
			
	rsRawCleanSitus := PROJECT(rsCleanSitus ,tAppendCleanSitus(LEFT));
	
	//Combine cleaned records with blank address records
	rsRawCleanSitusNorm	:=	rsRawCleanSitus + rsRawPreClean(TRIM(Append_Prep_Address_Situs) = '');
	
	Layout_Foreclosure_In_Sec DeNormalizeAddrLayout(Layout_Foreclosure_In_Sec dInput, Layout_NormalizedRec nInput) := TRANSFORM
		self.situs1_RawAID				:=	IF(nInput.AddrCnt=1, nInput.situs_RawAID, dInput.situs1_RawAID);
		self.situs1_prim_range		:=	IF(nInput.AddrCnt=1, nInput.situs_prim_range, dInput.situs1_prim_range);
		self.situs1_predir				:=	IF(nInput.AddrCnt=1, nInput.situs_predir, dInput.situs1_predir);
		self.situs1_prim_name			:=	IF(nInput.AddrCnt=1, nInput.situs_prim_name, dInput.situs1_prim_name);
		self.situs1_addr_suffix		:=	IF(nInput.AddrCnt=1, nInput.situs_addr_suffix, dInput.situs1_addr_suffix);
		self.situs1_postdir				:=	IF(nInput.AddrCnt=1, nInput.situs_postdir, dInput.situs1_postdir);
		self.situs1_unit_desig		:=	IF(nInput.AddrCnt=1, nInput.situs_unit_desig, dInput.situs1_unit_desig);		
		self.situs1_sec_range			:=	IF(nInput.AddrCnt=1, nInput.situs_sec_range, dInput.situs1_sec_range);
		self.situs1_p_city_name		:=	IF(nInput.AddrCnt=1, nInput.situs_p_city_name, dInput.situs1_p_city_name);
		self.situs1_v_city_name		:=	IF(nInput.AddrCnt=1, nInput.situs_v_city_name, dInput.situs1_v_city_name);
		self.situs1_st						:=	IF(nInput.AddrCnt=1, nInput.situs_st, dInput.situs1_st);
		self.situs1_zip						:=	IF(nInput.AddrCnt=1, nInput.situs_zip, dInput.situs1_zip);
		self.situs1_zip4					:=	IF(nInput.AddrCnt=1, nInput.situs_zip4, dInput.situs1_zip4);
		self.situs1_cart					:=	IF(nInput.AddrCnt=1, nInput.situs_cart, dInput.situs1_cart);
		self.situs1_cr_sort_sz		:=	IF(nInput.AddrCnt=1, nInput.situs_cr_sort_sz, dInput.situs1_cr_sort_sz);
		self.situs1_lot						:=	IF(nInput.AddrCnt=1, nInput.situs_lot, dInput.situs1_lot);
		self.situs1_lot_order			:=	IF(nInput.AddrCnt=1, nInput.situs_lot_order, dInput.situs1_lot_order);
		self.situs1_dpbc					:=	IF(nInput.AddrCnt=1, nInput.situs_dpbc, dInput.situs1_dpbc);
		self.situs1_chk_digit			:=	IF(nInput.AddrCnt=1, nInput.situs_chk_digit, dInput.situs1_chk_digit);
		self.situs1_record_type		:=	IF(nInput.AddrCnt=1, nInput.situs_record_type, dInput.situs1_record_type);
		self.situs1_ace_fips_st		:=	IF(nInput.AddrCnt=1, nInput.situs_ace_fips_st, dInput.situs1_ace_fips_st);
		self.situs1_fipscounty		:=	IF(nInput.AddrCnt=1, nInput.situs_fipscounty, dInput.situs1_fipscounty);
		self.situs1_geo_lat				:=	IF(nInput.AddrCnt=1, nInput.situs_geo_lat, dInput.situs1_geo_lat);
		self.situs1_geo_long			:=	IF(nInput.AddrCnt=1, nInput.situs_geo_long, dInput.situs1_geo_long);
		self.situs1_msa						:=	IF(nInput.AddrCnt=1, nInput.situs_msa, dInput.situs1_msa);
		self.situs1_geo_blk				:=	IF(nInput.AddrCnt=1, nInput.situs_geo_blk, dInput.situs1_geo_blk);
		self.situs1_geo_match			:=	IF(nInput.AddrCnt=1, nInput.situs_geo_match, dInput.situs1_geo_match);
		self.situs1_err_stat			:=	IF(nInput.AddrCnt=1, nInput.situs_err_stat, dInput.situs1_err_stat);
		
		self.situs2_RawAID				:=	IF(nInput.AddrCnt=2, nInput.situs_RawAID, dInput.situs2_RawAID);
		self.situs2_prim_range		:=	IF(nInput.AddrCnt=2, nInput.situs_prim_range, dInput.situs2_prim_range);
		self.situs2_predir				:=	IF(nInput.AddrCnt=2, nInput.situs_predir, dInput.situs2_predir);
		self.situs2_prim_name			:=	IF(nInput.AddrCnt=2, nInput.situs_prim_name, dInput.situs2_prim_name);
		self.situs2_addr_suffix		:=	IF(nInput.AddrCnt=2, nInput.situs_addr_suffix, dInput.situs2_addr_suffix);
		self.situs2_postdir				:=	IF(nInput.AddrCnt=2, nInput.situs_postdir, dInput.situs2_postdir);
		self.situs2_unit_desig		:=	IF(nInput.AddrCnt=2, nInput.situs_unit_desig, dInput.situs2_unit_desig);		
		self.situs2_sec_range			:=	IF(nInput.AddrCnt=2, nInput.situs_sec_range, dInput.situs2_sec_range);
		self.situs2_p_city_name		:=	IF(nInput.AddrCnt=2, nInput.situs_p_city_name, dInput.situs2_p_city_name);
		self.situs2_v_city_name		:=	IF(nInput.AddrCnt=2, nInput.situs_v_city_name, dInput.situs2_v_city_name);
		self.situs2_st						:=	IF(nInput.AddrCnt=2, nInput.situs_st, dInput.situs2_st);
		self.situs2_zip						:=	IF(nInput.AddrCnt=2, nInput.situs_zip, dInput.situs2_zip);
		self.situs2_zip4					:=	IF(nInput.AddrCnt=2, nInput.situs_zip4, dInput.situs2_zip4);
		self.situs2_cart					:=	IF(nInput.AddrCnt=2, nInput.situs_cart, dInput.situs2_cart);
		self.situs2_cr_sort_sz		:=	IF(nInput.AddrCnt=2, nInput.situs_cr_sort_sz, dInput.situs2_cr_sort_sz);
		self.situs2_lot						:=	IF(nInput.AddrCnt=2, nInput.situs_lot, dInput.situs2_lot);
		self.situs2_lot_order			:=	IF(nInput.AddrCnt=2, nInput.situs_lot_order, dInput.situs2_lot_order);
		self.situs2_dpbc					:=	IF(nInput.AddrCnt=2, nInput.situs_dpbc, dInput.situs2_dpbc);
		self.situs2_chk_digit			:=	IF(nInput.AddrCnt=2, nInput.situs_chk_digit, dInput.situs2_chk_digit);
		self.situs2_record_type		:=	IF(nInput.AddrCnt=2, nInput.situs_record_type, dInput.situs2_record_type);
		self.situs2_ace_fips_st		:=	IF(nInput.AddrCnt=2, nInput.situs_ace_fips_st, dInput.situs2_ace_fips_st);
		self.situs2_fipscounty		:=	IF(nInput.AddrCnt=2, nInput.situs_fipscounty, dInput.situs2_fipscounty);
		self.situs2_geo_lat				:=	IF(nInput.AddrCnt=2, nInput.situs_geo_lat, dInput.situs2_geo_lat);
		self.situs2_geo_long			:=	IF(nInput.AddrCnt=2, nInput.situs_geo_long, dInput.situs2_geo_long);
		self.situs2_msa						:=	IF(nInput.AddrCnt=2, nInput.situs_msa, dInput.situs2_msa);
		self.situs2_geo_blk				:=	IF(nInput.AddrCnt=2, nInput.situs_geo_blk, dInput.situs2_geo_blk);
		self.situs2_geo_match			:=	IF(nInput.AddrCnt=2, nInput.situs_geo_match, dInput.situs2_geo_match);
		self.situs2_err_stat			:=	IF(nInput.AddrCnt=2, nInput.situs_err_stat, dInput.situs2_err_stat);
		self											:=	dInput;
	END;				
				
	rsRawCleanSitusDeNorm := DENORMALIZE(rsRawPlusBaseDed, rsRawCleanSitusNorm,
									left.sequence = right.sequence,
									DeNormalizeAddrLayout(left,right));
				
	//Clean the names	
	//Only clean person names
	ValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
	Layout_Foreclosure_In	tCleanName(rsRawCleanSitusDeNorm pInput)
		:=
			TRANSFORM
				clean_name1					:=	IF(pInput.first_defendant_borrower_company_name = '', address.CleanPersonFML73(lib_StringLib.StringLib.StringCleanSpaces(pInput.first_defendant_borrower_owner_first_name + ' ' + pInput.first_defendant_borrower_owner_last_name)), '');
				//Pre-format name per Bug# 73391
				clean_name2					:=	IF(TRIM(REGEXFIND('^([A-Za-z-]+)( .+)?$', pInput.second_defendant_borrower_owner_last_name, 2), LEFT, RIGHT) IN ValidSuffix,
																	address.CleanPersonFML73(lib_StringLib.StringLib.StringCleanSpaces(pInput.second_defendant_borrower_owner_first_name
																	+	' ' + pInput.second_defendant_borrower_owner_last_name)),
																		IF(LENGTH(TRIM(REGEXFIND('^([A-Za-z-]+)( .+)?$', pInput.second_defendant_borrower_owner_last_name, 2), LEFT, RIGHT)) = 1,
																			address.CleanPersonFML73(lib_StringLib.StringLib.StringCleanSpaces(pInput.second_defendant_borrower_owner_first_name
																			+	' ' + TRIM(REGEXFIND('^([A-Za-z-]+)( .+)?$', pInput.second_defendant_borrower_owner_last_name, 2), LEFT, RIGHT)
																			+	' ' + TRIM(REGEXFIND('^([A-Za-z-]+)( .+)?$', pInput.second_defendant_borrower_owner_last_name, 1), LEFT, RIGHT))),
																			address.CleanPersonFML73(lib_StringLib.StringLib.StringCleanSpaces(pInput.second_defendant_borrower_owner_first_name
																			+	' ' + pInput.second_defendant_borrower_owner_last_name))
																		)
																);
				clean_name3					:=	IF(pInput.third_defendant_borrower_company_name = '', address.CleanPersonFML73(lib_StringLib.StringLib.StringCleanSpaces(pInput.third_defendant_borrower_owner_first_name + ' ' + pInput.third_defendant_borrower_owner_last_name)), '');
				clean_name4					:=	IF(pInput.fourth_defendant_borrower_company_name = '', address.CleanPersonFML73(lib_StringLib.StringLib.StringCleanSpaces(pInput.fourth_defendant_borrower_owner_first_name + ' ' + pInput.fourth_defendant_borrower_owner_last_name)), '');

				//Trim the raw names
				self.first_defendant_borrower_owner_first_name	:=	TRIM(pInput.first_defendant_borrower_owner_first_name, LEFT, RIGHT);
				self.first_defendant_borrower_owner_last_name		:=	TRIM(pInput.first_defendant_borrower_owner_last_name, LEFT, RIGHT);
				self.first_defendant_borrower_company_name			:=	TRIM(pInput.first_defendant_borrower_company_name, LEFT, RIGHT);
				self.second_defendant_borrower_owner_first_name	:=	TRIM(pInput.second_defendant_borrower_owner_first_name, LEFT, RIGHT);
				self.second_defendant_borrower_owner_last_name	:=	TRIM(pInput.second_defendant_borrower_owner_last_name, LEFT, RIGHT);
				self.second_defendant_borrower_company_name			:=	TRIM(pInput.second_defendant_borrower_company_name, LEFT, RIGHT);
				self.third_defendant_borrower_owner_first_name	:=	TRIM(pInput.third_defendant_borrower_owner_first_name, LEFT, RIGHT);
				self.third_defendant_borrower_owner_last_name		:=	TRIM(pInput.third_defendant_borrower_owner_last_name, LEFT, RIGHT);
				self.third_defendant_borrower_company_name			:=	TRIM(pInput.third_defendant_borrower_company_name, LEFT, RIGHT);
				self.fourth_defendant_borrower_owner_first_name	:=	TRIM(pInput.fourth_defendant_borrower_owner_first_name, LEFT, RIGHT);
				self.fourth_defendant_borrower_owner_last_name	:=	TRIM(pInput.fourth_defendant_borrower_owner_last_name, LEFT, RIGHT);
				self.fourth_defendant_borrower_company_name			:=	TRIM(pInput.fourth_defendant_borrower_company_name, LEFT, RIGHT);
				
				self.name1_prefix		:=	clean_name1[1..5];
				self.name1_first		:=	clean_name1[6..25];
				self.name1_middle		:=	clean_name1[26..45];
				self.name1_last			:=	clean_name1[46..65];
				self.name1_suffix		:=	clean_name1[66..70];
				self.name1_score		:=	clean_name1[71..73];
				self.name1_company	:=	TRIM(pInput.first_defendant_borrower_company_name);
				self.name2_prefix		:=	clean_name2[1..5];
				self.name2_first		:=	clean_name2[6..25];
				self.name2_middle		:=	clean_name2[26..45];
				self.name2_last			:=	clean_name2[46..65];
				self.name2_suffix		:=	clean_name2[66..70];
				self.name2_score		:=	clean_name2[71..73];
				self.name2_company	:=	TRIM(pInput.second_defendant_borrower_company_name);
				self.name3_prefix		:=	clean_name3[1..5];
				self.name3_first		:=	clean_name3[6..25];
				self.name3_middle		:=	clean_name3[26..45];
				self.name3_last			:=	clean_name3[46..65];
				self.name3_suffix		:=	clean_name3[66..70];
				self.name3_score		:=	clean_name3[71..73];
				self.name3_company	:=	TRIM(pInput.third_defendant_borrower_company_name);
				self.name4_prefix		:=	clean_name4[1..5];
				self.name4_first		:=	clean_name4[6..25];
				self.name4_middle		:=	clean_name4[26..45];
				self.name4_last			:=	clean_name4[46..65];
				self.name4_suffix		:=	clean_name4[66..70];
				self.name4_score		:=	clean_name4[71..73];
				self.name4_company	:=	TRIM(pInput.fourth_defendant_borrower_company_name);
				self								:=	pInput;
			END;

	rsCleanNames := PROJECT(rsRawCleanSitusDeNorm ,tCleanName(LEFT));
	
	//Add plaintiff_1 and plaintiff_2 as names for autokeys per Bug# 58284
	layoutForeclosureInPlusPlaintiff := record
		Layout_Foreclosure_In;
		string1		plaintiff_1_nametype;
		string1		plaintiff_2_nametype;
	end;

	//Flag the records for nametype
	PlaintiffBlank		:=	rsCleanNames(name5_prefix+name5_first+name5_middle+name5_last+name5_suffix+name5_company+
																					name6_prefix+name6_first+name6_middle+name6_last+name6_suffix+name6_company+
																					name7_prefix+name7_first+name7_middle+name7_last+name7_suffix+name7_company+
																					name8_prefix+name8_first+name8_middle+name8_last+name8_suffix+name8_company
																					='');
	PlaintiffNotBlank	:=	rsCleanNames(name5_prefix+name5_first+name5_middle+name5_last+name5_suffix+name5_company+
																					name6_prefix+name6_first+name6_middle+name6_last+name6_suffix+name6_company+
																					name7_prefix+name7_first+name7_middle+name7_last+name7_suffix+name7_company+
																					name8_prefix+name8_first+name8_middle+name8_last+name8_suffix+name8_company
																					<>'');
																					
	Address.Mac_Is_Business(PlaintiffBlank, plaintiff_1, PlaintiffNT1, nametype, false, true);

	layoutForeclosureInPlusPlaintiff tProjNametype1(PlaintiffNT1 pInput)
		:=
			TRANSFORM
				self.plaintiff_1_nametype	:=	pInput.nametype;
				self.name5_prefix					:=	IF(pInput.nametype = 'P' OR pInput.nametype = 'D', pInput.cln_title, '');
				self.name5_first					:=	IF(pInput.nametype = 'P' OR pInput.nametype = 'D', pInput.cln_fname, '');
				self.name5_middle					:=	IF(pInput.nametype = 'P' OR pInput.nametype = 'D', pInput.cln_mname, '');
				self.name5_last						:=	IF(pInput.nametype = 'P' OR pInput.nametype = 'D', pInput.cln_lname, '');
				self.name5_suffix					:=	IF(pInput.nametype = 'P' OR pInput.nametype = 'D', pInput.cln_suffix, '');
				self.name5_company				:=	IF(pInput.nametype = 'B' OR pInput.nametype =	'U', pInput.plaintiff_1, '');
				self.name6_prefix					:=	IF(pInput.nametype = 'D', pInput.cln_title2, '');
				self.name6_first					:=	IF(pInput.nametype = 'D', pInput.cln_fname2, '');
				self.name6_middle					:=	IF(pInput.nametype = 'D', pInput.cln_mname2, '');
				self.name6_last						:=	IF(pInput.nametype = 'D', pInput.cln_lname2, '');
				self.name6_suffix					:=	IF(pInput.nametype = 'D', pInput.cln_suffix2, '');
				self											:=	pInput;
				self											:=	[];
			END;

	 //NOFOLD required to run this attribute in dataland otherwise it will fail with a compiler error
	PlaintiffNT2	:=	NOFOLD(PROJECT(PlaintiffNT1, tProjNametype1(left)));
	
	Address.Mac_Is_Business(PlaintiffNT2, plaintiff_2, PlaintiffNT3, nametype, false, true);

	layoutForeclosureInPlusPlaintiff tProjNametype2(PlaintiffNT3 pInput)
		:=
			TRANSFORM
				self.plaintiff_2_nametype	:=	pInput.nametype;
				self.name7_prefix					:=	IF(pInput.nametype = 'P' OR pInput.nametype = 'D', pInput.cln_title, '');
				self.name7_first					:=	IF(pInput.nametype = 'P' OR pInput.nametype = 'D', pInput.cln_fname, '');
				self.name7_middle					:=	IF(pInput.nametype = 'P' OR pInput.nametype = 'D', pInput.cln_mname, '');
				self.name7_last						:=	IF(pInput.nametype = 'P' OR pInput.nametype = 'D', pInput.cln_lname, '');
				self.name7_suffix					:=	IF(pInput.nametype = 'P' OR pInput.nametype = 'D', pInput.cln_suffix, '');
				self.name7_company				:=	IF(pInput.nametype = 'B' OR pInput.nametype =	'U', pInput.plaintiff_2, '');
				self.name8_prefix					:=	IF(pInput.nametype = 'D', pInput.cln_title2, '');
				self.name8_first					:=	IF(pInput.nametype = 'D', pInput.cln_fname2, '');
				self.name8_middle					:=	IF(pInput.nametype = 'D', pInput.cln_mname2, '');
				self.name8_last						:=	IF(pInput.nametype = 'D', pInput.cln_lname2, '');
				self.name8_suffix					:=	IF(pInput.nametype = 'D', pInput.cln_suffix2, '');
				self											:=	pInput;
				self											:=	[];
			END;

	PlaintiffNT4	:=	PROJECT(PlaintiffNT3, tProjNametype2(left));

	foreclosureInClnPlaint	:=	PROJECT(PlaintiffNotBlank, Layout_Foreclosure_In)
														+ PROJECT(PlaintiffNT4, Layout_Foreclosure_In);
														
	//------------Apply Name Flipping Macro--------------------
	ut.mac_flipnames(foreclosureInClnPlaint,name1_first,name1_middle,name1_last,names_flipped1);
	ut.mac_flipnames(names_flipped1,name2_first,name2_middle,name2_last,names_flipped2);
	ut.mac_flipnames(names_flipped2,name3_first,name3_middle,name3_last,names_flipped3);
	ut.mac_flipnames(names_flipped3,name4_first,name4_middle,name4_last,names_flipped4);
	
	ut.mac_flipnames(names_flipped4,name5_first,name5_middle,name5_last,names_flipped5);
	ut.mac_flipnames(names_flipped5,name6_first,name6_middle,name6_last,names_flipped6);
	ut.mac_flipnames(names_flipped6,name7_first,name7_middle,name7_last,names_flipped7);
	ut.mac_flipnames(names_flipped7,name8_first,name8_middle,name8_last,names_flipped8);
	//---------------------------------------------------------
	
	//Add the source_rec_id
	UT.MAC_Append_Rcid(names_flipped8, source_rec_id, full_file_recid);	

EXPORT Foreclosure_Clean_AID := full_file_recid;