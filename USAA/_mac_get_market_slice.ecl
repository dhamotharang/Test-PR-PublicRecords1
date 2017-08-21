
IMPORT USAA;

EXPORT _mac_get_market_slice() := MACRO

	STRING3    min_ind_age        := '25';  
	STRING3    max_ind_age        := '30';
	STRING6    min_DOB            := '0';
	STRING6    max_DOB            := USAA.constants.TODAY;
	DECIMAL6_2 min_Count_LN_Yrs   := 0;
	DECIMAL6_2 max_Count_LN_Yrs   := 100;
	UNSIGNED2  min_Count_Zip1     := 4;
	UNSIGNED2  max_Count_Zip1     := 100;
	UNSIGNED2  min_Conseq_Zip1    := 3;
	UNSIGNED2  max_Conseq_Zip1    := 100;
	DECIMAL6_2 min_AvgMoves_LN    := 0;
	DECIMAL6_2 max_AvgMoves_LN    := 100;
	UNSIGNED2  min_Count_Zip2     := 4;
	UNSIGNED2  max_Count_Zip2     := 100;
	UNSIGNED2  min_Conseq_Zip2    := 3;
	UNSIGNED2  max_Conseq_Zip2    := 100;
	DECIMAL6_2 min_AvgMoves_Zip2  := 0;
	DECIMAL6_2 max_AvgMoves_Zip2  := 100;
	STRING6    min_Recent_Dt_Zip1 := '200609';
	STRING6    max_Recent_Dt_Zip1 := USAA.constants.TODAY;
	STRING6    min_Recent_Dt_Zip2 := '200609';
	STRING6    max_Recent_Dt_Zip2 := USAA.constants.TODAY;
	BOOLEAN    not_states         := FALSE;
	STRING150  states             := 'MA,WA,NY'; // Delimited string--make sure state values are separated.
	
	infile := DATASET([{ min_ind_age,       max_ind_age,       
	                     min_DOB,           max_DOB,           
	                     min_Count_LN_Yrs,  max_Count_LN_Yrs,  
	                     min_Count_Zip1,    max_Count_Zip1,    
	                     min_Conseq_Zip1,   max_Conseq_Zip1,   
	                     min_AvgMoves_LN,   max_AvgMoves_LN,   
	                     min_Count_Zip2,    max_Count_Zip2,    
	                     min_Conseq_Zip2,   max_Conseq_Zip2,   
	                     min_AvgMoves_Zip2, max_AvgMoves_Zip2, 
	                     min_Recent_Dt_Zip1,max_Recent_Dt_Zip1,
	                     min_Recent_Dt_Zip2,max_Recent_Dt_Zip2,
	                     not_states,        states            }], USAA.layout_infile);
	
	OUTPUT(USAA.fn_get_market_slice( infile[1] ));

ENDMACRO;