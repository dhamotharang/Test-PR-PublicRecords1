import address;

export Layouts :=
module

	shared max_size := _Dataset().max_record_size;

	export Input :=
	module
	
		export Dell :=
		record
			string9		APP_REF_KEY						;
			string7		SMB_EDM_APPL_ID				;
			string2		COMPANY_NUM						;
			string18	CREATION_DATE					;
			string18	LAST_UPDATE_DATE			;
			string18	APPL_LAST_ACTIVITY		;
			string7		SMB_BUSINESS_ID				;
			string9		DUNS_NUMBER						;
			string151	LEGAL_NAME						;
			string1		BUSINESS_TYPE					;
			string3		AREA_CD								;
			string7		PHONE_NUM							;
			string4		PHONE_TYPE						;
			string41	ADDR_LINE1						;
			string30	ADDR_LINE2						;
			string28	CITY									;  
			string2		STATE									;	 
			string5		POSTAL_CODE						;
			string4		POSTAL_PLUS4					;
			string7		ADDRESS_TYPE					;
			string25	CONTACT_FIRST_NAME		;
			string25	CONTACT_LAST_NAME			;
			string1		CONTACT_MIDDLE_NAME		;
			string47	CONTACT_TITLE					;
			string49	CONTACT_EMAIL_ADDRESS	;
			string3		CONTACT_SALUTATION		;
			string1		lf										;
		end;
	
		export Dell_out :=
		record
				string	APP_REF_KEY						;
				string	SMB_EDM_APPL_ID				;
				string	COMPANY_NUM						;
				string	CREATION_DATE					;
				string	LAST_UPDATE_DATE			;
				string	APPL_LAST_ACTIVITY		;
				string	SMB_BUSINESS_ID				;
				string	DUNS_NUMBER						;
				string	LEGAL_NAME						;
				string	BUSINESS_TYPE					;
				string	AREA_CD								;
				string	PHONE_NUM							;
				string	PHONE_TYPE						;
				string	ADDR_LINE1						;
				string	ADDR_LINE2						;
				string	CITY									;  
				string	STATE									;	 
				string	POSTAL_CODE						;
				string	POSTAL_PLUS4					;
				string	ADDRESS_TYPE					;
				string	CONTACT_FIRST_NAME		;
				string	CONTACT_LAST_NAME			;
				string	CONTACT_MIDDLE_NAME		;
				string	CONTACT_TITLE					;
				string	CONTACT_EMAIL_ADDRESS	;
				string	CONTACT_SALUTATION		;
		end;

	
	end;
	
	
	export address_summary :=
	record
		unsigned8 bdid 														;	// bdid
		string		vendor_id												;	// unique id for dataset(i.e. for corps, corp_key)
		string 		source 													;	// Source code
		unsigned8 address_id 											;	// Address id, AID
		string		address_type 										;	// 'P' = Physical, 'M' = Mailing, 'R' = Registered Agent, 'O' = Officer
		unsigned8 Date_Address_First_Seen					;	// Earliest date address seen
		unsigned8 Date_Address_Last_Seen 					;	// Latest date address seen																										
		boolean		current_address_change					;	// was there an address change in the current filing?
		unsigned8 count_address_changes						;	// total amount of times this address has changed
		unsigned8 time_between_last_two_addresses	;	// amount of time between last filing of previous address and the new filing of current address
		unsigned8 Count_Business_At_Address							;	// Count other businesses filed at address
		unsigned8 Count_Delinquent_Business_At_Address	;	// Count number of businesses filed at address currently with derogatory status
		unsigned8 Count_Derogatory_Business_At_Address	;	// Count number of businesses with derogatory events filed at address					
		string		business_residential						;	// B = Business & R = Rsidential	
		string 		vacant_property									;	// Property flagged as vacant (>90 days) Y/N
		string		recent_foreclosure              ;	// Property recent foreclosure (>?) Y/N
		unsigned8	Date_Of_Foreclosure							; // Date of foreclosure
		string 		Seasonal_Delivery_Indicator     ;	// Property seasonal - possibly vacant Y/N
		string		college                         ;	// College campus - Y/N
		string		CMRA 		                        ;	// This address is a CMRA (Commercial Mail Receiving Agency)
		string 		usps_hotlist                    ;	// Address found on USPS hotlist
		string		input_phone_matches_address     ;	// Input phone and address match listing (eda first else phones plus)
		string 		phone_type_match                ;	// EDA or Phones Plus Type
		string		alternate_phone_at_address      ;	// Alternate phone listing at input address (eda first else phones plus)
		string 		alternate_phone_type            ;	// Alternate EDA or Phones Plus type
		string		alternate_phone_listed_name     ;	// Alternate phone listing name																					
	end;

	export Business_Summary :=
	record

		unsigned8	bdid 																	;	// Bdid
		string		vendor_id     												;	// unique id for dataset(i.e. for corps, corp_key)
		string 		source 																;	// Source code
		string		latest_status     										;	// (D = Delinquent, G = Good Standing)

		unsigned8 Date_Filing_First_Seen								;	// Initial Filing Date
		unsigned8 Date_Filing_Last_Seen 								;	// Latest Filing Date or Latest Filing Event
		unsigned8 Date_Current_Status 									;	// date of the most recent filing status for the bdid / corp_key
		unsigned8 Date_Prior_Status			 								;	// date the status for the bdid / corp_key combo last reflected something different 
		unsigned8 Date_Last_Event 											;	// Date of Last Event Filing
		unsigned8 Date_Last_Derog_Event									;	// Date of Last Derog Event Filing
		unsigned8 Date_Most_Recent_Dissolution					;	// Date of Last Dissolution Event
		unsigned8 Date_Most_Recent_Reinstatement				;	// Date of Last Reinstatement

		unsigned8 Count_Delinquent_Statuses 						;	// Count of how many delinquent statuses there have been
		unsigned8 Count_Derog_Events 										;	// Count of all Derog Events
		unsigned8 Count_Bankruptcies_business 					;	// Count of all Bankruptcies
		unsigned8 Count_Liens_Judgements_business 			;	// Count of all Liens and Judgements
		unsigned8 Count_UCCs_business 									;	// Count of all UCCs
		unsigned8 count_address_changes									;	// Count of total address changes reported
		unsigned8 count_contact_changes									;	// Count of total contact changes reported
		unsigned8 Count_Business_At_Address							;	// Count other businesses filed at address
		unsigned8 Count_Delinquent_Business_At_Address	;	// Count number of businesses filed at address currently with derogatory status
		unsigned8 Count_Derogatory_Business_At_Address	;	// Count number of businesses with derogatory events filed at address					
		unsigned8 count_business_contacts								; // Count number of additional businesses associated with contacts
		unsigned8 count_delinquent_business_contacts		; // Count number of delinquent businesses associated with contacts
		unsigned8 count_derogatory_business_contacts		; // Count number of businesses with derogatory events associated with contacts

		unsigned8 time_since_last_report_date						;	// # of months between run date and latest filing
		unsigned8 time_between_filings									;	// # of months between latest filing and previous filing
		unsigned8 time_between_events										;	// # of months between latest event and previous event
		unsigned8 time_between_dissolution_reinstatement;	// # of months between dissolution and reinstatement

	end;

	export Contact_Summary :=
	record
		unsigned8	bdid 																					;// bdid
		unsigned6 did																						;
		string		vendor_id 																		;// unique id for dataset(i.e. for corps, corp_key)
		string		source 																				;// source code
		string		contact_type  																;// 'R' = Registered Agent, 'O' = Officer
		boolean		current_contact_change    										;// Latest filing includes contact change
		unsigned8 Date_Last_Contact_Filing		    							;// last time this contact was filed
		unsigned8 Date_Last_Contact_Type_Change    							;// last time this contact's info changed
		unsigned8 Count_Contact_Changes      										;// Count of Changes to this contact title
		unsigned8 Count_bankruptcies    												;// Count of bankruptcies for this contact
		unsigned8 Count_liens_judgements 												;// Count of Liens and Judgements for this contact
		unsigned8 Count_ucc_filings															;// Count of UCC filings for this contact							
	end;
	
	export Miscellaneous :=
	module
	
		export Cleaned_Phones :=
		record

			string10 Phone					;

		end;
		
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Append_fields :=
	record, maxlength(max_size)

		string 		filing_match													;	// 'Y' = filing match, 'N' = no filing match
		string 		filing_type_match                     ;	// ''
		string 		match_criteria                        ;	// 
		string1 	latest_status                         ;
		unsigned8 Date_Filing_Last_Seen 								;	// Latest Filing Date or Latest Filing Event
		unsigned8 time_since_last_report_date						;	// # of months between run date and latest filing
		unsigned8 time_between_filings									;	// # of months between latest filing and previous filing
		unsigned8 Date_Last_Event 											;	// Date of Last Event Filing
		unsigned8 time_between_events										;	// # of months between latest event and previous event
		boolean		current_derogatory_event							;
		boolean		current_address_change								;	// was there an address change in the current filing?
		boolean		current_contact_change    						;	// Latest filing includes contact change
		boolean		Dissolution_exists                    ;
		boolean		reinstatement_exists                  ;
