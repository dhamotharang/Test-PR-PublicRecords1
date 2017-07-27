
/* View documentation section for notes on this attribute. */

IMPORT ut, Autokey, Autokey_batch, AutokeyB2, AutokeyB2_batch, Doxie;

EXPORT Fetch_StCityFLName_Batch( 
		GROUPED DATASET(Autokey_batch.Layouts.rec_DID_InBatch) ds_in, 
		STRING t,
		BOOLEAN workHard = FALSE,
		BOOLEAN nofail = TRUE, 
		BOOLEAN isTestHarness = TRUE) :=
	FUNCTION

		// Grab the CityStName index.
		ds_indexed_StCityFLNames := Autokey.Key_CityStName(t);

		// Define the cast type to use in the join condition. Saves a little room in the code.
		key_lname_type := TYPEOF(ds_indexed_StCityFLNames.lname);
		key_fname_type := TYPEOF(ds_indexed_StCityFLNames.fname);		

		// Join condition for matching records in infile dataset (LEFT) to StFLName index (RIGHT).		
		JoinCondition() := 
			MACRO				
        LEFT.city_value != '' AND 
				(LEFT.pname_value = '' OR LEFT.addr_error_value) AND 
				((workHard AND LEFT.comp_name_value = '') OR 
				    (LEFT.lname_value != '')) AND
				KEYED(RIGHT.city_code in doxie.Make_CityCodes( LEFT.city_value).rox) AND				
				KEYED(RIGHT.st = LEFT.state_value OR 
						(LEFT.state_value = '' AND workHard)) AND
				KEYED(RIGHT.dph_lname = metaphonelib.DMetaPhone1(LEFT.lname_value)[1..6] OR 
						(LEFT.lname_value = '' AND workHard)) AND
				KEYED(RIGHT.lname[1..LENGTH( TRIM((key_lname_type)LEFT.lname_value))] = TRIM((key_lname_type)LEFT.lname_value) OR					
						((LEFT.phonetics OR LEFT.lname_value = '') AND workHard) ) AND
				KEYED(Autokey_batch.Functions.pfe(RIGHT.pfname, LEFT.fname_value) OR
						(LENGTH(TRIM(LEFT.fname_value)) < 2 AND workHard)) AND
				KEYED(RIGHT.fname[1..LENGTH( TRIM((key_fname_type)LEFT.fname_value))] = TRIM((key_fname_type)LEFT.fname_value) OR 				
				    LEFT.nicknames) AND
				(LEFT.find_year_low = 0 OR (RIGHT.dob div 10000) = 0 OR
						(RIGHT.dob div 10000) >= LEFT.find_year_low) AND
				(LEFT.find_year_high = 0 OR (RIGHT.dob div 10000) = 0 OR
						(RIGHT.dob div 10000) <= LEFT.find_year_high) AND
				Autokey_batch.Macros.Other_Join_Conditions() AND
				ut.bit_test(RIGHT.lookups, LEFT.lookup_value)
			ENDMACRO;

		// Obtain the matching DIDs from the indexed file:
		Autokey_batch.Macros.MAC_Match_For_DIDs(ds_in, ds_indexed_StCityFLNames, JoinCondition(), CITYSTFLNAME_MATCH, ds_results)

		// ***** For test harness only. OUTPUT() all of the input data along with matching DIDs and matchCodes.	
		IF( isTestHarness, OUTPUT(Autokey_batch.Functions.Display_Matched_Input_And_Output(ds_in, ds_results), 
		                          NAMED('Combined_Layout_Results_Autokey_Fetch_StCityFLName_Batch'), OVERWRITE) );

		RETURN ds_results;
			
	END;
