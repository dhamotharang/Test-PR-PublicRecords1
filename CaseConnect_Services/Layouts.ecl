import Accurint_AccLogs;

EXPORT Layouts := MODULE

	EXPORT DLNumber := RECORD
		Accurint_AccLogs.Layout_Autokey.orig_dl;
	END;
	
	EXPORT AccLogId := RECORD
		Accurint_AccLogs.Layout_Autokey.record_id;
	END;
	
	EXPORT DOB := RECORD
		INTEGER dob;
	END;
	
	EXPORT UserId := RECORD
		Accurint_AccLogs.Layout_Autokey.user_id;
	END;
	
	EXPORT UNIQUE_ID := RECORD
		Accurint_AccLogs.Layout_Autokey.orig_unique_id;
	END;
	
	EXPORT MainAccLogs := RECORD
		Accurint_Acclogs.Layout_Autokey AND NOT 
					[cart,  cr_sort_sz, lot, lot_order, dbpc, chk_digit, 
					 rec_type, county, geo_lat, geo_long, msa, geo_blk,
						geo_match, err_stat];
	END;
	
	EXPORT LogsAndPenalty := RECORD
		MainAccLogs;
		unsigned2 record_penalty;
	END;	
		
END;