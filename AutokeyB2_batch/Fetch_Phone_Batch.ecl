
/* View documentation section for notes on this attribute. */

import ut, AutokeyB2;

export Fetch_Phone_Batch( 
		 grouped dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in, 
		 string t,
		 boolean workHard = false,
		 boolean nofail = true, 
		 boolean isTestHarness = false) :=
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
			// Attempted to use a foreignized key; it's pretty sparse, too.
			// u := ut.foreign_prod+'thor_data400::key::liensv2_autokey';
			// ds_indexed_phones := AutokeyB2.Key_Phone(u);  
		
		ds_indexed_phones := AutokeyB2.key_phone(t);

		// Join condition for matching records in infile dataset (LEFT) to phones index (RIGHT):
		// Note: in AutokeyB2.Key_Phone, p3 may be indexed also.
		JoinCondition() := 
			MACRO
				LEFT.phone10 != '' AND
				KEYED(RIGHT.p7 = LEFT.p7) AND
				(RIGHT.p3 = LEFT.p3 OR LEFT.p3 = '') AND
				(LEFT.company_name = '' OR 
						ut.CS100S.current(LEFT.comp_name_indic_value, LEFT.comp_name_sec_value, 
						                  RIGHT.cname_indic, RIGHT.cname_sec) <= Constants.COMP_NAME_MATCH_THRESHOLD) 
				AND ut.bit_test(RIGHT.lookups, LEFT.lookup_value)
			ENDMACRO;

		// Obtain the matching BDIDs from the indexed file:	
		Macros.MAC_Match_For_BDIDs(ds_in_expanded, ds_indexed_phones, JoinCondition(), PHONE_MATCH, ds_results)

		// ***** For test harness only. OUTPUT() all of the input data along with matching BDIDs and matchCodes.	
		IF( isTestHarness, OUTPUT(Functions.Display_Matched_Input_And_Output(ds_in, ds_results), 
		                          NAMED('Combined_Layout_Results_Fetch_Phone_Batch'), OVERWRITE) );

		return ds_results;
			
	END;
