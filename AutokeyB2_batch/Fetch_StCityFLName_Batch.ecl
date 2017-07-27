
/* View documentation section for notes on this attribute. */

import ut, AutokeyB2, doxie;

export Fetch_StCityFLName_Batch( 
		grouped dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in, 
		string t,
		boolean workHard = false,
		boolean nofail = true, 
		boolean isTestHarness = false) :=
	FUNCTION

		// ***** GRAB THE CityStFLNames INDEX. *****
		ds_indexed_CityStFLNames := AutokeyB2.Key_CityStName(t);

		// Join condition for matching records in infile dataset (LEFT) to zips index (RIGHT).
		JoinCondition() := 
			MACRO					
				LEFT.company_name != '' AND 
				LEFT.p_city_name != '' AND 
				(LEFT.prim_name = '' OR LEFT.addr_error_value) AND
				KEYED(RIGHT.city_code in doxie.Make_CityCodes(LEFT.p_city_name).rox) AND
				KEYED(RIGHT.st = LEFT.st OR (LEFT.st = '' AND workHard)) AND
				LEFT.comp_name_indic_value != '' AND
				KEYED(AutokeyB2.is_CNameIndicMatch(RIGHT.cname_indic, LEFT.comp_name_indic_value)) AND
				ut.CS100S.current(RIGHT.cname_indic, RIGHT.cname_sec, 
				                  LEFT.comp_name_indic_value, LEFT.comp_name_sec_value) <= Constants.COMP_NAME_MATCH_THRESHOLD AND
				ut.bit_test(RIGHT.lookups, LEFT.lookup_value)
			ENDMACRO;

		// Obtain the matching BDIDs from the indexed file:	
		Macros.MAC_Match_For_BDIDs(ds_in, ds_indexed_CityStFLNames, JoinCondition(), CITYSTFLNAME_MATCH, ds_results)

		// ***** For test harness only. OUTPUT() all of the input data along with matching BDIDs and matchCodes.	
		IF( isTestHarness, OUTPUT(Functions.Display_Matched_Input_And_Output(ds_in, ds_results), 
		                          NAMED('Combined_Layout_Results_Fetch_StCityFLName_Batch'), OVERWRITE) );
		
		RETURN ds_results;
			
	END;
