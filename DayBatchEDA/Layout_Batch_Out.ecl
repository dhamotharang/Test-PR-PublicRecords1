IMPORT gong;

EXPORT Layout_Batch_Out := MODULE

	EXPORT Layout_Final_Output := RECORD
		STRING2   seq_num;
		STRING20  acctno;
	  STRING1   MatchCode;
		STRING2   max_results;
		gong.Layout_bscurrent_raw;
	END;
	
	EXPORT Layout_Out_Record := RECORD
		UNSIGNED2 seq_num;
	  STRING20  acctno;
	  STRING1   MatchCode;
		UNSIGNED2 max_results;
		gong.Layout_bscurrent_raw;
	END;

END;