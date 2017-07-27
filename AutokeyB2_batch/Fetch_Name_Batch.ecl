
/* View documentation section for notes on this attribute. */

import ut, AutokeyB2;

export Fetch_Name_Batch( 
	 grouped dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in, 
	 string t,
	 boolean workHard = false,
	 boolean nofail = true, 
	 boolean isTestHarness = false) :=
	FUNCTION

		TOO_MANY_MATCHES := AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES;
		
		// 1. Grab the Names index.
		ds_indexed_names := AutokeyB2.Key_Name(t);

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
				                  RIGHT.cname_indic, RIGHT.cname_sec) <= Constants.COMP_NAME_MATCH_THRESHOLD
			ENDMACRO;


		// ...and using _fuzzy_ matching criteria:	
		Macros.MAC_Match_For_BDIDs(ds_in, ds_indexed_names, 
		                           Fuzzy_Join_Condition(), 
		                           COMP_NAME_MATCH, 
		                           f_fuzzy);			

		ds_in_exact := JOIN(f_fuzzy(search_status = TOO_MANY_MATCHES),ds_in
		                    ,LEFT.acctno = RIGHT.acctno
												,TRANSFORM(recordof(ds_in),SELF := RIGHT)
												);	

		// 3. Obtain matching BDIDs from the indexed file using _strict_ matching criteria...	
		Macros.MAC_Match_For_BDIDs(ds_in_exact, ds_indexed_names, 
		                           Strict_Join_Condition(), 
		                           COMP_NAME_MATCH, 
		                           f_exact);
															 
															 
		// ***** For test harness only. OUTPUT() all of the input data along with matching BDIDs and matchCodes.	
		IF( isTestHarness, OUTPUT(Functions.Display_Matched_Input_And_Output(ds_in, IF( EXISTS(f_fuzzy(search_status = TOO_MANY_MATCHES)), f_exact, f_fuzzy )), 
		                          NAMED('Combined_Layout_Results_Fetch_Name_Batch'), OVERWRITE) );

		// RETURN IF( EXISTS(f_fuzzy(search_status = TOO_MANY_MATCHES)), f_exact, f_fuzzy );
	
		RETURN f_exact + f_fuzzy ;
			
	END;
