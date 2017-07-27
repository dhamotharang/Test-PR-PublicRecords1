
IMPORT Experian_Phones, Experian_Phones_Services, progressive_phone;

EXPORT fn_prep_Experian_records_for_gateway( 
					DATASET(Experian_Phones_Services.layouts.batch_in_plus) ds_batch_in_common,
					DATASET(Layouts.acctno_plus_Experian_Phones) ds_inhouse_Experian_recs ) := 
	FUNCTION
	
		// 1. Normalize input phone numbers into discrete records.
		rec_acctno_phone := RECORD
			STRING20  acctno      := '';
			UNSIGNED6 did         :=  0;
			STRING10  phone       := '';
			STRING3   phone_last3 := '';
		END;
		
		rec_acctno_phone xfm_normalize_phones(Experian_Phones_Services.layouts.batch_in_plus le, INTEGER c) :=
			TRANSFORM
				SELF.acctno := le.acctno;
				SELF.did    := le.did;
				SELF.phone  := 
						CASE( c,
							 1 => le.phone1 ,  2 => le.phone2 ,  3 => le.phone3 ,  4 => le.phone4 ,  5 => le.phone5 ,
							 6 => le.phone6 ,  7 => le.phone7 ,  8 => le.phone8 ,  9 => le.phone9 , 10 => le.phone10,
							11 => le.phone11, 12 => le.phone12, 13 => le.phone13, 14 => le.phone14, 15 => le.phone15,
							16 => le.phone16, 17 => le.phone17, 18 => le.phone18, 19 => le.phone19, 20 => le.phone20,
							21 => le.phone21, 22 => le.phone22, 23 => le.phone23, 24 => le.phone24, 25 => le.phone25,
							/* default: */ ''
						);
				  length_phone := LENGTH(TRIM(SELF.phone));
				SELF.phone_last3 := SELF.phone[length_phone-2..length_phone];
			END;
			
		ds_input_phone_numbers_normalized :=
			NORMALIZE( ds_batch_in_common, 25, xfm_normalize_phones(LEFT,COUNTER) );
		
		// 2. Remove any inhouse Experian records that exist already in the input.
		ds_inhouse_Experian_recs_filt := 
			JOIN(
				ds_inhouse_Experian_recs, ds_input_phone_numbers_normalized, 
				LEFT.acctno = RIGHT.acctno AND
				LEFT.did = RIGHT.did AND
				LEFT.phone_digits = RIGHT.phone_last3,
				TRANSFORM(LEFT /* i.e. Layouts.acctno_plus_Experian_Phones */),
				LEFT ONLY
			);
			
		// 3. Get the highest scoring record...
		ds_inhouse_Experian_recs_grouped := 
			GROUP(
				SORT(
					ds_inhouse_Experian_recs_filt,
					acctno, did, -score, -(UNSIGNED1)(rec_type[1] = Constants.MAIN_SUBJECT)
				),
				acctno, did
			);
		
		ds_inhouse_Experian_recs_highest_score :=
			TOPN( ds_inhouse_Experian_recs_grouped, 1, acctno, did );
		
		// 4. ...and transform it into the record layout needed for the gateway; return.
					
			// (following code is from: progressive_phone.phones_score_model_v1, lines 876-920)
		progressive_phone.layout_experian_phones 
				xfm_for_Gateway(Experian_Phones_Services.layouts.batch_in_plus le, Layouts.acctno_plus_Experian_Phones ri) := 
					TRANSFORM
						SELF.seq                   := '0';
						
						// Blank unknown info since we are getting this information from the gateway
						SELF.match_name            := FALSE;
						SELF.match_street_address  := FALSE;
						SELF.match_city            := FALSE;
						SELF.match_state           := FALSE;
						SELF.match_zip             := FALSE;
						SELF.match_ssn             := FALSE;
						SELF.match_did             := TRUE;
						SELF.matches               := TRUE;
						
						// Batch_in information
						SELF.acctno                := le.acctno;		
						SELF.matchcodes            := '';
						SELF.error_code            :=  0;
						SELF.subj_first            := le.name_first;
						SELF.subj_middle           := le.name_middle;
						SELF.subj_last             := le.name_last;
						SELF.subj_suffix           := le.name_suffix;
						SELF.subj_phone10          := '';   // Get this from the gateway
						SELF.subj_name_dual        := Functions.fn_format_name(le);
						SELF.subj_phone_type       := '';   // Leave blank.
						SELF.subj_date_first       := '';   // Get this from the gateway
						SELF.subj_date_last        := '';   // Get this from the gateway
						SELF.phpl_phones_plus_type := '';
						SELF.phpl_phone_carrier    := '';
						SELF.phpl_carrier_city     := '';
						SELF.phpl_carrier_state    := '';
						SELF.switch_type           := '';   // Get this from the gateway
						SELF.sort_order            := 0;
						SELF.sort_order_internal   := 0;
						SELF.sub_rule_number       := 0;
						SELF.dup_phone_flag        := 'N';
						SELF.vendor                := '';
							// Since we are only using the input DIDs, subj_phone_relationship should always be the subject phone
						SELF.subj_phone_relationship := 'Subject';	
						SELF.phone_score           := (STRING)ri.score;
						
						// From customer input:
						SELF.did                   := le.did;
						SELF.prim_range            := le.prim_range;
						SELF.predir                := le.predir;
						SELF.prim_name             := le.prim_name;
						SELF.addr_suffix           := le.addr_suffix;
						SELF.postdir               := le.postdir;
						SELF.unit_desig            := le.unit_desig;
						SELF.sec_range             := le.sec_range;
						SELF.p_city_name           := le.p_city_name;
						SELF.v_city_name           := '';
						SELF.st                    := le.st;
						SELF.zip5                  := le.z5;
						SELF.ssn                   := le.ssn;

						// From Experian Phone record ('p_' = 'phone')
						SELF.p_did                 := ri.pin_did;
						SELF.p_name_last           := ri.pin_lname;
						SELF.p_name_first          := ri.pin_fname;
						SELF.ExperianPin           := ri.encrypted_experian_pin;
						SELF.Phone_Last3Digits     := ri.phone_digits;

						// Other fields
						SELF.vanitycities          := '';
						SELF.subj_phone_date_last  := '';
						SELF                       := [];
					END;

		ds_inhouse_Experian_recs_for_Gateway := 
			JOIN(
				ds_batch_in_common, ds_inhouse_Experian_recs_highest_score,
				LEFT.acctno = RIGHT.acctno AND
				LEFT.did = RIGHT.did,
				xfm_for_Gateway(LEFT,RIGHT),
				INNER,
				KEEP(1)
			);

		// DEBUGs:
		// OUTPUT( ds_batch_in_common, NAMED('ds_batch_in_common') );
		// OUTPUT( ds_inhouse_Experian_recs, NAMED('ds_inhouse_Experian_recs') );
		// OUTPUT( ds_input_phone_numbers_normalized, NAMED('ds_input_phone_numbers_normalized') );
		// OUTPUT( ds_inhouse_Experian_recs_filt, NAMED('ds_inhouse_Experian_recs_filt') );
		// OUTPUT( ds_inhouse_Experian_recs_grouped, NAMED('ds_inhouse_Experian_recs_grouped') );
		// OUTPUT( ds_inhouse_Experian_recs_highest_score, NAMED('ds_inhouse_Experian_recs_highest_score') );
				
		RETURN ds_inhouse_Experian_recs_for_Gateway;
	END;