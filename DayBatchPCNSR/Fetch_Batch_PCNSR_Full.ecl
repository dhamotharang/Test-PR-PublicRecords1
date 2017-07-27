import Address,DayBatchPCNSR,DayBatchUtils,ut;

export Fetch_Batch_PCNSR_Full(DATASET(DayBatchPCNSR.Layout_clean_in) cleanInput, 
															STRING20 searchType) := FUNCTION
	
	max_count := DayBatchPCNSR.getMaxReturnCount(searchType);
	

	indata_grouped := PROJECT(GROUP(cleanInput, acctno),
														TRANSFORM(DayBatchPCNSR.Layout_PCNSR_Linked, SELF.indata := LEFT, SELF := []));
	//ALL MATCHES
	allMatch := MAP(searchType IN ['AC2A','AC2B','USPAGE_FL13Z','USPAGE_FL137Z','PHA1'] => DayBatchPCNSR.PhoneSearch_Simple(indata_grouped),
									searchType = 'AC04' => DayBatchPCNSR.PhoneSearch_Surnames(indata_grouped,max_count),
									searchType = 'AC03' => DayBatchPCNSR.PhoneSearch_Nbr(indata_grouped,max_count),
									searchType = 'AC4A' => DayBatchPCNSR.PhoneSearch_Reverse(indata_grouped),
									indata_grouped
									);

	//GET NAME MATCH CODE
	DayBatchUtils.MAC_Name_Match(allMatch,indata,outdata,name_last,name_first,lname,fname,matchCode,outf)
	
	srt_Priority_Dates := IF(DayBatchPCNSR.isSorted_Priority_RefDate(searchType),
													 DayBatchPCNSR.srtBy_acct_priority_refDate(outf,searchType),
													 outf
													);
	
	out_file := IF(DayBatchPCNSR.isDeduped_Phone(searchType),
								 DayBatchPCNSR.dedup_Phone(srt_Priority_Dates,searchType),
								 srt_Priority_Dates
								 );


	DayBatchPCNSR.Layout_PCNSR_Out formatOutput(out_file raw,STRING20 s,INTEGER cnt) := 
		TRANSFORM,SKIP( cnt > max_count OR (~DayBatchPCNSR.isProcessHit(raw.matchCode,s) AND cnt > 1))
		DayBatchPCNSR.MAC_Format_Output(raw,s)
	END;


	RETURN PROJECT(out_file,formatOutput(LEFT,searchType,COUNTER));

END;