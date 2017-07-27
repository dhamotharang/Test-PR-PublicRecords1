
/* View documentation section for notes on this attribute. */

import ut, AutokeyB2;

export Fetch_Zip_Batch( 
		 grouped dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in, 
		 string t,
		 boolean workHard = false,
		 boolean nofail = true, 
		 boolean isTestHarness = false) :=
	FUNCTION

		// ***** GRAB THE ZIPCODE INDEX. *****
		ds_indexed_zips := AutokeyB2.Key_Zip(t);

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
						                  RIGHT.cname_indic, RIGHT.cname_sec) <= Constants.COMP_NAME_MATCH_THRESHOLD) AND
				ut.bit_test(RIGHT.lookups, LEFT.lookup_value)
			ENDMACRO;

		// Obtain the matching BDIDs from the indexed file:	
		Macros.MAC_Match_For_BDIDs(ds_in, ds_indexed_zips, JoinCondition(), ZIP_MATCH, ds_results)

		// ***** For test harness only. OUTPUT() all of the input data along with matching BDIDs and matchCodes.	
		IF( isTestHarness, OUTPUT(Functions.Display_Matched_Input_And_Output(ds_in, ds_results), 
		                          NAMED('Combined_Layout_Results_Fetch_Zip_Batch'), OVERWRITE) );

		return ds_results;
				
	END;
