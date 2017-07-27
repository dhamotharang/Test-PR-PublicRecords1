
/* View documentation section for notes on this attribute. */

import ut, AutokeyB2;

export Fetch_StName_Batch( 
	 grouped dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in,
	 string t,
	 boolean workHard = false,
	 boolean nofail = true, 
	 boolean isTestHarness = false) :=
	FUNCTION
		
		// ***** GRAB THE StNames INDEX. *****
		ds_indexed_StNames := AutokeyB2.Key_StName(t);

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
				                  LEFT.comp_name_indic_value, LEFT.comp_name_sec_value) <= Constants.COMP_NAME_MATCH_THRESHOLD AND 
				ut.bit_test(RIGHT.lookups, LEFT.lookup_value)						
			ENDMACRO;

		// Obtain the matching BDIDs from the indexed file:	
		Macros.MAC_Match_For_BDIDs(ds_in, ds_indexed_StNames, JoinCondition(), STNAME_MATCH, ds_results)

		// ***** For test harness only. OUTPUT() all of the input data along with matching BDIDs and matchCodes.	
		IF( isTestHarness, OUTPUT(Functions.Display_Matched_Input_And_Output(ds_in, ds_results), 
		                          NAMED('Combined_Layout_Results_Fetch_StName_Batch'), OVERWRITE) );

		return ds_results;
			
	END;
