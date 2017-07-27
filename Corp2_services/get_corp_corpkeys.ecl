import AutoStandardI, doxie;

PENALTY_VALUE_FOR_NO_INPUT := 1000;

export get_corp_corpkeys := module
	
	//********* Shared functions *********
	
	SHARED get_blank_did_penalty() := FUNCTION
		tempmoddid := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_DID.full,opt))
			export string did_field := '';
		end;	
		return AutoStandardI.LIBCALL_PenaltyI_DID.val(tempmoddid);
	END;

	SHARED get_blank_ssn_penalty() := FUNCTION
		tempmodssn := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
			export string ssn_field := '';
		end;	
		return AutoStandardI.LIBCALL_PenaltyI_SSN.val(tempmodssn);
	END;
	
	SHARED get_blank_indvname_penalty() := FUNCTION
		tempmodindvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_name.full,opt))
			export boolean allow_wildcard := false;
			export string fname_field := '';
			export string lname_field := '';
			export string mname_field := '';
		end;	
		return AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname);
	END;
	
	// The following function does something you wouldn't expect: instead of penalizing blank input fields,
	// which always yield zero, it penalizes the input fields--whether they have values or not--as though the
	// matching record in the datastore had blank values. This will yield a penalty of 6, not zero.
	//
	// ***** REQUIRES REVIEW FOR LOGIC ERROR *****
	SHARED get_penalty_for_no_contact() := FUNCTION
		RETURN get_blank_did_penalty() + get_blank_ssn_penalty() + get_blank_indvname_penalty();
	END;
	

	//********* REPORT VIEW FUNCTION *********
	
	EXPORT report(DATASET(corp2_services.layout_corpkey)in_corpkeys, 
	                      string in_ssn_mask_type = '',
	                      BOOLEAN return_multiple_pages = FALSE,
												BOOLEAN is_batch_service = FALSE,
												BOOLEAN currentOnly = FALSE) := FUNCTION
		
		// Retrieve records for the Report/Source Search
		corp_recs        := corp2_services.corp2_report_recs.corps_raw(in_corpkeys, is_batch_service, currentOnly);
		contacts         := corp2_services.corp2_report_recs.retrieve_cont_recs(in_corpkeys,in_ssn_mask_type, currentOnly);
		stocks           := corp2_services.corp2_report_recs.retrieve_stock_recs(in_corpkeys, currentOnly);
		annual_reports   := corp2_services.corp2_report_recs.retrieve_ar_recs(in_corpkeys);
		
		
		// Determine the number of pages (i.e. records) that the system must return. We need to determine this 
		// beforehand, since we'll be joining all of the record sections based on corp_key and page_no.
		
		rec_max_pages_per_corpkey := RECORD
			corp2_services.layout_corpkey;
			INTEGER max_pages;
		END;

		rec_max_pages_per_corpkey xfm_determine_max_pages(corp_recs.base l) :=
			TRANSFORM
				SELF.corp_key  := l.corp_key;
				SELF.max_pages := MAX( MAX(contacts(corp_key = l.corp_key), page_no),
				                       MAX(corp_recs.events(corp_key = l.corp_key), page_no),
				                       MAX(stocks(corp_key = l.corp_key), page_no),
				                       MAX(annual_reports(corp_key = l.corp_key), page_no),
				                       MAX(corp_recs.hist(corp_key = l.corp_key), page_no),
				                       MAX(corp_recs.tradenames(corp_key = l.corp_key), page_no),
				                       MAX(corp_recs.trademarks(corp_key = l.corp_key), page_no)		
				                      );
			END;
			
		ds_corpkeys_with_max_pages := PROJECT(corp_recs.base, xfm_determine_max_pages(LEFT));
		
		
		layout_corp2_rollup_with_page_no := RECORD		
			INTEGER page_no;
			corp2_services.layout_corp2_rollup;
		END;
				
		ds_corp_recs_seed := NORMALIZE(ds_corpkeys_with_max_pages, 
		                               LEFT.max_pages, 
																	 TRANSFORM(layout_corp2_rollup_with_page_no,
																	           SELF.corp_key := LEFT.corp_key;
																						 SELF.page_no  := COUNTER;
																						 SELF          := [];)
																	);
										 
		// Assemble the report by joining individual sections to the final output layout. 
				
		corp_recs_bxxxxxxx := JOIN(ds_corp_recs_seed, corp_recs.base,
		                           LEFT.corp_key = RIGHT.corp_key,
		                           TRANSFORM(layout_corp2_rollup_with_page_no,
															           SELF.page_no  := LEFT.page_no;
																				 SELF.corp_key := LEFT.corp_key;
		                                     SELF          := RIGHT;
																				 SELF          := [];),
		                           LEFT OUTER, KEEP(1000));

		corp_recs_bcxxxxxx := JOIN(corp_recs_bxxxxxxx, contacts,
		                           LEFT.corp_key = RIGHT.corp_key AND
															 LEFT.page_no = RIGHT.page_no,
		                           TRANSFORM(layout_corp2_rollup_with_page_no,
		                                     SELF.contacts := RIGHT.contact;
		                                     SELF          := LEFT;),
		                           LEFT OUTER, KEEP(1000));
															 
		corp_recs_bcexxxxx := JOIN(corp_recs_bcxxxxxx, corp_recs.events,
		                           LEFT.corp_key = RIGHT.corp_key AND
															 LEFT.page_no = RIGHT.page_no,
		                           TRANSFORM(layout_corp2_rollup_with_page_no,
		                                     SELF.events := RIGHT.events;
		                                     SELF        := LEFT;),
		                           LEFT OUTER, KEEP(1000));	

		corp_recs_bcesxxxx := JOIN(corp_recs_bcexxxxx, stocks,
		                           LEFT.corp_key = RIGHT.corp_key AND
															 LEFT.page_no = RIGHT.page_no,
		                           TRANSFORM(layout_corp2_rollup_with_page_no,
		                                     SELF.stocks := RIGHT.stocks;
		                                     SELF        := LEFT;),
		                           LEFT OUTER, KEEP(1000));	

		corp_recs_bcesrxxx := JOIN(corp_recs_bcesxxxx, annual_reports,
		                           LEFT.corp_key = RIGHT.corp_key AND
															 LEFT.page_no = RIGHT.page_no,
		                           TRANSFORM(layout_corp2_rollup_with_page_no,
		                                     SELF.annual_reports := RIGHT.ar;
		                                     SELF                := LEFT;),
		                           LEFT OUTER, KEEP(1000));	
															 
		corp_recs_bcesrhxx := JOIN(corp_recs_bcesrxxx, corp_recs.hist,
		                           LEFT.corp_key = RIGHT.corp_key AND
															 LEFT.page_no = RIGHT.page_no,
		                           TRANSFORM(layout_corp2_rollup_with_page_no,
		                                     SELF.corp_hist := RIGHT.corp_hist;
		                                     SELF           := LEFT;),
		                           LEFT OUTER, KEEP(1000));															

		corp_recs_bcesrhtx := JOIN(corp_recs_bcesrhxx, corp_recs.tradenames,
		                           LEFT.corp_key = RIGHT.corp_key AND
															 LEFT.page_no = RIGHT.page_no,
		                           TRANSFORM(layout_corp2_rollup_with_page_no,
		                                     SELF.tradenames := RIGHT.tradenames;
		                                     SELF            := LEFT;),
		                           LEFT OUTER, KEEP(1000));	
															 
		corp_recs_bcesrhtt := JOIN(corp_recs_bcesrhtx, corp_recs.trademarks,
		                           LEFT.corp_key = RIGHT.corp_key AND
															 LEFT.page_no = RIGHT.page_no,
		                           TRANSFORM(layout_corp2_rollup_with_page_no,
		                                     SELF.trademarks := RIGHT.trademarks;
		                                     SELF            := LEFT;),
		                           LEFT OUTER, KEEP(1000));	
															 
		
		// An embedded view will only want page_no = 1, and this looks exactly the same as what the system returned
		// before the pagination effort. This shall be the default behavior.
		corp_records := IF( return_multiple_pages, corp_recs_bcesrhtt, corp_recs_bcesrhtt(page_no = 1) );

		// Debugs:
		// OUTPUT(corp_recs.hist, NAMED('corp_recs_hist'));
		
		// Shave off the page_no and return.
		RETURN PROJECT(corp_records, corp2_services.layout_corp2_rollup);
	
	END;



	//********* SEARCH VIEW FUNCTION *********
	PenaltyIBase := AutoStandardI.LIBIN.PenaltyI.base;
	AutoTranslator := AutoStandardI.InterfaceTranslator;

	export search(dataset(corp2_services.layout_corpkey)in_corpkeys,
								BOOLEAN isCorpSearchService = FALSE,
								PenaltyIBase params1 = PROJECT(AutoStandardI.GlobalModule(), PenaltyIBase, OPT),
								PenaltyIBase params2 = PROJECT(AutoStandardI.GlobalModule(), PenaltyIBase, OPT),
								BOOLEAN TwoPartySearch = FALSE) := function
		
		// 0.  Preliminary declarations.
		string32 inp_charter_number := '' : stored('CharterNumber');
		string30 inp_corp_key       := '' : stored('CorpKey');
		string11 inp_fein           := AutoStandardI.InterfaceTranslator.fein_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.fein_val.params)); 
		
		NULL_CONTACTS_SET           := DATASET([], assorted_layouts.cont_formatted);

		ssn_value_1 := AutoTranslator.ssn_value.val(PROJECT(params1, AutoTranslator.ssn_value.params));
		did_value_1 := AutoTranslator.did_value.val(PROJECT(params1, AutoTranslator.did_value.params));
		fname_value_1 := AutoTranslator.fname_value.val(PROJECT(params1, AutoTranslator.fname_value.params));
		lname_value_1 := AutoTranslator.lname_value.val(PROJECT(params1, AutoTranslator.lname_value.params));
		mname_value_1 := AutoTranslator.mname_value.val(PROJECT(params1, AutoTranslator.mname_value.params));;
		ssn_value_2 := AutoTranslator.ssn_value.val(PROJECT(params2, AutoTranslator.ssn_value.params));
		did_value_2 := AutoTranslator.did_value.val(PROJECT(params2, AutoTranslator.did_value.params));
		fname_value_2 := AutoTranslator.fname_value.val(PROJECT(params2, AutoTranslator.fname_value.params));
		lname_value_2 := AutoTranslator.lname_value.val(PROJECT(params2, AutoTranslator.lname_value.params));
		mname_value_2 := AutoTranslator.mname_value.val(PROJECT(params2, AutoTranslator.mname_value.params));;

		input_contains_personal_data() := MACRO
			(ssn_value_1 != '' OR did_value_1 != '' OR fname_value_1 != '' OR lname_value_1 != '' OR mname_value_1 != '' OR
			( TwoPartySearch AND
				( ssn_value_2 != '' OR did_value_2 != '' OR fname_value_2 != '' OR lname_value_2 != '' OR mname_value_2 != '')) )
		ENDMACRO;		
			
		layout_corp2_search_with_Penalties := record
			unsigned2 Penalt_phone_1 :=0;
			Unsigned2 Penalt_Company_1 :=0;
			Unsigned2 Penalt_Addr_1 :=0;
			unsigned2 Penalt_phone_2 :=0;
			Unsigned2 Penalt_Company_2 :=0;
			Unsigned2 Penalt_Addr_2 :=0;
			unsigned2 penalt_1 :=0;
			unsigned2 penalt_2 :=0;
			unsigned2 contact_penalt_1 :=0;
			unsigned2 contact_penalt_2 :=0;
			layout_corp2_search_rollup_Penalty - [penalt,contact_penalt];
		end;
		
		// ----------------- End declarations. -----------------
		
		// 1.  Retrieve records for the Search Service: base, corp_hist, and contacts. Retrieve contacts only 
		//     if there are personal data in the search, or if TextSearchService or FocusSearchService.
		corp_recs       := corp2_services.corp2_search_recs.corps_raw_search(in_corpkeys, TwoPartySearch, params1, params2);
		contacts_search := IF( input_contains_personal_data() OR NOT isCorpSearchService,
		                       corp2_services.corp2_search_recs.retrieve_cont_recs_search(in_corpkeys, TwoPartySearch, params1, params2),
													 NULL_CONTACTS_SET
		                      );
													
		// 2. Join the *Contacts* section to the base...:
		layout_corp2_search_with_Penalties join_contacts_search(corp_recs.base l, contacts_search r) := 
			TRANSFORM

				// If there are contacts for a particular corpkey, use a modulus to strip off any values of 
				// 1000 added when I penalized for no data in Corp2_services.corp2_search_recs. (I assign this
				// penalty when there is no value in the input to penalize; else the system returns a penalty 
				// of zero. Not good for determining which records are best matches.)  
				//
				// Else, assign the value of 100 to phone, company, and address penalties so that corpkeys 
				// having no contact records will be pushed to the bottom. 
				SELF.Penalt_phone_1   := IF( COUNT(r.contact) > 0, r.penalt_phone_1 % PENALTY_VALUE_FOR_NO_INPUT, 100 );
				SELF.Penalt_Company_1 := IF( COUNT(r.contact) > 0, r.penalt_company_1 % PENALTY_VALUE_FOR_NO_INPUT, 100 );
				SELF.Penalt_Addr_1    := IF( COUNT(r.contact) > 0, r.penalt_addr_1 % PENALTY_VALUE_FOR_NO_INPUT, 100 );
				SELF.Penalt_1         := IF( COUNT(r.contact) > 0, 
													         r.penalt_1 % PENALTY_VALUE_FOR_NO_INPUT,
													         IF( input_contains_personal_data(),
															         100,
															         get_penalty_for_no_contact() 
														          )
												          );
				SELF.Penalt_phone_2   := IF( COUNT(r.contact) > 0, r.penalt_phone_2 % PENALTY_VALUE_FOR_NO_INPUT, 100 );
				SELF.Penalt_Company_2 := IF( COUNT(r.contact) > 0, r.penalt_company_2 % PENALTY_VALUE_FOR_NO_INPUT, 100 );
				SELF.Penalt_Addr_2    := IF( COUNT(r.contact) > 0, r.penalt_addr_2 % PENALTY_VALUE_FOR_NO_INPUT, 100 );
				SELF.Penalt_2         := IF( COUNT(r.contact) > 0, 
													         r.penalt_2 % PENALTY_VALUE_FOR_NO_INPUT,
													         IF( input_contains_personal_data(),
															         100,
															         get_penalty_for_no_contact() 
														          )
												          );
			
				SELF.contacts := CHOOSEN(r.contact,50);
				SELF          := l;
			END;
		
			corp_base_with_contacts := join(corp_recs.base, contacts_search,
																			left.corp_key = right.corp_key,
																			join_contacts_search(left,right),
																			left outer, keep(1000));																			 
		
		// 3. Now join the corp_hist section...:
		//
		// Note: the penalty assigned to the entire record will derive from corp_hist records 
		// and not the contact records. And, use a modulus as above to strip off any values of 1000
		// added when I penalized for no data in Corp2_services.corp2_search_recs. Left values already 
		// have had the modulus applied above.
		layout_corp2_search_with_Penalties join_history_search(corp_base_with_contacts l, corp_recs.hist r) := 
			transform
			self.penalt_1         := l.penalt_1
								             + r.penalt_1
								             + MIN(l.penalt_phone_1, r.penalt_phone_1 % PENALTY_VALUE_FOR_NO_INPUT) 
								             + MIN(l.penalt_company_1, r.penalt_company_1 % PENALTY_VALUE_FOR_NO_INPUT)
								             + MIN(l.penalt_addr_1, r.penalt_addr_1 % PENALTY_VALUE_FOR_NO_INPUT);
			self.penalt_2         := l.penalt_2
								             + r.penalt_2
								             + MIN(l.penalt_phone_2, r.penalt_phone_2 % PENALTY_VALUE_FOR_NO_INPUT) 
								             + MIN(l.penalt_company_2, r.penalt_company_2 % PENALTY_VALUE_FOR_NO_INPUT)
								             + MIN(l.penalt_addr_2, r.penalt_addr_2 % PENALTY_VALUE_FOR_NO_INPUT);
			self.contact_penalt_1 := l.penalt_1; 
			self.contact_penalt_2 := l.penalt_2; 
			self.corp_hist        := CHOOSEN(r.corp_hist,50);
			self                  := l;
		end;			
		
		corp_base_search_ch := JOIN(corp_base_with_contacts, corp_recs.hist,
																left.corp_key = right.corp_key,
																join_history_search(left,right),
																left outer, keep(1000));			
    // 4.  Return.            
    RETURN corp_base_search_ch;

	end; 

end;
