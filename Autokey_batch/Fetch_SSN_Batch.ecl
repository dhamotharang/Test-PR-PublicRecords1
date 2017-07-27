
/* View documentation section for notes on this attribute. */

import ut, Autokey, Autokey_batch, AutokeyB2_batch;

export Fetch_SSN_Batch( 
		GROUPED DATASET(Autokey_batch.Layouts.rec_DID_InBatch) ds_in, 
		STRING t,
		BOOLEAN workHard = FALSE,
		BOOLEAN nofail = TRUE, 
		BOOLEAN useAllLookups = FALSE,
		BOOLEAN isTestHarness = TRUE) :=
	FUNCTION
	
		// Grab the SSN indexes.
		ds_indexed_SSNs  := Autokey.Key_SSN(t);
		ds_indexed_SSNs2 := Autokey.Key_SSN2(t);
		
		// only compare input SSNs with > 5 digits
		ds_in_filt :=  ds_in(length(trim(ssn_value,all)) > 5);

		// Join conditions for matching records in infile dataset (LEFT) to SSN index (RIGHT).		
		JoinCondition() := 
			MACRO
				LEFT.ssn_value != '' AND 
				(KEYED(RIGHT.s1 = LEFT.ssn_value[1]) AND KEYED(RIGHT.s2 = LEFT.ssn_value[2]) AND KEYED(RIGHT.s3 = LEFT.ssn_value[3]) AND 
				 KEYED(RIGHT.s4 = LEFT.ssn_value[4]) AND KEYED(RIGHT.s5 = LEFT.ssn_value[5]) AND KEYED(RIGHT.s6 = LEFT.ssn_value[6]) AND 
				 KEYED(RIGHT.s7 = LEFT.ssn_value[7]) AND KEYED(RIGHT.s8 = LEFT.ssn_value[8]) AND KEYED(RIGHT.s9 = LEFT.ssn_value[9]))
			ENDMACRO;	

		// Obtain the matching DIDs from the indexed file. Note the useLookups() macro appended to JoinCondition():	
		Autokey_batch.Macros.MAC_Match_For_DIDs(ds_in_filt, ds_indexed_SSNs,  JoinCondition(), SSN_MATCH, ds_SSNs_results)
		Autokey_batch.Macros.MAC_Match_For_DIDs(ds_in_filt, ds_indexed_SSNs2, JoinCondition() AND Autokey_batch.Macros.useLookups(), SSN_MATCH, ds_SSNs2_results)

		// ***** For test harness only. OUTPUT() all of the input data along with matching DIDs and matchCodes.	
		IF( isTestHarness, 
		    IF( useAllLookups,
				    OUTPUT(Autokey_batch.Functions.Display_Matched_Input_And_Output(ds_in_filt, ds_SSNs2_results), 
						       NAMED('Combined_Layout_Results_Autokey_Fetch_SSN2_Batch'), OVERWRITE),
						OUTPUT(Autokey_batch.Functions.Display_Matched_Input_And_Output(ds_in_filt, ds_SSNs_results),  
						       NAMED('Combined_Layout_Results_Autokey_Fetch_SSN_Batch'), OVERWRITE)
					 )
			 );

		RETURN IF( useAllLookups,
		           ds_SSNs2_results,
							 ds_SSNs_results
							);
			
	END;
	