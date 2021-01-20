/* This attribute had some code from Alpharetta removed */
export Constants := module

	export integer max_idls               := 50;
	EXPORT UNSIGNED2 SCORE_SEG := 85; // score when LexId is choosen base on segmentation.
	EXPORT UNSIGNED2 GOOD_SCORE := 75;
	EXPORT UNSIGNED1 DOB_WEIGHT_THRESHOLD := 12;
	EXPORT UNSIGNED1 NAME_WEIGHT_THRESHOLD := 15;
	EXPORT UNSIGNED1 SSN_WEIGHT_THRESHOLD := 15;	
	EXPORT DEAD_IND := 'DEAD';	
	EXPORT CORE_IND := 'CORE'; 
	EXPORT NO_SSN_IND := 'NO_SSN';	
	EXPORT GOOD_CLUSTERS := [CORE_IND, NO_SSN_IND, DEAD_IND];
	EXPORT GOOD_CANDIDATES_THESHOLD := 3;
	EXPORT UNSIGNED6 INSURANCE_LEXID := 140737488355328;
	EXPORT STRING3 INSURANCE_LEXID_TYPE := 'INS';
	EXPORT UNSIGNED1 HIGH_STATE_WEIGHT := 7;
	roxieEnv := stringlib.StringToUpperCase(thorlib.getenv('Environment','Default'));
	EXPORT BOOLEAN isCustomerTest := roxieEnv in ['DQA', 'DPROD'];
end;
