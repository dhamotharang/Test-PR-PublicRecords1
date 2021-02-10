IMPORT Business_Risk_BIP, BusinessInstantID20_Services;

// The following function appends the LexID to each of the Authorized Reps from the business shell (Business_Risk_BIP.getAuthRepLexIDs)
EXPORT fn_AppendLexIDs( 	DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_CleanedInput,
	DATASET(Business_Risk_BIP.Layouts.Shell) ds_Shell_Results
	) := FUNCTION

			ds_CleanedInput_with_DID := join(ds_cleanedInput, ds_shell_results, left.seq=right.seq,
				transform(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean,
					lexid1 := right.clean_input.rep_lexid;
					lexid2 := right.clean_input.rep2_lexid;
					lexid3 := right.clean_input.rep3_lexid;
					lexid4 := right.clean_input.rep4_lexid;
					lexid5 := right.clean_input.rep5_lexid;

					lexid1score := right.clean_input.rep_lexidscore;
					lexid2score := right.clean_input.rep2_lexidscore;
					lexid3score := right.clean_input.rep3_lexidscore;
					lexid4score := right.clean_input.rep4_lexidscore;
					lexid5score := right.clean_input.rep5_lexidscore;


					self.authreps := project(left.authreps,
						transform(BusinessInstantID20_Services.layouts.InputAuthRepInfoClean,
							self.lexid := map(left.rep_whichone=5 => lexid5, left.rep_whichone=4 => lexid4, left.rep_whichone=3 => lexid3, left.rep_whichone=2 => lexid2, lexid1 );
							self.LexIDScore := map(left.rep_whichone=5 => lexid5score, left.rep_whichone=4 => lexid4score, left.rep_whichone=3 => lexid3score, left.rep_whichone=2 => lexid2score, lexid1score );
							self := left) );
					self := left;
					));

		return ds_CleanedInput_with_DID;

END;
