import STD;
EXPORT Census_Options := MODULE				//(calbee.interfaces.Records)
		EXPORT exclude_persons            := FALSE;  // Includes people in the output.
		EXPORT exclude_businesses         := TRUE;   // Includes businesses in the output.
		EXPORT dt_range_start             := 201505; // YYYYMM format, or 0.  201003
		EXPORT dt_range_end               := (UNSIGNED3)workunit[2..7]; //YYYYMM format, or 0.
		EXPORT exclude_if_match_is_best   := FALSE;  // Don't return if the found record matches best record
		EXPORT exclude_if_match_isnt_best := FALSE;  // Don't return if the found record doesn't match best record
		EXPORT date_of_residence          := 201501;	//201004;
		EXPORT min_dod                    := 20140101;	//201004;
		export st_filter									:= ['NM','NJ','MI'];
	END;