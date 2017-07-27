
IMPORT AddrBest, Address, Autokey_batch, BatchServices, DidVille, Govt_Collections_Services, 
			 LN_PropertyV2_Services, PhilipMorris, progressive_phone, Risk_Indicators,STD;

EXPORT Transforms := MODULE

	EXPORT Govt_Collections_Services.Layouts.batch_in xfm_clean_address(Govt_Collections_Services.Layouts.batch_in l) := 
			TRANSFORM
				
				addr_line_1  := l.addr;
				addr_line_2  := Address.Addr2FromComponents(l.p_city_name, l.st, l.z5);
				cleaned      := address.GetCleanAddress(addr_line_1, addr_line_2, address.Components.country.US).results;
				is_cleanable := cleaned.error_msg[1] != 'E';
				
				self.prim_range 	:= if (is_cleanable, cleaned.prim_range, '');
				self.prim_name 		:= if (is_cleanable, cleaned.prim_name, '');
				self.sec_range 		:= if (is_cleanable, cleaned.sec_range, '');
				self.addr_suffix 	:= if (is_cleanable, cleaned.suffix, '');
				self.predir 			:= if (is_cleanable, cleaned.predir, '');
				self.postdir 			:= if (is_cleanable, cleaned.postdir, '');
				self.unit_desig 	:= if (is_cleanable, cleaned.unit_desig, '');
				self.p_city_name 	:= if (is_cleanable, cleaned.p_city, '');
				self.z5						:= if (is_cleanable, cleaned.zip, '');
				self.st						:= if (is_cleanable, cleaned.state, '');
				self.err_addr     := if (addr_line_1 != '', cleaned.error_msg, ''); // no input address is Ok if full name+ssn is provided per req.4.1.2
				self							:= l;
			END;
			
	EXPORT Govt_Collections_Services.Layouts.batch_in xfm_in_marked(Govt_Collections_Services.Layouts.batch_in le) := 
	  TRANSFORM
				    has_full_name := le.name_last != '' AND le.name_first != '';
						has_full_address := le.addr != '' AND 
							((le.p_city_name != '' AND le.st != '') OR le.z5 != '');
						has_SSN := LENGTH(TRIM(le.ssn))=9 OR LENGTH(TRIM(le.ssn))=4;  
						has_suff_input := has_full_name AND (has_full_address OR has_SSN);
					SELF.record_err_msg  := IF( NOT has_suff_input, 'INSUFF. DATA TO PROCESS',	'' );
					SELF.is_rejected_rec := NOT has_suff_input;
					SELF := le;
		END;
		
	EXPORT AddrBest.Layout_BestAddr.Batch_in xfm_to_BestAddr_batchIn(Govt_Collections_Services.Layouts.batch_working le) :=
		TRANSFORM
			SELF.did := (INTEGER)le.lex_id;
			SELF := le,
			SELF := []
		END;
	
	EXPORT PhilipMorris.Layouts.InRecord.Dirty.SSN4FullRecord 
			xfm_to_ExpSSN_batchIn(Govt_Collections_Services.Layouts.batch_working le) :=
				TRANSFORM
					SELF.acctno                      := le.acctno,
					SELF.NameFirst                   := le.name_first,
					SELF.NameMiddle                  := le.name_middle,
					SELF.NameLast                    := le.name_last,
					SELF.SSN                         := le.ssn,
					SELF.DOB_YYYYMMDD                := le.dob,
					SELF.CurrentAddress.AddressLine1 := Govt_Collections_Services.Functions.fn_format_AddressLine1(le);
					SELF.CurrentAddress.AddressLine2 := Govt_Collections_Services.Functions.fn_format_AddressLine2(le);
					SELF.CurrentAddress.City         := le.best_p_city_name;
					SELF.CurrentAddress.State        := le.best_st;
					SELF.CurrentAddress.ZipCode      := le.best_z5;
					SELF := []
				END;

	EXPORT DidVille.Layout_Did_OutBatch xfm_to_BestADL_batchIn(Govt_Collections_Services.Layouts.batch_working_plus_seq le ) :=
			TRANSFORM
				SELF.ssn         := le.ssn;
				SELF.dob         := le.dob;
				SELF.phone10     := '';
				SELF.title       := '';
				SELF.fname       := le.name_first;
				SELF.mname       := le.name_middle;
				SELF.lname       := le.name_last;
				SELF.prim_range  := le.best_prim_range;
				SELF.predir      := le.best_predir;
				SELF.prim_name   := le.best_prim_name;
				SELF.addr_suffix := le.best_addr_suffix;
				SELF.postdir     := le.best_postdir;
				SELF.unit_desig  := le.best_unit_desig;
				SELF.sec_range   := le.best_sec_range;
				SELF.p_city_name := le.best_p_city_name;
				SELF.st          := le.best_st;
				SELF.z5          := le.best_z5;
				SELF.zip4        := le.best_zip4;
				SELF             := le;
				SELF             := [];
			END;
	
	/* NOTE: In the transform below we are blanking out the address data, since there is 
	a scenario that would cause this search not to return a valid record. According to the 
	requirements, we take the cleaned name, address and SSN and send them to the DriversV2 
	Batch service. The batch service looks for a  driver's record using Autokeys only. 
	
	If a batch input record contains an address where the search subject moved to recently, and 
	she hasn't updated her address info at the local DMV yet (and so her driver's license has 
	her previous address), then the DL record that the batch service retrieves will exceed the 
	penalty threshold and won't be returned. But, if we send in just the subject's name and SSN, 
	the record will return since the address won't be penalized. 
	*/
	EXPORT Autokey_batch.Layouts.rec_inBatchMaster xfm_to_DriversV2_batchIn(Govt_Collections_Services.Layouts.batch_working le) :=
		TRANSFORM
			SELF.acctno := le.acctno,
			SELF.ssn := 
				MAP( 
					le.ssn != '' AND LENGTH(TRIM(le.ssn)) = 9 => le.ssn, 
					le.expanded_ssn != ''                     => le.expanded_ssn,
					le.best_ssn != ''                         => le.best_ssn,
					/* default .............................*/   ''
				),
			SELF.name_last   := le.name_last,
			SELF.name_first  := le.name_first,
			SELF.name_middle := le.name_middle,
			SELF := []
		END;
	
	/* In the following transform, the MAP statement is ordered in such a way as to fulfill 
	   the following requirement:
				"All components of the cleaned input address, cleaned input name, and input SSN
				or expanded SSN from step 4 (if only last 4 digits of SSN provided on input) or 
				Best SSN from step 5 (if there was no input SSN) will be processed through 
		    [service name]..."
		 
		 This requirement is listed in 4.1.12, 4.1.13, and 4.1.15.  
	*/		
	EXPORT Autokey_batch.Layouts.rec_inBatchMaster xfm_to_batchIn(Govt_Collections_Services.Layouts.batch_working le) :=
		TRANSFORM
			SELF.acctno := le.acctno,
			SELF.ssn := 
				MAP( 
					le.ssn != '' AND LENGTH(TRIM(le.ssn)) = 9 => le.ssn, 
					le.expanded_ssn != ''                     => le.expanded_ssn,
					le.best_ssn != ''                         => le.best_ssn,
					/* default .............................*/   ''
				),
			SELF := le, // i.e. we want to provide the input name and cleaned address data, not "Best".
			SELF := []
		END;
		
	EXPORT Risk_Indicators.Layout_output xfm_to_inputSSN_BatchIn(Layouts.batch_working le) :=
		TRANSFORM
			SELF.seq    := (UNSIGNED4) le.acctno;
			//SELF.did    := le.LexID;
			SELF.ssn    := IF( LENGTH(TRIM(le.ssn)) = 9, le.ssn, le.expanded_ssn);
			SELF        := [];
		END;
		
	EXPORT progressive_phone.layout_progressive_batch_in xfm_to_phones_batchIn(Govt_Collections_Services.Layouts.batch_working le) :=
		TRANSFORM
					SELF.acctno      := le.acctno,
					SELF.did				 := (INTEGER)le.lex_id;
					SELF.ssn         := '',
					SELF.suffix      := le.addr_suffix,
					SELF             := le,
					SELF             := []
		END;
		
	EXPORT LN_PropertyV2_Services.layouts.batch_in_plus_date_filter xfm_to_Property_batchIn(
																			Govt_Collections_Services.Layouts.batch_working le) := TRANSFORM
		SELF.acctno 			:= le.acctno;
		SELF.did 					:= (INTEGER)le.lex_id;	
		SELF := [];
	
	END;
	
	EXPORT Govt_Collections_Services.Layouts.PropertySubject xform_PropertySubjects(BatchServices.layout_Property_Batch_out le, 
																													DATASET(Govt_Collections_Services.Layouts.batch_working) ds_batch_in) := 
		TRANSFORM
			batch_in_rec := ds_batch_in(acctno = le.acctno);
			subject_did := batch_in_rec[1].lex_id;		
		
			PropertySubject_Type := MAP(le.buyer_1_did = subject_did => Govt_Collections_Services.Constants.PropertySubject_Types.Buyer_1, 
																	le.borrower_1_did = subject_did => Govt_Collections_Services.Constants.PropertySubject_Types.Borrower_1,
																	le.seller_1_did = subject_did => Govt_Collections_Services.Constants.PropertySubject_Types.Seller_1,
																	le.owner_1_did = subject_did => Govt_Collections_Services.Constants.PropertySubject_Types.Owner_1,
																	le.assessee_1_did = subject_did => Govt_Collections_Services.Constants.PropertySubject_Types.Assessee_1,
																	le.buyer_2_did = subject_did => Govt_Collections_Services.Constants.PropertySubject_Types.Buyer_2, 
																	le.borrower_2_did = subject_did => Govt_Collections_Services.Constants.PropertySubject_Types.Borrower_2,
																	le.seller_2_did = subject_did => Govt_Collections_Services.Constants.PropertySubject_Types.Seller_2,
																	le.owner_2_did = subject_did => Govt_Collections_Services.Constants.PropertySubject_Types.Owner_2,
																	le.assessee_2_did = subject_did => Govt_Collections_Services.Constants.PropertySubject_Types.Assessee_2,
																	'');
															
			SELF.acctno := le.acctno;
																						
			PropertySubject_did := CASE(PropertySubject_Type,
																		Govt_Collections_Services.Constants.PropertySubject_Types.Borrower_1 => 
																			le.borrower_2_did,
																		Govt_Collections_Services.Constants.PropertySubject_Types.Buyer_1 => 
																			le.buyer_2_did,
																		 Govt_Collections_Services.Constants.PropertySubject_Types.Seller_1 => 
																				le.seller_2_did,
																		 Govt_Collections_Services.Constants.PropertySubject_Types.Owner_1 => 
																				le.owner_2_did,
																		 Govt_Collections_Services.Constants.PropertySubject_Types.Assessee_1 => 
																				le.assessee_2_did,
																		 Govt_Collections_Services.Constants.PropertySubject_Types.Borrower_2 => 
																				le.borrower_1_did,
																		 Govt_Collections_Services.Constants.PropertySubject_Types.Buyer_2 => 
																				le.buyer_1_did,
																		 Govt_Collections_Services.Constants.PropertySubject_Types.Seller_2 => 
																				le.seller_1_did,
																		 Govt_Collections_Services.Constants.PropertySubject_Types.Owner_2 => 
																				le.owner_1_did,
																		Govt_Collections_Services.Constants.PropertySubject_Types.Assessee_2 => 
																				le.assessee_1_did,
																		'');
												
			SELF.PropertySubject_did := IF(PropertySubject_did = '', SKIP, PropertySubject_did);
			
			SELF.PropertySubject_fname := CASE(PropertySubject_Type,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Borrower_1 => 
																							le.borrower_2_first_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Buyer_1 => 
																							le.buyer_2_first_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Seller_1 => 
																							le.seller_2_first_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Owner_1 => 
																							le.owner_2_first_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Assessee_1 => 
																							le.assessee_2_first_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Borrower_2 => 
																							le.borrower_1_first_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Buyer_2 => 
																							le.buyer_1_first_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Seller_2 => 
																							le.seller_1_first_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Owner_2 => 
																							le.owner_1_first_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Assessee_2 => 
																							le.assessee_1_first_name,
																						'');
																		
			SELF.PropertySubject_lname := CASE(PropertySubject_Type,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Borrower_1 => 
																							le.borrower_2_last_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Buyer_1 => 
																							le.buyer_2_last_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Seller_1 => 
																							le.seller_2_last_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Owner_1 => 
																							le.owner_2_last_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Assessee_1 => 
																							le.assessee_2_last_name,
																						 Govt_Collections_Services.Constants.PropertySubject_Types.Borrower_2 => 
																							le.borrower_1_last_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Buyer_2 => 
																							le.buyer_1_last_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Seller_2 => 
																							le.seller_1_last_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Owner_2 => 
																							le.owner_1_last_name,
																						Govt_Collections_Services.Constants.PropertySubject_Types.Assessee_2 => 
																							le.assessee_1_last_name,
																					 '');
																	 
			SELF.PropertySubject_ssn := CASE(PropertySubject_Type,
																					Govt_Collections_Services.Constants.PropertySubject_Types.Borrower_1 => 
																						le.borrower_2_ssn,
																					Govt_Collections_Services.Constants.PropertySubject_Types.Buyer_1 => 
																						le.buyer_2_ssn,
																					Govt_Collections_Services.Constants.PropertySubject_Types.Seller_1 => 
																						le.seller_2_ssn,
																					Govt_Collections_Services.Constants.PropertySubject_Types.Owner_1 => 
																						le.owner_2_ssn,
																					Govt_Collections_Services.Constants.PropertySubject_Types.Assessee_1 => 
																						le.assessee_2_ssn,
																					Govt_Collections_Services.Constants.PropertySubject_Types.Borrower_2 => 
																						le.borrower_1_ssn,
																					Govt_Collections_Services.Constants.PropertySubject_Types.Buyer_2 => 
																						le.buyer_1_ssn,
																					Govt_Collections_Services.Constants.PropertySubject_Types.Seller_2 => 
																						le.seller_1_ssn,
																					Govt_Collections_Services.Constants.PropertySubject_Types.Owner_2 => 
																						le.owner_1_ssn,
																					Govt_Collections_Services.Constants.PropertySubject_Types.Assessee_2 => 
																						le.assessee_1_ssn,
																					'');
			
		END;	
		
		EXPORT Govt_Collections_Services.Layouts.batch_working
				xfm_property_subjects_denorm(Govt_Collections_Services.Layouts.batch_working le, 
				           DATASET(Govt_Collections_Services.Layouts.batch_working) allRows) :=
					TRANSFORM
					  SELF.Property_debtor_2_best_fname := allRows[1].best_fname;
						SELF.Property_debtor_2_best_lname := allRows[1].best_lname;
						SELF.Property_debtor_2_best_addr1 := allRows[1].best_addr1;
						SELF.Property_debtor_2_best_city := allRows[1].best_city;
						SELF.Property_debtor_2_best_state := allRows[1].best_state;
						SELF.Property_debtor_2_best_zip := allRows[1].best_zip;
						SELF.Property_Debtor_2_phone_number_1 := allRows[1].phone_number_1,
						SELF.Property_Debtor_2_phone_number_2 := allRows[1].phone_number_2,
						SELF.Property_Debtor_2_phone_number_3 := allRows[1].phone_number_3;
						
						SELF.Property_debtor_3_best_fname := allRows[2].best_fname;
						SELF.Property_debtor_3_best_lname := allRows[2].best_lname;
						SELF.Property_debtor_3_best_addr1 := allRows[2].best_addr1;
						SELF.Property_debtor_3_best_city := allRows[2].best_city;
						SELF.Property_debtor_3_best_state := allRows[2].best_state;
						SELF.Property_debtor_3_best_zip := allRows[2].best_zip;
						SELF.Property_Debtor_3_phone_number_1	:= allRows[2].phone_number_1;
						SELF.Property_Debtor_3_phone_number_2 := allRows[2].phone_number_2;
						SELF.Property_Debtor_3_phone_number_3 := allRows[2].phone_number_3;
						
						SELF.Property_debtor_4_best_fname := allRows[3].best_fname;
						SELF.Property_debtor_4_best_lname := allRows[3].best_lname;
						SELF.Property_debtor_4_best_addr1 := allRows[3].best_addr1;
						SELF.Property_debtor_4_best_city := allRows[3].best_city;
						SELF.Property_debtor_4_best_state := allRows[3].best_state;
						SELF.Property_debtor_4_best_zip := allRows[3].best_zip;
						SELF.Property_Debtor_4_phone_number_1 := allRows[3].phone_number_1;
						SELF.Property_Debtor_4_phone_number_2 := allRows[3].phone_number_2;
						SELF.Property_Debtor_4_phone_number_3 := allRows[3].phone_number_3;
						SELF := le			
				END;	
	
END;