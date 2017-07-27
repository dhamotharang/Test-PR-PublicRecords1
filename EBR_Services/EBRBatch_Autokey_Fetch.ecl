
IMPORT Autokey_batch, AutokeyB, AutokeyB2, AutokeyB2_batch, Doxie, EBR, ut;

/*
		This code is a bad, bad hack. The EBR autokeys are named according to 
    an older convention (all of them end in ‘B’ and not ‘B2’), and these 
    names are not supported by the batch autokey fetches. I tried to fix 
    this problem by implementing some changes to the autokey fetches that 
    live in AutokeyI—something I’ve been working on for a year and a half—but 
    my changes did not pass regression testing. So, I created this attribute, 
    which essentially takes the existing batch autokey fetches and references 
    the ‘B’ version of the autokeys. Ugh. But, it works.
*/

EXPORT EBRBatch_Autokey_Fetch() := 
	MODULE

		SHARED boolean workHard         := FALSE;
		SHARED boolean nofail           := TRUE;
		SHARED string  autokey_filename := EBR.constants('').Str_autokeyName;
		
		/* 
		NOTE:  export set of string1 get_skip_set := ['C','F']; ...so there are no calls
    to Person Autokeys, and no call to Fetch_FEIN_batch. 
		*/
		
		/* Autokey fetches below...: 
			   o  Fetch_Address_Batch( )
			   o  Fetch_Name_Batch( )
			   o  Fetch_NameWords_Batch( )
			   o  Fetch_Phone_Batch( )
			   o  Fetch_StCityFLName_Batch( )
			   o  Fetch_StName_Batch( )
			   o  Fetch_Zip_Batch( )
			   o  NOTE: no Fetch_FEIN_Batch( ) owing to skip set.
		*/
		
		SHARED Fetch_Address_Batch(dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in) :=
			FUNCTION

				TOO_MANY_MATCHES := AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES;

				rec_InBatch_expanded := RECORD
					AutokeyB2_batch.Layouts.rec_BDID_InBatch AND NOT zip_value;
					SET OF STRING zip_value;			
					SET OF INTEGER city_codes_set;
				END;
				
				rec_InBatch_expanded xfm_add_derived_data(ds_in l) := 
					TRANSFORM
						SELF.zip_value      := (SET OF STRING)l.zip_value;
						SELF.city_codes_set := doxie.Make_CityCodes(l.p_city_name).rox + ut.ZipToCities(l.z5).set_codes;
						SELF                := l;
					END;

				ds_in_modified := PROJECT(ds_in, xfm_add_derived_data(LEFT));
				
				// ***** GRAB THE Address INDEX. *****
				ds_indexed_Addresses := AutokeyB.Key_Address(autokey_filename);

				// Join condition for matching records in infile dataset (LEFT) to address index (RIGHT).		
				Strict_Join_Condition() := 					
					MACRO					
						LEFT.prim_name != '' AND 
						KEYED(RIGHT.prim_name = LEFT.prim_name) AND 				
						KEYED(RIGHT.prim_range = LEFT.prim_range) AND		
						KEYED(RIGHT.st = LEFT.st) AND
						KEYED(RIGHT.city_code IN LEFT.city_codes_set) AND	
						KEYED(RIGHT.zip IN LEFT.zip_value OR LEFT.zip_value = []) AND
						KEYED(RIGHT.sec_range = LEFT.sec_range OR LEFT.sec_range = '') AND
						KEYED(RIGHT.cname_indic = LEFT.comp_name_indic_value) AND
						KEYED(RIGHT.cname_sec = LEFT.comp_name_sec_value)
					ENDMACRO;						

				Fuzzy_Join_Condition() := 
					MACRO					
						LEFT.prim_name != '' AND 
						KEYED(RIGHT.prim_name = LEFT.prim_name) AND 				
						KEYED( (workHard AND (LEFT.prim_range = '' OR LEFT.addr_loose)) OR 
								RIGHT.prim_range = LEFT.prim_range) AND				
						KEYED(RIGHT.city_code IN LEFT.city_codes_set OR 
								(LEFT.p_city_name='' and workHard)) AND										
						KEYED(RIGHT.st = LEFT.st OR 
								(LEFT.st = '' and workHard)) AND
						(LEFT.sec_range = '' OR 
								LEFT.sec_range = RIGHT.sec_range) AND
						(LEFT.company_name = '' OR 
								ut.CS100S.current(RIGHT.cname_indic, RIGHT.cname_sec, 
																	LEFT.comp_name_indic_value, LEFT.comp_name_sec_value) <= AutokeyB2_batch.Constants.COMP_NAME_MATCH_THRESHOLD)
					ENDMACRO;
				
				// ...and using _fuzzy_ matching criteria:	
				AutokeyB2_batch.Macros.MAC_Match_For_BDIDs(ds_in_modified, 
																	ds_indexed_Addresses, 
																	Fuzzy_Join_Condition(), 
																	COMP_ADDR_MATCH, 
																	f_fuzzy);		

				ds_in_exact := JOIN(f_fuzzy(search_status = TOO_MANY_MATCHES),ds_in_modified
														,LEFT.acctno = RIGHT.acctno
														,TRANSFORM(recordof(ds_in_modified),SELF := RIGHT)
														);		
				
				// Obtain matching BDIDs from the indexed file using _strict_ matching criteria...	
				AutokeyB2_batch.Macros.MAC_Match_For_BDIDs(ds_in_exact, 
																	ds_indexed_Addresses, 
																	Strict_Join_Condition(), 
																	COMP_ADDR_MATCH, 
																	f_exact);

				RETURN f_exact + f_fuzzy ;
					
			END;

		SHARED Fetch_Name_Batch(dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in) :=
			FUNCTION

				TOO_MANY_MATCHES := AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES;
				
				// 1. Grab the Names index.
				ds_indexed_names := AutokeyB.Key_Name(autokey_filename);

				// 2. Join conditions for matching records in infile dataset (LEFT) to names index (RIGHT).
				Is_Company_Name_Search() :=
					MACRO
						LEFT.bdid_value = 0 AND
						LEFT.comp_name_indic_value != '' AND 
						LEFT.st = '' AND 
						LEFT.p_city_name = '' AND 
						LEFT.zip_value = [] 
					ENDMACRO;
					
				Strict_Join_Condition() :=
					MACRO				
						Is_Company_Name_Search() AND
						KEYED(RIGHT.cname_indic = LEFT.comp_name_indic_value) AND
						KEYED(RIGHT.cname_sec = LEFT.comp_name_sec_value)
					ENDMACRO;
				
				Fuzzy_Join_Condition() := 
					MACRO
						Is_Company_Name_Search() AND			
						KEYED(AutokeyB2.is_CNameIndicMatch(right.cname_indic, left.comp_name_indic_value)) AND
						ut.CS100S.current(LEFT.comp_name_indic_value, LEFT.comp_name_sec_value, 
															RIGHT.cname_indic, RIGHT.cname_sec) <= AutokeyB2_batch.Constants.COMP_NAME_MATCH_THRESHOLD
					ENDMACRO;


				// ...and using _fuzzy_ matching criteria:	
				AutokeyB2_batch.Macros.MAC_Match_For_BDIDs(ds_in, ds_indexed_names, 
																	 Fuzzy_Join_Condition(), 
																	 COMP_NAME_MATCH, 
																	 f_fuzzy);			

				ds_in_exact := JOIN(f_fuzzy(search_status = TOO_MANY_MATCHES),ds_in
														,LEFT.acctno = RIGHT.acctno
														,TRANSFORM(recordof(ds_in),SELF := RIGHT)
														);	

				// 3. Obtain matching BDIDs from the indexed file using _strict_ matching criteria...	
				AutokeyB2_batch.Macros.MAC_Match_For_BDIDs(ds_in_exact, ds_indexed_names, 
																	 Strict_Join_Condition(), 
																	 COMP_NAME_MATCH, 
																	 f_exact);
																	 																	 
				RETURN f_exact + f_fuzzy ;
					
			END;
			
		SHARED Fetch_NameWords_Batch(dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in) :=
			FUNCTION
				
				// Remove 'THE' from company name, per AutokeyB.Fetch_NameWords.
				AutokeyB2_batch.Layouts.rec_BDID_InBatch xfm_remove_the_from_company_name(AutokeyB2_batch.Layouts.rec_BDID_InBatch l) := 
					TRANSFORM
						SELF.company_name := IF(l.company_name[1..4]='THE ',
																		l.company_name[5..LENGTH(l.company_name)],
																		l.company_name);
						SELF.comp_name_indic_value := IF(l.comp_name_indic_value[1..4]='THE ',
																						 l.comp_name_indic_value[5..LENGTH(l.comp_name_indic_value)],
																						 l.comp_name_indic_value);
						SELF              := l;
					END;
					
				ds_in_no_the := PROJECT( ds_in, xfm_remove_the_from_company_name(LEFT));
																					
				// Inflate the incoming dataset with extra fields containing squished company name.
				ds_in_expanded := AutokeyB2_batch.Functions.Add_Comp_Name_Val_Filt( GROUP(ds_in_no_the, acctno) );		
				
				// Grab the NameWords index.
				ds_indexed_names := AutokeyB.key_nameWords(autokey_filename);
				
				// Define the cast type to use in the join condition. Saves a little room in the code.
				keyfld_type := TYPEOF(ds_indexed_names.word);
					
					// Join condition for matching records in infile dataset (LEFT) to names index (RIGHT).
					// To cut down on the number of strange yet legitimate matches (e.g. 'ING' matching 
					// 'HOEHER UND INGERGRUPPE', the company name must occur in either the first or second 
					// word of the matching record. And, we'll limit which companies are returned by invoking 
					// StringSimilar to (hopefully) filter out the most egregious mismatches.
				JoinCondition() := 
					MACRO
						LEFT.bdid_value = 0 AND LENGTH(TRIM(LEFT.company_name_val_filt)) > 1 AND LEFT.zip_value = [] 
						AND 
						KEYED( TRIM((keyfld_type)LEFT.company_name_val_filt) 
							= RIGHT.word[ 1..LENGTH(TRIM((keyfld_type)LEFT.company_name_val_filt)) ] OR
										(LEFT.company_name_val_filt2 != '' AND 
										 TRIM((keyfld_type)LEFT.company_name_val_filt2) 
											 = RIGHT.word[ 1..LENGTH(TRIM((keyfld_type)LEFT.company_name_val_filt2)) ]) ) 
						AND 
						KEYED( RIGHT.state = LEFT.st OR LEFT.st = '' ) AND 
						KEYED( RIGHT.seq IN [1,2] ) AND 
						DataLib.StringSimilar100(LEFT.company_name_val_filt, RIGHT.word) < 50
					ENDMACRO;
					
				// Obtain the matching BDIDs from the indexed file. Outfile from macro is ds_results.
				AutokeyB2_batch.Macros.MAC_Match_For_BDIDs(ds_in_expanded, ds_indexed_names, JoinCondition(), NAME_WORDS_MATCH, ds_results)
				
				RETURN ds_results;
					
			END;
			
		SHARED Fetch_Phone_Batch(dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in) :=
			FUNCTION

				// Inflate the incoming dataset with extra fields containing parsed phone number.
				rec_BDID_InBatch_wParsed_Phone := 
					RECORD
						AutokeyB2_batch.Layouts.rec_BDID_InBatch;
						STRING3 p3 := '';
						STRING7 p7 := '';
					END;
				
				rec_BDID_InBatch_wParsed_Phone xfm_parse_phone(ds_in l) := 
					TRANSFORM
						SELF.p3 := IF( LENGTH(TRIM(l.phone10)) = 10, (STRING3)l.phone10[1..3], '' );
						SELF.p7 := IF( LENGTH(TRIM(l.phone10)) = 10, (STRING7)l.phone10[4..10], (STRING7)l.phone10);
						SELF := l;
					END;

				ds_in_expanded := PROJECT(ds_in, xfm_parse_phone(LEFT));

				// ***** GRAB THE PHONES INDEX. *****						
				ds_indexed_phones := AutokeyB.key_phone(autokey_filename);

				// Join condition for matching records in infile dataset (LEFT) to phones index (RIGHT):
				// Note: in AutokeyB2.Key_Phone, p3 may be indexed also.
				JoinCondition() := 
					MACRO
						LEFT.phone10 != '' AND
						KEYED(RIGHT.p7 = LEFT.p7) AND
						(RIGHT.p3 = LEFT.p3 OR LEFT.p3 = '') AND
						(LEFT.company_name = '' OR 
								ut.CS100S.current(LEFT.comp_name_indic_value, LEFT.comp_name_sec_value, 
																	RIGHT.cname_indic, RIGHT.cname_sec) <= AutokeyB2_batch.Constants.COMP_NAME_MATCH_THRESHOLD) 
					ENDMACRO;

				// Obtain the matching BDIDs from the indexed file:	
				AutokeyB2_batch.Macros.MAC_Match_For_BDIDs(ds_in_expanded, ds_indexed_phones, JoinCondition(), PHONE_MATCH, ds_results)

				return ds_results;
					
			END;
			
		SHARED Fetch_StCityFLName_Batch(dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in) :=
			FUNCTION

				// ***** GRAB THE CityStFLNames INDEX. *****
				ds_indexed_CityStFLNames := AutokeyB.Key_CityStName(autokey_filename);

				// Join condition for matching records in infile dataset (LEFT) to zips index (RIGHT).
				JoinCondition() := 
					MACRO					
						LEFT.company_name != '' AND 
						LEFT.p_city_name != '' AND 
						(LEFT.prim_name = '' OR LEFT.addr_error_value) AND
						KEYED(RIGHT.city_code = HASH((QSTRING25)LEFT.p_city_name)) AND
						KEYED(RIGHT.st = LEFT.st OR (LEFT.st = '' AND workHard)) AND
						LEFT.comp_name_indic_value != '' AND
						KEYED(AutokeyB2.is_CNameIndicMatch(RIGHT.cname_indic, LEFT.comp_name_indic_value)) AND
						ut.CS100S.current(RIGHT.cname_indic, RIGHT.cname_sec, 
															LEFT.comp_name_indic_value, LEFT.comp_name_sec_value) <= AutokeyB2_batch.Constants.COMP_NAME_MATCH_THRESHOLD // AND
					ENDMACRO;

				// Obtain the matching BDIDs from the indexed file:	
				AutokeyB2_batch.Macros.MAC_Match_For_BDIDs(ds_in, ds_indexed_CityStFLNames, JoinCondition(), CITYSTFLNAME_MATCH, ds_results)

				RETURN ds_results;
					
			END;
			
		SHARED Fetch_StName_Batch(dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in) :=
			FUNCTION
				
				// ***** GRAB THE StNames INDEX. *****
				ds_indexed_StNames := AutokeyB.Key_StName(autokey_filename);

				// Join condition for matching records in infile dataset (LEFT) to StNames index (RIGHT). 
				JoinCondition() := 
					MACRO					
						LEFT.company_name != '' AND 
						LEFT.st != '' AND 
						LEFT.p_city_name = '' AND 
						LEFT.zip_value = [] AND
						KEYED(RIGHT.st = LEFT.st) AND
						KEYED(AutokeyB2.is_CNameIndicMatch(RIGHT.cname_indic, LEFT.comp_name_indic_value)) AND
						ut.CS100S.current(RIGHT.cname_indic, RIGHT.cname_sec, 
															LEFT.comp_name_indic_value, LEFT.comp_name_sec_value) <= AutokeyB2_batch.Constants.COMP_NAME_MATCH_THRESHOLD // AND 
					ENDMACRO;

				// Obtain the matching BDIDs from the indexed file:	
				AutokeyB2_batch.Macros.MAC_Match_For_BDIDs(ds_in, ds_indexed_StNames, JoinCondition(), STNAME_MATCH, ds_results)

				return ds_results;
					
			END;
			
		SHARED Fetch_Zip_Batch(dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in) :=
			FUNCTION

				// ***** GRAB THE ZIPCODE INDEX. *****
				ds_indexed_zips := AutokeyB.Key_Zip(autokey_filename);

				// Join condition for matching records in infile dataset (LEFT) to zips index (RIGHT).
				JoinCondition() := 
					MACRO
						LEFT.zip_value != [] AND 
						(LEFT.prim_name = '' OR LEFT.addr_error_value) AND
						LEFT.comp_name_indic_value != '' AND
						KEYED(RIGHT.zip IN LEFT.zip_value) AND
						KEYED(AutokeyB2.is_CNameIndicMatch(RIGHT.cname_indic, LEFT.comp_name_indic_value)) AND
						(LEFT.company_name = '' OR 
								ut.CS100S.current(LEFT.comp_name_indic_value, LEFT.comp_name_sec_value, 
																	RIGHT.cname_indic, RIGHT.cname_sec) <= AutokeyB2_batch.Constants.COMP_NAME_MATCH_THRESHOLD) // AND
					ENDMACRO;

				// Obtain the matching BDIDs from the indexed file:	
				AutokeyB2_batch.Macros.MAC_Match_For_BDIDs(ds_in, ds_indexed_zips, JoinCondition(), ZIP_MATCH, ds_results)

				return ds_results;
						
			END;


		SHARED Get_BDIDs_Batch(DATASET(Autokey_batch.Layouts.rec_Cleaned_Input_Record) ds_in) := 
			FUNCTION
			
				// 0. Transform to rec_BDID_InBatch.
				ds_BDID_InBatch := PROJECT(ds_in, AutokeyB2_batch.Transforms.xfm_convert_for_getting_BDIDs(LEFT));
						
				// 1.  Obtain the set of zipcodes that are valid for the city name, state, single zipcode and zip radius.
				ds_input_with_ZipSet := PROJECT(ds_BDID_InBatch, AutokeyB2_batch.Transforms.xfm_add_zip_set(LEFT));
				
				// 2.  Parse the input company name into indic and sec values.
				ds_input := PROJECT(ds_input_with_ZipSet, AutokeyB2_batch.Transforms.xfm_parse_companyname(LEFT));
				
				// 3. Run autokey fetches.
				ds_results := 
					Fetch_Name_Batch(ds_input) +
					Fetch_NameWords_Batch(ds_input) +
					Fetch_Address_Batch(ds_input) +
					Fetch_StName_Batch(ds_input) +
					Fetch_StCityFLName_Batch(ds_input) + 
					Fetch_Zip_Batch(ds_input) +
					Fetch_Phone_Batch(ds_input) 
				;

				// 4. Sort and return.
				ds_sorted_results  := SORT(UNGROUP(ds_results), acctno, search_status, matchcode, bdid);

				RETURN ds_sorted_results;

			END;
			
		SHARED get_ids_batch(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_in) := 
			FUNCTION
				
				// 1. Transform the dataset in doxie.layout_inBatchMaster to Autokey_batch.Layouts.rec_Cleaned_Input_Record.
				//    Sort and group. NOTE! As of this point in time (Jan 2008), rec_Cleaned_Input_Record doesn't contain 
				//    certain data, like DID, DL or VIN. These can be added to the layout later, if necessary.
				ds_input         := PROJECT(ds_in, Autokey_batch.Transforms.xfm_to_Cleaned_Input_Record(LEFT));
				ds_input_sorted  := SORT(ds_input, AccountNumber);
				
				// 2. Get BDIDs.	
				bdids_raw := Get_BDIDs_Batch(ds_input_sorted);
				
				AutokeyB2_batch.Layouts.rec_output_IDs_batch xfm_make_BDIDs(AutokeyB2_batch.Layouts.rec_output_BDIDs_batch l) := 
					TRANSFORM
						SELF.ID     := l.BDID;
						SELF.isBDID := TRUE;
						SELF        := l;
					END;

				bdids := PROJECT( bdids_raw, xfm_make_BDIDs(LEFT) );
				 				
				// 3. Sort and roll up matchcodes, concatenating the matchCodes on adjacent records.
				ds_sorted_ids := SORT(bdids, acctno, ID, matchcode);

				AutokeyB2_batch.Layouts.rec_output_IDs_batch xfm_rollup_final_results(ds_sorted_ids l, ds_sorted_ids r) := 
					TRANSFORM
						SELF.matchCode := IF( r.matchCode != '' AND r.matchCode != l.matchcode, 
																	TRIM((STRING10)(l.matchCode)) + r.matchCode, 
																	l.matchCode);
						SELF           := l;
					END;

				ds_final_results := ROLLUP(ds_sorted_ids, xfm_rollup_final_results(LEFT, RIGHT), acctno, search_status, ID);	
				
				RETURN ds_final_results;
				
			END;
				
		EXPORT get_EBR_fids( DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in 
					     = DATASET([],Autokey_batch.Layouts.rec_inBatchMaster) ) := 
			FUNCTION
			  // Output type is AutokeyB2_batch.Layouts.rec_output_IDs_batch
				RETURN get_ids_batch(ds_batch_in);
			END;
			
	END;