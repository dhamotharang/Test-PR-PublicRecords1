
//This Function Macro validates the input file before processing the results
EXPORT MAC_InputFileValidation(ds_in):=FUNCTIONMACRO
IMPORT ut,std;

	//Validation checks
	BOOLEAN isLexIDZero				:= EXISTS(ds_in((UNSIGNED)lexid=0));
	BOOLEAN isSeqZero  				:= EXISTS(ds_in((UNSIGNED)seq=0));
	BOOLEAN LexID_Not_Unique  := COUNT(ds_in) <> COUNT(DEDUP(ds_in, lexid));
	BOOLEAN Seq_Not_Unique  	:= COUNT(ds_in) <> COUNT(DEDUP(ds_in, seq));
	
	RETURN isLexIDZero OR isSeqZero OR LexID_Not_Unique OR Seq_Not_Unique;  //this will return false if all validation passes
ENDMACRO;

