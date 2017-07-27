EXPORT Macros := MODULE
	
		  // The following macro is used by the fetch_*_batch functions found in AutokeyB2. 
			// It joins two arbitrary datasets (ds_inLeft and ds_inRight) based on the join
			// condition--JoinCond()--whatever it may be. If a match is found, the match
			// code (matchCd) is written to the transform. Else, failure codes are written.
			// These codes are defined in AutokeyB2.Constants.
		EXPORT MAC_Match_For_BDIDs(ds_inLeft, ds_inRight, JoinCond, matchCd, ds_out) := MACRO
			
			#UNIQUENAME(rec)
			#UNIQUENAME(search)
			#UNIQUENAME(successtra)
			#UNIQUENAME(failtra)			
			#UNIQUENAME(matchCode)
			#UNIQUENAME(LIMIT_VALUE)
					
			%rec%         := AutokeyB2_batch.Layouts.rec_output_BDIDs_batch;
			%search%      := AutokeyB2_batch.Constants; // For search statuses.
			%matchCode%   := %search%.matchCd;
			%LIMIT_VALUE% := 2500;
			
			//***** TRANSFORMS TO EXTRACT BDID FROM THE KEY WHEN MATCH OCCURS
			%rec% %successtra%(ds_inLeft l, ds_inRight r) := 
				TRANSFORM
					SELF.search_status := if(r.bdid != 0, %search%.SUCCEEDED, %search%.FAILED_NO_MATCHES);
					SELF.matchCode     := %matchCode%;
					SELF.bdid          := r.bdid;
					SELF               := l;
				END;

			%rec% %failtra%(ds_inLeft l) := 
				TRANSFORM
					SELF.search_status := %search%.FAILED_TOO_MANY_MATCHES;
					SELF.matchCode     := %matchCode%;
					SELF               := l;
					SELF               := [];
				END;

			// Chad's note: ***** CHOICE OF WHETHER TO FAIL WHEN LIMIT EXCEEDED ***** WE STILL NEED A WAY
			//  TO DO A KEYED AND UNKEYED VERSION OF EACH LIMIT (ATMOST IS KEYED AND LIMIT IS NOT) ***** NOT
			//  WORKING WHEN WORKHARD = TRUE BECAUSE OF THE COMPLICATED JOIN CONDITION. See #22584.
			ds_out := JOIN(ds_inLeft, ds_inRight, 
										 JoinCond, 
										 %successtra%(LEFT, RIGHT), 
										 LIMIT(%LIMIT_VALUE%), 
										 ONFAIL(%failtra%(LEFT)), 
										 LEFT OUTER);						
		ENDMACRO;		

END;  // Macros module