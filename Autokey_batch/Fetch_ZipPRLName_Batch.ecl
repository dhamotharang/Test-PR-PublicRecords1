
/* View documentation section for notes on this attribute. */

IMPORT ut, Autokey, Autokey_batch, AutokeyB2, AutokeyB2_batch, Doxie;

EXPORT Fetch_ZipPRLName_Batch( 
		GROUPED DATASET(Autokey_batch.Layouts.rec_DID_InBatch) ds_in, 
		STRING t,
		BOOLEAN workHard = FALSE,
		BOOLEAN nofail = TRUE, 
		BOOLEAN isTestHarness = TRUE) :=
	FUNCTION

		// Grab the ZipPRLName index.
		ds_indexed_ZipPRLName := Autokey.Key_ZipPRLName(t);

		// Join condition for matching records in infile dataset (LEFT) to Key_Zip index (RIGHT).			
		JoinCondition() := 
			MACRO		
				(LEFT.zip_value != []) AND 
				(LEFT.pname_value = '') AND 
				(LEFT.prange_value != '') AND
				KEYED(RIGHT.zip IN LEFT.zip_value) AND
				KEYED(RIGHT.prim_range = LEFT.prange_value) AND 
				KEYED(RIGHT.lname[1..LENGTH(TRIM(LEFT.lname_value))] = LEFT.lname_value) AND
				ut.bit_test(RIGHT.lookups, LEFT.lookup_value)
			ENDMACRO;

		// Obtain the matching DIDs from the indexed file:	
		Autokey_batch.Macros.MAC_Match_For_DIDs(ds_in, ds_indexed_ZipPRLName, JoinCondition(), ZIPPRLNAME_MATCH, ds_results)

		// ***** For test harness only. OUTPUT() all of the input data along with matching DIDs and matchCodes.	
		IF( isTestHarness, OUTPUT(Autokey_batch.Functions.Display_Matched_Input_And_Output(ds_in, ds_results), 
		                          NAMED('Combined_Layout_Results_Autokey_Fetch_ZipPRLName_Batch'), OVERWRITE) );

		RETURN ds_results;
			
	END;
	
/*				
	zip_value<>[] AND 
	pname_value='' AND 
	prange_Value <> '' AND
	keyed(zip IN zip_value) AND 
	keyed(prim_Range = prange_Value) AND 
	keyed(lname[1..LENGTH(TRIM(lname_value))] = lname_value) AND
	ut.bit_test(lookups, lookup_value))			
*/			
	