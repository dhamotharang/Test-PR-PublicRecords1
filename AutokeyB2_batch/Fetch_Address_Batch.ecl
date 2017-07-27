	
/* View documentation section for notes on this attribute. */

import doxie, ut, AutokeyB2;

export Fetch_Address_Batch( 
		grouped dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in, 
		string t,
		boolean workHard = false,
		boolean nofail = true, 
		boolean isTestHarness = false) :=
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
				SELF.city_codes_set := [doxie.Make_CityCodes(l.p_city_name).rox] + ut.ZipToCities(l.z5).set_codes;
				SELF                := l;
			END;

		ds_in_modified := PROJECT(ds_in, xfm_add_derived_data(LEFT));
		
		// ***** GRAB THE Address INDEX. *****
		ds_indexed_Addresses := AutokeyB2.Key_Address(t);

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
						                  LEFT.comp_name_indic_value, LEFT.comp_name_sec_value) <= Constants.COMP_NAME_MATCH_THRESHOLD)
			ENDMACRO;
		
		// ...and using _fuzzy_ matching criteria:	
		Macros.MAC_Match_For_BDIDs(ds_in_modified, 
		                          ds_indexed_Addresses, 
															Fuzzy_Join_Condition(), 
															COMP_ADDR_MATCH, 
															f_fuzzy);		

		ds_in_exact := JOIN(f_fuzzy(search_status = TOO_MANY_MATCHES),ds_in_modified
		                    ,LEFT.acctno = RIGHT.acctno
												,TRANSFORM(recordof(ds_in_modified),SELF := RIGHT)
												);		
		
		// Obtain matching BDIDs from the indexed file using _strict_ matching criteria...	
		Macros.MAC_Match_For_BDIDs(ds_in_exact, 
		                          ds_indexed_Addresses, 
															Strict_Join_Condition(), 
															COMP_ADDR_MATCH, 
															f_exact);


		// ***** For test harness only. OUTPUT() all of the input data along with matching BDIDs and matchCodes.	
		IF( isTestHarness, OUTPUT(Functions.Display_Matched_Input_And_Output(ds_in, IF( EXISTS(f_fuzzy(search_status = TOO_MANY_MATCHES)), f_exact,  f_fuzzy)), 
		                          NAMED('Combined_Layout_Results_Fetch_Address_Batch'), OVERWRITE) );

		// RETURN IF( EXISTS(f_fuzzy(search_status = TOO_MANY_MATCHES)), f_exact, f_fuzzy );

		RETURN f_exact + f_fuzzy ;
			
	END;
	
	