
IMPORT AutoStandardI, BatchDatasets, Doxie, Progressive_Phone, Std, ut;

EXPORT fn_getPhonesRecs(DATASET(Layouts.batch_out) ds_batch_out_so_far, IParams.BatchParams in_mod) := 
	FUNCTION

		// 1. Now load the property data from ds_batch_out_so_far into the input for Phones. NOTE that
		// per the requirements we're looking for the phone number for owner_1 only.
		BatchDatasets.Layouts.batch_in xfm_norm_property_data(Layouts.batch_out le, INTEGER c) :=
			TRANSFORM
				SELF.acctno := TRIM(le.acctno) + '_' + (STRING)c;
				SELF.did    := le.did1;
				SELF.name_first := 
					CHOOSE(c, le.owner_1_first_name_1, le.owner_1_first_name_2, le.owner_1_first_name_3, le.owner_1_first_name_4, le.owner_1_first_name_5, le.owner_1_first_name_6, le.owner_1_first_name_7, le.owner_1_first_name_8, le.owner_1_first_name_9, le.owner_1_first_name_10 );
				SELF.name_middle := 
					CHOOSE(c, le.owner_1_middle_name_1, le.owner_1_middle_name_2, le.owner_1_middle_name_3, le.owner_1_middle_name_4, le.owner_1_middle_name_5, le.owner_1_middle_name_6, le.owner_1_middle_name_7, le.owner_1_middle_name_8, le.owner_1_middle_name_9, le.owner_1_middle_name_10 );
				SELF.name_last := 
					CHOOSE(c, le.owner_1_last_name_1, le.owner_1_last_name_2, le.owner_1_last_name_3, le.owner_1_last_name_4, le.owner_1_last_name_5, le.owner_1_last_name_6, le.owner_1_last_name_7, le.owner_1_last_name_8, le.owner_1_last_name_9, le.owner_1_last_name_10 );
				SELF.addr := 
					CHOOSE(c, 
						TRIM(le.property_address1_1) + ' ' + TRIM(le.property_address2_1), 
						TRIM(le.property_address1_2) + ' ' + TRIM(le.property_address2_2), 
						TRIM(le.property_address1_3) + ' ' + TRIM(le.property_address2_3), 
						TRIM(le.property_address1_4) + ' ' + TRIM(le.property_address2_4), 
						TRIM(le.property_address1_5) + ' ' + TRIM(le.property_address2_5),
						TRIM(le.property_address1_6) + ' ' + TRIM(le.property_address2_6), 
						TRIM(le.property_address1_7) + ' ' + TRIM(le.property_address2_7), 
						TRIM(le.property_address1_8) + ' ' + TRIM(le.property_address2_8), 
						TRIM(le.property_address1_9) + ' ' + TRIM(le.property_address2_9), 
						TRIM(le.property_address1_10) + ' ' + TRIM(le.property_address2_10)
					);
				SELF.p_city_name := 
					CHOOSE(c, le.property_p_city_name_1, le.property_p_city_name_2, le.property_p_city_name_3, le.property_p_city_name_4, le.property_p_city_name_5, le.property_p_city_name_6, le.property_p_city_name_7, le.property_p_city_name_8, le.property_p_city_name_9, le.property_p_city_name_10 );
				SELF.st := 
					CHOOSE(c, le.property_st_1, le.property_st_2, le.property_st_3, le.property_st_4, le.property_st_5, le.property_st_6, le.property_st_7, le.property_st_8, le.property_st_9, le.property_st_10 );
				SELF.z5 := 
					CHOOSE(c, le.property_zip_1, le.property_zip_2, le.property_zip_3, le.property_zip_4, le.property_zip_5, le.property_zip_6, le.property_zip_7, le.property_zip_8, le.property_zip_9, le.property_zip_10 );
				SELF.ssn  := le.owner_1_SSN;	
				SELF      := [];
			END;

		ds_for_Phones := NORMALIZE( ds_batch_out_so_far, 10, xfm_norm_property_data(LEFT,COUNTER) );

		BatchDatasets.Layouts.batch_in xfm_clean_property_data(BatchDatasets.Layouts.batch_in le) :=
			TRANSFORM, SKIP(le.addr = '') // Ref.: Address.GetCleanAddress
					clean_address := Doxie.cleanaddress182(le.addr, le.p_city_name + ' ' + le.st + ' ' + le.z5);
				SELF.prim_range  := clean_address[1..10];
				SELF.predir      := clean_address[11..12];
				SELF.prim_name   := clean_address[13..40];
				SELF.addr_suffix := clean_address[41..44];
				SELF.postdir     := clean_address[45..46];
				SELF.unit_desig  := clean_address[47..56];
				SELF.sec_range   := clean_address[57..64];
				SELF.p_city_name := clean_address[90..114];
				SELF.st          := clean_address[115..116];
				SELF.z5          := clean_address[117..121];
				SELF.zip4        := clean_address[122..125];
				SELF             := le;	
				SELF             := [];
			END;
			
		ds_for_Phones_cleaned := PROJECT( ds_for_Phones, xfm_clean_property_data(LEFT) );

		// 1. Configure Progressive Phone params module. For reference, see ERO_Services.fn_addPhone( ).
		tmpMod :=
			MODULE(PROJECT(AutoStandardI.GlobalModule(),progressive_phone.iParam.Batch,OPT))
				EXPORT BOOLEAN ExcludeDeadContacts := FALSE;
				EXPORT BOOLEAN DedupOutputPhones   := TRUE; 
				EXPORT INTEGER MaxPhoneCount       := 100; 
				EXPORT INTEGER CountES             := 10;
				EXPORT INTEGER CountSE             := 10;
				EXPORT INTEGER CountAP             := 10;
				EXPORT INTEGER CountCR             := 10;
			END;
			
		// 2. Fetch records from the Progressive Phones Batch service.
		Progressive_Phone.layout_progressive_phone_common
				ds_phone_recs_raw := BatchDatasets.fetch_Phone_recs(ds_for_Phones_cleaned, tmpMod);
		
		// 3. Filter out unwanted phones and select the best phone for each address. 
		// NOTE: this needs works as I'm just using TOPN to select one of the phones 
		// from each group.
    
		// use returned MATCH flags to mark which phone records match by name and street address.
		score_rec := record
		  Progressive_Phone.layout_progressive_phone_common;
			boolean isMatch := 0;
		end;
		
		score_rec addScore(ds_phone_recs_raw l) := transform
      self.isMatch := map(l.match_name and l.match_street_address => TRUE, 
													l.match_did and l.match_street_address => TRUE, 
													FALSE);
		  self := l;
		end;
		
		ds_phone_recs_raw_scored := project(ds_phone_recs_raw, addScore(left));
		
		ds_phone_recs_raw_grpd := GROUP( SORT( ds_phone_recs_raw_scored(isMatch), acctno ), acctno );
		
		//remove the score field after selectign the top 1
		ds_phone_recs_raw_best := PROJECT(TOPN( ds_phone_recs_raw_grpd, 1, acctno, -phone_score ), Progressive_Phone.layout_progressive_phone_common);
		
		// 4. Separate the sequence number appended to the acctno as such (e.g. acctno_seq), so
		// we can assign each phone number correctly in the Denormalize below.
		layout_progressive_phone_plus_seq := RECORD
			Progressive_Phone.layout_progressive_phone_common;
			UNSIGNED seq;
		END;
		
		layout_progressive_phone_plus_seq xfm_derive_seqNo(Progressive_Phone.layout_progressive_phone_common le) := 
			TRANSFORM
						set_acctno := ut.StringSplit(le.acctno, '_');
				SELF.acctno := set_acctno[1];
				SELF.seq    := (UNSIGNED)set_acctno[2];
				SELF        := le;
			END;
		
		ds_phone_recs_raw_plus_seq := 
			PROJECT( UNGROUP(ds_phone_recs_raw_best), xfm_derive_seqNo(LEFT) );
		
		// 5. Assign the phone number to its corresponding property address.
		Layouts.batch_out xfm_add_phones(Layouts.batch_out le, DATASET(layout_progressive_phone_plus_seq) phones) :=
			TRANSFORM
				SELF.property_phone_1 := phones(seq = 1)[1].subj_phone10;
				SELF.property_phone_2 := phones(seq = 2)[1].subj_phone10;
				SELF.property_phone_3 := phones(seq = 3)[1].subj_phone10;
				SELF.property_phone_4 := phones(seq = 4)[1].subj_phone10;
				SELF.property_phone_5 := phones(seq = 5)[1].subj_phone10;
				SELF.property_phone_6 := phones(seq = 6)[1].subj_phone10;
				SELF.property_phone_7 := phones(seq = 7)[1].subj_phone10;
				SELF.property_phone_8 := phones(seq = 8)[1].subj_phone10;
				SELF.property_phone_9 := phones(seq = 9)[1].subj_phone10;
				SELF.property_phone_10 := phones(seq = 10)[1].subj_phone10;
				SELF := le;
				SELF := []
			END;

		ds_batch_out_with_phones :=
			DENORMALIZE(
				ds_batch_out_so_far, ds_phone_recs_raw_plus_seq,
				LEFT.acctno = RIGHT.acctno,
				GROUP,
				xfm_add_phones(LEFT,ROWS(RIGHT))
			);
    
		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_for_Phones_cleaned, NAMED('input_for_phones') ) );
		
		IF( in_mod.ViewDebugs, 
			OUTPUT( ds_phone_recs_raw, NAMED('Phone_results') ) );
		
		// OUTPUT( ds_for_Phones_cleaned, NAMED('ds_for_Phones_cleaned') );
		// OUTPUT( ds_phone_recs_raw_scored, NAMED('ds_phone_recs_raw_scored') );
		// OUTPUT( ds_phone_recs_raw, NAMED('ds_phone_recs_raw') );
		// OUTPUT( ds_phone_recs_raw_grpd, NAMED('ds_phone_recs_raw_grpd') );
		// OUTPUT( ds_phone_recs_raw_best, NAMED('ds_phone_recs_raw_best') );
		// OUTPUT( ds_phone_recs_raw_plus_seq, NAMED('ds_phone_recs_raw_plus_seq') );
		
		RETURN ds_batch_out_with_phones;
	END;