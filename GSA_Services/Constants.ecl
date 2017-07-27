import iesp;
export Constants := MODULE

	export batch_max_record_length := 2500; //actual 2403
	export max_record_length_slim := 500; 
	export batch_max_recs_address := 5;
	export batch_max_recs_actions := 10;
	export batch_max_recs_references_ := 20;
	export unsigned2 MAX_INPUT:= iesp.constants.MAX_GSA_VERIFICATION_REQUEST_RECORDS;
	export integer MAX_RESULTS_DEFAULT := iesp.constants.MAX_GSA_VERIFICATION_RESPONSE_RECORDS;
	export STRING4 termdate_permanent := 'PERM';
	export STRING5 termdate_indefinite := 'INDEF';
	export STRING1 RECORD_TYPE_PRIMARY := 'P';
	export STRING10 RECORD_TYPE_INDIVIDUAL := 'INDIVIDUAL';
	
END;