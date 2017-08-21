import address;
export Layouts :=
module

	export Miscellaneous :=
	module
	
		export CA_Cleaned_Dates :=
		record
			unsigned4		FILE_STATUS_DATE						;
			unsigned4		TYPES_STATUS_DATES1					;
			unsigned4 	TYPES_STATUS_DATES2					;
			unsigned4 	TYPES_STATUS_DATES3					;
			unsigned4 	TYPES_STATUS_DATES4					;
			unsigned4 	TYPES_STATUS_DATES5					;
			unsigned4 	TYPES_STATUS_DATES6					;
			unsigned4 	TYPES_STATUS_DATES7					;
			unsigned4 	TYPES_STATUS_DATES8					;
			unsigned4 	TYPES_ORIGINAL_ISSUE_DATES1	;
			unsigned4 	TYPES_ORIGINAL_ISSUE_DATES2	;
			unsigned4		TYPES_ORIGINAL_ISSUE_DATES3	;
			unsigned4		TYPES_ORIGINAL_ISSUE_DATES4	;
			unsigned4 	TYPES_ORIGINAL_ISSUE_DATES5	;
			unsigned4 	TYPES_ORIGINAL_ISSUE_DATES6	;
			unsigned4 	TYPES_ORIGINAL_ISSUE_DATES7	;
			unsigned4 	TYPES_ORIGINAL_ISSUE_DATES8	;
			unsigned4 	TYPES_EXPIRATION_DATES1			;
			unsigned4 	TYPES_EXPIRATION_DATES2			;
			unsigned4 	TYPES_EXPIRATION_DATES3			;
			unsigned4 	TYPES_EXPIRATION_DATES4			;
			unsigned4 	TYPES_EXPIRATION_DATES5			;
			unsigned4 	TYPES_EXPIRATION_DATES6			;
			unsigned4 	TYPES_EXPIRATION_DATES7			;
			unsigned4 	TYPES_EXPIRATION_DATES8			;
		end;


		export CA_Cleaned_Dates2 :=
		record
			unsigned4		FILE_STATUS_DATE						;
			{unsigned4	TYPES_STATUS_DATE					} TYPES_STATUS_DATES					[8];
			{unsigned4 	TYPES_ORIGINAL_ISSUE_DATE	}	TYPES_ORIGINAL_ISSUE_DATES	[8];
			{unsigned4 	TYPES_EXPIRATION_DATE			}	TYPES_EXPIRATION_DATES			[8];
		end;

		export CA_Cleaned_Dates_both :=
		record
			unsigned4		FILE_STATUS_DATE					;
			unsigned4		TYPES_STATUS_DATE					;
			unsigned4 	TYPES_ORIGINAL_ISSUE_DATE	;
			unsigned4 	TYPES_EXPIRATION_DATE			;
		end;

		export CT_Cleaned_Dates :=
		record
			unsigned4		Effective_Date					;
			unsigned4		Expiration							;
		end;

		export IN_Cleaned_Dates :=
		record
			unsigned4		EXPIRATION_DATE						;
			unsigned4		EXTENSION_EXPIRATION_DATE	;
		end;
		
		export TX_Cleaned_Dates :=
		record
			unsigned4		originalLicenseDate					;
			unsigned4		expiryDate									;
		end;

	end;
	////////////////////////////////////////////////////////////////////////
	// -- Vendor Layouts
	////////////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		export CA := 
		record
			string2		license_type						;
			string8		file_number							;
			string3		lic_or_app							;
			string8		type_status							;
			string11	type_orig_issue_dates		;
			string11	expiration_dates				;
			string8		fee_codes								;	
			string3		duplicate_counts				;
			string1		master_indicator				;
			string2		term_in_months					;
			string4		geo_code								;
			string2		district_office_code		;
			string50	primary_name						;
			string50	premise_street_address1	;
			string50	premise_street_address2	;
			string25	premise_city						;
			string2		premise_state						;
			string10	premise_zip							;
			string50	DBA_name								;
			string50	mail_street_address1		;
			string50  mail_street_address2		;
			string25  mail_city								;
			string2   mail_state							;
			string10  mail_zip								;
			string2 	crlf										;
		end;

		export CA_sprayed := 
		record
			CA;
			string100 __filename { virtual(logicalfilename)};
		end;

		export CA_both := 
		record
			string2		license_type								;
			string8		file_number									;
			string3		lic_or_app									;
			string8		type_status									;
			string11	type_orig_issue_dates				;
			string11	expiration_dates						;
			string8		fee_codes										;	
			string3		duplicate_counts						;
			string1		master_indicator						;
			string2		term_in_months							;
			string4		geo_code										;
			string2		district_office_code				;
			string50	primary_name								;
			string50	premise_street_address1			;
			string50	premise_street_address2			;
			string25	premise_city								;
			string2		premise_state								;
			string10	premise_zip									;
			string50	DBA_name										;
			string50	mail_street_address1				;
			string50  mail_street_address2				;
			string25  mail_city										;
			string2   mail_state									;
			string10  mail_zip										;
			string10	CENSUS_TRACT								;
			string11  TYPES_TRANSFER_FROM_NUMBER	;
			string9		TYPES_STATUS_DATE						;
			string8		FILE_STATUS_CODE						;
			string9		FILE_STATUS_DATE						;
		end;

		export CA_old :=
		record
			string8		FILE_NUMBER									;//
			string8		FILE_STATUS_CODE						;
			string9		FILE_STATUS_DATE						;
			string4		GEO_CODE										;
			string2		DISTRICT_CODE								;
			string4		LICENSE_TYPE1								;//
			string4		LICENSE_TYPE2								;//
			string4		LICENSE_TYPE3								;//
			string4		LICENSE_TYPE4								;//
			string4		LICENSE_TYPE5								;//
			string4		LICENSE_TYPE6								;//
			string4		LICENSE_TYPE7								;//
			string4		LICENSE_TYPE8								;//
			string8		TYPES_STATUS_CODE1					;//
			string8		TYPES_STATUS_CODE2					;//
			string8		TYPES_STATUS_CODE3					;//
			string8		TYPES_STATUS_CODE4					;//
			string8		TYPES_STATUS_CODE5					;//
			string8		TYPES_STATUS_CODE6					;//
			string8		TYPES_STATUS_CODE7					;//
			string8		TYPES_STATUS_CODE8					;//
			string1		TYPES_MASTER_INDICATORS1		;
			string1		TYPES_MASTER_INDICATORS2		;
			string1		TYPES_MASTER_INDICATORS3		;
			string1		TYPES_MASTER_INDICATORS4		;
			string1		TYPES_MASTER_INDICATORS5		;
			string1		TYPES_MASTER_INDICATORS6		;
			string1		TYPES_MASTER_INDICATORS7		;
			string1		TYPES_MASTER_INDICATORS8		;
			string9		TYPES_STATUS_DATES1					;
			string9 	TYPES_STATUS_DATES2					;
			string9 	TYPES_STATUS_DATES3					;
			string9 	TYPES_STATUS_DATES4					;
			string9 	TYPES_STATUS_DATES5					;
			string9 	TYPES_STATUS_DATES6					;
			string9 	TYPES_STATUS_DATES7					;
			string9 	TYPES_STATUS_DATES8					;
			string9 	TYPES_ORIGINAL_ISSUE_DATES1	;
			string9 	TYPES_ORIGINAL_ISSUE_DATES2	;
			string9		TYPES_ORIGINAL_ISSUE_DATES3	;
			string9		TYPES_ORIGINAL_ISSUE_DATES4	;
			string9 	TYPES_ORIGINAL_ISSUE_DATES5	;
			string9 	TYPES_ORIGINAL_ISSUE_DATES6	;
			string9 	TYPES_ORIGINAL_ISSUE_DATES7	;
			string9 	TYPES_ORIGINAL_ISSUE_DATES8	;
			string9 	TYPES_EXPIRATION_DATES1			;
			string9 	TYPES_EXPIRATION_DATES2			;
			string9 	TYPES_EXPIRATION_DATES3			;
			string9 	TYPES_EXPIRATION_DATES4			;
			string9 	TYPES_EXPIRATION_DATES5			;
			string9 	TYPES_EXPIRATION_DATES6			;
			string9 	TYPES_EXPIRATION_DATES7			;
			string9 	TYPES_EXPIRATION_DATES8			;
			string3 	TYPES_DUPLICATE_COUNTS1			;
			string3 	TYPES_DUPLICATE_COUNTS2			;
			string3 	TYPES_DUPLICATE_COUNTS3			;
			string3 	TYPES_DUPLICATE_COUNTS4			;
			string3 	TYPES_DUPLICATE_COUNTS5			;
			string3 	TYPES_DUPLICATE_COUNTS6			;
			string3 	TYPES_DUPLICATE_COUNTS7			;
			string3 	TYPES_DUPLICATE_COUNTS8			;
			string8 	TYPES_FEE_CODES1						;
			string8		TYPES_FEE_CODES2						;
			string8		TYPES_FEE_CODES3						;
			string8 	TYPES_FEE_CODES4						;
			string8 	TYPES_FEE_CODES5						;
			string8 	TYPES_FEE_CODES6						;
			string8 	TYPES_FEE_CODES7						;
			string8		TYPES_FEE_CODES8						;
			string11	TYPES_TRANSFER_FROM_NUMBERS1;
			string11	TYPES_TRANSFER_FROM_NUMBERS2;
			string11	TYPES_TRANSFER_FROM_NUMBERS3;
			string11	TYPES_TRANSFER_FROM_NUMBERS4;
			string11	TYPES_TRANSFER_FROM_NUMBERS5;
			string11	TYPES_TRANSFER_FROM_NUMBERS6;
			string11	TYPES_TRANSFER_FROM_NUMBERS7;
			string11	TYPES_TRANSFER_FROM_NUMBERS8;
			string50	PRIMARY_NAME								;
			string50	PREMISE_STREET_ADDRESS1			;
			string50	PREMISE_STREET_ADDRESS2			;
			string25	PREMISE_CITY								;
			string2		PREMISE_ST									;
			string10	PREMISE_ZIP									;
			string10	CENSUS_TRACT								;
			string50	DBA_NAME										;
			string50	MAIL_STREET_ADDRESS1				;
			string50	MAIL_STREET_ADDRESS2				;
			string25	MAIL_CITY										;
			string2		MAIL_ST											;
			string10	MAIL_ZIP										;
			string1		lf													;
		end;
		
		export CA_old2 :=
		record
			string8		FILE_NUMBER									;//
			string8		FILE_STATUS_CODE						;
			string9		FILE_STATUS_DATE						;
			string4		GEO_CODE										;//
			string2		DISTRICT_CODE								;//
			{string4 LICENSE_TYPE}		LICENSE_TYPES[8]							;//
			{string8 TYPES_STATUS_CODE}		TYPES_STATUS_CODES[8]				;//
			{string1 TYPES_MASTER_INDICATOR}		TYPES_MASTER_INDICATORS[8]	;//
			{string9 TYPES_STATUS_DATE}		TYPES_STATUS_DATES[8]				;
			{string9 TYPES_ORIGINAL_ISSUE_DATE} 	TYPES_ORIGINAL_ISSUE_DATES[8]	;	//
			{string9 TYPES_EXPIRATION_DATE} 	TYPES_EXPIRATION_DATES[8]			;//
			{string3 TYPES_DUPLICATE_COUNT} 	TYPES_DUPLICATE_COUNTS[8]			;//
			{string8 TYPES_FEE_CODE} 	TYPES_FEE_CODES[8]						;	//
			{string11 TYPES_TRANSFER_FROM_NUMBER}	TYPES_TRANSFER_FROM_NUMBERS[8];
			string50	PRIMARY_NAME								;//
			string50	PREMISE_STREET_ADDRESS1			;//
			string50	PREMISE_STREET_ADDRESS2			;//
			string25	PREMISE_CITY								;//
			string2		PREMISE_ST									;//
			string10	PREMISE_ZIP									;//
			string10	CENSUS_TRACT								;
			string50	DBA_NAME										;//
			string50	MAIL_STREET_ADDRESS1				;//
			string50	MAIL_STREET_ADDRESS2				;//
			string25	MAIL_CITY										;//
			string2		MAIL_ST											;//
			string10	MAIL_ZIP										;//
			string1		lf													;
		end;

		export CT_old :=
		record
			string30	First_Name		;
			string30	Last_Name			;
			string100	Business_Name	;
			string50	DBA_Name			;
			string50 	Address				;
			string30	City					;
			string2		State					;
			string10	Zip						;
			string15	Number				;
			string6		Status				;
			string10	Effective_Date;
			string10	Expiration		;
			string1		lf						;
		end;
		
		export CT :=
		record
			string30	First_Name		;
			string30	Last_Name			;
			string100	Business_Name	;
			string50 	Address				;
			string30	City					;
			string2		State					;
			string10	Zip						;
			string15	Number				;
			string6		Status				;
			string10	Effective_Date;
			string10	Expiration		;
			string1		lf						;
		end;

		export IN :=
		record
			string9		PERMIT_NUMBER							;
			string77	NAME											;
			string35	TYPE											;
			string17	STATUS										;
			string77	CORPORATION								;
			string70	DOING_BUSINESS_AS					;
			string60	ADDRESS_LINE_1						;
			string40	ADDRESS_LINE_2						;
			string19	CITY											;
			string2		STATE											;
			string9		ZIP_CODE									;
			string11	COUNTY										;
			string29	JURISDICTION							;
			string10	EXPIRATION_DATE						;
			string10	EXTENSION_EXPIRATION_DATE	;
			string62	PRESIDENT									;
			string62	SECRETARY									;
			string1		STOCKHOLDERS							;
			string1		lf												;
		end;
		
		export LA := 
		record
			string19	FORMATTEDCREDENTIAL	;
			string50	TradeName						;
			string40	ADDRESS							;
			string17	TRADECITY						;
			string2		TRADESTATE					;
			string10	TRADEZIP						;
			string39	CredentialType			;
			string60	OwnerName						;
			string30	OWNERADDRESS				;
			string17	OWNER_CITY					;
			string2		OWNER_STATE					;
			string10	OWNER_ZIP						;
			string1		lf									;
		end;
		
		export OH :=
		record
			string40	NAME												;
			string40	DBA													;
			string40	Address_line1								;
			string30	Address_line2								;
			string40	City_state_zip							;
			string10	County											;
			string18	Permit_Classes							;
			string12	Permit_Number								;
			string20	Taxing_District							;
			string3		Wholesale_Outlet						;
			string1		lf													;
		end;
		
		export PA :=
		record
			string2		Renewal_District																					;
			string3		License_Type																							;
			string36	Licensee_NAME_1																						;
			string36	Licensee_NAME_2																						;
			string36	Licensee_NAME_3																						;
			string36	Licensee_ADDRESS_1																				;
			string36	Licensee_ADDRESS_2																				;
			string36	Licensee_ADDRESS_3																				;
			string5		Licensee_ZIP_CODE																					;
			string2		Licensee_Prefix																						;
			string5		Licensee_Amusement_Permit																	;
			string5		Licensee_Sunday_Sales_Permit															;
			string2		Licensee_PLCB_County_Number																;
			string3		Licensee_PLCB_Municipal_Number_within_PLCB_County_Number	;
			string1		Licensee_Enforcement_District_Number											;
			string1		Licensee_Business_Organization_Type												;
			string1		Retail_Wholesale_License_Type															;
			string1		Malt_Beverage_Or_Liquor_License_Type											;
			string1		Club_License_Type																					;
			string5		License_Sequence_Number																		;
			string7		License_Identification_Number															;
			string2		crlf																											;
		end;
		
		export TX :=
		record
			string25	clp													;
			string64	tradename										;
			string64	owner												;
			string12	ll_streetaddressnbr					;
			string80	ll_addressline1							;
			string40	ll_addressline2							;
			string21	ll_addressline3							;
			string20	ll_cityname									;
			string2		ll_statecode								;
			string10	ll_zip											;
			string16	ll_phoneNbr									;
			string13	ll_countyname								;
			string20	ll_countryname							;
			string15	ma_streetaddressnbr					;
			string80	ma_addressline1							;
			string36	ma_addressline2							;
			string19	ma_addressline3							;
			string20	ma_cityname									;
			string2		ma_statecode								;
			string10	ma_zip											;
			string14	ma_countryname							;
			string40	licStatusDesc								;
			string25	originalLicenseDate					;
			string25	expiryDate									;
			string8		relClp											;
			string1		pendingRenewal							;
			string1		pendingChgLL								;
			string2		winepercent									;
			string1		lf													;
		end;
		

	end;

	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	module
	
		export CA :=
		record
			unsigned4 													dt_first_seen							;
			unsigned4 													dt_last_seen							;
			unsigned4 													dt_vendor_first_reported	;
			unsigned4 													dt_vendor_last_reported		;

			input.ca_both												rawfields									;
			Address.Layout_Clean_Name						clean_primary_name				;
			Address.Layout_Clean182_fips				Clean_location_address		;
			Address.Layout_Clean182_fips				Clean_mailing_address			;

			Miscellaneous.CA_Cleaned_Dates_both	clean_dates								;
		end;
		
		export CA_old :=
		record
			unsigned4 											dt_first_seen							;
			unsigned4 											dt_last_seen							;
			unsigned4 											dt_vendor_first_reported	;
			unsigned4 											dt_vendor_last_reported		;

			input.ca_old										rawfields									;
			Address.Layout_Clean_Name				clean_primary_name				;
			Address.Layout_Clean182_fips		Clean_location_address		;
			Address.Layout_Clean182_fips		Clean_mailing_address			;

			Miscellaneous.CA_Cleaned_Dates	clean_dates								;
		end;

		export CA_old2 :=
		record
			unsigned4 											dt_first_seen							;
			unsigned4 											dt_last_seen							;
			unsigned4 											dt_vendor_first_reported	;
			unsigned4 											dt_vendor_last_reported		;

			input.ca_old2 									rawfields									;
			Address.Layout_Clean_Name				clean_primary_name				;
			Address.Layout_Clean182_fips		Clean_location_address		;
			Address.Layout_Clean182_fips		Clean_mailing_address			;

			Miscellaneous.CA_Cleaned_Dates2	clean_dates								;
		end;

		export CT :=
		record
			unsigned4 											dt_first_seen							;
			unsigned4 											dt_last_seen							;
			unsigned4 											dt_vendor_first_reported	;
			unsigned4 											dt_vendor_last_reported		;

			input.ct_old										rawfields									;
			Address.Layout_Clean_Name				clean_contact_name				;
			Address.Layout_Clean182_fips		Clean_address							;

			Miscellaneous.CT_Cleaned_Dates	clean_dates								;
		end;

		export IN :=
		record
			unsigned4 											dt_first_seen							;
			unsigned4 											dt_last_seen							;
			unsigned4 											dt_vendor_first_reported	;
			unsigned4 											dt_vendor_last_reported		;

			input.in 												rawfields									;
			Address.Layout_Clean_Name				clean_president_name			;
			Address.Layout_Clean_Name				clean_secretary_name			;
			Address.Layout_Clean182_fips		Clean_address							;

			Miscellaneous.IN_Cleaned_Dates	clean_dates								;
		end;

		export LA :=
		record
			unsigned4 											dt_first_seen							;
			unsigned4 											dt_last_seen							;
			unsigned4 											dt_vendor_first_reported	;
			unsigned4 											dt_vendor_last_reported		;

			input.la 												rawfields									;
			Address.Layout_Clean_Name				clean_owner_name					;
			Address.Layout_Clean182_fips		Clean_trade_address				;
			Address.Layout_Clean182_fips		Clean_owner_address				;

		end;

		export OH :=
		record
			unsigned4 											dt_first_seen							;
			unsigned4 											dt_last_seen							;
			unsigned4 											dt_vendor_first_reported	;
			unsigned4 											dt_vendor_last_reported		;

			input.oh 												rawfields									;
			Address.Layout_Clean_Name				clean_person_name					;
			Address.Layout_Clean182_fips		Clean_address							;

		end;

		export PA :=
		record
			unsigned4 											dt_first_seen							;
			unsigned4 											dt_last_seen							;
			unsigned4 											dt_vendor_first_reported	;
			unsigned4 											dt_vendor_last_reported		;

			input.pa 												rawfields									;
			Address.Layout_Clean_Name				clean_person_name1				;
			Address.Layout_Clean_Name				clean_person_name2				;
			Address.Layout_Clean_Name				clean_person_name3				;
			Address.Layout_Clean182_fips		Clean_address							;

		end;

		export TX :=
		record
			unsigned4 											dt_first_seen							;
			unsigned4 											dt_last_seen							;
			unsigned4 											dt_vendor_first_reported	;
			unsigned4 											dt_vendor_last_reported		;

			input.tx 												rawfields									;
			Address.Layout_Clean_Name				clean_tradename_name			;
			Address.Layout_Clean_Name				clean_owner_name					;
			Address.Layout_Clean182_fips		Clean_location_address		;
			Address.Layout_Clean182_fips		Clean_mailing_address			;

			Miscellaneous.TX_Cleaned_Dates	clean_dates								;
			string10												clean_phone								;
		end;

	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
	
		export CA :=
		record

			unsigned8										unique_id									;

			string100 									location_address1					;
			string50										location_address2					;

			string100										mailing_address1					;
			string50										mailing_address2					;

			base.ca																								;

		end;
	
		export CT :=
		record

			unsigned8										unique_id									;

			string100 									address1									;
			string50										address2									;

			base.ct																								;

		end;

		export IN :=
		record

			unsigned8										unique_id									;

			string100 									address1									;
			string50										address2									;

			base.in																								;

		end;

		export LA :=
		record

			unsigned8										unique_id									;

			string100 									trade_address1						;
			string50										trade_address2						;
                               
			string100										owner_address1						;
			string50										owner_address2						;
                               
			base.la																								;

		end;

		export OH :=
		record

			unsigned8										unique_id									;

			string100 									address1									;
			string50										address2									;

			base.oh																								;

		end;
	
		export PA :=
		record

			unsigned8										unique_id									;

			string100 									address1									;
			string50										address2									;

			base.pa																								;

		end;

		export TX :=
		record

			unsigned8										unique_id									;

			string100 									location_address1					;
			string50										location_address2					;

			string100										mailing_address1					;
			string50										mailing_address2					;

			base.tx																								;

		end;

	end;

end;