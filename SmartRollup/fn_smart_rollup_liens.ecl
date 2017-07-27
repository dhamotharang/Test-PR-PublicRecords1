import iesp, TopBusiness;
export fn_smart_rollup_liens(dataset(iesp.lienjudgement.t_LienJudgmentReportRecord) inRecs) := function
  outLayout := record
	  string40 lien_id;
	  string1 active_closed;
		unsigned4 regist_date_9999;
		recordof(inRecs);
	end;
	
	outLayout assignType(inRecs L) := transform
	  //for now if the filing status is blank say its active.
		self.lien_id := l.filings[1].number;
	  self.active_closed := if (L.filingStatus='' AND
		                              count(L.filings(_type ='TERMINATION')) = 0
															    ,TopBusiness.Constants.ACTIVE
																	,TopBusiness.Constants.TERMINATED);
    self.regist_date_9999 := 99999999 - iesp.ECL2ESP.DateToInteger(l.OriginFilingDate);																	
	  self := l
	end;
  fRecs := project(inRecs, assignType(LEFT));
	sRecs   := SORT(fRecs,  lien_id, active_closed , regist_date_9999, record); 
	dRecs   := DEDUP(sRecs, lien_id);
  finalSort := SORT(dRecs, active_closed, regist_date_9999);  
	outRecs := project(finalSort, transform(iesp.smartlinxreport.t_SLRLienJudgment, self.activeClosed := LEFT.active_closed,self := LEFT ));
	RETURN outRecs; 
end;