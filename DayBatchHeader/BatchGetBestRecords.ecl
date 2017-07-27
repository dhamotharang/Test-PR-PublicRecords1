import doxie;

export BatchGetBestRecords(GROUPED DATASET(DayBatchHeader.Layout_LinkHeader) inData, 
														INTEGER dppa,
														INTEGER glba) := FUNCTION
	
	doxie.layout_references makeDidList(DayBatchHeader.Layout_LinkHeader le) := TRANSFORM		
			SELF.did := le.outdata.did;
	END;
		
	didList := DEDUP(SORT(PROJECT(UNGROUP(inData(outdata.did <> 0)),makeDidList(LEFT)),did),did);		
	
	bestRecs := doxie.best_records(didList,false,dppa,glba,true);	
		
	DayBatchHeader.Layout_LinkHeader fillOutputRecord(DayBatchHeader.Layout_LinkHeader le, bestRecs ri) := TRANSFORM
		SELF.outdata.dt_last_seen := ri.addr_dt_last_seen;				
		SELF.outdata := ri;
		SELF.indata := le.indata;		
		SELF := le;
		SELF := [];
	END;
	
	fullLinkRec := JOIN(inData, 
											bestRecs, 
											LEFT.outdata.did = RIGHT.did, 
											fillOutputRecord(LEFT,RIGHT), 
											LEFT OUTER, MANY LOOKUP);
	
	srtLinked := SORT(fullLinkRec,-outdata.did);
	
	DayBatchHeader.Layout_LinkHeader removeZeroDIDs(DayBatchHeader.Layout_LinkHeader le,INTEGER C) := TRANSFORM,SKIP(le.outdata.did = 0 AND C > 1)
		SELF.matchCode := IF(le.outdata.did = 0,'',le.matchCode);
		SELF := le;
	END;	
	
	retSet := PROJECT(srtLinked,removeZeroDIDs(LEFT,COUNTER));	

//output(bestRecs, named('BestRecs'));	
	RETURN retSet;	
	
END;