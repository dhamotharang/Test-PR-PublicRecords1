EXPORT GeocodeSearch_Interfaces := MODULE

	EXPORT Records := INTERFACE

		EXPORT BOOLEAN exclude_persons;             // Includes people in the output.
		EXPORT BOOLEAN exclude_businesses;          // Includes businesses in the output.
		
		EXPORT UNSIGNED3 dt_range_start;                // YYYYMM format, or 0.
		EXPORT UNSIGNED3 dt_range_end;                  // YYYYMM format, or 0.
		
		EXPORT BOOLEAN exclude_if_match_is_best;    // Don't return if the found record matches best record
		EXPORT BOOLEAN exclude_if_match_isnt_best;  // Don't return if the found record doesn't match best record
	
	END;
	
END;
