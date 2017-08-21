
IMPORT USAA;

EXPORT layout_infile := RECORD
	STRING3    min_ind_age        := '0';  
	STRING3    max_ind_age        := '100';
	STRING6    min_DOB            := '0';
	STRING6    max_DOB            := '999999';
	DECIMAL6_2 min_Count_LN_Yrs   := 0;
	DECIMAL6_2 max_Count_LN_Yrs   := 100;
	UNSIGNED2  min_Count_Zip1     := 0;
	UNSIGNED2  max_Count_Zip1     := 100;
	UNSIGNED2  min_Conseq_Zip1    := 0;
	UNSIGNED2  max_Conseq_Zip1    := 100;
	DECIMAL6_2 min_AvgMoves_LN    := 0;
	DECIMAL6_2 max_AvgMoves_LN    := 100;
	UNSIGNED2  min_Count_Zip2     := 0;
	UNSIGNED2  max_Count_Zip2     := 100;
	UNSIGNED2  min_Conseq_Zip2    := 0;
	UNSIGNED2  max_Conseq_Zip2    := 100;
	DECIMAL6_2 min_AvgMoves_Zip2  := 0;
	DECIMAL6_2 max_AvgMoves_Zip2  := 100;
	STRING6    min_Recent_Dt_Zip1 := '0';
	STRING6    max_Recent_Dt_Zip1 := '999999';
	STRING6    min_Recent_Dt_Zip2 := '0';
	STRING6    max_Recent_Dt_Zip2 := '999999';
	BOOLEAN    not_states         := FALSE; // True == 'all states except...' [states] below.
	STRING150  states             := ''; // Delimited string--make sure state values are separated.				

END;