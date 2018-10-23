
IMPORT BatchServices, LN_PropertyV2_Services, FFD;

EXPORT layout_Accurint_Property_batch_out_pre xfm_Accurint_Property_make_flat(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes l, 
																																							BOOLEAN return_formatted_values, 
																																							integer c = 0) := 
	TRANSFORM
	
		LCase           := StringLib.StringToLowerCase;
		Currency        := BatchServices.Functions.convert_to_currency;
		DISPLAY_NOTHING := '';	

		property        := l.parties( LCase(party_type_name) = 'property' )[1];
		first_owner     := l.parties( LCase(party_type_name) IN ['buyer','assessee'] )[1].entity[1];
		second_owner    := l.parties( LCase(party_type_name) IN ['buyer','assessee'] )[1].entity[2];
		first_borrower  := l.parties( LCase(party_type_name) = 'borrower' )[1].entity[1];
		second_borrower := l.parties( LCase(party_type_name) = 'borrower' )[1].entity[2];
		seller          := l.parties( LCase(party_type_name) = 'seller' )[1].entity[1];		
		deed            := l.deeds[1];
		assessment      := l.assessments[1];
		
		SELF.acctno             := l.acctno;
		SELF.SequenceNumber     := c;
		SELF.error_code         := l.error_code;
		SELF.matchcodes         := l.matchcodes;
		
//	***** POTENTIALLY USEFUL DATA *****
		
		SELF.record_type        := CASE(l.ln_fares_id[2],
																			'A' => 'ASSESSMENT',
																			'D' => 'DEED',
																			'M' => 'MORTGAGE',
																			'');
		SELF.sortby_date        := l.sortby_date;
		SELF.current_record     := l.current_record;

