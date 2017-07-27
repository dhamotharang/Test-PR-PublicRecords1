
/* View documentation section for notes on this attribute. */

import ut, Autokey, Autokey_batch, AutokeyB2_batch, Doxie;

export Fetch_Phone_Batch( 
		GROUPED DATASET(Autokey_batch.Layouts.rec_DID_InBatch) ds_in, 
		STRING t,
		BOOLEAN workHard = FALSE,
		BOOLEAN nofail = TRUE, 
		BOOLEAN useAllLookups = FALSE,
		BOOLEAN isTestHarness = TRUE) :=
	FUNCTION

		// Grab the Phones indexes.
		ds_indexed_Phones  := Autokey.key_phone(t);
		ds_indexed_Phones2 := Autokey.key_phone2(t);

		// Create the join condition.
		JoinCondition() := 
			MACRO					
				LEFT.phone_value != '' AND
				KEYED(RIGHT.p7 = IF( LENGTH(TRIM(LEFT.phone_value)) = 10, 
				                     LEFT.phone_value[4..10], 
														 (STRING7)LEFT.phone_value) 
														) AND
				KEYED(RIGHT.p3 = LEFT.phone_value[1..3] OR LENGTH(TRIM(LEFT.phone_value)) != 10) AND
				KEYED(LEFT.lname_value = '' OR RIGHT.dph_lname = (STRING6)metaphonelib.DMetaPhone1(LEFT.lname_value)[1..6])						
			ENDMACRO;

		// Obtain the matching DIDs from the indexed file. Note the useLookups() macro appended to JoinCondition():	
		Autokey_batch.Macros.MAC_Match_For_DIDs(ds_in, ds_indexed_Phones,  JoinCondition(), PHONE_MATCH, ds_phones_results)
		Autokey_batch.Macros.MAC_Match_For_DIDs(ds_in, ds_indexed_Phones2, JoinCondition() AND Autokey_batch.Macros.useLookups(), PHONE_MATCH, ds_phones2_results)

		// ***** For test harness only. OUTPUT() all of the input data along with matching DIDs and matchCodes.	
		IF( isTestHarness, 
		    IF( useAllLookups,
				    OUTPUT(Autokey_batch.Functions.Display_Matched_Input_And_Output(ds_in, ds_phones2_results), 
						NAMED('Combined_Layout_Results_Autokey_Fetch_Phone2_Batch'), OVERWRITE),
						OUTPUT(Autokey_batch.Functions.Display_Matched_Input_And_Output(ds_in, ds_phones_results),  
						NAMED('Combined_Layout_Results_Autokey_Fetch_Phone_Batch'), OVERWRITE)
					 )
			 );

		RETURN IF( useAllLookups,
		           ds_phones2_results,
							 ds_phones_results
							);
							
	END;

	