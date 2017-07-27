EXPORT layouts_logging := MODULE

	EXPORT transactionLog := RECORD			
		STRING20 transaction_id ; 				// ID of the transaction. This ID will be associated with all logging entries.
		INTEGER  product_id ; 						// MBS gbl_product_id
		INTEGER  sub_product_id ; 				// MBS sub product id		
		STRING60 date_added ; 						// Date the record was added.
		STRING60 login_id ; 							// LOG-IN id of the USER executing the search.
		STRING60 billing_code ; 					// Billing CODE of the transaciton. FOR migrated products it would be special billing id
		STRING30 function_name ; 					// TYPE of TRANSACTION/search that IS being executed. Equivalent FOR the current insurance products AS "report_service_type"
		INTEGER  report_code ; 						// Denotes the reporting CODE TO be used FOR billing
		INTEGER  gc_id ; 									// Gc id of the company running the search
		INTEGER  billing_id ; 						// Billing id of the company running the search
		STRING32 customer_reference_code; // Pass through VALUE BY the customer TO ID the transaction. IN the current insurance world referred AS "full quote back" AND IN accurint "reference number"
		STRING32 i_unique_id ; 						// UNIQUE ID provided aka LexID
		STRING15 i_tax_id ; 							// Input TaxId
		STRING15 i_fein ; 								// Input FEIN
		STRING10 i_npi ; 									// Input NPI
		STRING15 i_clia ; 								// Input CLIA
		STRING12 i_upin ; 								// Input UPIN
		STRING20 i_provider_id ; 					// Input LN ProviderId
		STRING20 i_facility_id ; 					// Input LN FacilityId
		STRING5  i_person_name_prefix ; 	// Prefix NAME provided
		STRING20 i_person_last_name ; 		// LAST NAME, input IN search
		STRING20 i_person_first_name ; 		// FIRST NAME input IN search
		STRING20 i_person_middle_name ; 	// Middle NAME input IN search
		STRING5  i_person_name_suffix ; 	// Suffix NAME provided
		STRING8  i_person_dob ; 					// DOB of the SUBJECT
		STRING9  i_person_ssn ; 					// SSN of the person being inquiried
		STRING10 i_person_phone ; 				// Phone of the person being inquiried
		STRING90 i_person_addr ; 					// Line1 address being passed
		STRING50 i_person_city ; 					// City of the address passed
		STRING2  i_person_state ; 				// State of the address being passed
		STRING10 i_person_zip ; 					// ZIP of the address passed
		STRING3  i_person_country ; 			// 3 letter ISO CODE of the country of the address passed
		STRING80 i_bus_name ; 						// Business/facility/organization Name
		STRING10 i_bus_phone ; 						// Phone of the business being inquiried
		STRING90 i_bus_addr ; 						// Line1 business address being passed
		STRING50 i_bus_city ; 						// City of the business address passed
		STRING2  i_bus_state ; 						// State of the business address being passed
		STRING10 i_bus_zip ; 							// ZIP of the business address passed
		STRING3  i_bus_country ; 					// 3 letter ISO CODE of the country of the business address passed
		STRING256 user_agent; 						// User Agent string if from Web App if Web transaction
		STRING10  error_code; 						// Other transaction error
		STRING100 error_detail; 					// Verbose description of error_code
		STRING10 dataprep_error_code ; 		// Processing error from Roxie
		STRING1  match_flag ; 						// From Roxie
		STRING1  subject_to_sla ; 				// From Roxie - if transaction is subject to SLA
		DECIMAL18_9 price; 								// Price of the transaction. Having the price in the accounting_log easily helps reporting tieing a type of transaction with the price
		INTEGER  currency; 								// Indicates the type of currency. 0=unknown, 1= U.S Dollar,etc
		INTEGER  pricing_error_code; 			// To be set by the pricing application. Indicates default pricing status after pricer process the record
		INTEGER  free; 									  // Tells whether the record is for free and the reason, i.e free = 1 Free Trial, free 2= Exempt Company, free = 3 Next Page search, free = 4/6 , marked as Freebee
		INTEGER  record_count ; 					// Results returned from the search for one type
		STRING10 report_options ; 				// Register the options for each possible search if applies. Can be similar to what we use in Accurint accounting_log but even expand the use if necessary, and as opposed to use boolean 1/0 for each position, can have different values
		INTEGER  transaction_code ; 			// This would be used for billing and potentially for rollup
		INTEGER  order_status_code ; 			// Order status code reflects whether its subject to billing, not or if there has been any error
		INTEGER  result_code ; 						// Denotes the specifics/nature of the result, in case it could be fulfilled
		INTEGER  login_history_id ; 			// Optional. Possibly NULL in this case for non WEB transactions
		STRING45 ip_address ; 						// IP where the request was made for the search
		STRING8  response_time ; 					// Response time taken to fullfil the request, from request to result
		STRING40 esp_method ; 						// ESP method tied to this transaction id
		
	END; // RECORD
	
	EXPORT transactionLogWrap := RECORD
		transactionLog Rec {xpath('Rec')};
	END;
	
	EXPORT transactionLogWrapWrap := RECORD
		transactionLogWrap Records {xpath('Records')};
	END;
	
END; // MODULE