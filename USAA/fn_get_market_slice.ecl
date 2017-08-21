UNSIGNED4 Cvt_Dates(string6 date) := FUNCTION
	RETURN (UNSIGNED4)(date[3..6] + date[1..2]);
END;


EXPORT fn_get_market_slice( USAA.layout_infile i) := 	
	FUNCTION
	
		RETURN  USAA.file_direct_marketing( /* filter...: */
			((UNSIGNED4)ind_age BETWEEN (UNSIGNED4)i.min_ind_age AND (UNSIGNED4)i.max_ind_age) AND
			(Cvt_Dates(DOB)     BETWEEN (UNSIGNED4)i.min_DOB     AND (UNSIGNED4)i.max_DOB)     AND
			(Count_LN_Yrs       BETWEEN i.min_Count_LN_Yrs       AND i.max_Count_LN_Yrs)       AND
			(Count_Zip1         BETWEEN i.min_Count_Zip1         AND i.max_Count_Zip1)         AND
			(Conseq_Zip1        BETWEEN i.min_Conseq_Zip1        AND i.max_Conseq_Zip1)        AND
			(AvgMoves_LN        BETWEEN i.min_AvgMoves_LN        AND i.max_AvgMoves_LN)        AND
			(Count_Zip2         BETWEEN i.min_Count_Zip2         AND i.max_Count_Zip2)         AND
			(Conseq_Zip2        BETWEEN i.min_Conseq_Zip2        AND i.max_Conseq_Zip2)        AND
			(AvgMoves_Zip2      BETWEEN i.min_AvgMoves_Zip2      AND i.max_AvgMoves_Zip2)      AND
			
			( (Count_Zip1 = 0 AND Recent_Dt_Zip1 = '000000') OR (Cvt_Dates(Recent_Dt_Zip1) div 100 >= 1996) ) AND
			(Cvt_Dates(Recent_Dt_Zip1) BETWEEN (UNSIGNED4)i.min_Recent_Dt_Zip1 AND (UNSIGNED4)i.max_Recent_Dt_Zip1) AND

			( (Count_Zip2 = 0 AND Recent_Dt_Zip2 = '000000') OR (Cvt_Dates(Recent_Dt_Zip2) div 100 >= 1996) ) AND
			(Cvt_Dates(Recent_Dt_Zip2) BETWEEN (UNSIGNED4)i.min_Recent_Dt_Zip2 AND (UNSIGNED4)i.max_Recent_Dt_Zip2)	AND	
			
			( ( NOT i.not_states AND REGEXFIND(state, i.states) ) OR 
            ( i.not_states AND NOT REGEXFIND(state, i.states) ) OR
            TRIM(i.states,LEFT,RIGHT) = '' ) );
	END;
	
/* *** NOTES: ***
Requirements for Universe: A consumer will be included for consideration as long as he/she: 
1.	Has lived on a military base (ZIP SET 1) at least once on or since January 1, 1996:
2.	Or has lived within 15 mile radius of a military base (ZIP SET 2) at least twice consecutively 
    at some time on or since January 1, 1996. [ We're gonna fudge this one a tad. --cda ]
*/