//		unsigned8 time_between_dissolution_reinstatement;	// # of months between latest event and previous event
		unsigned8 Count_Delinquent_Statuses 						;	// Count of how many delinquent statuses there have been
		unsigned8 Count_Derog_Events 										;	// Count of all Derog Events
		unsigned8 count_address_changes									;
		unsigned8 count_contact_changes									;
		unsigned8 Count_Business_At_Address							;	// Count other businesses filed at address
		unsigned8 Count_Delinquent_Business_At_Address	;	// Count number of businesses filed at address currently with derogatory status
		unsigned8 Count_Derogatory_Business_At_Address	;	// Count number of businesses with derogatory events filed at address					
		unsigned8 count_business_contacts								;	// Count number of additional businesses associated with contacts
		unsigned8 count_delinquent_business_contacts		;	// Count number of delinquent businesses associated with contacts
		unsigned8 count_derogatory_business_contacts		;	// Count number of businesses with derogatory events associated with contacts
		unsigned8 Count_Bankruptcies_business 					;	// Count of all Bankruptcies
		unsigned8 Count_Liens_Judgements_business 			;	// Count of all Liens and Judgements
		unsigned8 Count_UCCs_business 									;	// Count of all UCCs
		unsigned8 Count_Bankruptcies_contacts 					;	// Count of all Bankruptcies
		unsigned8 Count_Liens_Judgements_contacts 			;	// Count of all Liens and Judgements
		unsigned8 Count_UCCs_contacts 									;	// Count of all UCCs
		string		business_residential									;	// B = Business & R = Rsidential	
		string 		vacant_property												;	// Property flagged as vacant (>90 days) Y/N
		string		recent_foreclosure              			;	// Property recent foreclouse (>?) Y/N
		unsigned8	Date_Of_Foreclosure										; // Date of foreclosure
		string 		Seasonal_Delivery_Indicator     			;	// Property seasonal - possibly vacant Y/N
		string		college                         			;	// College campus - Y/N
		string		CMRA 		                        			;	// This address is a CMRA (Commercial Mail Receiving Agency)
		string		Record_Type_Code											; // Address type, "An alphabetic value that identifies the type of delivery point
		string 		usps_hotlist                    			;	// Address found on USPS hotlist
		string		input_phone_matches_address     			;	// Input phone and address match listing (eda first else phones plus)
		string 		phone_type_match                			;	// EDA or Phones Plus Type
		string		alternate_phone_at_address      			;	// Alternate phone listing at input address (eda first else phones plus)
		string 		alternate_phone_type            			;	// Alternate EDA or Phones Plus type
		string		alternate_phone_listed_name     			;	// Alternate phone listing name																					
		                                          			
	end;

	export Append_fields_outy :=
	record, maxlength(max_size)

		string3 		filing_match													; // 'Y' = filing match, 'N' = no filing match
		string12 		filing_type_match                     ;	// 
		string12 		match_criteria                        ;
		string7	 	latest_status                         ;
		string10 		latest_filing_date		 								;	// Latest Filing Date or Latest Filing Event
		string10 		time_since_last_report_date						;	// # of months between run date and latest filing
		string10 		time_between_filings									;	// # of months between latest filing and previous filing
		string10 		Date_Last_Event 											;	// Date of Last Event Filing
		string10 		time_between_events										;	// # of months between latest event and previous event
		string3		current_derogatory_event							;
		string3		current_address_change								;	// was there an address change in the current filing?
		string3		current_contact_change    						;	// Latest filing includes contact change
		string3		Dissolution_exists                    ;
		string3		reinstatement_exists                  ;
		string7 		Count_Delinquent_Statuses 						;	// Count of how many delinquent statuses there have been
		string7 		Count_Derog_Events 										;	// Count of all Derog Events
		string7 		count_address_changes									;
		string7 		count_contact_changes									;
		string7 		Count_Business_At_Address							;	// Count other businesses filed at address
		string7 		Count_Delinquent_Business_At_Address	;	// Count number of businesses filed at address currently with derogatory status
		string7 		Count_Derogatory_Business_At_Address	;	// Count number of businesses with derogatory events filed at address					
		string7 		count_business_contacts								;	// Count number of additional businesses associated with contacts
		string7 		count_delinquent_business_contacts		;	// Count number of delinquent businesses associated with contacts
		string7 		count_derogatory_business_contacts		;	// Count number of businesses with derogatory events associated with contacts
		string7 		Count_Bankruptcies_business 					;	// Count of all Bankruptcies
		string7 		Count_Liens_Judgements_business 			;	// Count of all Liens and Judgements
		string7 		Count_UCCs_business 									;	// Count of all UCCs
		string7 		Count_Bankruptcies_contacts 					;	// Count of all Bankruptcies
		string7 		Count_Liens_Judgements_contacts 			;	// Count of all Liens and Judgements
		string7 		Count_UCCs_contacts 									;	// Count of all UCCs
		string3		business_residential									;	// B = Business & R = Rsidential	
		string3 		vacant_property												;	// Property flagged as vacant (>90 days) Y/N
		string3		recent_foreclosure              			;	// Property recent foreclousr (>?) Y/N
		string10		Date_Of_Foreclosure										; // Date of foreclosure
		string3 		Seasonal_Delivery_Indicator     			;	// Property seasonal - possibly vacant Y/N
		string3		college                         			;	// College campus - Y/N
		string3		CMRA 		                        			;	// This address is a CMRA (Commercial Mail Receiving Agency)
		string3		Record_Type_Code											; // Address type, "An alphabetic value that identifies the type of delivery point
		string3 		usps_hotlist                    			;	// Address found on USPS hotlist
		string3		input_phone_matches_address     			;	// Input phone and address match listing (eda first else phones plus)
		string7 		phone_type_match                			;	// EDA or Phones Plus Type
		string9		alternate_phone_at_address      			;	// Alternate phone listing at input address (eda first else phones plus)
		string3 		alternate_phone_type            			;	// Alternate EDA or Phones Plus type
		string52		alternate_phone_listed_name     			;	// Alternate phone listing name																										
		                                          			
	end;

	export Append_fields_old :=
	record, maxlength(max_size)

		string 		filing_match													;
		string 		filing_type_match                     ;
		string 		match_criteria                        ;
		string1 	latest_status                         ;
		unsigned8 Date_Filing_Last_Seen 								;	// Latest Filing Date or Latest Filing Event
		unsigned8 time_since_last_report_date						;	// # of months between run date and latest filing
		unsigned8 time_between_filings									;	// # of months between latest filing and previous filing
		unsigned8 Date_Last_Event 											;	// Date of Last Event Filing
		unsigned8 time_between_events										;	// # of months between latest event and previous event
		boolean		current_derogatory_event							;
		boolean		current_address_change								;	// was there an address change in the current filing?
		boolean		current_contact_change    						;	// Latest filing includes contact change
		boolean		Dissolution_exists                    ;
		boolean		reinstatement_exists                  ;
		unsigned8 time_between_dissolution_reinstatement;	// # of months between latest event and previous event
		unsigned8 Count_Delinquent_Statuses 						;	// Count of how many delinquent statuses there have been
		unsigned8 Count_Derog_Events 										;	// Count of all Derog Events
		unsigned8 count_address_changes									;
		unsigned8 count_contact_changes									;
		unsigned8 Count_Business_At_Address							;	// Count other businesses filed at address
		unsigned8 Count_Delinquent_Business_At_Address	;	// Count number of businesses filed at address currently with derogatory status
		unsigned8 Count_Derogatory_Business_At_Address	;	// Count number of businesses with derogatory events filed at address					
		unsigned8 count_business_contacts								;	// Count number of additional businesses associated with contacts
		unsigned8 count_delinquent_business_contacts		;	// Count number of delinquent businesses associated with contacts
		unsigned8 count_derogatory_business_contacts		;	// Count number of businesses with derogatory events associated with contacts
		unsigned8 Count_Bankruptcies_business 					;	// Count of all Bankruptcies
		unsigned8 Count_Liens_Judgements_business 			;	// Count of all Liens and Judgements
		unsigned8 Count_UCCs_business 									;	// Count of all UCCs
		unsigned8 Count_Bankruptcies_contacts 					;	// Count of all Bankruptcies
		unsigned8 Count_Liens_Judgements_contacts 			;	// Count of all Liens and Judgements
		unsigned8 Count_UCCs_contacts 									;	// Count of all UCCs
		string		business_residential									;	// B = Business & R = Rsidential	
		string 		vacant_property												;	// Property flagged as vacant (>90 days) Y/N
		string		recent_foreclosure              			;	// Property recent foreclousr (>?) Y/N
		unsigned8	Date_Of_Foreclosure										; // Date of foreclosure
		string 		Seasonal_Delivery_Indicator     			;	// Property seasonal - possibly vacant Y/N
		string		college                         			;	// College campus - Y/N
		string		CMRA 		                        			;	// This address is a CMRA (Commercial Mail Receiving Agency)
		string		Record_Type_Code											; // Address type, "An alphabetic value that identifies the type of delivery point
		string 		usps_hotlist                    			;	// Address found on USPS hotlist
		string		input_phone_matches_address     			;	// Input phone and address match listing (eda first else phones plus)
		string 		phone_type_match                			;	// EDA or Phones Plus Type
		string		alternate_phone_at_address      			;	// Alternate phone listing at input address (eda first else phones plus)
		string 		alternate_phone_type            			;	// Alternate EDA or Phones Plus type
		string		alternate_phone_listed_name     			;	// Alternate phone listing name																					
		                                          			
	end;

	export Base_old :=
	record, maxlength(max_size)
		unsigned6												Bdid												:= 0;
		unsigned1												bdid_score									:= 0;
		unsigned8												unique_id												;
		
		input.Dell											rawfields												;
		Address.Layout_Clean_Name				clean_contact_name							;
		unsigned8												ace_aid													;
		unsigned8												ace_aid_from_bdid								;
		Address.Layout_Clean182_fips		Clean_address										;

		Miscellaneous.Cleaned_Phones		clean_phones										;
		address_summary									summary_address									;
		business_summary								summary_business								;
		contact_summary									summary_contact									;
		Append_fields_old										Appended_fields									;
		
	end;

	export Base :=
	record, maxlength(max_size)
		unsigned6												Bdid												:= 0;
		unsigned1												bdid_score									:= 0;
		unsigned8												unique_id												;
		
		input.Dell											rawfields												;
		Address.Layout_Clean_Name				clean_contact_name							;
		unsigned8												ace_aid													;
		unsigned8												ace_aid_from_bdid								;
		Address.Layout_Clean182_fips		Clean_address										;

		Miscellaneous.Cleaned_Phones		clean_phones										;
		address_summary									summary_address									;
		business_summary								summary_business								;
		contact_summary									summary_contact									;
		Append_fields										Appended_fields									;
		
	end;

	export Out :=
	record, maxlength(max_size)

		input.Dell											rawfields												;
		address_summary									summary_address									;
		business_summary								summary_business								;
		contact_summary									summary_contact									;
		
	end;
	
	
	export OutAppend :=
	record, maxlength(max_size)

		input.Dell_out														;
		Append_fields_outy												;
		
	end;

	export Dell_return :=
	record, maxlength(max_size)

		input.Dell_out														;
		Append_fields_outy	- Date_Of_Foreclosure											;
		string							organization_id				;
		string							fpd_fl								;
		
	end;

	export temporary :=
	module

		export AggregateCorpV2Bdids :=
		record

			string		source			;
			string		vendor_id		;
			unsigned6	bdid				;
			
		end;

		export AggregateCorpV2Bdids_extra :=
		record

			string source						;
			string vendor_id		;
			unsigned6 bdid 		;
			unsigned8 Count_Bankruptcies_business 					;	// Count of all Bankruptcies
			unsigned8 Count_Liens_Judgements_business 			;	// Count of all Liens and Judgements
			unsigned8 Count_UCCs_business 									;	// Count of all UCCs
			
		end;

		export AggregateCorpV2Events :=
		record

			string		vendor_id							;
			unsigned4 Date_Filing_Last_Seen	;
			unsigned8 time_between_events		;
			unsigned8 count_derog_events		;
		
		end;
		
		export AggregateCorpV2Contacts :=
		record

			unsigned6 did																	;
			string		source															;
			string		vendor_id														;
			unsigned8 count_business_contacts							;
			unsigned8 count_delinquent_business_contacts	;
			unsigned8 count_derogatory_business_contacts	;
			unsigned8 count_contact_changes								;		
		
		end;
		
		export AggregateCorpV2Addresses :=
		record

			unsigned8 address_id														;
			string		source																;
			string		vendor_id															;
			unsigned8 count_address_changes									;
			unsigned8 Count_Business_At_Address							;	
			unsigned8 Count_Delinquent_Business_At_Address	;
			unsigned8 Count_Derogatory_Business_At_Address	;
		
		end;

		export PrepAdvo :=
		record
			string		address1										;
			string		address2										;
			string		business_residential				;	// B = Business & R = Residential	
			string 		vacant_property							;	// Property flagged as vacant (>90 days) Y/N
			string 		Seasonal_Delivery_Indicator ;	// Property seasonal - possibly vacant Y/N
			string		college                     ;	// College campus - Y/N
			string		cmra                    	 	;	// This address is a CMRA (Commercial Mail Receiving Agency)
			string		Record_Type_Code						; // Address type, "An alphabetic value that identifies the type of delivery point
																							//		F = Firm
																							//		G = General
																							//		H = Highrise
																							//		P = PO Box
																							//		R = Rural Route
																							//		S = Street"

			unsigned8 ace_aid											;
		end;
		
	//need ace_aid, phone, phone type(both types), listed name
		export PrepUSPISHotList :=
		record
		
			unsigned8 ace_aid;
				
		end;
		
		export PrepForeclosure :=
		record
		
			unsigned8 ace_aid;
			unsigned8	Date_Of_Foreclosure										; // Date of foreclosure
			
		end;

		export PrepPhonesPlus := 
		record
			string		address1				;
			string		address2				;
			string		listed_name			;
			string		listing_type		;
			string		phone_type			;
			unsigned8 phone						;
			unsigned8 ace_aid					;
			unsigned8 unique_id				;
		end;

		export aidaddr := 
		record
			string		address1			;
			string		address2			;
			string		address_type	;
			string		address_desc	;
			unsigned8 address_date	;
			unsigned8 rawaid				;
		end;
	
		export businesssummary :=
		record
			Business_Summary								;
		end;
		
		export addresssummary :=
		record
			unsigned8	unique_id	;
			Address_Summary	;
			string address1	;
			string address2	;
			string		city 	;	// city
			string		state ;	// state
			string		name	;	// company name
			unsigned8		phone	;	// phone
		end;

		export contactsummary :=
		record
			unsigned8	unique_id	;
			contact_Summary	;
			string fname;
			string mname;
			string lname;
			string contact_title;
			unsigned8 name_hash;
			unsigned8	dt_first_seen	;
			unsigned8	dt_last_seen	;
		end;

		export Counts :=
		record
		
			unsigned8 id						;
			unsigned8 Count_filings	;
		
		end;
	
		export StandardizeInput := 
		record, maxlength(max_size)


			string100 									address1	;
			string50										address2	;

			Base															;
		end;
		
		export StandardizeInput_old := 
		record, maxlength(max_size)


			string100 									address1	;
			string50										address2	;

			Base_old															;
		end;
		

		export UniqueId := 
		record, maxlength(max_size)


			Base																	;
		end;

		export BdidSlim := 
		record

			unsigned8		unique_id					;
			unsigned8		ace_aid						;
			string			App_ref_key				;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string			city							;
			string5			zip5							;
			string8			sec_range					;
			string2			state							;
			string10		phone							;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string			match_criteria		;
	
		end;
		
		export fCorpV2UniqueNameCityState :=
		record
			unsigned6 bdid						;
			string		corp_legal_name	;
			string		city						;
			string		state						;
			string		corp_key				;
		end;

	end;
	
	#if(_Dataset().isDebugging = true)
		export laybus		:= temporary.BusinessSummary;
		export layaddr	:= temporary.AddressSummary;
		export laycont	:= temporary.ContactSummary;
	#else
		export laybus		:= Business_Summary;
		export layaddr	:= Address_Summary;
		export laycont	:= Contact_Summary;
	#end


end;