//	***** REQUIRED OUTPUT *****

		SELF.parcel_number      := IF( TRIM(deed.apnt_or_pin_number) != '',
		                               deed.apnt_or_pin_number, 
		                               assessment.apna_or_pin_number
		                              );
		SELF.fares_source_id    := l.vendor_source_flag;
		SELF.source_code        := l.vendor_source_desc;
		SELF.unique_id          := l.ln_fares_id;
		
		
		name_owner_1       := MAP(
																TRIM(first_owner.lname) != ''    => 1,
																TRIM(first_owner.cname) != ''    => 2,
																TRIM(first_borrower.lname) != '' => 3,
																TRIM(first_borrower.cname) != '' => 4,
																5
															 );		
		SELF.name_owner_1       := MAP(
																name_owner_1 = 1 => TRIM(first_owner.lname)  + ', ' + TRIM(first_owner.fname) + ' '  + TRIM(first_owner.mname),
																name_owner_1 = 2 => TRIM(first_owner.cname),
																name_owner_1 = 3 => TRIM(first_borrower.lname)  + ', ' + TRIM(first_borrower.fname) + ' '  + TRIM(first_borrower.mname),
																name_owner_1 = 4 => TRIM(first_borrower.cname),
																DISPLAY_NOTHING
															 );
		// populate LexId only if corresponding name is populated
		SELF.owner_1_did       := MAP(
																name_owner_1 IN [1, 2] => TRIM(first_owner.did),
																name_owner_1 IN [3, 4] => TRIM(first_borrower.did),
																DISPLAY_NOTHING
															 );
		

		
		name_owner_2       := MAP(
																TRIM(second_owner.lname) != ''    => 1,
																TRIM(second_owner.cname) != ''    => 2,
																TRIM(second_borrower.lname) != '' => 3,
																TRIM(second_borrower.cname) != '' => 4,
																5
															 );		
		SELF.name_owner_2       := MAP(
																name_owner_2 = 1 => TRIM(second_owner.lname) + ', ' + TRIM(second_owner.fname) + ' ' + TRIM(second_owner.mname),
																name_owner_2 = 2 => TRIM(second_owner.cname),
																name_owner_2 = 3 => TRIM(second_borrower.lname) + ', ' + TRIM(second_borrower.fname) + ' ' + TRIM(second_borrower.mname),
																name_owner_2 = 4 => TRIM(second_borrower.cname),
																DISPLAY_NOTHING
															 );

		// populate LexId only if corresponding name is populated
		SELF.owner_2_did       := MAP(
																name_owner_2 IN [1, 2] => TRIM(second_owner.did),
																name_owner_2 IN [3, 4] => TRIM(second_borrower.did),
																DISPLAY_NOTHING
															 );
		
		SELF.prop_prim_range    := property.prim_range;
		SELF.prop_predir        := property.predir;
		SELF.prop_prim_name     := property.prim_name;
		SELF.prop_suffix        := property.suffix;
		SELF.prop_postdir       := property.postdir;
		SELF.prop_unit_desig    := property.unit_desig;
		SELF.prop_sec_range     := property.sec_range;
		SELF.prop_p_city_name   := property.p_city_name;
		SELF.prop_st            := property.st;
		SELF.prop_zip           := property.zip;
		SELF.prop_zip4          := property.zip4;
		SELF.fips               := assessment.fips_code;
		
		SELF.total_value        := IF( NOT return_formatted_values, assessment.fares_calculated_total_value, Currency( assessment.fares_calculated_total_value ) );
		
		SELF.sale_date          := assessment.sale_date;
		SELF.sale_price         := IF( TRIM(deed.sales_price) != '',
		                               IF( NOT return_formatted_values, deed.sales_price, Currency(deed.sales_price) ),
		                               IF( NOT return_formatted_values, assessment.sales_price, Currency(assessment.sales_price) )
		                              );
		
		SELF.name_seller        := IF( TRIM(seller.lname) != '',
		                               TRIM(seller.lname) + ', ' + TRIM(seller.fname) + ' ' + TRIM(seller.mname),
																	 DISPLAY_NOTHING
																	);
		
		// populate LexId only if corresponding name is populated
		SELF.seller_did        := IF( TRIM(seller.lname) != '', TRIM(seller.did),
																	 DISPLAY_NOTHING
																	);
		
		SELF.mortgage_amount    := IF( assessment.mortgage_loan_amount != '',
		                               IF( NOT return_formatted_values, assessment.mortgage_loan_amount, Currency( assessment.mortgage_loan_amount ) ),
																	 IF( NOT return_formatted_values, deed.first_td_loan_amount, Currency( deed.first_td_loan_amount ) )
																	);
																	
		SELF.assessed_value     := IF( NOT return_formatted_values, assessment.assessed_total_value, Currency( assessment.assessed_total_value ) );
		SELF.total_market_value := IF( NOT return_formatted_values, assessment.market_total_value, Currency( assessment.market_total_value ) );
		SELF.recording_date     := assessment.recording_date;
		SELF.legal_description  := IF( deed.legal_brief_description != '',
		                               deed.legal_brief_description,
		                               assessment.legal_brief_description
		                              );		
		assessStatements 		:= 	project(l.assessments[1].statementids,FFD.InitializeConsumerStatementBatch(
														left,FFD.Constants.RecordType.RS,' ',FFD.Constants.DataGroups.ASSESSMENT,c ,l.acctno ));

		assessDisputes 			:= 	if(l.assessments[1].isDisputed,row(FFD.InitializeConsumerStatementBatch(
														FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR,' ',FFD.Constants.DataGroups.ASSESSMENT,c ,l.acctno )));		
												
		DeedStatements 			:= 	project(l.deeds[1].statementids,FFD.InitializeConsumerStatementBatch(
														left,FFD.Constants.RecordType.RS ,' ',FFD.Constants.DataGroups.DEED,c,l.acctno ));

		DeedDisputes    		:= 	if(l.deeds[1].isDisputed , row(FFD.InitializeConsumerStatementBatch(
														FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR,' ',FFD.Constants.DataGroups.DEED,c ,l.acctno)));
													
		owner_1_Statements_o := project(first_owner.statementids , FFD.InitializeConsumerStatementBatch(
														left,FFD.Constants.RecordType.RS,'owner_1',FFD.Constants.DataGroups.PROPERTY_SEARCH,c,l.acctno));

		owner_1_Disputes_o 	:= 	if(first_owner.isDisputed,row(FFD.InitializeConsumerStatementBatch(
														FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR,'owner_1',FFD.Constants.DataGroups.PROPERTY_SEARCH,c,l.acctno)));

		owner_1_Statements_b := project(first_borrower.statementids ,FFD.InitializeConsumerStatementBatch(
														left,FFD.Constants.RecordType.RS,'owner_1',FFD.Constants.DataGroups.PROPERTY_SEARCH,c,l.acctno));

		owner_1_Disputes_b := if(first_borrower.isDisputed,row(FFD.InitializeConsumerStatementBatch(
													FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR ,'owner_1',FFD.Constants.DataGroups.PROPERTY_SEARCH,c,l.acctno)));


		owner_2_Statements_o := project(second_owner.statementids , FFD.InitializeConsumerStatementBatch(
														left,FFD.Constants.RecordType.RS ,'owner_2',FFD.Constants.DataGroups.PROPERTY_SEARCH,c ,l.acctno));

		owner_2_Disputes_o := if(second_owner.isDisputed,row(FFD.InitializeConsumerStatementBatch(
													FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR ,'owner_2',FFD.Constants.DataGroups.PROPERTY_SEARCH,c ,l.acctno)));

		owner_2_Statements_b := project(second_borrower.statementids ,FFD.InitializeConsumerStatementBatch(
													left,FFD.Constants.RecordType.RS ,'owner_2',FFD.Constants.DataGroups.PROPERTY_SEARCH,c ,l.acctno));

		owner_2_Disputes_b := if(second_borrower.isDisputed,row(FFD.InitializeConsumerStatementBatch(
												FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR ,'owner_2',FFD.Constants.DataGroups.PROPERTY_SEARCH,c,l.acctno)));
											
		seller_Statements := project(seller.statementids, FFD.InitializeConsumerStatementBatch(
											left,FFD.Constants.RecordType.RS,'seller',FFD.Constants.DataGroups.PROPERTY_SEARCH,c ,l.acctno));

		seller_Disputes := if(seller.isDisputed,row(FFD.InitializeConsumerStatementBatch(
										FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR ,'seller',FFD.Constants.DataGroups.PROPERTY_SEARCH,c ,l.acctno )));

		
		
		owner1 := map(
					name_owner_1 in [1,2 ] => owner_1_Disputes_o + owner_1_Statements_o,
					name_owner_1 in [3,4 ] => owner_1_Disputes_b + owner_1_Statements_b,
					dataset([],FFD.Layouts.ConsumerStatementBatch));	



		owner2 := map(
					name_owner_2 in [1,2 ] => owner_2_Disputes_o + owner_2_Statements_o,
					name_owner_2 in [3,4 ] => owner_2_Disputes_b + owner_2_Statements_b,
					dataset([],FFD.Layouts.ConsumerStatementBatch)
				);

		StatementsAndDisputes := assessDisputes + 
														 DeedDisputes + 
														 seller_Disputes + 
														 assessStatements + DeedStatements + seller_Statements +
														 owner1 +
														 owner2;
														 
		SELF.StatementsAndDisputes := StatementsAndDisputes;
		SELF := l;
		
	END;
	
	/* Available "value" fields:
			assessments[1].fares_calculated_land_value 
			assessments[1].fares_calculated_improvement_value
			assessments[1].fares_calculated_total_value
			assessments[1].assessed_total_value 
			assessments[1].assessed_improvement_value 
			assessments[1].market_land_value
			assessments[1].market_improvement_value 
			assessments[1].market_total_value 
			assessments[1].market_value_year;
			assessments[1].assessed_land_value		
	*/