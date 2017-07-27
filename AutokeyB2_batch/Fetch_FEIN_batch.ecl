
/* View documentation section for notes on this attribute. */

import AutokeyB2, ut;

export Fetch_FEIN_batch
		(grouped dataset(AutokeyB2_batch.Layouts.rec_BDID_InBatch) ds_in, 
		 string t,
		 boolean workHard = false,
		 boolean nofail = true,	  
		 boolean isTestHarness = false) :=
	FUNCTION

		// ***** GRAB THE FEINs INDEX. *****
		ds_indexed_FEINs := AutokeyB2.Key_FEIN(t);

		// Join conditions for matching records in infile dataset (LEFT) to FEIN index (RIGHT).
		JoinCondition() := 
			MACRO
				keyed(right.f1=left.fein[1]) and keyed(right.f2=left.fein[2]) and keyed(right.f3=left.fein[3]) and 
				keyed(right.f4=left.fein[4]) and keyed(right.f5=left.fein[5]) and keyed(right.f6=left.fein[6]) and 
				keyed(right.f7=left.fein[7]) and keyed(right.f8=left.fein[8]) and keyed(right.f9=left.fein[9])
			ENDMACRO;	

		// Obtain the matching BDIDs from the indexed file. Outfile from macro is ds_results.
		Macros.MAC_Match_For_BDIDs(ds_in, ds_indexed_FEINs, JoinCondition(), FEIN_MATCH, ds_results)

		// ***** For test harness only. OUTPUT() all of the input data along with matching BDIDs and matchCodes.	
		IF( isTestHarness, OUTPUT(Functions.Display_Matched_Input_And_Output(ds_in, ds_results), 
		                          NAMED('Combined_Layout_Results_Fetch_FEIN_Batch'), OVERWRITE) );

		return ds_results;

	END;