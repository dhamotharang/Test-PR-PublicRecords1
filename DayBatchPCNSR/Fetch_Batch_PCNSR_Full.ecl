import Address,$,DayBatchUtils, doxie, ut;

export Fetch_Batch_PCNSR_Full(DATASET($.Layout_clean_in) cleanInput, 
															STRING20 searchType,
                              doxie.IDataAccess mod_access) := FUNCTION
	
	max_count := $.getMaxReturnCount(searchType);
	

	indata_grouped := PROJECT(GROUP(cleanInput, acctno),
														TRANSFORM($.Layout_PCNSR_Linked, SELF.indata := LEFT, SELF := []));
	//ALL MATCHES
	allMatch := MAP(searchType IN ['AC2A','AC2B','USPAGE_FL13Z','USPAGE_FL137Z','PHA1'] => $.PhoneSearch_Simple(indata_grouped, mod_access),
									searchType = 'AC04' => $.PhoneSearch_Surnames(indata_grouped,max_count, mod_access),
									searchType = 'AC03' => $.PhoneSearch_Nbr(indata_grouped,max_count, mod_access),
									searchType = 'AC4A' => $.PhoneSearch_Reverse(indata_grouped, mod_access),
									indata_grouped
									);

	//GET NAME MATCH CODE
	DayBatchUtils.MAC_Name_Match(allMatch,indata,outdata,name_last,name_first,lname,fname,matchCode,outf)
	
	srt_Priority_Dates := IF($.isSorted_Priority_RefDate(searchType),
													 $.srtBy_acct_priority_refDate(outf,searchType),
													 outf
													);
	
	out_file := IF($.isDeduped_Phone(searchType),
								 $.dedup_Phone(srt_Priority_Dates,searchType),
								 srt_Priority_Dates
								 );


	$.Layout_PCNSR_Out formatOutput(out_file raw,STRING20 s,INTEGER cnt) := 
		TRANSFORM,SKIP( cnt > max_count OR (~$.isProcessHit(raw.matchCode,s) AND cnt > 1))
		$.MAC_Format_Output(raw,s)
	END;


	RETURN PROJECT(out_file,formatOutput(LEFT,searchType,COUNTER));

END;