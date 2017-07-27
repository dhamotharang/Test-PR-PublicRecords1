
/* View documentation section for notes on this attribute. */

IMPORT ut, Autokey, Autokey_batch, AutokeyB2, AutokeyB2_batch, Doxie;

EXPORT Fetch_Address_Batch( 
		GROUPED DATASET(Autokey_batch.Layouts.rec_DID_InBatch) ds_in, 
		STRING t,
		BOOLEAN workHard = FALSE,
		BOOLEAN nofail = TRUE, 
		BOOLEAN isTestHarness = TRUE) :=
	FUNCTION

		TOO_MANY_MATCHES := AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES;

		// 1. Fiddle with the incoming dataset to add more derived data.
		rec_InBatch_with_derived_values :=
			RECORD
				Autokey_batch.Layouts.rec_DID_InBatch;
				SET OF STRING5   zips           := [];
				SET OF STRING5   extended_zips  := [];
			END;
			
		rec_InBatch_with_derived_values xfm_Add_Derived_Values(ds_in l) :=
			TRANSFORM
				zip_values          := SET(PROJECT(DATASET(l.zip_value,{INTEGER4 zip}),TRANSFORM({STRING5 zip},SELF.zip:=INTFORMAT(LEFT.zip,5,1))),zip);
				
				SELF.zips           := (SET OF STRING5)zip_values;
				SELF.extended_zips  := (SET OF STRING5)zip_values + 
		                           IF( l.state_value != '' AND l.city_value != '',
																	 SET(PROJECT(DATASET(ziplib.ZipsWithinRadius(ziplib.CityToZip5(l.state_value, l.city_value), l.zipradius_value),{INTEGER4 zip}),TRANSFORM({STRING5 zip},SELF.zip:=INTFORMAT(LEFT.zip,5,1))),zip),
				                           []
				                          );
				SELF                := l;
			END;	
					
 		ds_in_with_derived_values := PROJECT(ds_in, xfm_Add_Derived_Values(LEFT));		
					
		// 2. Grab the Address indexed file.
		ds_indexed_Addresses := Autokey.Key_Address(t);

		// 3. Define a macro to express matching criteria common to both strict and fuzzy matches.
		//    Second Lookup bit checks for representative address.
//		Other_Match_Criteria() := 
//			MACRO
//				LEFT.prev_state_val1 = ''       OR ut.bit_test(RIGHT.states, ut.St2Code(LEFT.prev_state_val1))AND
//				LEFT.prev_state_val2 = ''       OR ut.bit_test(RIGHT.states, ut.St2Code(LEFT.prev_state_val2)) AND
//				LEFT.other_lname_value1[1] = '' OR ut.bit_test(RIGHT.lname1, ut.Chr2Code(LEFT.other_lname_value1[1])) AND
//				LEFT.other_lname_value1[2] = '' OR ut.bit_test(RIGHT.lname2, ut.Chr2Code(LEFT.other_lname_value1[2])) AND
//				LEFT.other_lname_value1[3] = '' OR ut.bit_test(RIGHT.lname3, ut.Chr2Code(LEFT.other_lname_value1[3])) AND
//				ut.bit_test(RIGHT.lookups, LEFT.lookup_value) AND
//				ut.bit_test(RIGHT.lookups, LEFT.lookup_value2)
//			ENDMACRO;
			
		// 3-and-a-half. Define a macro to express strict matching criteria. Contains macro other_match_criteria().
		Strict_Join_Condition() :=
			MACRO
				KEYED(RIGHT.prim_name = LEFT.pname_value) AND
				KEYED(RIGHT.prim_range = LEFT.prange_value) AND				
				KEYED(RIGHT.city_code IN LEFT.city_codes_set OR LEFT.city_value = '') AND
				KEYED(RIGHT.st = LEFT.state_value) AND
				KEYED(RIGHT.zip IN LEFT.zips OR LEFT.zip_val = '') AND
				KEYED(RIGHT.sec_range = LEFT.sec_range_value OR LEFT.sec_range_value = '') AND
				KEYED(RIGHT.dph_lname = metaphonelib.DMetaPhone1(LEFT.lname_value)[1..6] OR LEFT.lname_value = '') AND
				KEYED(RIGHT.lname = LEFT.lname_value  OR LEFT.lname_value = '') AND
				KEYED(Autokey_batch.Functions.pfe(RIGHT.pfname, LEFT.fname_value) OR LEFT.fname_value = '') // AND
//				Other_Match_Criteria() 
			ENDMACRO;

		// 4. Define a macro to express fuzzy matching criteria. Contains macro other_match_criteria().
		Fuzzy_Join_Condition() :=
			MACRO
				KEYED(RIGHT.prim_name = LEFT.pname_value) AND
				KEYED(RIGHT.prim_range = LEFT.prange_value OR (workHard AND (LEFT.prange_value = '' /* OR addr_loose */ ))) AND
				KEYED(RIGHT.city_code IN LEFT.city_codes_set OR (LEFT.city_codes_set = [] AND workHard)) AND
				KEYED(RIGHT.st = LEFT.state_value OR (LEFT.state_value = '' AND workHard)) AND
				KEYED(RIGHT.zip IN LEFT.extended_zips OR LEFT.zip_val = '') AND
				KEYED(LEFT.sec_range_value = RIGHT.sec_range OR LEFT.sec_range_value = '') AND
				KEYED(RIGHT.dph_lname = metaphonelib.DMetaPhone1(LEFT.lname_value)[1..6] OR LEFT.lname_value = '') // AND
//				Other_Match_Criteria() 
			ENDMACRO;				 

		// 5. Obtain matching DIDs from the indexed file using _fuzzy_ matching criteria:	
		Autokey_batch.Macros.MAC_Match_For_DIDs(ds_in_with_derived_values, ds_indexed_Addresses, 
																						Fuzzy_Join_Condition(), 
																						ADDRESS_MATCH, 
																						f_fuzzy)
																						
	  
		ds_in_exact := JOIN(f_fuzzy(search_status = TOO_MANY_MATCHES),ds_in_with_derived_values
		                    ,LEFT.acctno = RIGHT.acctno
												,TRANSFORM(recordof(ds_in_with_derived_values),SELF := RIGHT)
												);

		// 6. Obtain matching DIDs from the indexed file using _strict_ matching criteria:	
		Autokey_batch.Macros.MAC_Match_For_DIDs(ds_in_exact, ds_indexed_Addresses, 
																						Strict_Join_Condition(), 
																						ADDRESS_MATCH, 
																						f_exact)
		// ***** For test harness only. OUTPUT() all of the input data along with matching DIDs AND matchCodes.	
		IF( isTestHarness, OUTPUT(Autokey_batch.Functions.Display_Matched_Input_And_Output(ds_in, IF( EXISTS(f_fuzzy(search_status = TOO_MANY_MATCHES)), f_exact, f_fuzzy )),
		                          NAMED('Combined_Layout_Results_Autokey_Fetch_Address_Batch'), OVERWRITE) );		
		
		RETURN f_exact + f_fuzzy ;
			
	END;
	