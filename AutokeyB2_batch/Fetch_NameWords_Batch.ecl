
/* View documentation section for notes on this attribute. */

import ut, AutokeyB2;

export Fetch_NameWords_Batch( 
		 grouped dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in, 
		 string t,
		 boolean workHard = false,
		 boolean nofail = true, 
		 boolean isTestHarness = false) :=
	FUNCTION
		
		// Remove 'THE' from company name, per AutokeyB.Fetch_NameWords.
		AutokeyB2_batch.Layouts.rec_BDID_InBatch xfm_remove_the_from_company_name(AutokeyB2_batch.Layouts.rec_BDID_InBatch l) := 
			TRANSFORM
				SELF.company_name := IF(l.company_name[1..4]='THE ',
				                        l.company_name[5..LENGTH(l.company_name)],
				                        l.company_name);
				SELF.comp_name_indic_value := IF(l.comp_name_indic_value[1..4]='THE ',
				                                 l.comp_name_indic_value[5..LENGTH(l.comp_name_indic_value)],
				                                 l.comp_name_indic_value);
				SELF              := l;
			END;
			
		ds_in_no_the := PROJECT( ds_in, xfm_remove_the_from_company_name(LEFT));
																			
		// Inflate the incoming dataset with extra fields containing squished company name.
		ds_in_expanded := Functions.Add_Comp_Name_Val_Filt(ds_in_no_the);		
		
		// Grab the NameWords index.
		ds_indexed_names := AutokeyB2.key_nameWords(t);
		
		// Define the cast type to use in the join condition. Saves a little room in the code.
		keyfld_type := TYPEOF(ds_indexed_names.word);
			
			// Join condition for matching records in infile dataset (LEFT) to names index (RIGHT).
			// To cut down on the number of strange yet legitimate matches (e.g. 'ING' matching 
			// 'HOEHER UND INGERGRUPPE', the company name must occur in either the first or second 
			// word of the matching record. And, we'll limit which companies are returned by invoking 
			// StringSimilar to (hopefully) filter out the most egregious mismatches.
		JoinCondition() := 
			MACRO
				LEFT.bdid_value = 0 AND LENGTH(TRIM(LEFT.company_name_val_filt)) > 1 AND LEFT.zip_value = [] 
				AND 
				KEYED( TRIM((keyfld_type)LEFT.company_name_val_filt) 
				  = RIGHT.word[ 1..LENGTH(TRIM((keyfld_type)LEFT.company_name_val_filt)) ] OR
								(LEFT.company_name_val_filt2 != '' AND 
								 TRIM((keyfld_type)LEFT.company_name_val_filt2) 
								   = RIGHT.word[ 1..LENGTH(TRIM((keyfld_type)LEFT.company_name_val_filt2)) ]) ) 
				AND 
        KEYED( RIGHT.state = LEFT.st OR LEFT.st = '' ) AND 
				KEYED( RIGHT.seq IN [1,2] ) AND 
				DataLib.StringSimilar100(LEFT.company_name_val_filt, RIGHT.word) < 50
			ENDMACRO;
			
		// Obtain the matching BDIDs from the indexed file. Outfile from macro is ds_results.
		Macros.MAC_Match_For_BDIDs(ds_in_expanded, ds_indexed_names, JoinCondition(), NAME_WORDS_MATCH, ds_results)

		// ***** For test harness only. OUTPUT() all of the input data along with matching BDIDs and matchCodes.	
		IF( isTestHarness, OUTPUT(Functions.Display_Matched_Input_And_Output(ds_in_no_the, ds_results), 
		                          NAMED('Combined_Layout_Results_Fetch_NameWords_Batch'), OVERWRITE) );		
		
		// OUTPUT( ds_in, NAMED('ds_in'), OVERWRITE );
		// OUTPUT( ds_in_expanded, NAMED('ds_in_expanded'), OVERWRITE );
		
		RETURN ds_results;
			
	END;
