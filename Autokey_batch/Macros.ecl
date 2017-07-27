
EXPORT Macros := MODULE

		// The following macro is used by the fetch_*_batch functions found in Autokey. 
		// It joins two arbitrary datasets (ds_inLeft and ds_inRight) based on the join
		// condition--JoinCond()--whatever it may be. If a match is found, the match
		// code (matchCd) is written to the transform. Else, failure codes are written.
		// These codes are defined in AutokeyB2.Constants.
		EXPORT MAC_Match_For_DIDs(ds_inLeft, ds_inRight, JoinCond, matchCd, ds_out) := 
			MACRO
				
				#UNIQUENAME(rec)
				#UNIQUENAME(search)
				#UNIQUENAME(xfm_success)
				#UNIQUENAME(xfm_fail)	
				#UNIQUENAME(matchCode)
				#UNIQUENAME(LIMIT_VALUE)
				#UNIQUENAME(ds_join)
				
				%rec%         := Autokey_batch.Layouts.rec_DID_OutBatch;
				%search%      := AutokeyB2_batch.Constants;    // For search statuses.
				%matchCode%   := %search%.matchCd;
				%LIMIT_VALUE% := ut.limits.FETCH_LEV2_UNKEYED; // 3000
				
				
				//***** TRANSFORMS TO GET DID OFF OF KEY WHEN MATCH OCCURS
				%rec% %xfm_success%(ds_inLeft l, ds_inRight r) := 
					TRANSFORM
						SELF.search_status := if(r.did != 0, %search%.SUCCEEDED, %search%.FAILED_NO_MATCHES);
						SELF.matchCode     := %matchCode%;
						SELF.did           := r.did;
						SELF               := l;
					END;
			
				%rec% %xfm_fail%(ds_inLeft l) := 
					TRANSFORM
						SELF.search_status := %search%.FAILED_TOO_MANY_MATCHES;
						SELF.matchCode     := %matchCode%;
						SELF := l;
						SELF := [];
					END;

				// Chad's note: ***** WE STILL NEED A WAY TO DO A KEYED AND UNKEYED VERSION OF EACH 
				// LIMIT (ATMOST IS KEYED AND LIMIT IS NOT).***** NOT WORKING WHEN WORKHARD = TRUE 
				// BECAUSE OF THE COMPLICATED JOIN CONDITION.
				%ds_join% := JOIN(ds_inLeft, 
													ds_inRight, 
													JoinCond, 
													%xfm_success%(LEFT, RIGHT), 
													LIMIT(%LIMIT_VALUE%), 
													ONFAIL(%xfm_fail%(LEFT)), 
													LEFT OUTER);			
											 
				// This macro must behave as though the query has failed when nofail = true and there 
				// are too many matches. To do this, we just filter out those records having the nice 
				// error message stating that there are too many matches. Else, when nofail = false, 
				// return the dataset unfiltered, to include the 'too many' error message.
				ds_out := IF( nofail,
				              %ds_join%(search_status != %search%.FAILED_TOO_MANY_MATCHES),
				              %ds_join%
										 );										 
				
			ENDMACRO;
		
		
		EXPORT useLookups() :=
			MACRO			
				(ut.bit_test(RIGHT.lookups, LEFT.lookup_value))				
			ENDMACRO;
			

		EXPORT Other_Join_Conditions() := 
			MACRO
			
				LEFT.prev_state_val1 = ''       OR ut.bit_test(RIGHT.states, ut.St2Code(LEFT.prev_state_val1)) AND
				LEFT.prev_state_val2 = ''       OR ut.bit_test(RIGHT.states, ut.St2Code(LEFT.prev_state_val2)) AND
				LEFT.other_lname_value1[1] = '' OR ut.bit_test(RIGHT.lname1, ut.Chr2Code(LEFT.other_lname_value1[1])) AND
				LEFT.other_lname_value1[2] = '' OR ut.bit_test(RIGHT.lname2, ut.Chr2Code(LEFT.other_lname_value1[2])) AND
				LEFT.other_lname_value1[3] = '' OR ut.bit_test(RIGHT.lname3, ut.Chr2Code(LEFT.other_lname_value1[3])) AND
				LEFT.other_city_value[1]=''     OR ut.bit_test(RIGHT.city1, ut.Chr2Code(LEFT.other_city_value[1])) AND
				LEFT.other_city_value[2]=''     OR ut.bit_test(RIGHT.city2, ut.Chr2Code(LEFT.other_city_value[2])) AND
				LEFT.other_city_value[3]=''     OR ut.bit_test(RIGHT.city3, ut.Chr2Code(LEFT.other_city_value[3])) AND
				LEFT.rel_fname_value1[1]=''     OR ut.bit_test(RIGHT.rel_fname1, ut.Chr2Code(LEFT.rel_fname_value1[1])) AND
				LEFT.rel_fname_value1[2]=''     OR ut.bit_test(RIGHT.rel_fname2, ut.Chr2Code(LEFT.rel_fname_value1[2])) AND
				LEFT.rel_fname_value1[3]=''     OR ut.bit_test(RIGHT.rel_fname3, ut.Chr2Code(LEFT.rel_fname_value1[3])) AND
				LEFT.rel_fname_value2[1]=''     OR ut.bit_test(RIGHT.rel_fname1, ut.Chr2Code(LEFT.rel_fname_value2[1])) AND
				LEFT.rel_fname_value2[2]=''     OR ut.bit_test(RIGHT.rel_fname2, ut.Chr2Code(LEFT.rel_fname_value2[2])) AND
				LEFT.rel_fname_value2[3]=''     OR ut.bit_test(RIGHT.rel_fname3, ut.Chr2Code(LEFT.rel_fname_value2[3]))
				
			ENDMACRO;
			
END;