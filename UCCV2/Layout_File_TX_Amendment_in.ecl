export Layout_File_TX_Amendment_in 
		:= record
			string8    		process_date;
			string1    		transaction_code;
			string12    	original_filing_number;
			string10    	ucc3_filing_number;
			string40    	amendment_type;
			string8    		filing_date;
			string4    		filing_time;
			string4    		page_count;
			string8    		filing_entry_date;
			string4    		filing_entry_time;
			string256    	filing_history_comment;
			string20    	document_number;
		  end;