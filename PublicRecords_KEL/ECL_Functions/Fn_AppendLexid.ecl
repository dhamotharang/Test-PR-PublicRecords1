/* This function appends the lexid from THOR.
The default for the score threshold is 80 - meaning no scores less than 80 will return 
a lexid. The user can override this score threshold by setting the score_threshold parameter.
*/
IMPORT did_add, PublicRecords_KEL;

// this function will take the input data, append the DID and do all default values in layout output
EXPORT Fn_AppendLexid(
							DATASET(PublicRecords_KEL.ECL_Functions.Input_Cleaned_Layout) indata,
              INTEGER Score_threshold = 80
					) := FUNCTION


	matchset_input := ['A','D','S','P','Z'];
	
	// HARD CODE TO USE THE THOR VERSION OF DID APPEND
	#STORED('did_add_force', 'thor');
	
	did_Add.MAC_Match_Flex(indata, matchset_input,
												 SSN, DOB, fName, mname, LName, suffix, 
												 prim_range, prim_name, sec_range, z5,
												 st, Phone10,
												 Lexid,
                         PublicRecords_KEL.ECL_Functions.Input_Cleaned_Layout,												 
                         TRUE, score,	//these should default to zero in definition
												 0,	  //dids with a score below here will be dropped 	
												 resu);
  //Keep scores greater or equal to the score threshold
  dids_with_good_scores := resu((INTEGER) score >= Score_threshold);
  //Change the lexid and score to be 0 for records below the score threshold
  dids_with_below_scores := PROJECT(resu((INTEGER) score < Score_threshold), 
    TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Cleaned_Layout, 
      SELF.Lexid := 0, 
      SELF.score := 0, 
      SELF := LEFT));

RETURN dids_with_good_scores + dids_with_below_scores;

END;