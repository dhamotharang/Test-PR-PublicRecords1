export Layout_clean_in := RECORD
	DayBatchPCNSR.Layout_PCNSR_In;
	STRING2 predir := '';
	STRING4 addr_suffix := '';
	STRING2 postdir := '';
	STRING10 unit_desig := '';
	STRING4	z4 := '';
	STRING10 pobox := '';
	STRING4		err_stat := '';
	STRING addr1_for_clean := '';
	STRING addr2_for_clean := '';	
	STRING clean_addr := '';
END;